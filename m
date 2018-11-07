Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA38DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A26020896
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="UYKIWahn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A26020896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbeKGSRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 13:17:00 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35280 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbeKGSRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 13:17:00 -0500
Received: by mail-lj1-f194.google.com with SMTP id x85-v6so14041897ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 00:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uJhCXDpMB4CHmRSDfpZAmsbG/gVWqnv31v9wAomE9DQ=;
        b=UYKIWahn4q7dYASO3Ia+VzuPA/IT4DcrhcB4ptTyElig7Zj7YCr45rDWQvSe++Vjs6
         j2rmIgGu2FVvGGyXqWkwWubD+Q5UVHnIbP/Athwps0PdtDR511BlZBnXX2JIcv5II0g2
         Bf/3NFFKWafgesPgU4LCrlVng4bSLFDzgQbPzqtTx/N2nOEbmMNQ4qZcDnvl+wnVfDNY
         I2ezFiBz4SJVSnMSWfq5b37MljRuUd+yvzSWMee7/kNJnn8aB8ptNncblnJz/CLk8wOb
         M9kGz8CSaAzOty4xIV9fw2nHbAcdDoQsSyM5dHTZwVsXJI6UeV/ipnE+mKygI+kKuy4m
         TNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uJhCXDpMB4CHmRSDfpZAmsbG/gVWqnv31v9wAomE9DQ=;
        b=pXI5xAVmzjIZFPY74FFas4psLSWkrqUvMKtjQ7/tHhXG05/n55woG6yTTYjMyx20DS
         ldcu8yTrnsZf/S04k/geM4RczByppPVb+LBr9iQIYzkLe8XGxP4H9usveStpEEy9yhMe
         MXhzmxc9+kJ9hhOQtiJ0mIs1EEbv8TpIyDbf1D4WBxeN5T40rgH7asJXxPffpAE/m51V
         1CUjhGj6SdDtP1qrDGmQYGwAMwBQx/7RlfV/JVk/mMlYRDibVgU9+rCE5hYgqpqkxUUw
         q0JpasvzZ7/4nbnZ6EUr28YqOzW9ca3bklVg2eLPaT9ahOu6IO3wtE9y9WsKdQ3NqcJB
         SRfw==
X-Gm-Message-State: AGRZ1gKiXBZ6ZzCKmpG5ectpKDyY0b7O8DEYP0pA4i1KWXtFF6SYmVMf
        FZ5dLEcSxQD2FiMeeJkvNKqnqKJoNDM=
X-Google-Smtp-Source: AJdET5cjbL96D9EyyRbOjU1G3S3hf30jc+64ieDF6JkpEB54nhoSXAPTPlWheE6Kwn4R78cYdFNnhw==
X-Received: by 2002:a2e:449c:: with SMTP id b28-v6mr667106ljf.47.1541580456107;
        Wed, 07 Nov 2018 00:47:36 -0800 (PST)
Received: from [192.168.0.36] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id a20-v6sm1143905ljf.28.2018.11.07.00.47.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 00:47:35 -0800 (PST)
Subject: Re: [PATCH v3 0/7] PBLK Bugfixes and cleanups
To:     hans.ml.holmberg@owltronix.com
Cc:     javier@cnexlabs.com, sboisvert@gydle.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        hans.holmberg@cnexlabs.com
References: <20181106133330.26570-1-hans.ml.holmberg@owltronix.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <b73d4c3e-bc2e-9a7d-cc8d-abf5dacb874e@lightnvm.io>
Date:   Wed, 7 Nov 2018 09:47:34 +0100
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

Sebastien, would you like me add your Reviewed-by?
