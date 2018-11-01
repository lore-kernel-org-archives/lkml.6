Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D91EC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2DD2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAtcnP95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2DD2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbeKAXph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:45:37 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34877 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbeKAXph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:45:37 -0400
Received: by mail-qk1-f195.google.com with SMTP id v68-v6so12398184qka.2;
        Thu, 01 Nov 2018 07:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=lsikBII0ToU9QdxVdDi2czjvfabaJyqmLh7r7+VP4rA=;
        b=SAtcnP9532ladwbhFZvL3+Xn1kDHpqqC4XhkZwH/nsAbJ4nJ/L8x8EglT92JVhzWVq
         oVq2No5TxHNHHaoA0DEuAilVVWrinQDJ+HKACpsEhBbDfmlvFMNSUMZyJkDhHSAmX5fy
         dxxuEPwX+u4pc8qmhhwLY1mGGeVVECl69yLbEGcxjOSXvvFVEZmx8sxNalQQkgnqTaNz
         IjB0tRDj3b7pVC9sFV583KkxJXD9/BML/RysnSkbEAn/aXdutAia1OeuSH51EXB/R4/9
         gzKjnX4uuNQ3QmzQMYWGZUYu0ZO3vPQQKZkVd4Rfg4C4cHLaoqMYKXPRw31ZMDr9+RdA
         SKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lsikBII0ToU9QdxVdDi2czjvfabaJyqmLh7r7+VP4rA=;
        b=srcVe9XxZAh6Wmav9AwZd4Fv+aDqfXujwze5x5ixGKG7QE0O6+/UVNPPdU6DyGuFDa
         Bb3Zkcn9wotecnE8dGvI4fs1a78582BeUW2TFjJtAtgDcFjUauHyfX8Le+YhJzYsfhmd
         AnCswBdwRySi/dg1Rni/eiUsMK0WadZOcwzcReP97ez3UubolckrGgDFT2gDekqd8q9V
         xZSd1paYRznJlybRxTIiHrRaOKj/ZexAoPi8ESAxFANEIr+xdBfp1Szwym2xyhEYL450
         lPbOwMQaLt4tl1VJ3nVGioNiXDA8mvzZDi5np2O9vZr/9aAAps9A7d/B5s7SEO9rh1dQ
         Rfkg==
X-Gm-Message-State: AGRZ1gJCdqnGdONHOn8WJ2IvPQms9L2m5lOvZOGcVl7VIU54x+GYo2gC
        xaJJ/zYpX9vobTma+QpCi60=
X-Google-Smtp-Source: AJdET5dNMfVhZuduZRW8ceC0Rjg32JfpkiuFd3ZttlZYLC+9gEv9wmW/z6xS3+hksRzNP0B8HCh2FA==
X-Received: by 2002:a37:3b04:: with SMTP id i4mr6997685qka.110.1541083341216;
        Thu, 01 Nov 2018 07:42:21 -0700 (PDT)
Received: from renatolg ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id e81sm21311282qkh.55.2018.11.01.07.42.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 07:42:20 -0700 (PDT)
Date:   Thu, 1 Nov 2018 11:42:16 -0300
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        giuliano.belinassi@usp.br
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v3 0/3] staging: iio: ad7780: correct driver read
Message-ID: <cover.1541082656.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this series is to correct two issues in the driver's raw
read function and remove unnecessary struct fields.

Changelog:
*v2
	- separated original patch into two patches
	  (https://marc.info/?l=linux-iio&m=154047435605492)
*v3
	- reordered patches so that fixes go first
	- removed unnecessary initialization
	- removed unnecessary voltage field variable
	- dropped reading voltage on probe
	- returns -EINVAL error on null voltage

Renato Lui Geh (3):
  staging: iio: ad7780: fix offset read value
  staging: iio: ad7780: update voltage on read
  staging: iio: ad7780: remove unnecessary stashed voltage value

 drivers/staging/iio/adc/ad7780.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
2.19.1

