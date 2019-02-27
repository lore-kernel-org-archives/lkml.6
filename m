Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9165AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568ED21850
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NQt03jJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbfB0T5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 14:57:21 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:37255 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbfB0T5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 14:57:21 -0500
Received: by mail-it1-f193.google.com with SMTP id z124so11927742itc.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 11:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=83V7j15vBBfS984rGnTbpuaKeqSIjpIFzcupAdX7D8c=;
        b=NQt03jJoTJFdaHZm7J4Uyq6Z7p+6gjFaDWBqFI6wvliWY5ZZ4+n/3pPXxwGs3YLK3i
         orjnaqS2HhpnTGa3uuVGIrNt+t7J24+wB/9+Y5J+16V8SDoV7RyW/6wJ5riwj0+fEy/S
         fLH2FiZ1NnjAHUdVIgPFkndHgz6MIV78qk2z8xdzNnZ+odQEuAf46AHaftUS1LvkgkKS
         1OagM45BOod/D4GCTNrwHU6dvWL7XlRTOGKPm6uiKRb7in9Bh42+Bu0xou/dklo8SJbc
         7+6ymxy8HJrpCJa1Vwq66nNW7KVU710qd3+CQYLskcEl7qC1S4fB4u2edWuhr8KK8MQF
         66iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=83V7j15vBBfS984rGnTbpuaKeqSIjpIFzcupAdX7D8c=;
        b=KuFuIABainifiR1mqZx8QAcurRIULZcHE3HxGSZ1DD2XuK66bs9tQdQPtcBpd5qJvl
         1BYI3C3WOX2ksV4MqI26+wDWlU/3wKsjDsel1e1v+VUF7bU1at4vBHny8Ko6bqDhjF0y
         N3x0WBPGAlCgOvDm+bm/9fPK6wA+atDkKJGqliaCHonx3K9LMWg1sG7V2HEKuhMAJmw/
         bXx5Jgvrdai/rzHP2tISHGBNpzgRgSme2Pi+g/0XU9DldURIrXbFGDvCMdcNoZZGbskh
         VgdIh9teLHk2PGgrdl4ipwLxiPiy+ABIHNplf0rBa67HCyonccHSbuoLtay/+gOD4g30
         UfDA==
X-Gm-Message-State: AHQUAuZb7mOB83nOjOpqW0QlaHmNwJweZqmWGlzCefsAP+8KX/wap92P
        cxUKi8ZqdB2HP/8KJkbzfRtRwpfUg2zKvoymLBj0+A==
X-Google-Smtp-Source: AHgI3Ia8t6dhqsh5P6ddYLI/koz1ESlPY9C2OXqa/0TUbNSOWjCOsD2hqCZCJYXnyPy0gMEsnFc57+2hyR3HWbD5OHo=
X-Received: by 2002:a02:76c2:: with SMTP id z185mr2328462jab.102.1551297440002;
 Wed, 27 Feb 2019 11:57:20 -0800 (PST)
MIME-Version: 1.0
References: <20190222202606.160816-1-matthewgarrett@google.com>
 <20190222202606.160816-3-matthewgarrett@google.com> <20190227140259.GA17106@linux.intel.com>
In-Reply-To: <20190227140259.GA17106@linux.intel.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 27 Feb 2019 11:57:09 -0800
Message-ID: <CACdnJuucWezNf3jki5wN2XJ6wsN_uMSxQuyrekr9F-3aJJE4kA@mail.gmail.com>
Subject: Re: [PATCH V4 2/4] tpm: Reserve the TPM final events table
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 6:03 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
> My guess is that your patches are based a later 5.0-rcX. Unfortunately I
> cannot update my master at this point because my 5.1 PR was taken to
> security tree and rebasing would change the commit IDs of 5.1 content
> because security/next-general does not yet contain those patches.

Bother. I'll rebase against your tree.
