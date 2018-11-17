Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0441DC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 00:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7AD32087C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 00:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNfLX2X0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7AD32087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbeKQK72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 05:59:28 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43127 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbeKQK71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 05:59:27 -0500
Received: by mail-qk1-f194.google.com with SMTP id r71so40369001qkr.10;
        Fri, 16 Nov 2018 16:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LWNKI5peLI4zp0T/ZWr+jjM4k4CAwflQSoLhwWF1hxI=;
        b=eNfLX2X0sr5SRPtMS+nFmjD/7FK5O4Y3nMsHiP8cRYkf8v1SZGCXLiTVe/OpUi1Rfy
         H155QEnyDsrG5z5/+qrQfI8MXfBxYJFzD4HDLS3zVFMYHgvnUPFw2/dWDQTizkMzydq3
         +f/u6lkUlRftLlj9SUGsUrtX8LWuPTABp0NljjdI137dBTyMowCjm/zb/dZZPpFoZ1fM
         +hm9BEzE+kEcESgRUyadGxEVSY1hG7fqnfd+Zraoh8seeZm7EsSl7/lVtdvMjn15URy5
         +4bxJU+Hk6yBoE5J17Misam2rTJ55ZG1IOmDq3nidfYkQ9VE9d3nd7PCEhHt4y8d5Ccj
         EHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LWNKI5peLI4zp0T/ZWr+jjM4k4CAwflQSoLhwWF1hxI=;
        b=d+TjFHMaosp2XYZeuCGO9UJaRo9UAPgQhpcSTR4lCeuN2IXeMgiYXdHrgt9vQU7oui
         0qW86JXbAVbAocVrE9HrpcVig4856dnCsv/vpNm6DmprAkCMpq23Wr9n1DE6vf4r+yi9
         ijtRwwEOLc3vrrhZGyjC4IkB8vEAgT8OEjs0E3fFsBjAAaZkoKI34L0p+vEZqG4wTQxt
         UKC+8Xrj2XvvjDm4lfOK69rjUEyTicV4ybGX2YvTUmSsCZbcHqklbckPXaDPB3Dkptw3
         4UsclIfrUuWD3phSGZ4cibDCopPPMJQeJfQ17vGkejhSRT1Al/fTJG1v6CNs9QtF4VGc
         cIhQ==
X-Gm-Message-State: AGRZ1gK2pecB9T3bQgQnuShz8ubu+5zMmwFzZcpv5lLEymO4MiZpIv2P
        28TJoGf30OKynb1WMTOSSuEcM4Tu8xMki8BzpqA=
X-Google-Smtp-Source: AJdET5feMrmo58bccHVC+KK6pYPWE01sF0D7X7Vt62bA5tlFPrlcEKA4mrylGjXZfFxDGhXZpEMBmjIKTRLPC27yEIQ=
X-Received: by 2002:a37:5f05:: with SMTP id t5mr12617088qkb.47.1542415489639;
 Fri, 16 Nov 2018 16:44:49 -0800 (PST)
MIME-Version: 1.0
References: <bce0322a-6392-3fd4-a6fb-562160c26198@solarflare.com>
In-Reply-To: <bce0322a-6392-3fd4-a6fb-562160c26198@solarflare.com>
From:   Y Song <ys114321@gmail.com>
Date:   Sat, 17 Nov 2018 00:44:13 +0000
Message-ID: <CAH3MdRUmaqmFWFS4xUuB3kVYZntExw3xw_nHJ+p013ZJ+bhtng@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix off-by-one error in adjust_subprog_starts
To:     Edward Cree <ecree@solarflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 12:00 PM Edward Cree <ecree@solarflare.com> wrote:
>
> When patching in a new sequence for the first insn of a subprog, the start
>  of that subprog does not change (it's the first insn of the sequence), so
>  adjust_subprog_starts should check start <= off (rather than < off).
> Also added a test to test_verifier.c (it's essentially the syz reproducer).
>
> Fixes: cc8b0b92a169 ("bpf: introduce function calls (function boundaries)")
> Reported-by: syzbot+4fc427c7af994b0948be@syzkaller.appspotmail.com
> Signed-off-by: Edward Cree <ecree@solarflare.com>

Acked-by: Yonghong Song <yhs@fb.com>
