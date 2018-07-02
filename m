Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBA3C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF41225025
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="KRm/3b+e";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hgIurG3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF41225025
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753531AbeGBVoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:44:24 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:43055 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752860AbeGBVoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:44:22 -0400
Received: by mail-yw0-f196.google.com with SMTP id l189-v6so790397ywb.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 14:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=CLN0u1QBbiRi5+jhUPeMSfAPo+BSlzbC3nvv+Ky8Ln8=;
        b=KRm/3b+e90BscCbGZ3/OlsBqkEMi9hA81fJsHtNzxKUqIn6kjHSs3mBax0d8BLAymp
         oj3xFYlexow0HGk5OKJhOUCz2sd88Mc0Lf+KocGJ05wbjTtwKvGGpPdFrAGnWRGUG6ph
         NUTBDWdvAOzBO0ZlxPypVyizw8VtjD6sJj/VmHAfXkaGV9pKRjTCemDPZJ97wvEeEBUq
         Clq14uwWMqEFwNkUhGWBkUCIsqxiyX36ISJPQztNlEbnbwr8qN96qhT39GS9bvehKeoD
         TDnGKs0YSxAzsH3TOhHr5hTn4WkuA/Gi0e7IhDCXd8EruWyZBuE1EeDd1Dj0d7HMJikB
         LUfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=CLN0u1QBbiRi5+jhUPeMSfAPo+BSlzbC3nvv+Ky8Ln8=;
        b=hgIurG3NxmeVxiEWl2EOgIA8o57+1PpAKqEZnzG0dMsJcUlOW+IGm+WM0SRqtTlXLs
         TZkeLUuvczg5uQrpRQiWEW96gpjgvTG+iYN3FRScEyZc0zl+4MlHWTlANQLUa75asA8K
         6U3dFc6eRxn+oLb5epjYXK4OU+ywJ4sB/IfRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=CLN0u1QBbiRi5+jhUPeMSfAPo+BSlzbC3nvv+Ky8Ln8=;
        b=FCQ6ak4htbkrCTYo3WLoG5wQZpD0dI+4XrSOurPoqtVkbtR/ebCw6DVvKBDGbHN0MM
         m/6xE/pCvGamnK9tZy3whLCv6CsWzVvHSlblggqU4/TT+/u6cPmRTVjVpKV8ButINiUF
         J19SU65oX7udfhDmVIq+yEaQFtxWZWxfDLo5uuacUibPzJvCMJmn+LwKtzWULiT23A6d
         Q/SfeJ8pYfINlDiwhwWO3imPhdjgSNqVXY/TneuYODk4BuTW6jPEReOPYyyHTq3zT3aO
         4/7ZAQdg1FHGvBgzdzWzYmpQy6+/h04r9bQJAySvBuEmPChKtT3YubxPSb/J4w9lNji2
         yzgg==
X-Gm-Message-State: APt69E0OOoozSas8B28+/6nTqMrBTWEP1pUScgR2ZSy1mk55I/zFSrEH
        DqzdJhjFQbAbnJX4ouTfP3JlmylZ7n0OyHoFn8mYJQ==
X-Google-Smtp-Source: AAOMgpcUr79PhEOSLyi8+4JcpPpaCCU1cnIdiQqXpwmq5cGayH0NtDvJdGi8dXs7Gk6uwmsghAcHGV0UPRCBnTwc9kg=
X-Received: by 2002:a81:3b04:: with SMTP id i4-v6mr13233957ywa.38.1530567860776;
 Mon, 02 Jul 2018 14:44:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 14:44:19 -0700 (PDT)
In-Reply-To: <5400614.4lJzJ1gdXR@blindfold>
References: <20180701212051.29486-1-richard@nod.at> <2073665.T6vW7v0NJO@blindfold>
 <CAGXu5jJabYkC06ZGa1X2HweY8idyDR8a2y805btY5jKMHKbSuA@mail.gmail.com> <5400614.4lJzJ1gdXR@blindfold>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 2 Jul 2018 14:44:19 -0700
X-Google-Sender-Auth: 5oQdjJDs10a2szcfCQScUfmPY3k
Message-ID: <CAGXu5j+YroAA935Pa+X+evxM2Nj_ocFRNkDegOYS_a9gceGrVw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "UBIFS: Fix potential integer overflow in allocation"
To:     Richard Weinberger <richard@nod.at>
Cc:     Linux mtd <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Silvio Cesare <silvio.cesare@gmail.com>,
        "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 2:41 PM, Richard Weinberger <richard@nod.at> wrote:
> Am Montag, 2. Juli 2018, 20:27:00 CEST schrieb Kees Cook:
>> > Let's queue another patch for the next merge window which converts
>> > kmalloc() -> kmalloc_array().
>>
>> I'd prefer to leave it as-is for 4.18 because it would be the only
>> unconverted kmalloc()-with-multiplication in the entire tree. We did
>> treewide conversions and a revert would be undoing that here. (The
>> scripts that check for this case would run "clean" for 4.18.)
>>
>> So, this gets back to the question of the int vs u32: if you just
>> didn't revert this patch, then the kmalloc_array() would stand too.
>> Easy! :)
>
> I can queue the kmalloc_array() conversion on top of the revert.
> But TBH, using kmalloc_array() here is just ridiculous, we allocate
> dn->size times 2 where dn->size is at most 4k.

Right, I don't think this spot still suddenly become vulnerable again,
but it'll generate the same machine code (since one arg is a constant
value), and then static checkers never have to flag on it again. :)

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
