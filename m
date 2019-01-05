Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4D3C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 18:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011C322306
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 18:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P4j9cTRc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfAESfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 13:35:45 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33055 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfAESfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 13:35:44 -0500
Received: by mail-lf1-f68.google.com with SMTP id i26so27566649lfc.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 10:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s419Dn9GH8c6GJbc+UhiGVdvtHUjHKhw21jVuGtDEuI=;
        b=P4j9cTRcu58iMr8iLfMUYUrIw+gbCDYeYVhXTlxIeV0j+xMQ3ftLywqCPyFbVSHMGg
         wSk9222Guzox9phzNKfhgXlGE8oX5yGYQffUW3TAPzngg/Ow0ghfWYVGBm34uoVU8dlB
         /BZ0tvVTO1bCIzDXBKLin4h6mzTBNsF3xsbQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s419Dn9GH8c6GJbc+UhiGVdvtHUjHKhw21jVuGtDEuI=;
        b=I7kbB4mS+5hEs68S3VmkG24Xk9MD51Hhf+RSHb4QbetiOVu7tmCs4FW3Xljwr6xrXb
         xc6psYtoAZ6yytNpa5Bajlrbd9ySjzr55yzo58qr5MuYntTKACZhqhCMRFx9QBu7l0le
         SCKro7dYfzQbDbMWUjoEvWo3aCU8E1mufXm5uhbbrjATw95ooKnstmXKQXxwb2lZMNNc
         J3B9UYOjcz/pRJAy12Rhs+zIBSzc5C15Q4t7TDBXmL8c9ceE/27x4qB8Zmyfcw+ACWTG
         MWqFLzXODfmbT57VV1m9TzcWEx1Yw1G1B3V39aQhuPF/NJPU90jWClve/hz/+cftGuqf
         9CLQ==
X-Gm-Message-State: AJcUukf53c2+hTfrext3pDE5dZUMHBp+5hnwvmbV2FQVR6GyG1fZbjNj
        Gp8Gf5YBwTBqlAO+uBJ60SBqmvfcw5w=
X-Google-Smtp-Source: ALg8bN5RobtkdHc+s4G5UFZBaoZTNyBJO1tAeDA+Neb5VpdOY9g6YdmN3bQFXQpqLHnsbPVbExzYqA==
X-Received: by 2002:a19:7006:: with SMTP id h6mr25190366lfc.147.1546713341289;
        Sat, 05 Jan 2019 10:35:41 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id e5-v6sm12815763ljj.91.2019.01.05.10.35.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 10:35:40 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id v1-v6so35036470ljd.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 10:35:40 -0800 (PST)
X-Received: by 2002:a2e:9c7:: with SMTP id 190-v6mr23915713ljj.120.1546713339775;
 Sat, 05 Jan 2019 10:35:39 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNAQzEHv7Y69xFTPDEhyMP6JX4ghb96UMqMdxYyVyah6-VA@mail.gmail.com>
In-Reply-To: <CAK7LNAQzEHv7Y69xFTPDEhyMP6JX4ghb96UMqMdxYyVyah6-VA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Jan 2019 10:35:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=whg49nn5q_2QVMGN0u4rQFBmRKywtqJUSk+5=rBzTk1kg@mail.gmail.com>
Message-ID: <CAHk-=whg49nn5q_2QVMGN0u4rQFBmRKywtqJUSk+5=rBzTk1kg@mail.gmail.com>
Subject: Re: [GIT PULL 1/4] Kbuild updates for v4.21
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro,
 this isn't really related to the your request, but to just another
pull request that caused much more of a rebuild than I expected.

Doing a "make --debug", I see that the cause was that it touched
include/uapi/linux/elf-em.h, and make says things like

     Prerequisite 'include/uapi/linux/elf-em.h' is newer than target
'drivers/net/ethernet/sfc/falcon/efx.o'.
    Must remake target 'drivers/net/ethernet/sfc/falcon/efx.o'.

which is obviously true, but was unexpected.

The chain seems to be

  <linux/module.h> ->
    <linux/elf.h> ->
      <uapi/linux/elf.h> ->
        <linux/elf-em.h>

or similar, and the reason <linux/module.h> does that is it wants some
of the elf types (ie code like this:

struct mod_kallsyms {
        Elf_Sym *symtab;
        unsigned int num_symtab;
        char *strtab;
};

and for declarations of module_bug_finalize() etc.

Fine, fine. I can see why everybody includes <linux/module.h>, and I
can see why module.h in turn wants the elf information.

And I think I can see a way to avoid this chain, particularly with
lots of those things really being internal to kernel/module.h and
shouldn't be visible to random <linux/module.h> users.

But the reason for this email to you is simply to ask whether you
use/have any tools for seeing these kinds of deep include chains.
Getting rid of some of the deep chains of header includes would likely
speed up kernel builds even when a rebuild is forced, and when it's
something like "we really shouldn't have rebuilt that file at all" the
speedup is obviously even bigger than just a "the compiler saw much
too much unnecessary header contents".

                 Linus
