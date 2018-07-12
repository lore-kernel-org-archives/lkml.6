Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0419AECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4CBE2124D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hLsObV3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4CBE2124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732226AbeGLUrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:47:47 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38964 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeGLUrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:47:47 -0400
Received: by mail-it0-f65.google.com with SMTP id 198-v6so370526ite.4;
        Thu, 12 Jul 2018 13:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6cdcvVt1oSJZhx07g+hA0IEuiW82yJMU4jnkJZzlRLs=;
        b=hLsObV3yAkgT46naBPFPW51StHVLr9qIlub+G2Lg1drUPuLp/O5SFqZr9j6Imi0YeH
         hfBAvkWyfoMf8kVAr8GwSIL4J4K6MFYKA5Qr/DmdZL1RBtJ+kdN6tJK/YUcLFyBaFvMY
         B6ozCZs9EQu3kp/s5578JGWs8TxjCFDbTavUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6cdcvVt1oSJZhx07g+hA0IEuiW82yJMU4jnkJZzlRLs=;
        b=qXo+ndEftRG2Fcn+uFEJAx70Dw7kUQWsxAnhhwdijuyOHmMyhA0xFAwNWFn2W3bKjP
         5Acqq1Wt3bcS1zsrtYquoPaCs55RB3UWNaTYV0mx4KrkIG0UIpAkWQSGTZj8PCwvBEaY
         EE1FbevlGx3xk4T7MgqSOLV9OuTvIiWfZLOhbLOaPwjCgz+GEUap9r9N/6EvEsnVzMjx
         Ks48B5k1rqMW1J+Ng09webSUIpls4Bq94XScESbIDqYhBrlmuX/c76ndd3YQkVxkiwCv
         6CS/eiBsgtUE+LvDgbhkGLuEMU7MC9rCzQUvC0qG8xtel1pElnGLw+/ZEio0MDXrVswS
         v3eA==
X-Gm-Message-State: AOUpUlHWU/2Py1/dk+zbViSVarXiaAvEQ8t/reZ6WRvuOPTMkbuXJ3ZX
        JpkL6J22mbyBOI1ZVdRWdvqgFIsWykhdG8vcDWg=
X-Google-Smtp-Source: AAOMgpdnNKj6ciKuauALqqrCHOR6X1efeClksGJGVgHPRIZkLMjc+2UcHBj1eDRZTxzqYAcVy3wJcYriBGUvpgNvZys=
X-Received: by 2002:a02:1bdc:: with SMTP id 89-v6mr2877489jas.72.1531427794245;
 Thu, 12 Jul 2018 13:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
 <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk>
 <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net> <22370.1531293761@warthog.procyon.org.uk>
 <CALCETrU3kbh-ZRHDj7-Asq+OH-35dQ2p_erpHpYUvN5+BdAoVQ@mail.gmail.com>
 <7002.1531407244@warthog.procyon.org.uk> <CA+55aFx+xm333ZZ7d2Z39QuhDu=0XM6nTMChbHvWQOXNk32yxw@mail.gmail.com>
 <16699.1531426991@warthog.procyon.org.uk> <CA+55aFw1WyKY+-2dg62M-QT_F0-waCTCrba1DW4dStYz-f_fjA@mail.gmail.com>
In-Reply-To: <CA+55aFw1WyKY+-2dg62M-QT_F0-waCTCrba1DW4dStYz-f_fjA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Jul 2018 13:36:22 -0700
Message-ID: <CA+55aFx=tVoeyDWqeNtv-v=r_v7pwbTV+KCrzg4Mzab66MuxEA@mail.gmail.com>
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for
 superblock creation [ver #9]
To:     David Howells <dhowells@redhat.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 1:34 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This is the whole "write() is only for data". If you ever have
> credentials mattering at write time, you're doing something wrong.
>
> Really really.
>
> Don't do it.

.. and I'd like to repeat: we *have* done things wrong. But that's
simply not an excuse. We've done it wrong in SCSI, we've done it wrong
in various /proc files, we've done it wrong in many places.

But let's not do it wrong AGAIN.

                Linus
