Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F74C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93CB21479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3QnLhh5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93CB21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbeJIEE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 00:04:57 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37677 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeJIEE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 00:04:57 -0400
Received: by mail-qk1-f196.google.com with SMTP id x8-v6so12929358qka.4;
        Mon, 08 Oct 2018 13:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mvk/VeOEPDJeU1dLxiW4QkOmS/rPiXU2ENPpO20DZm0=;
        b=o3QnLhh5DPrctUYRB9hbzpNXLdq942kO+9C+5TscRdeWdKmvH45+vTj3hh6o6Sphzb
         lT2myEP3YYjtntqBjwa+oRUkzojI/d8MRnzjcNSYLVh7av9smpFOS3z2cKkEsedneZwB
         ziX0J1BGuGJ2kyfov0xNXRGFMU/bMhc3yauoCf9Bfjr6FGn2MJ/YVpep5uHeA79vd6En
         ZNr2VUdgOnzqVqGTSz+062pIM7AWJhNCg6qBUP5V4aY2YT104bMeTBfTDlp5IY0Cjbqi
         JiTGK21P7thbDNyyQaAEMBobVfF+mXMlT1Eo+tUUwS/JzHvHbqgJ4qVcmaf80i3/zYFU
         4yJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mvk/VeOEPDJeU1dLxiW4QkOmS/rPiXU2ENPpO20DZm0=;
        b=tvac7kSbxNNnbhy/NHr1kJ32N3DKICxFtsr9pPuUdz+N8z72fLHnShSl8Lmi8VZCIS
         HX5Ml3E8DNwQbzysQSwk4hhRmGnzQACX9zWTZ7/x9A4nf77fWqNMlx7ixZcCB9o/LFbp
         PiXLGSnfkAhSaaqOTZE3dt0S2t2Xla3N4yijNj5hRDKDwGhCevoKCCcYIcF4EX7JCisR
         PNAxRt8BEJ6p2p9bwlMGKgwRDuYRTOI0IsO8UmlhOVtQevbl6Xd5qfH1OUuSClBX8QaU
         c/uLj7yhhHmg1150I4KBJq1oCM99xAvZ7jlZ8doY3/5YHUaEMNnbRZrGc7q+hBVz6s5O
         kqjA==
X-Gm-Message-State: ABuFfoiNv00+lipRvWKgAhRHlN3PTNte6Hq0T4Iny0z1O/pOd98Du5VC
        ihQW1IWUJZqVQ/u3GzkSdFUGIUfwU9vtFUqMJqQ=
X-Google-Smtp-Source: ACcGV62stIjkvWuyKHx/7wN31UNxZev7dXASOKTgpL3e8VQEepil7R8n/XY2m2BWl6OmQ5tsuCppKxm23j5ie+4S2Zc=
X-Received: by 2002:a37:cf88:: with SMTP id v8-v6mr18652351qkl.355.1539031880771;
 Mon, 08 Oct 2018 13:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <1538943795-30895-1-git-send-email-wang6495@umn.edu>
In-Reply-To: <1538943795-30895-1-git-send-email-wang6495@umn.edu>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 8 Oct 2018 13:51:09 -0700
Message-ID: <CAPhsuW5vnVjRS7DWFYPSmq5G-dAFxOrHCAOMkK-iaOoirzMazQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: btf: Fix a missing check bug
To:     wang6495@umn.edu
Cc:     kjlu@umn.edu, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 7, 2018 at 1:26 PM Wenwen Wang <wang6495@umn.edu> wrote:
>
> In btf_parse_hdr(), the length of the btf data header is firstly copied
> from the user space to 'hdr_len' and checked to see whether it is larger
> than 'btf_data_size'. If yes, an error code EINVAL is returned. Otherwise,
> the whole header is copied again from the user space to 'btf->hdr'.
> However, after the second copy, there is no check between
> 'btf->hdr->hdr_len' and 'hdr_len' to confirm that the two copies get the
> same value. Given that the btf data is in the user space, a malicious user
> can race to change the data between the two copies. By doing so, the user
> can provide malicious data to the kernel and cause undefined behavior.
>
> This patch adds a necessary check after the second copy, to make sure
> 'btf->hdr->hdr_len' has the same value as 'hdr_len'. Otherwise, an error
> code EINVAL will be returned.

These two numbers are copied from same memory location, right? So I
think this check is not necessary?

Thank,
Song

>
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
>  kernel/bpf/btf.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 2590700..7cce7db 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -2114,6 +2114,9 @@ static int btf_parse_hdr(struct btf_verifier_env *env, void __user *btf_data,
>
>         hdr = &btf->hdr;
>
> +       if (hdr->hdr_len != hdr_len)
> +               return -EINVAL;
> +
>         btf_verifier_log_hdr(env, btf_data_size);
>
>         if (hdr->magic != BTF_MAGIC) {
> --
> 2.7.4
>
