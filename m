Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1263C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81ACA21655
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cr3bDfUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81ACA21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbeHNVq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 17:46:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41548 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbeHNVq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 17:46:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id j5-v6so18074438wrr.8;
        Tue, 14 Aug 2018 11:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TitiTOLOFT9g75MsiYHuPBZyhEtH/ktwpNk8cShak7w=;
        b=cr3bDfULIS3ZUJt84Sy2us9X8tYEv3r5wle42538s13JzKV3//zdIojEoinlI7wMK+
         cRr7iJ1DxOlvg26D5cEwAXhgo2lc4npUgpPYEYENq9bIShlA01iIdJkW0cV9+Wr0u/K7
         20cD9WLXt+TI3sI/aj63sjrrBO6cWioOJTDZw5LkVrrTKjtAEcmPD4qh+WNuqz5TooW+
         IWBCeqmtvVQa1T+7UZgAp4vdb4R8n/8LJM6J0Xif1YF6cJsLN6kk5OZOyUb1josojaQ2
         VMAGiW9lj8shjrCAudKWkYLdPNkX6+E+wqmZNTNKOMLLxnIQz1dUXrgkkNXkdQLz2cp6
         s3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TitiTOLOFT9g75MsiYHuPBZyhEtH/ktwpNk8cShak7w=;
        b=NZIUioUL0NBYyTBj9A1saSMRPiYNxqX2lWEgSIGITx43o+GQaAesj8L/DS5TmSkF39
         EDYzoWpiX10zo8WlmOeE6g6PFzKHlDLqmM54k/A++eQbjVr/DA8/3+hZO3z6KOJYRV6l
         wqSU9fxXE2PxdeT5CPemxoGkjQLQbyAfm7sm/sIRad+Mkjnq0weQiFInbLAkX5XKAgGW
         H2F2xmwjt1eEUlhR2UAwqMz+nFbu+RJflYaJy72S4CU9cbNLQDTa9CIJHX7bAeSjBcY+
         Ou1YUTAbKwave9pKdbFkQET+xzs5qd87z/DzEWkVFrcepbJsWKLPgpyeLVyO9J7Mdaxd
         aJ3A==
X-Gm-Message-State: AOUpUlHuf+a+LJFkW6KH0j3wA/dz/s2t3WmyO+uD9gqtHx6zm3ewIhEI
        c/Lh/kLd+rYCENNxPEG6NdY=
X-Google-Smtp-Source: AA+uWPyJ62AVZBndUHxr6APRqqDMhud7hEOVqDBuW2forp1F5LXzhR4LiDAZBrdY2Wefa6o0olNG9w==
X-Received: by 2002:adf:f001:: with SMTP id j1-v6mr13678873wro.260.1534273101316;
        Tue, 14 Aug 2018 11:58:21 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id e141-v6sm22489149wmd.32.2018.08.14.11.58.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 11:58:20 -0700 (PDT)
Date:   Tue, 14 Aug 2018 11:58:18 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 000/107] 4.9.120-stable review
Message-ID: <20180814185818.GA7987@flashbox>
References: <20180814171520.883143803@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814171520.883143803@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 07:16:23PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.120 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Aug 16 17:14:53 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.120-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed onto my OnePlus 6, which is
my daily driver while my Pixel 2 XL is in for another screen RMA...

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
