Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83090ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418D020866
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZ0V5vgT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 418D020866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbeJRDRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:17:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34196 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbeJRDRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:17:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id g12-v6so12991114pgs.1;
        Wed, 17 Oct 2018 12:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mkps+6l/8sCJwG+Iz+N6Xcf6XQ7BpPNiCd+c3U9/8ps=;
        b=hZ0V5vgTT3PB3lV5/0HLQVQz0zG6RFfei3oTZC251gkzmfz/rILzF6Bvgh+Q67GnrP
         v2p1hPc7Tv3f9dVn9I+dnI180kLtCViE6OM6nufKiI6+SYZ2KYC6vGvFaDMxP7Z1hre9
         hae61wnhu+NirduQ0cRpo9Em8GokY4uS/gAY8boPxzcuAjp6YG0UeOSX/eS+Zm5lodIH
         rMkdSpAbV5fjSbONbVuagB7IBKNVR3IuqXtteKSLTCxEfO9/RviKuQkgQNlYHcmaiNyX
         INJGlZEwUbfTOIJY9OlWlU3vEzANviEHQlgHWo/M9fO66m+QnG7myxNY3HSO0uyajgY5
         V+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mkps+6l/8sCJwG+Iz+N6Xcf6XQ7BpPNiCd+c3U9/8ps=;
        b=GVcH7Iezdux/OkXfYaBxM2PvgsJBo2HjyaSRDoyq8BK13EaiMTNHrakJiDnDW5Iv9n
         OWW8fE28Oz6ETE5L7vujm7KPUT9fH9z8oyFvMpASf0N4tQqNGXBM0YkgeVAvCGKdYNmD
         XfbMxK9K3nSuikw/TpbciNdMusdXXqV/b9le2QgChQG1JjPeHCCY0f8NpwN8Dsb0Oh18
         8wGY48h1dpArVK25HZ20cdUvkx01dbWo+d/We6VvJokhJOsygT5aLeVESrdjB4QIuFLw
         EudadhMa5toe4CFOZUhQ4O3/aEYFrhubp0M4jYSSqxwvn89KS5Rqm4WeqXdSqwvsNO7n
         Qaeg==
X-Gm-Message-State: ABuFfojUvzYP6SDUpzrD/LR0rlOxKbFgZvpjZapui4PJec7PlLpRntbg
        bC2FBFzkscau3ug0ObqmkOQ=
X-Google-Smtp-Source: ACcGV60vMvR5328uLOslueX39JKBEmKWe102HG2/I6daqOaOSpDYwjez2i/KvF1QV6EUMpPhWUyBsQ==
X-Received: by 2002:a65:5347:: with SMTP id w7-v6mr26146151pgr.17.1539804033600;
        Wed, 17 Oct 2018 12:20:33 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id j5-v6sm22310423pgm.79.2018.10.17.12.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 12:20:33 -0700 (PDT)
Date:   Wed, 17 Oct 2018 12:20:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/109] 4.14.77-stable review
Message-ID: <20181017192032.GB1653@roeck-us.net>
References: <20181016170524.530541524@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 07:04:28PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.77 release.
> There are 109 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Oct 18 17:04:58 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.14.76-110-g3dbba66c8671:

Build results:
	total: 150 pass: 150 fail: 0
Qemu test results:
	total: 318 pass: 318 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
