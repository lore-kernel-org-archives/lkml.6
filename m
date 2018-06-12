Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 02DA4C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC65E2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfT/y4y2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC65E2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754237AbeFLSUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 14:20:05 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44317 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753455AbeFLSUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 14:20:01 -0400
Received: by mail-pl0-f66.google.com with SMTP id z9-v6so14824393plk.11;
        Tue, 12 Jun 2018 11:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kpr8yk+NtI8ZwacqX5sGGe2h2O0AzzEMIqCRY8cmZ34=;
        b=BfT/y4y2vDpP5V+ZjvpmD8NzuCkKZckkDgBteG3DzGX++nGRqy3fyJ0OBeevasCRoa
         jFjBI43Vtq1veprKZX3TlPw9KVqZC/KV6RCM9jDvkGWKBpUlITY25CIKTckI0o3ZRAId
         NA94fliBHYph/10jtuukqi3TgUc9pwpP3aIyiLdkrmOjBLd0TrBv9wLUrDgaBe1lucCT
         qyEU1e611gSAgeZenGtTBPShuRCg+Dswz5RsOsOu0IHbrSxrvI/vMC9Gl05jEDoQ/aXR
         /v1aSPXixEMPDA/2UZcE8vkvgM1AYMxorpaMMYLXbF9EfNAx2XIPazxBPRDGO3hQdGHg
         BAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kpr8yk+NtI8ZwacqX5sGGe2h2O0AzzEMIqCRY8cmZ34=;
        b=jgev0aULz783itZhDI4PX4ghg9iDJV+mKowH3Wz+5xBAKAfuLOh7u3xYWbQNal0T4i
         hqno21i+jpMiibXbWwt/ps/vsGQdUAcIXalyZjFw1jqMnFqJDac7lXpqQAZwQP7ZR67l
         uQgovpLo8j9HCM5UJx+8VBAh55v/XleM9hJG1mZEPQJ31+v1Lp1faIw3tS2g84I3pRDZ
         snF9nSRsQKDg2ifz3uto+UjLwpVqJV/VniarA5DQDvDHHP4yGfDN4yA9OnSoyyeuap4A
         6NdGpkaRa4YPaijtWtQmjoA4cGLRAySyZ2/TuB92PQi2kyAikExQz3h1PoZ4JmaswTQA
         Y0RQ==
X-Gm-Message-State: APt69E3G7FlJNcgldrepecifOkIZ3JX8mwcD9T3FhczeqoPNDtDObwbm
        OIIv1NXlvR6vGBW7wDCngO4=
X-Google-Smtp-Source: ADUXVKI/XLPrl0TGDB9/HggUfNTVa/royTAzpMGBG2ssYWIrI61IJ71qeR7xkg4t4XcqI/HcFnTfOQ==
X-Received: by 2002:a17:902:28c8:: with SMTP id f66-v6mr1636266plb.60.1528827600851;
        Tue, 12 Jun 2018 11:20:00 -0700 (PDT)
Received: from localhost ([185.236.200.248])
        by smtp.gmail.com with ESMTPSA id z64-v6sm1103654pfi.150.2018.06.12.11.19.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 11:20:00 -0700 (PDT)
Date:   Tue, 12 Jun 2018 11:19:56 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/21] 3.18.113-stable review
Message-ID: <20180612181956.GB2621@localhost>
References: <20180612164825.401145490@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612164825.401145490@linuxfoundation.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 06:51:57PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.113 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Jun 14 16:48:15 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.113-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed on my Pixel XL.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
