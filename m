Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E6EC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDB52087F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="PlgX07nt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDDB52087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeLMGvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 01:51:41 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33477 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeLMGvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 01:51:38 -0500
Received: by mail-lj1-f196.google.com with SMTP id v1-v6so815514ljd.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 22:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=liTu7i/BxQ/14hVWUvO7mO/zt9R5JN2dQC8H0WBWFJU=;
        b=PlgX07ntho9DEthvYS8j9Cf09Z1e+4nZWDAzCGn5ZasGXNL/+dLz7jSc1ZtxeaIshJ
         o4ZidqBq58W5+J7vvaotcSMtU8AUJ67STbPnaaGZgjeVtOG/Va3//qGr6bB4cRicyV5D
         hjqNo21e1hfYTRrZXO7mLF8seigUjx/E+6R/A9YA/n7ChxwIaQ1mRVkwqCrxH605IAjg
         zjFdeFn46/dgOYAI3sUbnCatQhHZXGesXgH+8WInQM37VYoXhQKap8UzY2rYkZGadZEn
         pEgCz3j/X9EGQbhkAPlRUihbs57XAoDIzzvCZ4nSoq7doDRFNUGjGdD3HP1yFGYTri0e
         TSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=liTu7i/BxQ/14hVWUvO7mO/zt9R5JN2dQC8H0WBWFJU=;
        b=gA/70SdLf3c7rxHlDdHBdEvnnrusGP/dPe9YC3MfyzP8MZsc3J3mjH3yW1tufXLifK
         cCQikVIMJgjaqTuFf/wS21mBKv3MmIpWpKTFwcSXD1kviycdLGJ/zVRoprQ1t1bq7E/Q
         Y+vBN9EXkI3ebGAgkLOY+LHoa8PMBLV0llBRJgtHqAMZCqNdrEg2JIVq7ug8b39GAElj
         HVRkfSmBKK1dIXAsT5pKEj5fjWGIGYCnRNqO93Pk44NbsWN2mkxdyBQi27V0QASnWXkZ
         yLUlu71J8pbS1kAQlRw8Tj0YQAtoBh3Jhr/F+V2ulZjFCYRAWlXaqK4CgAb31nGbzwJW
         aQZQ==
X-Gm-Message-State: AA+aEWbpAb1gOsED6GqaQBIm299KEKvKuV38zmm2HF2ORuB4kgd9ACW2
        bVTj1cSvvDXHwPrF70VdWloxXQ==
X-Google-Smtp-Source: AFSGD/VeBKi4mF99u+BqBDO7jfL1EAh4g58s1c05k7+jDT5FmqeUb+PE42zh0Y51mbKC9KymsE+FPw==
X-Received: by 2002:a2e:2c02:: with SMTP id s2-v6mr14335725ljs.118.1544683896144;
        Wed, 12 Dec 2018 22:51:36 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id z6sm175067lfd.50.2018.12.12.22.51.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 22:51:35 -0800 (PST)
Date:   Wed, 12 Dec 2018 18:16:39 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 5/9] arm64: defconfig: Replace PINCTRL_MT7622 with
 PINCTRL_MTK_MOORE
Message-ID: <20181213021639.6n5suqypqxvyb5mf@localhost>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
 <cb016b53-906a-adec-d8c6-019d2c74569b@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb016b53-906a-adec-d8c6-019d2c74569b@free.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 02:03:20AM +0100, Marc Gonzalez wrote:
> Commit e78d57b2f87c ("pinctrl: mediatek: add pinctrl-moore that
> implements the generic pinctrl dt-bindings") made PINCTRL_MT7622
> depend on PINCTRL_MTK_MOORE.
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

Applied, needed touchups.


-Olof
