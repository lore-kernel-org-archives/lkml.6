Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBB7C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 22:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB9C20837
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 22:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+vcFmST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAB9C20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbeHHAuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 20:50:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45800 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbeHHAuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 20:50:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id f12-v6so190827wrv.12;
        Tue, 07 Aug 2018 15:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Juswqv2h+CIKFzJI4RI5I24LA45LTT6X7Pyhzc62+m0=;
        b=F+vcFmSThDQdFSFowswsQ6WtJUsNYGcubvGt+K/cLpyTHz3qsL85wQWohIqYdfjY6l
         bFLwcEf3Drf3McAC8u817woeQ9+iQ+YnJ3IXg8AS6K4sRyRDj8b3JsW2h0uWNUnhLFKI
         2CxT6XEnb/NfqgGhsPwSleFgRrh6mJYKICu5lgMuAkqq6M8MSbjBkGmO9h3w1qzpeDEM
         6EE5mVe1P55E7jmkPSjBX3kyOiCcSaE0mzo6XmupYi8IFAkac7iq6z23PP30z9JveRhA
         js0YIHBqpxZtAJFO3yX2ZjUbPUCLKvNcRmUzb9PsN2o0aVDPMioIvWKJB0UOXbNXZPNw
         bkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Juswqv2h+CIKFzJI4RI5I24LA45LTT6X7Pyhzc62+m0=;
        b=hqM6bfNK9VCv/mjv5dXWAr1t18OrWXlRExnrssS+X3DdkRii9SsdwgLDXTHbJJWvSx
         knSSQGLSsDNdBtZxEXWLtynWn6ea3fCtoUmci2WVfurYi4C/uIKeUvhuEBQcDjiQAUQg
         TTGoWAM4fo5NTmL+V8B1MmAu2i2miQww/SXpw9WOmFyr/hBlidHf+ANd3rYmZeaVy5IQ
         pTJbL/oa0liZChoipW1r+FA4kvMZ0F/couNA/FgCnr26tLwMtldfj1MVxzTUlNSM8J/T
         VVojUNYIm3eZU5bcCCWDLg2AGPglAqdT6FeMKQ5Rx5KOmmOTdfoWcyP5rEuJTUv0+ltq
         w8wQ==
X-Gm-Message-State: AOUpUlFyHlOxUHXWY1WGWafEThPBV+LJlesfQKo1pl137Qs98FpMbeb8
        02BzwJoJ5adRGX6Mevr321dfUpM6GeZjpA==
X-Google-Smtp-Source: AA+uWPxy4JAhXv4pC4wdHwjSS8U93if6A4t0cDa1gxoVDxrAbZQzPxJV6bzpmeowfdf8NgafragN8w==
X-Received: by 2002:adf:f188:: with SMTP id h8-v6mr205572wro.214.1533681211569;
        Tue, 07 Aug 2018 15:33:31 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id s139-v6sm5003549wmd.41.2018.08.07.15.33.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 15:33:30 -0700 (PDT)
Date:   Tue, 7 Aug 2018 15:33:29 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/85] 3.18.118-stable review
Message-ID: <20180807223329.GC20628@flashbox>
References: <20180807172357.357252052@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807172357.357252052@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 08:51:02PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.118 release.
> There are 85 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Aug  9 17:23:43 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.118-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed onto my Pixel XL.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
