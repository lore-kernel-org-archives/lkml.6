Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27562C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAAAC206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CJQKbZj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbfAPTtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 14:49:19 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:33478 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730875AbfAPTtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 14:49:18 -0500
Received: by mail-ot1-f44.google.com with SMTP id i20so8919276otl.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=IUCNzigZOFXUUU8wyt5pYGcNKd4MxLFlEFqjqfIThn0=;
        b=CJQKbZj09KZJnkLm9eoc+mWal1WvsadcRNHLArL5EMt2q9XH+0g0YJC1DfihzuIogz
         wyj56oSyq7mcjM4HidjoyPFuREet19gQWrYEOhC9aZuSku7Jc8gyrZN9UNFfCPjinwgC
         MUgHe1+7yT8OP7QZNMMYFvUSX/5mCgLKcPhy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IUCNzigZOFXUUU8wyt5pYGcNKd4MxLFlEFqjqfIThn0=;
        b=gwlJd5x21AE6NgpcYnXc7qKgJb+iwas91ePZwbSwvZMR69Q95JHJOONH8hYnYamsr3
         HuMFTVopkYQDYtfzPTxzc3aKO/4uGOfKY66ty3lg6yuUTvsCMkHqwISqnIr/HFjaFmiJ
         9qu9IDdH+6RSIz5IqqIana+dkOkFMu4+77s1Kw3F5ON3TMEDarH902XqsfWKaWocslvT
         /mVnxofdDKOx1tk79oXBeDtSGgORgczfj6vyo5VnhB1r7ZJlEHqm5j3lsQ21jEfftzHd
         FYX9ALGypgu3fwp7nLxxNYfjDkuarky+EOgyOl6+BKnLuwO9H9ptM1Gm27c75G9t3gRN
         E85g==
X-Gm-Message-State: AJcUukdm8haeX9QrwZnI7IURVKBYqWLGuM6/d49CungmtVqb+I6JTQxP
        RS06V2ERc9v0FSjjbBaublRkMH3ZimMAi/OnVC7KCW8u
X-Google-Smtp-Source: ALg8bN5pgrzklDEploFEabURHT9/6loL38Ew/cnwLesxvQ0d9Xb60ljnzM/KYzNueyxvszOtzmJsgaIj75CVUtNAld0=
X-Received: by 2002:a9d:2387:: with SMTP id t7mr6253605otb.68.1547668157969;
 Wed, 16 Jan 2019 11:49:17 -0800 (PST)
MIME-Version: 1.0
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Wed, 16 Jan 2019 22:49:07 +0300
Message-ID: <CAD8XO3aVboq5okUNXNMkO9yV2GgbGxPz0ZefesgwO_PkDD22uA@mail.gmail.com>
Subject: license for samples in Linux kernel
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello community,

I would like to touch such delicate question as GPL license for
/samples maintained inside linux kernel. Samples are usually exist for
quick bootstrap your application. I.e. people just start with
copy-pasting samples, see that they work then do something on top of
it. Here is problem with quick integration new features from samples
to non GPL code. For example let's take eBPF/AF_XDP samples and
tcpdump application which is BSD licensed. Theoretically samples
should help to use new kernel features but in practise it can create
legal precedent that GPL code was merged to BSD project or some other
non GPL project. Which is might happen if we assume that project
maintainers are not aware that code was copy-pasted. I'm sorry if this
topic was already discussed. But if it is not it might be good to
think about it. My proposal is to remove GPL restriction from samples
and publish them as public domain.

Thank you,
Maxim.
