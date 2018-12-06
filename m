Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09468C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A822146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="b1NitquW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A822146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbeLFTUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:20:44 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:38609 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeLFTUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:20:44 -0500
Received: by mail-io1-f67.google.com with SMTP id l14so1293567ioj.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 11:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3l1bT1wrmEe0RdgJPl48rj9ymkjVQkwNUnWZ7wIpihI=;
        b=b1NitquWdvPrBmRdCB1RcjV7nivZ2P8SRLbrLmQcgBjgfyM5qPAkUNYXlAwxXw0kKA
         FQWofFpUCb8R5C88k8CsSAlv91Z/y6f2DWCNSCyji6ZRo8vj7biuSO5aapZT0+/bxLLG
         fzNZ21rTpTWwNqZGuEjOI7UWrjYAbWoakMja5kmZn0zBvLNzxqSaMXeRDR6zgn5nBMiI
         lKMg1JUUpclzCfjoqdQNMAIFiq36Hf5r0jmnQaRZpjy6G9HLnQNI4JI2l3KoneQocafE
         eB8IEjcEPl2kZ+4762a3ZZPgT7BtIvHY2xSo/C8+EvdzjJIoEzlO7zO6sBI36Rhr5wvs
         d8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3l1bT1wrmEe0RdgJPl48rj9ymkjVQkwNUnWZ7wIpihI=;
        b=C4Ag2CWj+Iy3VqLc78etLtdJ02h1GS1jOI+u1uAPTNKmvjkcSB5wXn1xyzwDhDuK/C
         CtAfDe39gQx3N7IeozNBRw9aREMdExh8DbXANYkOyXXQGv5oskroTTx9pWo3Ohjcvmo7
         oFbIISuA1uztP0vb06BR1cJ1flSMl4a4u8+6w5Qxev7TAkgsAI2AcQGqTNGnSBuTBole
         f5YWZaVjeIKxB1Hq1ysz/ZRjJKIYaYNtIWxaCEqOpzIEUb461XU+ji6pYHsUnO/ptgpJ
         qAjkCYNwv92/AUq+5Bzq8d6NLqCXQeVA91lGbVQh2EepZf32El/I/Yv6b/i7+OBFim5Y
         9geQ==
X-Gm-Message-State: AA+aEWY+TUGZ2LKYtAK603fb4pHmWeA4JonFSWm1KSUJFoq6FdMlSNK1
        In+6E5d6SASMm/+C+1LedxNiKyIGeeHxgIf8qnm5OA==
X-Google-Smtp-Source: AFSGD/X34khEbHWDAJCWiOXfd18MB7Gmxal6uEb4gbp0RK24ery8cyYKEwTcjcuOLbytmbRqFVmBDzptPWdw4E8khxU=
X-Received: by 2002:a5e:c107:: with SMTP id v7mr2148052iol.155.1544124042917;
 Thu, 06 Dec 2018 11:20:42 -0800 (PST)
MIME-Version: 1.0
References: <20181206102626.2557-1-david.abdurachmanov@gmail.com>
In-Reply-To: <20181206102626.2557-1-david.abdurachmanov@gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Thu, 6 Dec 2018 11:20:31 -0800
Message-ID: <CAOesGMiT2OpN9VFaeST5tBW=epkknRUcrQtVLrpeR-GpRCr34w@mail.gmail.com>
Subject: Re: [PATCH] riscv: remove unused variable in ftrace
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 2:26 AM David Abdurachmanov
<david.abdurachmanov@gmail.com> wrote:
>
> Noticed while building kernel-4.20.0-0.rc5.git2.1.fc30 for
> Fedora 30/RISCV.
>
> [..]
> BUILDSTDERR: arch/riscv/kernel/ftrace.c: In function 'prepare_ftrace_return':
> BUILDSTDERR: arch/riscv/kernel/ftrace.c:135:6: warning: unused variable 'err' [-Wunused-variable]
> BUILDSTDERR:   int err;
> BUILDSTDERR:       ^~~
> [..]
>
> Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>

Please add a:
Fixes: e949b6db51dc1 ("riscv/function_graph: Simplify with
function_graph_enter()")
Reviewed-by: Olof Johansson <olof@lixom.net>
