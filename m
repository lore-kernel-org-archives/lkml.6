Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC5DC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 11:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147CD21734
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 11:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=prjkt-io.20150623.gappssmtp.com header.i=@prjkt-io.20150623.gappssmtp.com header.b="ac4vNpbg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbeLOLOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 06:14:42 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35734 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729192AbeLOLOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 06:14:41 -0500
Received: by mail-pg1-f196.google.com with SMTP id s198so3905433pgs.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 03:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prjkt-io.20150623.gappssmtp.com; s=20150623;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=YVrdsweQMsG8v31DB/jl6OILhfLAdtbmrsscR/V+QcI=;
        b=ac4vNpbg0M7pzKFSzkcedvhaa0bErXrTKJnNHpCCRzl7/Vyz070CTZBioLqQxwOYUf
         5qUrU4MHHAPKILMTf5gVBKwhnOLZHzdzQzyIrd7TnEvg7fivJ1VWFBR8Qp1xG6mAyDQk
         CRWI37uteXjPc6PnnoMMCdlyC6nc9uw+bIWjuegGRiXov7MJhQssgAVuL4aK07FZPD2V
         ZEOAqIagp9kNChz/NmDeIJpP8BEq19HnLod8szdTTrsA2aVBxaO2McaqIdFRrJmc2wN9
         s+RRxGeAM7SWRbQ5wJXg2jH9UCcUkO8Fuk2zlmX1CTSep7pRhghw38p5kwh3L/ltfXM7
         YxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=YVrdsweQMsG8v31DB/jl6OILhfLAdtbmrsscR/V+QcI=;
        b=A9G5EWTzZZYYRrcqYcHT95orKLRg0wwEsFeyPEUi5qNv0B2y4Vtc4TYaQONfu03jFw
         67bcJc9Z0Bhv20WojjuETBCSWCd59sFcl4lNM1QW67rbUrotyS+7X420F7X6OJcxJt2p
         cgRxei4EGy4D8bhibcRmQ8LwnKdNadGGyxO8rD53c6FkLDb09vUvuBNJ+C3w1bCOP+CG
         Qy7loCr55+j7KY7NF0U+Oc9lX9LhE059wAZhKN1J72RyGpvij6kPEbLUEpTtTVyGwFGE
         kM6tH3c/2+Zz+HY6pmK50NDQOinfeJpAd7frYOTI7vKtSOueq5OcuV2bULFOLqkoi04R
         eOVQ==
X-Gm-Message-State: AA+aEWZpfQ5V8TMRbym6X/uHtrxABWkhy4Ei6yAWvvI062ByCi54zUTW
        iHjQhdPig6cHw/RnLxV50Tk7wg==
X-Google-Smtp-Source: AFSGD/WHXWDLqUO5FhHy5lWx6jcINU1JSi7u8pSbB98r6YPzNd93mzkIU4RsfXtkAhjg/oSCJV0Rrw==
X-Received: by 2002:a62:2c81:: with SMTP id s123mr6062402pfs.174.1544872480931;
        Sat, 15 Dec 2018 03:14:40 -0800 (PST)
Received: from [192.168.0.102] ([160.202.36.248])
        by smtp.gmail.com with ESMTPSA id w136sm11466743pfd.169.2018.12.15.03.14.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 03:14:40 -0800 (PST)
Date:   Sat, 15 Dec 2018 16:45:33 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4.4 00/88] 4.4.168-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
CC:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
From:   Harsh Shandilya <harsh@prjkt.io>
Message-ID: <FF529C4A-07F3-4B96-8935-D0EB26638094@prjkt.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 December 2018 5:29:34 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundat=
ion=2Eorg> wrote:
>This is the start of the stable review cycle for the 4=2E4=2E168 release=
=2E
>There are 88 patches in this series, all will be posted as a response
>to this one=2E  If anyone has any issues with these being applied, please
>let me know=2E
>
>Responses should be made by Sun Dec 16 11:56:41 UTC 2018=2E
>Anything received after that time might be too late=2E
>
>The whole patch series can be found in one patch at:
>	https://www=2Ekernel=2Eorg/pub/linux/kernel/v4=2Ex/stable-review/patch-4=
=2E4=2E168-rc1=2Egz
>or in the git tree and branch at:
>	git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/stable/linux-stable-rc=
=2Egit
>linux-4=2E4=2Ey
>and the diffstat can be found below=2E
>
>thanks,
>
>greg k-h
Built and booted on the Pixel 2, no dmesg regressions=2E Rather clean merg=
e, only required adjustments in two places in Qualcomm drivers for the get_=
user_pages API change=2E
--=20
Harsh Shandilya
PRJKT Development LLC
