Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048DCECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE00C20875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdW8CFm+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE00C20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388521AbeGWQNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:13:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40697 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388097AbeGWQNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:13:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id t6-v6so1076584wrn.7;
        Mon, 23 Jul 2018 08:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MidtYc8ozvHkxQCnsAATIDpbjJLK2cI7UsGIrSPWnfo=;
        b=DdW8CFm+sRjUXrP8s2Goq5L4jWqKfZHfZZs2ZCbtfUgT19c98JwTgcZ4O+e2n1vKwl
         ZiO1zuc3nesZrGgf8kIGha+FdZ3MGKer0JgrXJ2ixXBIXmVP0kLIN1HwtmRvq3gBaJuF
         0w99v/65xcLxBnFOMqigT9v/88NLFANx3Szr/ZYMu3MfjfN4AXneVGovB4RJ0E9fohcN
         ++7bT9+VZtv9IIIiQD/a5ZACocmi4StZz6u44jIdziHEJ3zwqFoiL3HDRgMFRdTOwLK+
         ihqNq/aLI02mZ4cHS3iK0scUTL8F9/j5b8GLxe5DOPM34274nGSm1jPHol86tKLZNtsX
         HezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MidtYc8ozvHkxQCnsAATIDpbjJLK2cI7UsGIrSPWnfo=;
        b=Ft81Zl0omKyuZCHHVBiYn3bJRAyEXg0nPMhIEKIynqUuPS2rjYHeVO/OyJzTqf6A5S
         rpkWALQpGki9wTEUs0j1l+peW9Jznkh22rcytqnx0V3RPmTl0adlbS5eyjM9/FojlkGl
         67JCniXUttWWLnSwjMoLnJOdH7tWBuXI54UOVn6PXO1dZxVPz25+IXCHb0JbzhQSsey1
         r6IjNQOoYeK0wp5vyjzWtIHq5NquoukHisbr/sTxpp6683M5U8jk5WhrRMRS+ogiuyNs
         2C5fv+fPThnt9c2+yA6O7mjYWTUIeGBluU/w2di9R+OQ2zfUANiJpFIm9md1rB9MskqU
         AbYA==
X-Gm-Message-State: AOUpUlFlNJsR5Z3MNf+PYqYFMnfxdYLfP1T2vLpGSO3tWsgYU9TISdQS
        1o9B0vDPDEXtQ8hT7GgU6ek=
X-Google-Smtp-Source: AAOMgpdNdyIADLPDxK1R9bNyA8TUz2dtLAy60DnNgh6xkHgKXI64pWJgGfhmRh+lRv7HDrxQHL0SEQ==
X-Received: by 2002:adf:fc45:: with SMTP id e5-v6mr8893927wrs.157.1532358698653;
        Mon, 23 Jul 2018 08:11:38 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id w204-v6sm2635493wmw.5.2018.07.23.08.11.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 08:11:37 -0700 (PDT)
Date:   Mon, 23 Jul 2018 08:11:36 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/107] 4.4.144-stable review
Message-ID: <20180723151136.GA31725@flashbox>
References: <20180723122413.003644357@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723122413.003644357@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 02:40:54PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.144 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jul 25 12:23:53 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.144-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed onto my Pixel 2 XL.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
