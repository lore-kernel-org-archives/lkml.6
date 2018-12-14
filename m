Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEEDC65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFE020879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="ZuDKJen+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFFE020879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbeLNB6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:58:11 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39027 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbeLNB6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 20:58:11 -0500
Received: by mail-it1-f194.google.com with SMTP id a6so7110731itl.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 17:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ZuewYPe6vrlp66Uf3MR3QYVOS9gpDzYNJlEAO6gBL8=;
        b=ZuDKJen+UQW2IUtcB8p6I/iVec+0vV4wtfZ0jix6Dngc/dDXfSVU4AhV5x8RDIdpRd
         0rLA0up1ZTIv0AUr7LTQCmsp3YX3eSoshSl2RRF546MsutPtCe+BgCiLKVvmdyCZTSEl
         q7oJEm6nm5b3BPBE9ZDJqDDsrK49ZylefwemmPl2chViP9ybhzlvPDOufHLBFPYmixGa
         sWgAQl7dKLlDLsD+1OAts7NdVaYI+vxW7oITSU4SxkrPxvNGOAfYU/QME3eOEzmuqlcj
         T+53iuDAg0D3Wa958GJBTTO81n4FH9b5v0gB1SRSc751KrIuOLEfGMmlmCNGOegI8Y42
         hUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ZuewYPe6vrlp66Uf3MR3QYVOS9gpDzYNJlEAO6gBL8=;
        b=YOaWKgMilvsub2bHQwJDSSKxz2e/KdLJVKtIjW0iaY24H8NbC8mJOyrHLUqA68wEPW
         f6Mayha3fdO6BNSthi6wAVgUoh6OekOd6Oy2W9MX5v7j+4TcT3xebvGFfPci10QR4R9q
         NDGcOazeqmfuwh9xuhRQEGoK2V3U77emO2Zlybp1gqWwE4pO4IpzCPzkYFUOqy6O69vj
         aQpqJVo6KOvLWhk7Gm54ms44A5GdPxnFZN/FEw+dB1CqwOgURmRpylbMsVsAuKIbBHPF
         dogBUf3trbA1DY456IYAfv8d8hgPeau5lUe+0W6TTmCfdQVu+urL4AKIfRoI4V1+P4Us
         KQzw==
X-Gm-Message-State: AA+aEWYj+7o2D90BisqP4xdIIsN5KHBsvFNCL0EqlgWCG/is3sB29ciQ
        es8/OVNS8puZwvQfdStmGIV4mCf3eXpb5xcPbVNy8g==
X-Google-Smtp-Source: AFSGD/Xw9MvGzuzWqMP/CrcqETUlbFzw5WUQKW10MqNm+laDdcftUK/1jYBE5iUFjIom67mVwCoLm3HkISf9ZUBXKUU=
X-Received: by 2002:a24:ce42:: with SMTP id v63mr15977itg.136.1544752690364;
 Thu, 13 Dec 2018 17:58:10 -0800 (PST)
MIME-Version: 1.0
References: <20181210204355.3483-1-david.abdurachmanov@gmail.com> <20181210204355.3483-2-david.abdurachmanov@gmail.com>
In-Reply-To: <20181210204355.3483-2-david.abdurachmanov@gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 14 Dec 2018 09:57:59 +0800
Message-ID: <CAOesGMiVZpBtOjCDw86-u0tEBS4yYhTqQHEwtaiL+MV3PGDAhA@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: define NR_syscalls in unistd.h
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 4:44 AM David Abdurachmanov
<david.abdurachmanov@gmail.com> wrote:
>
> This macro is used by kernel/trace/{trace.h,trace_syscalls.c} if we
> have CONFIG_FTRACE_SYSCALLS enabled.
>
> Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
> Fixes: b78002b395b4 ("riscv: add HAVE_SYSCALL_TRACEPOINTS to Kconfig")

Reviewed-by: Olof Johansson <olof@lixom.net>


-Olof
