Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB22C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59EC20883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="t3OYj9ir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C59EC20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbeKISr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 13:47:58 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45690 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbeKISr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 13:47:58 -0500
Received: by mail-lf1-f65.google.com with SMTP id b20so768045lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 01:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s4DXMw+kdtmvuSFNhSsFI4AnY/HdDgTquRILLbQDOv0=;
        b=t3OYj9irBiryZolX4AAYs8s+MxFoEHIOgltijVr5Hle6u9n4XMvGrdT/VamLXY4LIw
         XD8NsRu/f1rnIsvfoUV1o/ru0lafKo44zjqXgYn10qMsmtRWLMYwLMyBU+Kfb/KTr0sx
         U0uC1qSliDjv0M4FFRVBbHSiqBZTrI4hmzZN9yQJW9RyGsrSduJzcV+bEfeMe1TJHsnu
         FybNlTvdVK0JRkDwA89H2pqpolRnhU2PdI3Haniua3p2OCOQmLOJU154tI+S51BHdCvm
         JRTzO2gAVCLtsTw8IhjQIEVHFbb+7Mkzeyuu5T4kHoPybVlb5U62Z/WWw9wNRc7c0Qz4
         wgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s4DXMw+kdtmvuSFNhSsFI4AnY/HdDgTquRILLbQDOv0=;
        b=R1TvxXi8jVuVSlklB2XhnJ9o0LkQpEg5zmGKKLGebsJQbCw3ZsWpRX9H405CxKQnsC
         g1mBz8px1hxLHWQ9/aCdzkAhLFWxqLXrRvY3f6VsUJf4D9uS/Q/lZWdMzbFeM9Nz5Y84
         60/1PNlcGxdWeNRbbXX8oQB91Z3z/Vr0Dk492XhSDbtCFuuIMVybeQReYrK+/bRy8bL+
         ndm9tU3k7PGqU+zfIZYThmr1deDH/+tXvUXwF1rWaOJyVqox/JiCJkavacZKQ4RkNlnj
         7icixRUNDqiSsnnulPP+SshAWd0GNqJL5290KemDFQN4P1GBZOm+npxco4uCyjqxeGrU
         G5aw==
X-Gm-Message-State: AGRZ1gKo6EbWSAcr5ivuAT6+kPLI4N9lELGcmbbEkWper5UOdPynkOwk
        SF0LqQGB90EDYXk1GF0LXfSk1fVvfn4=
X-Google-Smtp-Source: AJdET5eIJU1h7R99s+m9Akn/ekiwQDwFem2K/kxC/7Y3+AGakphqAXPYC5yMNwxioMNqDz2+ElFCuA==
X-Received: by 2002:a19:5510:: with SMTP id n16mr4819240lfe.68.1541754497872;
        Fri, 09 Nov 2018 01:08:17 -0800 (PST)
Received: from [192.168.0.36] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id m6-v6sm1186463ljh.16.2018.11.09.01.08.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 01:08:17 -0800 (PST)
Subject: Re: [PATCH v3 0/7] PBLK Bugfixes and cleanups
To:     hans.ml.holmberg@owltronix.com
Cc:     javier@cnexlabs.com, sboisvert@gydle.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        hans.holmberg@cnexlabs.com
References: <20181106133330.26570-1-hans.ml.holmberg@owltronix.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <5b549e02-5c48-4f11-f969-a849b17e7991@lightnvm.io>
Date:   Fri, 9 Nov 2018 10:08:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181106133330.26570-1-hans.ml.holmberg@owltronix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2018 02:33 PM, Hans Holmberg wrote:
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
> This series is a slew of bugfixes and cleanups for PBLK, mostly
> fixing issues found during corner-case testing in QEMU.
> 
> Changes since v1:
> 	Messed up from:, now the patches apply with the correct author
> 	Pardon the mess.
> 
> Changes since v2:
> 	Fixed kbuild reported issue and potential divide by zero in:
> 		("lightnvm: pblk: set conservative threshold for user writes")
> 	Fixed commit message nitpicks reported by Sebastien
> 
> The patch-set applies on top of:
> 	remote https://github.com/OpenChannelSSD/linux.git
> 	branch for-4.21/core
> 
> Hans Holmberg (7):
>    lightnvm: pblk: fix resubmission of overwritten write err lbas
>    lightnvm: pblk: account for write error sectors in emeta
>    lightnvm: pblk: stop writes gracefully when running out of lines
>    lightnvm: pblk: set conservative threshold for user writes
>    lightnvm: pblk: remove unused macro
>    lightnvm: pblk: fix pblk_lines_init error handling path
>    lightnvm: pblk: remove dead code in pblk_recov_l2p
> 
>   drivers/lightnvm/pblk-init.c     | 45 ++++++++++++++++++--------
>   drivers/lightnvm/pblk-map.c      | 47 ++++++++++++++++-----------
>   drivers/lightnvm/pblk-recovery.c |  1 -
>   drivers/lightnvm/pblk-rl.c       |  5 ++-
>   drivers/lightnvm/pblk-write.c    | 55 +++++++++++++++++++++++---------
>   drivers/lightnvm/pblk.h          | 16 ++++++++--
>   6 files changed, 116 insertions(+), 53 deletions(-)
> 

Thanks Hans. Applied for 4.21.
