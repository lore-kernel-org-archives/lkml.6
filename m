Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B07C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD86020825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUkx8auz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD86020825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbeKHWid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:38:33 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44099 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbeKHWic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:38:32 -0500
Received: by mail-qk1-f194.google.com with SMTP id n12so26171265qkh.11;
        Thu, 08 Nov 2018 05:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=sUR7VTLIRaI011Np0xxYMZqLrPu+H6IpuQbiDwJZflE=;
        b=gUkx8auzpFIlis6A85zX3Bkq+VbG2GNiJIUt+bKNqmWkMfrV5+U/C8RoA0z9FRGvi8
         dkK4h7B3K/T8P9AYnZoYLNRESns2rDFzeXieKXpkT8uH1OIMzDBGXXyt6RfpYooM7NQU
         hZTkhhKrbCHMEdx+mvCeTlERx55jsCmdrEHV+YeOubNSjUumHfsK4HVhObWVFGvDWIui
         RD5c8Vgs/zYBhQrqYGZjk5QYgGrArh3mP7nAFq1/1uiqgj30D7jEeGEaakjqGpay94Vx
         6QPqArV0dPGbkoCLq2crrd/Nq+qG6u2kyx+Ayg1iI0z/wF+9pjP2LL2rysLhzb/b6wQs
         qM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sUR7VTLIRaI011Np0xxYMZqLrPu+H6IpuQbiDwJZflE=;
        b=GjRprOYFb+aKJN7/dU4DEdb6ILjDGKNYHqeCy3yyXoqhDfrOgKTVNGk2iEKXin2mJk
         /i7qacY2uZ2G8IPVo6cJ+n2LVBqXb6U4/h7SBHTomgaMMK7KPmhL9K4/3Ud7vf+v2ZI+
         9e+uBdcfrW0PwfnPm4b/IK7MR+DOpHgPkF3OQIf79M/mR1Cu/lSxGzQYe4yYZYzYwPTy
         sUvFjwpExSSD7ax1hC6DBuGR+MWxkOLeH45AhEU7KVtt5z8w012oODz5eP1Mq0y+dolx
         R8a1pFEMrnurUyqy1cOej8l1RI4nZ+YjaAXzmZJU+17aKj9iRq47TJO54xlPt5QqWV3J
         lK0Q==
X-Gm-Message-State: AGRZ1gKTZ82f2EB1Oy3XfVG0STJqVbgSSrNQ4Hj54OR8p6hRRsfawKlY
        f57TyGFhWbCuOuXQbrBAZ0M=
X-Google-Smtp-Source: AJdET5e2rsviW+3UbyQVkcHmoBgN91yB+AALy0dKuQHGMDZpKM+1w4yJzk7edopH5CIWVtjXvymM7A==
X-Received: by 2002:a0c:aa84:: with SMTP id f4mr4170835qvb.243.1541682188532;
        Thu, 08 Nov 2018 05:03:08 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d6-v6sm1799752qth.18.2018.11.08.05.03.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 05:03:07 -0800 (PST)
From:   Giuliano Belinassi <giuliano.belinassi@gmail.com>
X-Google-Original-From: Giuliano Belinassi <giuliano.belinassi@usp.br>
Date:   Thu, 8 Nov 2018 11:03:02 -0200
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        renatogeh@gmail.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v2 0/2] pattern generation and gain update
Message-ID: <cover.1541681371.git.giuliano.belinassi@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches fixes a bug in ad717x chips where the PAT2 bit
was wrongly read as a GAIN bit. It also refactors the pattern_mask
generation with the PAT bits.

Changelog:
* v2
	- Squashed is_add778x flag commit with the gain update fix
	- Changed u8 is_add778x to bool is_add778x
	- Set pattern and pattern_mask as macros
	- Aligned identation of macros

Giuliano Belinassi (2):
  staging: iio: ad7780: check if ad778x before gain update
  staging: iio: ad7780: generates pattern_mask from PAT bits

 drivers/staging/iio/adc/ad7780.c | 55 ++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 20 deletions(-)

-- 
2.19.1

