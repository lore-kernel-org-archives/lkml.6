Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5884C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7966220659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7966220659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbeIFTLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:11:23 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44498 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbeIFTLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:11:23 -0400
Received: by mail-qk1-f195.google.com with SMTP id d131-v6so7435188qke.11;
        Thu, 06 Sep 2018 07:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kcvla0kV4NHcFw3QwcM7wWDpAKpbbcozGK5eYXEoSpY=;
        b=tuz6oPSsShZV+6uKSwIV7xy/fectJtNq5aLLG+7+RGU33b6XxaK0l/HgDNAXt9Nqhf
         vFpGnIq7ia860gaLdXrEKEIJJEeexijFWnO3gFecd+6ztZs9dDGljbkMLL713DM1BAeh
         1R08OemgAL7svdsivUSfDpkJoFMQqM4iWGHCaGpsOyxdTyN5D/mhPtFW4tn9hGDmZhHp
         KKOinWHkz548LW89qC3CJST8OJra3vV8XrVJD5659DxsvPfrC4FLGfOYM7phVWXaikGE
         /JizPbb3zyS4JauVZWxEwmhMgHJIR9CV2dFwYX5LegQmPzWYUeAGGrFSYOv1qbGT6+FE
         Q4FQ==
X-Gm-Message-State: APzg51CvoqR985/GYPmxD3/NLtUqkGrokTqj++Y2YXyS9aQP0Ifybrv4
        Ebr2EFaLRmeM9W4+Yrg6Mmrij9S/YwtblAoe9ww=
X-Google-Smtp-Source: ANB0VdYCDUAu2kodWLVI/um6ILZK0B1Uv+knOTbFgtOvomG6DlXAQQXVHdUNwdiZf5Z5rIPfNltdtwJ7DT+NHJg2hhs=
X-Received: by 2002:a37:7347:: with SMTP id o68-v6mr2300148qkc.291.1536244533087;
 Thu, 06 Sep 2018 07:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536138304.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1536138304.git.ren_guo@c-sky.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 6 Sep 2018 16:35:17 +0200
Message-ID: <CAK8P3a3rACZHeSUm5Tct2PxfY4_GfkFEjb2hCwLWSpvNc2qDtg@mail.gmail.com>
Subject: Re: [PATCH V3 00/26] C-SKY(csky) Linux Kernel Port
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 2:08 PM Guo Ren <ren_guo@c-sky.com> wrote:
>
> This is the 3th version patchset to add the Linux kernel port for C-SKY(csky).
> Thanks to everyone who provided feedback on the previous version.
>
> This patchset adds architecture support to Linux for C-SKY's 32-bit embedded
> CPU cores and the patches are based on linux-4.18.4

I looked at all patches again, overall this seems well done, thanks
for addressing
all the prior feedback.

Most of my comments are are for fairly unimportant issues, the one thing
I found that needs to be properly addressed is the asm/io.h header, which
should implement the I/O accessors as your hardware requires them.

       Arnd
