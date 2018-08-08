Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2394C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD3321A18
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJL+tn29"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD3321A18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbeHHSH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:07:26 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39312 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbeHHSH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:07:26 -0400
Received: by mail-pl0-f67.google.com with SMTP id w14-v6so1210391plp.6;
        Wed, 08 Aug 2018 08:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R/3O2ern+XS+WdHdGKTAOr1XZF8mVwryHU3fU4hwxn8=;
        b=VJL+tn29FuMwAO4XMuhJFPmhyzYVI3XX1crsxXbsHV0LHrlYMdGvCTpxyIWs/1mQgs
         ylUW29QR6tFI9oi7cHGzoMPZY7QKZdLqgnfyWTtneUtv/504NwwUDHODD2xG7TredM2c
         BqZCydUKV2vBeDW4WHx1jJh/1aVRaIPeQoMDK3K7Wy+nrn0+odh/qAdgExUawPrt+qxn
         ty4krx3ksDnhoVy4K21HHJngxQZs+le7kDJG7PiCaonqjbLjQGwHTU0GVtqoI+FkpfT+
         zGEEaAMyyRGilfImYs6MVmupVky5DwPS0u4VDj/I3AjM/vN7oCgMIQUSimICUcIoPzLN
         105g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=R/3O2ern+XS+WdHdGKTAOr1XZF8mVwryHU3fU4hwxn8=;
        b=a///eSNIzHvhSzJ/Tfucze0Xr3tSTDPOoZoFkhlkxgFeAhlTrZaIFWnVQ9M/wUM350
         kJ/YBeWYCp7ZmnwdktrifemFFDL/zQJ9fdPH29kkLpRQs50/2LzaK9QXgKd+G/u8qRS1
         OYcFkvBmzANU0Ot9lmsbpexVY5lqkAwSJfOxIJnU4LeRhIYZzbsLE/IRxsQzV3y+zrYt
         4ZouyQ5tgaAQP8DngDaZ+HBhAyE1LAd1zAaNGHz/Q0p8KYjXPTIIpUvF6odPGepcHSL1
         4qLopswhezvyRadmF0PYFf3CvXrjMU6+1qYhwMNusaVipkWNuPhsaFV5LENJqq/xydyi
         8i/A==
X-Gm-Message-State: AOUpUlGUbKDsIPX7mxAbujjASmJ3Xc8QwR1/S047HkKN7xBHP66FECJX
        OIUPqTZipaA65ek/BwUaZT0=
X-Google-Smtp-Source: AA+uWPzah8dBwqF+q2/hcFZXyIRG4TTOrAZVTLL2xqJRhg0qWRHxLJoEbC9cOrXszT50oAgCEX2D5w==
X-Received: by 2002:a17:902:bd07:: with SMTP id p7-v6mr3163732pls.32.1533743231470;
        Wed, 08 Aug 2018 08:47:11 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id x15-v6sm4723414pgc.46.2018.08.08.08.47.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:47:10 -0700 (PDT)
Date:   Wed, 8 Aug 2018 08:47:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/12] 4.4.147-stable review
Message-ID: <20180808154708.GA5368@roeck-us.net>
References: <20180807172343.326201671@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807172343.326201671@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 08:52:04PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.147 release.
> There are 12 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Aug  9 17:23:34 UTC 2018.
> Anything received after that time might be too late.
> 
Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 249 pass: 249 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
