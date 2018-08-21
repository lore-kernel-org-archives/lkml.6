Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C825C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BABD217C6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKpr8s0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BABD217C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbeHUSSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:18:14 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:33037 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbeHUSSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:18:14 -0400
Received: by mail-pf1-f173.google.com with SMTP id d4-v6so8639907pfn.0;
        Tue, 21 Aug 2018 07:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iL5hgliDndPvwu7k6HA39M05MPYiJn86WSb7qbP4dX4=;
        b=UKpr8s0HGSmatTSU9u/0D2FGpJvBWRkC2fIA1KmJtyo0c1o04kyq9ByBxKq/rDzfAp
         W1ekKcMXcGvNxMsQ8/LuWUMMqBWrJHPgomNu+GUJVl2erA6l/tRV+sTlErDVT+lCDDOG
         0KvCnceWr0Olh8O/xQwe6oprHZMeSc8tXnqF1ZfiH48x85zcCeGlllgsdekUT+/7/p1Q
         iJ3jp8XrjkeEuOGElneM9htBZYA3dkGY2HoaeejSfxap9uY5rKMy3MI9yPIaHEk0Ngbf
         JvtPVVIIoBhJKEk0PzJUXfAZiVZevp0OUaIRHSOLhyeJ1dT6GMRAKMKJ1xEBlnEQSaUY
         dhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iL5hgliDndPvwu7k6HA39M05MPYiJn86WSb7qbP4dX4=;
        b=IzE7zv4JlGoK12lWCqMGbW2grszY1HgWFpFnmlYIA6m8z9IBiZTFg6ZfCr2DqsvVMC
         p6J+1Syj+HHo8qO4k+6Ll9GL/plUZ4GyboQdy2WMuQGHIy5tUO1YTtDfpv91YylmTIl4
         YH4MI4TGdRjpUYp1AHLb8NUicURhEyoCZuCqshJkazph9G1JgZ0qfOIov3viWMHfUpAB
         L9F0AswnQVJ188DcQdxwZv1lyCvc5WB1Bck9q+IWTlbz+2FYt+q52i+/L4WiJewKsJ37
         ClXv+MwzQETjVkGue8Hp98pNx7p4QUGClIGHmZ4y4EhHt/D/8a26b/A7M2NkcO5t8g5C
         ZWxQ==
X-Gm-Message-State: AOUpUlGUUMyqUVNwjcbeZGE9ImIpG7Avfqiw2RLZMLqE0v+hnovmvl1v
        sXoWOVhbu2mLZOi2q5iCgcA=
X-Google-Smtp-Source: AA+uWPwR5vNTVWaKA/SeoOT7KQc1G3cUk9Fuwa6L+3Sj689jdHtj+1Hk5bOUlMr0kbYoglsFr5MKhA==
X-Received: by 2002:a63:2a0b:: with SMTP id q11-v6mr46981364pgq.36.1534863464613;
        Tue, 21 Aug 2018 07:57:44 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id c4-v6sm22191401pfb.71.2018.08.21.07.57.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 07:57:44 -0700 (PDT)
Date:   Tue, 21 Aug 2018 07:57:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/29] 4.14.66-stable review
Message-ID: <20180821145743.GC13639@roeck-us.net>
References: <20180821055108.333930282@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821055108.333930282@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 08:20:53AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.66 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Aug 23 05:50:58 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 299 pass: 299 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
