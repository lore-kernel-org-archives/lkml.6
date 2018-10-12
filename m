Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3055C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0BDA20835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="NiOgo0XK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0BDA20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbeJMBz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:55:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34671 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbeJMBz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:55:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id l6-v6so13984752wrt.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 11:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q/nvU2SXCzA1M+Vn7uxxRtDLXka0GXkzWDxE2RuniPQ=;
        b=NiOgo0XKhHQKALux+Xn9M/gMwMvS3LcAJCB4HAVfVH3LwCBZBCH6g47Bv9UO5ye/GH
         RYUCDe2eT+aXnnJ/6iQlVokC4sCC+ug1fqqfsDhqmYsgzwpYaJzA23V7WN/qpJCgo1Os
         mV3a0pp+7wO+6URoQxUkOUDN34pf8q5UEneYlCG4lJkV8466ByZxqxu4i1wiqMOBDsYX
         0Fjw5jJzS/vfSs1XcoNPB2wnife4Un4LEIXRo9OYvjVZj2hr+pE6y4u3U1G445wYiWOD
         cmMkSVWKnJB8mM/UNBRdcPFWYVaByh5iAnDs1i0vq6wD2+9kU2i28kB3bNniGPMZ+70B
         GNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q/nvU2SXCzA1M+Vn7uxxRtDLXka0GXkzWDxE2RuniPQ=;
        b=dwwbcDtrTW6hcCXr4icUebQK4ZzNMXu25J+T1qKW3KAUq2WO4OhWyiBt7DqUDDEmFs
         PyqkWgIJ23BNrRSSNdkoZjB5/Uum6lXHJXa7OQB1mY7Yrmx7hyJtMM4zkcclduvMvnEw
         V0AyNfEAMKnsZX9C1kzxcrh4E3kPKkPVwfaoNMgxc1Qf6/oHy3j2Ot1lNiwZb4TpGvBm
         LTcuylG4MF8hxrOGB1+X7ctuFqRKMdNIJNZfJf00tPHmYHrpv8k5AL3vLfbv7pqPHm5V
         s9q9p12hGDNnyAzssW4BSId39xeYq0GNFejuhI+c09BR2ACdvgNesykcMzEYliz+YcHl
         qHtw==
X-Gm-Message-State: ABuFfog/Uq/L2nOYdCkQ02nvbTI3ev7D+w4pnQikyYfyizJf00H197Mk
        GwTo91mnrU2WN+FHJJ6afTHlBej7g8p5WOleO5ZNfQ==
X-Google-Smtp-Source: ACcGV615nB5Vv+RjUIwyOFsvN7UpW1WT3i+Se1HBAG9Mdlh6v2QakubRTgda/0VhUN7cWaUDpxdjPHEewqbQBvIkPQY=
X-Received: by 2002:adf:b188:: with SMTP id q8-v6mr6241416wra.95.1539368499981;
 Fri, 12 Oct 2018 11:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <20181011230021.0a7604fa@vmware.local.home> <20181012122641.3d87ed29@gandalf.local.home>
In-Reply-To: <20181012122641.3d87ed29@gandalf.local.home>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 12 Oct 2018 11:21:28 -0700
Message-ID: <CALCETrXn9zKTb9i1LP3qoFcpqZHF34BdkuZ5D3N0uCmRr+VnbA@mail.gmail.com>
Subject: Re: [RFC][PATCH] x86: ptrace: Add function argument access API
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 9:26 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
>
> Anyone have any issues with this patch?
>

I'm conceptually okay with it.  That being said,
regs_within_kernel_stack(), which you're indirectly using, is
off-by-a-few.  And updating it to use probe_kernel_read() might be
nice for robustness.

--Andy
