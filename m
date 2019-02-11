Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA8DC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D250A2070C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="x8iCobPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfBKG14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 01:27:56 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38361 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfBKG14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 01:27:56 -0500
Received: by mail-wm1-f65.google.com with SMTP id v26so14615783wmh.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 22:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZdYV9cBrNvxpAafw74yMbiJSEo0ins9g9PxDhrTBATE=;
        b=x8iCobPhM5PJ5ha+Fn+ZQ6U9DR6yh70BcZwChFnMYQ+R42EtjW1it75U1k0CTvfzct
         xjoteCg5bx4w5X4a/oHWSNkitjlmWM7ak3aDuLdlhUcR8GEwN+U+DH56eZtP4jhaFDiu
         4olVsaN25xKPSOsDjcJZhttczZdbSJlYM5ItGF73qZu+BQUvrJo9Hhcqsev4mUjIEEk6
         9t53uPR0ibdi1c2sDH1T+TcKQooWSTBNKVg7vghO9ta7DQmkJKO+7ssR7/RnAeTnDFJt
         ebZ3ZHma+f5S+bGYeNhYOu1PCzHgje4fVLDAqae1gnKj407FN8f6klMSNUV2yiA7x7so
         gBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZdYV9cBrNvxpAafw74yMbiJSEo0ins9g9PxDhrTBATE=;
        b=nMtomRY87BzniiG9z48eRAw7flXdentiq36xlMEguZ4U4ch1eL96Cqta+N5PNNxGEq
         nlUJN4IlfyHqQLltrZdi79gziaUsdPSGzvC6VPdSuhM6uTfj74geNLy13aYmSmQHz7p7
         Lmv2Px4AGfhqYpdsR+O09t9bJ+0bYhuynW8OMCNZrPQQtk6R1Th1A+3PQlWdBNTp+cUJ
         yq7VRso23GBhQb1QE5iEYcW3XzK8NC9DAIRl2miVvf0lNwAHU0CN8kwHCpjm8RSriwXk
         YFmpdzvkm2lDGuGtMLhEpxohiIFdAGWnszcsBPuwkEbqAIy4xfMnHStQI9msJ5kQbSYP
         tsZg==
X-Gm-Message-State: AHQUAuarBbc1iRj8K1zpkb9Ys4uN9x52SXm/KNxQ9213F5At0GSZP/kz
        isxsIjG82/nCzEGmD4z1X5t60XbKzZn1KK+2uajD2w==
X-Google-Smtp-Source: AHgI3IacPZSJur1z2d1314FofV6UNJQdCNNfUqbYzPRMiBuHGHFNsgZIN4lncKc4sZmLmiU+qXsWEhmaEkOqqlECRxQ=
X-Received: by 2002:a5d:5004:: with SMTP id e4mr28020481wrt.59.1549866473927;
 Sun, 10 Feb 2019 22:27:53 -0800 (PST)
MIME-Version: 1.0
References: <20190119132650.9978-1-anup.patel@wdc.com>
In-Reply-To: <20190119132650.9978-1-anup.patel@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 11 Feb 2019 11:57:43 +0530
Message-ID: <CAAhSdy2t-L6EtZ9a7Cv=-rVtzpfAyC5nKW72DUWOiYsjXcgJtA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Fixmap support and MM cleanups
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Any comments on this series ??

Regards,
Anup
