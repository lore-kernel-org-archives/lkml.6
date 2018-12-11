Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DE3C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8442081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="nlcyGlKR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B8442081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeLKQ34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:29:56 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43081 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeLKQ3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 11:29:55 -0500
Received: by mail-pf1-f195.google.com with SMTP id w73so7355083pfk.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 08:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id;
        bh=gzbxHecU86LFLkoFtvtJbFFqdwZzwuGxgACWUAu+Sow=;
        b=nlcyGlKRTqTbq8+IqXBHRqittXZfjRRwenzH80RsKpkqfJtTJNrQgXGnnLbcZUMhYr
         wvTmkOaaCn434bSQn7aCr/wxuJHQKqxuIbeWcUIJDYE57yOeW1/AB3NLcFPtzL1kP4Ml
         YPY0npu+udLAC11iErcC+8C7cCojqyC8fEA0bJB9HSrpyIbO4IGRXiDPeGmI7T7B3pTc
         fV7/bES0gkdi+IYjwD3lfkFnUhYNhJk0SSd1IRGUH8vXf8KQX5HtgHjCFkNWVWzqcX6/
         A6roqauT34wp6klDiUXjgRIlt6o+5UCDN++fDfLvXtXxh+nIPu8/8+BUrwW2tUWxvuMo
         i/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id;
        bh=gzbxHecU86LFLkoFtvtJbFFqdwZzwuGxgACWUAu+Sow=;
        b=sOKQ+Jd1zKH26uWAc0jmbIQ22TgIjdDfYY6nnY4jeYySvNZoyZm42owEVJH8JUqCOC
         ErUEAERn8ssXQOjhQZknDO+7M/5RWNFZX0NHtqtqxrxaYyyVXzxNF+c1cfPyqwOaXtxT
         pqXjSeZYf/NTNoiECXUiVb76qs6c2kmbuRUy4VwOo/acgeijk0ZOI6WKS3L/PgXiC3bV
         iK2x/VK8xpWJMrH3HEeQD53J4rWD0qeL7H+1ln2jhOh+aJY1UGWl6pUXHtKWP/re+en5
         +BDme03P0NPgcCHibL46lRdPHFcsL8/5rNTk+kb//3dlsc6MaQt4zc5cwJbDevCAvU4L
         F8WA==
X-Gm-Message-State: AA+aEWa+QAOdOs+vAPGrqGqZdlNpOnQcAv1b+WtH7T5vmKN5aUPptAKI
        SDYLec6F0skOo7UK2npmLyUFmw==
X-Google-Smtp-Source: AFSGD/X4jMEyWNxSR2E0mKM7M07cpiLlL+IqKW6i6KevEKdtwNAhn/64cIvGL8dbmcdvJMK78BwZcg==
X-Received: by 2002:a63:4745:: with SMTP id w5mr15452249pgk.377.1544545794727;
        Tue, 11 Dec 2018 08:29:54 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id c13sm20690787pfo.121.2018.12.11.08.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 08:29:53 -0800 (PST)
Date:   Tue, 11 Dec 2018 08:29:53 -0800 (PST)
X-Google-Original-Date: Tue, 11 Dec 2018 08:22:07 PST (-0800)
Subject:     Re: [PATCH 2/3] kbuild: generate asm-generic wrappers if mandatory headers are missing
In-Reply-To: <CAK7LNAS7hh4f8mYoZc7RUWStnchhftUN0nU5MJ_trjyNJx50Lw@mail.gmail.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        linux-kbuild@vger.kernel.org, sam@ravnborg.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, michal.lkml@markovi.net
From:   Palmer Dabbelt <palmer@sifive.com>
To:     yamada.masahiro@socionext.com
Message-ID: <mhng-f63eb098-71bf-411a-9583-388234647f1e@palmer-si-x1c4>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018 04:59:26 PST (-0800), yamada.masahiro@socionext.com wrote:
> Hi Christoph,
>
>
> On Fri, Dec 7, 2018 at 12:04 AM Christoph Hellwig <hch@infradead.org> wrote:
>>
>> On Wed, Dec 05, 2018 at 08:28:05PM +0900, Masahiro Yamada wrote:
>> > Some time ago, Sam pointed out a certain degree of overwrap between
>> > generic-y and mandatory-y. (https://lkml.org/lkml/2017/7/10/121)
>> >
>> > I a bit tweaked the meaning of mandatory-y; now it defines the minimum
>> > set of ASM headers that all architectures must have.
>> >
>> > If arch does not have specific implementation of a mandatory header,
>> > Kbuild will let it fallback to the asm-generic one by automatically
>> > generating a wrapper. This will allow to drop lots of redundant
>> > generic-y defines.
>> >
>> > Previously, "mandatory" was used in the context of UAPI, but I guess
>> > this can be extended to kernel space ASM headers.
>>
>> How useful is it to keep the generic-y behavior around at all vs making
>> everything useful mandatory?
>
>
> What I can tell is not all architectures
> support kvm_para.h, ucontext.h
>
> I guess they will stay as arch-specific generic-y,
> but I am not an expert in this area.
>
>
> kvm_para.h is missing csky, nds32, riscv.

It looks like RISC-V missed it and everyone else copied us.  I don't see any 
reason why the generic version wouldn't work on RISC-V, as it just has failures 
for all the calls.

> ucontext.h is missing in alpha, arm, m68k, parisc, sparc, xtensa
>
>
>
> bpf_perf_event.h could be promoted to mandatory-y ?
> All architectures have it.
