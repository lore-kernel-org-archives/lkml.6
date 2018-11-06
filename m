Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBE1C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E9520827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="RfA7r2/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E9520827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbeKFJ7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 04:59:02 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37991 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbeKFJ7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 04:59:02 -0500
Received: by mail-qt1-f193.google.com with SMTP id p17so819590qtl.5;
        Mon, 05 Nov 2018 16:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=akTpZTBPAXL85p0vdHNPPTO7rOzjQoR6U5LUQJKn1MI=;
        b=RfA7r2/vEO7htlzv4TX/TPKT5VOahhWxZ/24AbrY2wZXuFNy0Z92iSX06CM4QvNSok
         hikpivth+IZu+ouQ+//kIflNHn+eSMSwj/iEc2PuSZfDRA9qDyKQXgwkD6yY3pxM5WI3
         GVr/7TqsRtcM2M1SzVF9OYKSPgFEBYNmdmYDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=akTpZTBPAXL85p0vdHNPPTO7rOzjQoR6U5LUQJKn1MI=;
        b=KKHK2/t6spA5I1sDrsS1TTWWbT3LlU6myfkqNtIAxJTMIdF1wlRvkGxnW/9Tzx78/b
         kfOh3z05Rwa1hG5YxoS2Si1teeDf7CLnM4FB8Tehi/5Z1qaE/y+RynLTmEFiJNmpxsvu
         URJjQM6W9c75yhb1gysDRKoGzcSdOdsNADXCUgaHFGVkJsHXMLctN7+3dubywYORpqIu
         N8O4+CffLSQ8JE3dRRDSZGU7JZ2Mb28BLq5qXZ8xNgb2+QaT4y6Ssn260wHlZk3E/SOS
         QmTg01htdNCg1kHTtMtQJo/i9gWOGxSPK1IQhiO8Akk1fWxl8+0Kv5+6yGN7HTnwgR1E
         j3kw==
X-Gm-Message-State: AGRZ1gJL5ldxMrGvpyVC4kt3vWbnY+YecjtR6MnjzoIeZPrVOc7/w/0p
        GEVPiBqLN7W0JFgTcDCd/FtNBcgac2vnCNBoQG0=
X-Google-Smtp-Source: AJdET5ce2zdHFhoWH1IuOJrVG9+R+YvIHaDiKffeGGN486EVZ6jUj3Go2Avkv1E/k77CkwjvKpJyRbE31fzXkxVcSBA=
X-Received: by 2002:ac8:2992:: with SMTP id 18-v6mr23222098qts.266.1541464596135;
 Mon, 05 Nov 2018 16:36:36 -0800 (PST)
MIME-Version: 1.0
References: <20181104231133.30848-1-joel@jms.id.au> <CAKwvOdm8WZTeB_wxkO2nN7PW=v=2z7tdVapTq-TiB18nZZfS=A@mail.gmail.com>
In-Reply-To: <CAKwvOdm8WZTeB_wxkO2nN7PW=v=2z7tdVapTq-TiB18nZZfS=A@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 6 Nov 2018 11:06:24 +1030
Message-ID: <CACPK8XeoBufr6ScXcdESsZEg9LQBHyx5V1T2WKbTbSDCaqFYfA@mail.gmail.com>
Subject: Re: [PATCH 0/2] poewrpc/Boot: Fix cross compiling with clang
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2018 at 09:07, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Sun, Nov 4, 2018 at 3:11 PM Joel Stanley <joel@jms.id.au> wrote:
> >
> > Hello,
> >
> > These patches allow clang to cross-compile the powerpc boot wrapper.
> > The boot wrapper constructs it's own compiler flags as it may not be
> > built for the same arch as the kernel.
>
> Hi Joel, thanks for the series!  I'm just curious, how does the boot
> wrapper run on a different arch than the kernel?

The kernel can have a ppc32 boot wrapper for a ppc64 kernel. There's
some rationale in the boot wrapper's Makefile:

 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/boot/Makefile#n10

Cheers,

Joel
