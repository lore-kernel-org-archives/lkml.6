Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54709C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 00:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C10218DE
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 00:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQeE9bd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfAEAez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 19:34:55 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:34353 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfAEAez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 19:34:55 -0500
Received: by mail-ua1-f66.google.com with SMTP id c24so12555153uak.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 16:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:sender:from:date:message-id
         :subject:to:cc;
        bh=5X2ykSD+Z2E9Z3yOJY41ClW0eBg2tNrdIffr/IeHYSk=;
        b=ZQeE9bd+1Ir0v7sB/94OsGPlfzaB9byWBmfOfQ0GF+ERI+OKd0cYMn2J9mj07fHx+L
         kRrjCobC4iUWP+h6R0yNoTgc16QvWXziFS7ZOytu6Pz+FexXguX3HD/2CTX+L9GxVn6n
         WW7mEWHBXjvoJ2H36WIl56/RiAC1kgaY6wyDCGReZWbWKcYfLnf0EXZxlq+bBLrqk3wX
         BuK+yiexASjEdO1grGLSIZfqzRxOUD1XQmlaLfHs7YgQdUH1Hv0GeE8+17LvnaKJrt0y
         yeAgu0wOvuRWG+as+1+MiLnWJvvTCauyj7blXcdBUM0fxRhAI5JfmahhtK/XqAeg7gQm
         FTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:sender:from
         :date:message-id:subject:to:cc;
        bh=5X2ykSD+Z2E9Z3yOJY41ClW0eBg2tNrdIffr/IeHYSk=;
        b=qqiTXAZzF5zvQzPxM4Sh3h7b9ESIB8WPKww8sPM0IHdjbYPKLX+Zt6bVU6DEh3sIVb
         oJ65OrR/XjflS3NU2IiYNOPKUAlet6miaqPMq8YLmdVPRpAG5xuVvJFRxpVLfP3lCr+E
         9CPjRHQDOOdHpxk3naWWWoaSf5f+wevYxZU2Kd0zQDueeqMSQYSkEsTxx4F5UTuCkS2K
         vGO3yDT8RNUpAlE4piDz2Jhgd5icxNnEhFNUK9uAPmpajY1vCFuH65t+wJEG7ISBpmLK
         CE8byyLrerMR85sB1OlaLbY/nJiZ8Gu5jPfYDUzdXyPcOVmr39orFKUckcXFMeWoa+hX
         hBAg==
X-Gm-Message-State: AJcUukeWoQSSY7ZLxrcwVPFJbNpufC5Zprab4vCxSXaBqQ3+xND+sjU7
        e2JQhkJZWqDl/DMPFPXvnXnM2HCNvDTExXU2m9PigTTc
X-Google-Smtp-Source: ALg8bN4XGgb7cH4GyE1zJlEzbPzIvO7gySYWf1BnIxiskhbnU6g+R0K4/Ab0mJW005DuEJEPND1pxubriTMyL1m2r78=
X-Received: by 2002:ab0:25ca:: with SMTP id y10mr19172567uan.21.1546648493760;
 Fri, 04 Jan 2019 16:34:53 -0800 (PST)
MIME-Version: 1.0
References: <s5hk1k48ayx.wl-tiwai@suse.de> <CAHk-=wg+hjDa8UGRVnCFytjwYLPk2yDgJoKOESVSE7_6KfaeTg@mail.gmail.com>
 <20181228124303.GA16558@gmail.com> <s5hmuoplgw2.wl-tiwai@suse.de>
 <CAHk-=wjXVPpDWHzvNL=9gGVGNnYg1jOH8hQx=dq4caEzip-n0g@mail.gmail.com>
 <s5hef9zl69r.wl-tiwai@suse.de> <82bb7f60-c3c2-4715-a0a0-f1f2a8b14c74@linux.intel.com>
 <s5h1s5ykteg.wl-tiwai@suse.de> <CAAW1UO_YDtddPk7-b=c03crPAOL33YWtu_q225um_hxh4SVYtA@mail.gmail.com>
 <47137843-14fc-f6d0-4372-a9ef2456cab8@linux.intel.com>
In-Reply-To: <47137843-14fc-f6d0-4372-a9ef2456cab8@linux.intel.com>
X-Google-Sender-Delegation: a3at.mail@gmail.com
From:   Azat Khuzhin <dohardgopro@gmail.com>
Date:   Sat, 5 Jan 2019 03:34:39 +0300
X-Google-Sender-Auth: Wkz3gExqNdkJEQHmSWozi_zBTcY
Message-ID: <CAAW1UO-P5cWWx-orjCHvHw3deStJTiUmT5BHveTTiJotvB9aNA@mail.gmail.com>
Subject: Re: [GIT PULL] sound updates for 4.21
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is unfortunately a known issue with this driver, Takashi and I had
> a couple of email threads on this. Even without errors removing the
> module doesn't seem to release all resources. I don't like this at all,
> and for the Sound Open Firmware (SOF) driver I mandated module
> load-unload as a functional requirement along with zero warnings w/
> Sparse, Coccinelle and friends, but on this legacy code I am afraid
> there is no simple fix - at least not in a merge window or a single
> kernel cycle.

And the fact that kernel crashes after?
Just want extra confirmation

Thanks,
Azat.
