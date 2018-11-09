Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5501C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCC42086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYl1QigC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BCC42086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbeKIRNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 12:13:37 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39640 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbeKIRNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 12:13:36 -0500
Received: by mail-pg1-f196.google.com with SMTP id r9-v6so498357pgv.6;
        Thu, 08 Nov 2018 23:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=HnTeUMjknPYuDRExOVIqkJbzR1URO+WU2PNAyXjhYCs=;
        b=PYl1QigCaG7yFspXTF6hQTsTbvwCKsX1+/bfDFAi8rc2aOC0W5i+WlLJxVx9/Qymj4
         xmTbd1L0kkuogcU7ZYcKWArJL1E4uK41ydYTp7mWHu+cP+EVkaIVOiYcWQcTJlZZR2Zo
         9eoO4ftWWKMadWu5pB7XvQI8lKeNCUECaNZ6H4KfLvvAzNTE4K6HwTKy2CIcCe1njUqh
         cu0e8JPrN83IIQoWredSwZR0/PyU93JARNTD8WiGk7cawWlFVUYyEsTbbBlqp82PWMdc
         QeJfwuYc+OTLdoIDDsHpplVeHtU3hy9vEBmaseVnY0FR8E0kKajXbUuN3rHkr2FGZiHD
         3guQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=HnTeUMjknPYuDRExOVIqkJbzR1URO+WU2PNAyXjhYCs=;
        b=nOg4/O8xAFqh/UGMGBCg1MO01Lrg9MVLOyvnhDFGH18SFYmgd2xoEMhAtTrUT0FfhM
         6ld5l5qs3R6MEWD7lHLO6j+4Zqn6L7GOpOtYJqh0XTkQrQcvj3x1Cidg6LemDLd3XIS7
         Lj/1y+5cH6S02+qXXW6wAbDWI0I7rkf1cn7iOi+I97HhO9sKzY9kkL/Gj/MiSR/VzKaP
         O4/gq8ZtEye+dSegIwv0ypije0tms/Mus3g49WYsvgIvbB3GeP6iRM/zrG2sibTbydVZ
         nupMYOsK5ZPXX1bIv3WWjqv3YWGc92t0+Z+xLcCa/ibFLbBScUuoaidKLdLf3eL+AXvU
         19xA==
X-Gm-Message-State: AGRZ1gLOH8rm+LVdR++fQPuoPoreaUxQwIkd78Qmy3IRjVRpvzH3j06/
        2sX583S43yCD/BHRE0HDPKzneAF9bvQ=
X-Google-Smtp-Source: AJdET5fgAK4G++rpXpQeHXMz9C3QodO1erHufkfMeff5Dac9NhnoeeXeviw4gbW2XI1Oc0UCTTgI8A==
X-Received: by 2002:a62:4dc4:: with SMTP id a187-v6mr7899013pfb.92.1541748857838;
        Thu, 08 Nov 2018 23:34:17 -0800 (PST)
Received: from nishad ([106.210.186.71])
        by smtp.gmail.com with ESMTPSA id y18-v6sm7743149pfa.136.2018.11.08.23.34.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 23:34:17 -0800 (PST)
Date:   Fri, 9 Nov 2018 13:04:09 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] staging: iio: ad7816: Switch to the gpio descriptor
 interface
Message-ID: <cover.1541733949.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v4:
 - Drop busy pin in case of AD7818.
 - Set RD/WR pin and CONVST pin as outputs.
 - Add device tree table.

Nishad Kamdar (4):
  staging: iio: ad7816: Switch to the gpio descriptor interface
  staging: iio: ad7816: Do not use busy_pin in case of AD7818
  staging: iio: ad7816: Set RD/WR pin and CONVST pin as outputs.
  staging: iio: ad7816: Add device tree table.

 drivers/staging/iio/adc/ad7816.c | 111 +++++++++++++++++--------------
 1 file changed, 60 insertions(+), 51 deletions(-)

-- 
2.17.1

