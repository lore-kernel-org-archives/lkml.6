Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F020C67879
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 314432145D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ge6D+aV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 314432145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbeJIH7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 03:59:19 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34879 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbeJIH7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 03:59:19 -0400
Received: by mail-qt1-f193.google.com with SMTP id v19-v6so23009046qtg.2;
        Mon, 08 Oct 2018 17:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ICfAujeX9Ki4u3dqmrqRil9WVpptlgrIhpg5HD58dcc=;
        b=ge6D+aV6FD0IRq61BXIOveVctaCJ1U8LL86VqQEAhEgXCTGxdJ68ElIxV6gKQrJogV
         FhyRawkhB+xDGpyzfewuR82lTVvRdpczvDiBNTLeClWmAP38VExybwgDvlgSWVNNLoFf
         MEbc3rwvrK0E0SaMnYEDX/vTk5g/+ETrvGANzOkgWb+gB6lQKguYgzmB5iXmf1aVwVzV
         JM10UXmvdFAqXsePTbN41e8DAoCSFFQnc6+jU7B4KzG7ZBlKHYSYQ1A0/Ngrso3XNzZp
         gHN6GL+/Xrx0MSiwQ40OrKS7oZdL4gp2jqQYhvZeu5kBsXo1g5vPhAQoBH3L/tu/iGAV
         ywcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ICfAujeX9Ki4u3dqmrqRil9WVpptlgrIhpg5HD58dcc=;
        b=aIQk2XLxWeAlK7B7/05WqMhhy2fQkBExeLqI9mtgx701wQF2SQ5z5H1Zu/Po+3M4cG
         o0AliZVtj3yEgDuHgN7A6P0HRoKP/+lwcrHuH+I+4wKCf+jB11hoX87ISJqEIivMUq+F
         IHq7PgAOlqiGzp1Z9mgRy9PCGZIJU0uxTF+u7yk9q9SxiYau8NhPCk0wOTLXLsz4N/Yl
         1nObxfEZeUsxqYBRP6TOMvG3ji57Iq33aq26vPxhL7DDgzkDR2xdoczT8W/RW0HzyYN+
         z99HkokPGFVcoiA4Z/c8tUUGTCVhXP3rH78TFGJePoA5mCOToeJXLep5jU+O+dKYLOK0
         gsKw==
X-Gm-Message-State: ABuFfojoOW+sgH5E4bJXboSZXsjxqMFQaemtqYKt+Z1kIyu8xNAUYp+5
        WyWhPdKPlW5U/D+LKjCYR3+9EbpDpSTJyxrxWIw=
X-Google-Smtp-Source: ACcGV627zzytLpEb+tyF3y7xN3Ibm605GhdWDwElVuIzxUCBvxQtOqVPLKRH6ZGpX51+IPsjkY7NdH+LezyFDwXr9Zc=
X-Received: by 2002:ac8:1793:: with SMTP id o19-v6mr21303598qtj.98.1539045898549;
 Mon, 08 Oct 2018 17:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <1538943795-30895-1-git-send-email-wang6495@umn.edu>
 <CAPhsuW5vnVjRS7DWFYPSmq5G-dAFxOrHCAOMkK-iaOoirzMazQ@mail.gmail.com> <43898.1539033428@turing-police.cc.vt.edu>
In-Reply-To: <43898.1539033428@turing-police.cc.vt.edu>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 8 Oct 2018 17:44:46 -0700
Message-ID: <CAPhsuW5nPGMOEMKa1UFwgquoUeYiUV8i8nVgWfM6McH2Ri1esg@mail.gmail.com>
Subject: Re: [PATCH] bpf: btf: Fix a missing check bug
To:     valdis.kletnieks@vt.edu
Cc:     wang6495@umn.edu, kjlu@umn.edu,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 2:17 PM <valdis.kletnieks@vt.edu> wrote:
>
> On Mon, 08 Oct 2018 13:51:09 -0700, Song Liu said:
> > On Sun, Oct 7, 2018 at 1:26 PM Wenwen Wang <wang6495@umn.edu> wrote:
>
> > > same value. Given that the btf data is in the user space, a malicious user
> > > can race to change the data between the two copies. By doing so, the user
> > > can provide malicious data to the kernel and cause undefined behavior.
>
> > These two numbers are copied from same memory location, right? So I
> > think this check is not necessary?
>
> Security researchers call this a TOCTOU bug - Time of Check - Time of Use.
>
> What can happen:
>
> 1) We fetch the value  (say we get 90) from userspace and stash it in hdr_len.
>
> 2) We do some other stuff like check the hdr_len isn't too big, etc..
>
>         meanwhile, on another CPU running another thread of the process...
>                 3) malicious code stuffs a 117 into that field
>
> 4) We fetch the entire header, incliding a now-changed hdr_len  (now 117) and
> stick it in btf->hdr->hdr_len.
>
> 5) Any code that assumes that hdr_len and btf->hdr->hdr_len are the same value
> explodes in interesting ways.

I think I get the security concept here. However, hdr_len here is only used to
copy the whole header into kernel space, and it is not used in other
logic at all.
I cannot image any security flaw with either hdr_len > btf->hdr->hdr_len case or
hdr_len < btf->hdr->hdr_len. Could you please provide more insights on what
would break by malicious user space?

Thanks,
Song
