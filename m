Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60122C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20FC321780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxZs9wrD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20FC321780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbeKPFyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:54:52 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34034 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725742AbeKPFyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:54:52 -0500
Received: by mail-yw1-f67.google.com with SMTP id g75so4709409ywb.1;
        Thu, 15 Nov 2018 11:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2HafzmdE4OChnNQVMVoa7I7NAx7LaJ1V5JofshtcpHU=;
        b=fxZs9wrDvzDx1cqdEsvP9kvX+e9jw6R9iER9hyQMGUBabLmsW7J+iT9nxyhpdzYDKO
         hLWJgRpcqW3B9JNjRPiSHa2VSRv+CldnB28j1bmmi8iMeweCbJ5e7hTECBA2axzMUMWq
         IAdpm3b/aMeDoNCiAQlISsZNhc/Xe6V12txLlSKZnt0yif8EbZIk/nCHxFagvx5LkozQ
         TkHP/ikqsSybByNbwEvawCHB9zbVhXTQMEm6TeRNkbpwN8pkZ+EQAMdKlDCbJ16d14qC
         EkPdKsPYoMwk6TjFnHV70mrpf8k+H+LBg2ZxUMLSGXefRtS+yJk8+r5IsOJ5k3+YbtOy
         8KjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2HafzmdE4OChnNQVMVoa7I7NAx7LaJ1V5JofshtcpHU=;
        b=pMwW2MmP+x8/0T0QmE6+sQk3EdCU8dUMQSsf+GYtf5iop44/QlNo/RGEDHjPt7sH0z
         KHWdTnG9upyN4tzImrqFiuThBh2N1JnzC0NZiO2M4p1TJLNM6YwzKXD3wB2yY6PJN5Z4
         ZxIXcSc8JW5dQNNvHA+5HQhwbYOSWB6MVVNZxin9LoBsCYgv3n4+iZq6yQ2WvIJ68mqI
         wQcvdtlH1U+AW09TcfzfcTXqbxMqp/vTCKf5huNviYL+mWOhc/QqggZhykfXkMudH6fs
         E/KdYxIZRVN7T+ci8Pw3XWfmqV8c3QwJzNfJr+MfdWahYxp3pFaLtrDloiPdfkg2FZqp
         6jSg==
X-Gm-Message-State: AGRZ1gKB2IfgO7Yz/i0Ugubm1SJfxCoAlpXmVjQYDjPGuF/8xnl8kzvU
        y8KaOPPT00J9uZxCiFLZJNoDlPa22LKvIzdQKnE=
X-Google-Smtp-Source: AJdET5eP/V2vXI3wgMuoQn6lumjPS4e8UsQpOeVDqnDtoJRvDsf8IMsillY9w/fSauDAOBC+yKsw5i5NJpfbWHlD2ww=
X-Received: by 2002:a0d:f103:: with SMTP id a3-v6mr7530103ywf.468.1542311141932;
 Thu, 15 Nov 2018 11:45:41 -0800 (PST)
MIME-Version: 1.0
References: <1542104370-22831-1-git-send-email-firoz.khan@linaro.org>
 <1542104370-22831-2-git-send-email-firoz.khan@linaro.org> <CAMo8BfJGWgJrsg858nwO_845HQOSMNm4AxEqjEjVsSMZMG1Gzw@mail.gmail.com>
 <CALxhOnhBN3ibNku5z4ZwnRjnWEtSrsbyVQUDzJkT6U65Ek0H+g@mail.gmail.com>
In-Reply-To: <CALxhOnhBN3ibNku5z4ZwnRjnWEtSrsbyVQUDzJkT6U65Ek0H+g@mail.gmail.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 15 Nov 2018 11:45:30 -0800
Message-ID: <CAMo8BfKM0M-f9UNmz0o9qZb9srJn7yxkYVYjqGc84c0eO5jnmg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] xtensa: add __NR_syscalls along with __NR_syscall_count
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038@lists.linaro.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        marcin.juszkiewicz@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 2:05 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> On Wed, 14 Nov 2018 at 05:19, Max Filippov <jcmvbkbc@gmail.com> wrote:
> > If we remove __NR_syscall_count from the uapi header I'd
> > suggest dropping it completely and switching its two current
> > users to __NR_syscalls.
>
> I'm not removing the __NR_syscall_count macro; just place it
> in asm/unistd.h file for the above reason.

Ok, I'll apply this series to the xtensa tree and make my cleanups
on top of it.

> FYI, I made sure that the kernel will build with my patch. I would
> appreciate if you can perform the boot test on the actual platform.

I did a simple boot testing on a range of configurations, it works.
I'll also run LTP a bit later.

-- 
Thanks.
-- Max
