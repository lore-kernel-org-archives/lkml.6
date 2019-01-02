Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9983C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56CB1218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SIVntgj3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbfABPai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 10:30:38 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37574 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbfABPai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 10:30:38 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so14648939plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 07:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aotKXRgI5ukT4+MDFSiCmLWgKTQf+3ZKVeVttVdQs8k=;
        b=SIVntgj3pdOMeja7HJx9uNiQTutdLM/R47mNTw1lTZUKmMS1kSm7Bs7x+jZhFx12R3
         TMDVtgiZ7SkkQ5329dpqWppFkx1VlgyFOD6vAScU2kdH1gUJkWBb4EU/2+rR/bwU9iF6
         Uw5MoGvcp10PgtMJMrupsPV1Z7ZlyxZ0z38v55yw1Co47aPv1DOHkrYTNrGvVDSK/uUy
         0w2FGOFEqyH0D5xHD4GmzIv7yJ/wtKE/O9jbAg3sXUbJkv7GDIZca61B230BXpEiX3B1
         BzIa/TWlzMEXDrG04Y+pnr2czcRzhtyozPQPAF0syd2UgqWqulkfYX4RwRPY+DnVdlVa
         HxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aotKXRgI5ukT4+MDFSiCmLWgKTQf+3ZKVeVttVdQs8k=;
        b=qIxjFllJPEmWX4KpvAqOfmIzOOu+xpI+UoFKQMF4JgC17prRNJFE5xvv/8DsEB6J4l
         NTg175VES8iZlV3dMXdhdn3WBMHXTNeLEhSCstaCcXxL8h+pTLvG7PC79muCyuQJStVh
         BNzBOsxv+Om3xNpU1rp4X0aIWWgbcDgN54UOTs1g7979jipiKUfHRHZVPHmnRFiLTWrk
         YjU31Udbyg0Tda7cnRUePyIRHfBdT3AezsbXeqf49W5ynTdrUx1gWZ6ZaSp5tqq9KnMN
         kk1DT2aGo9oEcFd07xXze0byOcR8uTyFU77c4nSGDNreXmj+TVx7va2xYFKWgcyYLaSK
         eZPw==
X-Gm-Message-State: AJcUukd8n4BsGNyRIVAu+cn9DCOGzUBNrzNYGIJTWV/u/+GkieX2ehvR
        NAWQcf7hpR8V0JeSdVIN4Gr9T52sthvbkcpBZPyBkQ==
X-Google-Smtp-Source: ALg8bN4eWtyV/c9h4bUe0I8Ah5BznJgnzedri0hDWjIkPmPVfFreq4xkm00CDpi30Y6ReuER6Azk08RcWRnH4QDYT7Y=
X-Received: by 2002:a17:902:a58a:: with SMTP id az10mr44489200plb.10.1546443036861;
 Wed, 02 Jan 2019 07:30:36 -0800 (PST)
MIME-Version: 1.0
References: <75ce3040b4086ffa2d2e088ad7f24f5e4a87be56.1523552145.git.andreyknvl@google.com>
 <20180604042900.GB31498@zurbaran.ger.intel.com>
In-Reply-To: <20180604042900.GB31498@zurbaran.ger.intel.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 2 Jan 2019 16:30:25 +0100
Message-ID: <CAAeHK+yvf-LqrfdQ18FMzaCNqdNHqAjgrDMrwUReZq8ei=hTYQ@mail.gmail.com>
Subject: Re: [PATCH] NFC: fix attrs checks in netlink interface
To:     Samuel Ortiz <sameo@linux.intel.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 6:29 AM Samuel Ortiz <sameo@linux.intel.com> wrote:
>
> Hi Andrey,
>
> On Thu, Apr 12, 2018 at 06:56:56PM +0200, Andrey Konovalov wrote:
> > nfc_genl_deactivate_target() relies on the NFC_ATTR_TARGET_INDEX
> > attribute being present, but doesn't check whether it is actually
> > provided by the user. Same goes for nfc_genl_fw_download() and
> > NFC_ATTR_FIRMWARE_NAME.
> >
> > This patch adds appropriate checks.
> >
> > Found with syzkaller.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  net/nfc/netlink.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> Thanks, applied to nfc-next.

Hi Samuel,

It's been 6 months and this fix is still not in mainline. Did it get lost?

Thanks!

>
> Cheers,
> Samuel.
