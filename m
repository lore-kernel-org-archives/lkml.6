Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE2FC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C0F20825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMRQY4JY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C0F20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbeKIV5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 16:57:30 -0500
Received: from mail-lj1-f173.google.com ([209.85.208.173]:40841 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbeKIV5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 16:57:30 -0500
Received: by mail-lj1-f173.google.com with SMTP id t22-v6so1392063lji.7;
        Fri, 09 Nov 2018 04:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vFbuTLTMGuDOf4qii62CvVyRQ/QK9ZmFRBVcJREqFzs=;
        b=MMRQY4JYt0CcLG9ZSHwS+v93dz4RrasuTUyScMWGv46Wie4nrUn6HsPhs3XmPyMbMy
         zTg4DcMn5rpsQetgbqBH6ogbptt8eCqxD8zzLfmuOhM57FTAyESRMXSgFUOppzZ4uKRb
         50vqYbITeWHH3OEohVfUz1xYVLKtkazQrCceIE9OsjIRmeKCS+cACAGt77TEPaQZTjWO
         ImtJktjtINl3ZrU3noayxOchamc9ECFqRUCoiVEFSU+91zgB+PnKkeXROc6VKyM9F690
         7ShDO8rDknEwOxMqMAlXett0DifwTWIF3zfiOf33uP/eP8dNfscZ7trdBF/Ubm0gmaVT
         8TfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vFbuTLTMGuDOf4qii62CvVyRQ/QK9ZmFRBVcJREqFzs=;
        b=Tw0ZgCBm+wDSEbnTl4EBIMLdxqfa/eQoyY5/UJc2JOk2klBRisQ7Nii/IF6kCGWgt5
         Oarwb4UT3uPCGJ0L5yzWcMAZhp96huIu79c/qqdV0ndZ1b5FsjXk8VZWTQo1SJZuMCs/
         4WoXykGTtaK4oAmsh0UqOX57UB4AezS8h3y0Cf1s5UaXG+OT+ZDnjN/B54sFrF+gkPvE
         ZM7yoB7ESnohmvVuy+WMYFbuxybVjG4R/VyXyPChSFccQEBKapUpAraQ/swLbSi8A1fE
         VOq6RafCm5wdgmcxUa9r2PH8PiUTAydE0GZZYzJAYSsEdVVT06i4ZIfIw1PIfFOPHE3c
         HjGg==
X-Gm-Message-State: AGRZ1gKhW/19yCdLdNsx2KD8+h6EH/1O55zEuWI0rkxGiJ3ocMxuOrRE
        Z6UfpgzRWsr46/mJwYTc549xyAUn
X-Google-Smtp-Source: AJdET5e4DGMw5ymjymP6Q0t9hIuHDQ0Qh3wFoj564rp1AgqENkKUQXzGtl2tTHbopPX9X/+UFxUYoQ==
X-Received: by 2002:a2e:8007:: with SMTP id j7-v6mr5626865ljg.22.1541765825596;
        Fri, 09 Nov 2018 04:17:05 -0800 (PST)
Received: from bars (ip-195-182-157-78.clients.cmk.ru. [195.182.157.78])
        by smtp.gmail.com with ESMTPSA id m21sm994964lfl.97.2018.11.09.04.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 04:17:05 -0800 (PST)
Date:   Fri, 9 Nov 2018 15:17:04 +0300
From:   Sergey Matyukevich <geomatsi@gmail.com>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>,
        devicetree@vger.kernel.org
Subject: Re: [bug report] armada-8040-mcbin: 4.20-rc1 boot failure
Message-ID: <20181109121704.i3dvunpwqjhcfo2e@bars>
References: <20181109121112.xibwnc354wzsbovl@bars>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109121112.xibwnc354wzsbovl@bars>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 03:11:12PM +0300, Sergey Matyukevich wrote:
> Hello Gregory,
> 
> MacchiatoBin board fails to boot v4.20-rc1 kernel built using arm64
> defconfig. According to quick bisection of the board dts file, the
> root cause is in dts patch enabling CPU deep idle states:
> see 8ed46368776b3bc. Is there any pending fix other than reverting
> deep idle state support ?

Adding devicetree mailing list.
