Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E599C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 03:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213C321741
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 03:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bWTusvGr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbeL0DcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 22:32:18 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46813 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbeL0DcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 22:32:17 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so15192179ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 19:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JsQOaWra+DSUeycw9x63/D4S8hJKNBuEWfhDTZUo++k=;
        b=bWTusvGr6tF3mvaag+JNlxFO8/D3rA+zAbnFBKpmnfU3wzw8ahHWKghD5/A9kAKNMr
         ZX3TjGlWJFMXgAnXxzGdnHACfrRcc93JpS3FvauhGdSOlS5Ao2lmhoKhIuimrJ3zAMM/
         tI6XoV1YNoXmKqVTx5W4uTXQ6E54p4OI5Fozc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JsQOaWra+DSUeycw9x63/D4S8hJKNBuEWfhDTZUo++k=;
        b=jGkIDGsQ80kyqyiaJEalW+i9t9ecUo/Nn6fCtbXa4M4itUDzg4YwqZ/WJfxkgB1e1Y
         uHOQz/rzCiIEHS6EJ5tnCS2Pw0DEBC6Xr3gs5ib7ki581eQCFIa/aBgqjq2JetAjT3Gr
         QsFj8bJQz/OuwExI5kiPqWAaa/RH+wES/ZrE96bIXZ/xDFPWFlnPuta3LiWW9PAVxRLL
         aIINbDVDiedbV8lUtX0KdiEvgFC6Odyeq7ZI6pZQVE+mpUdlEhHLlWe+iiIMusZ2R5pr
         83u5edNATfXOI4gDJIgKq9WgSlp2JUQpDoZ7LGPcy4txeyczjL04XfCnlDY1xRnkiTXG
         M1YQ==
X-Gm-Message-State: AA+aEWYSLFeyIiCTpOUAgmUm6NS6E9f5b5SX7p+sZztX9dRixzyn4QMc
        X6rB8XXHq5d/uCxw3Df8n7Nan0AgjPY=
X-Google-Smtp-Source: ALg8bN4NCzZ455W3v+GJ1DCKxRcbEhz5NJ88z2RgqkEtMNb1HEv8IlOhRpt4zbUya698Wyu1KGe7FQ==
X-Received: by 2002:a2e:99d7:: with SMTP id l23-v6mr12210528ljj.165.1545881534059;
        Wed, 26 Dec 2018 19:32:14 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id i143sm7497853lfg.74.2018.12.26.19.32.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 19:32:13 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id n18so11887348lfh.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 19:32:12 -0800 (PST)
X-Received: by 2002:a19:cbcc:: with SMTP id b195mr11594246lfg.117.1545881532303;
 Wed, 26 Dec 2018 19:32:12 -0800 (PST)
MIME-Version: 1.0
References: <s5hk1k48ayx.wl-tiwai@suse.de>
In-Reply-To: <s5hk1k48ayx.wl-tiwai@suse.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 26 Dec 2018 19:31:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg+hjDa8UGRVnCFytjwYLPk2yDgJoKOESVSE7_6KfaeTg@mail.gmail.com>
Message-ID: <CAHk-=wg+hjDa8UGRVnCFytjwYLPk2yDgJoKOESVSE7_6KfaeTg@mail.gmail.com>
Subject: Re: [GIT PULL] sound updates for 4.21
To:     Takashi Iwai <tiwai@suse.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 7:38 AM Takashi Iwai <tiwai@suse.de> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-4.21-rc1

Hmm.

It turns out that commit c337104b1a16 ("ALSA: HD-Audio: SKL+: abort
probe if DSP is present and Skylake driver selected") causes my laptop
(XPS13 9350) to no longer suspend.

The screen goes dark, but the power light never turns off. There's
nothing in the logs.

> Pierre-Louis Bossart (16):
>       ALSA: HD-Audio: SKL+: abort probe if DSP is present and Skylake driver selected

Sadly, that commit does not revert cleanly, since it's preparatory for
a lot of other changes.

Here's the lspci output:

  /sbin/lspci -s 0:1f.3 -vn
  00:1f.3 0403: 8086:9d70 (rev 21) (prog-if 80)
  Subsystem: 1028:0704
  Flags: bus master, fast devsel, latency 32, IRQ 16
  Memory at dc328000 (64-bit, non-prefetchable) [size=16K]
  Memory at dc300000 (64-bit, non-prefetchable) [size=64K]
  Capabilities: <access denied>
  Kernel driver in use: snd_soc_skl
  Kernel modules: snd_hda_intel, snd_soc_skl

and it's a bog-standard Intel i7-6560U laptop.

I have no real information, except that I bisected the (reliable)
behavior to this commit. Before that commit, suspend/resume works
fine. After that commit, suspend just hangs and leaves a dead machine.

            Linus
