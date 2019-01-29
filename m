Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB469C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6522147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebtV/hFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbfA2Wti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 17:49:38 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42583 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfA2Wth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 17:49:37 -0500
Received: by mail-vs1-f67.google.com with SMTP id b74so13021317vsd.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 14:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UECppes1NXlONSBM2u64eJ/FcHzNxJoDIt0Oeyx5+iw=;
        b=ebtV/hFgYQx2Dl+4oqYrvHR4oqk6mEnaJxBo5cZzZZ4CFI5wrmnO+OlGlfDt6uUkWq
         MeMDAlDntefx4bgKy/VpZ6TBEdy/rOzjiP8Txh4WKeMkmMxkjjAAqwRbtit0E64gzsJk
         iSiFOsb3njWO8BmpCCmVvhjOTCc7G/f2obJ/nRqSGeyTOR1FTlL6pMZRvMQScSVLXDw1
         ezgKncd60uxDdXk/H9WTrLz7rF7oQ4s1pwSjkYePxyG30N8ET0BDVg5dOxJ00asxA1Qb
         v3pqtgg7jakvOPpzKWxpsUV8ldobWqsG7LERqG+1t901rNBtaw+Cy5murQLrk9LZsVUp
         GIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UECppes1NXlONSBM2u64eJ/FcHzNxJoDIt0Oeyx5+iw=;
        b=HkofpY30T0zEzCZ8EXywSGL+sK3FTGMnE++pHaPCFbIbigtkxRvtFJylmhaJidMauh
         RNHsP0Zo7cYjL7DqYsdbrFU+6C2VNoxtxZu7el8POZ/p3jQ33OYNhPg/UvTaeV6WOAUW
         cgpovX3faf9EmIB6609KsFNi/lIiJ6sXcYnAZ9LXZpT5ACKrzmIc0/PUpWDW2Mc6t80S
         4n9v/HdFNWdhmfM2s9KLEnEw1F4ieICEYjumHSXO8n+WuMtbyMX16i1ATW+FRyGQSNSz
         BcZ9OUC+GWTVQOrTD+h7ASb8ipJ+62mz9yG49cyyomIFogoIW+MPjiqQgSa2BsVlJ3eg
         pnNw==
X-Gm-Message-State: AJcUukcJELCBlCtSeCIc8ayYc50UuJ5hDKNzllirJlGo7wmFZYeOt0TN
        cb517GXR0zFl/Wg9MwHbNC54yN0nnqQoUe1t+HE=
X-Google-Smtp-Source: ALg8bN6gqwDXWkQFPnOpdPqVAkHpLbyVq7sv7zgvpQy0W1otNY2+B7CFRSs5/u9/GHc9GA4MigtnXJqvBcmTRTPgm4Q=
X-Received: by 2002:a67:d20d:: with SMTP id y13mr11663171vsi.163.1548802175921;
 Tue, 29 Jan 2019 14:49:35 -0800 (PST)
MIME-Version: 1.0
References: <20190123000057.31477-1-oded.gabbay@gmail.com> <20190123000057.31477-2-oded.gabbay@gmail.com>
 <CAK8P3a2NX_SNZPfqE4fnVcnxmSfAEzWMODce3L-g6JJ0NSTuBw@mail.gmail.com>
 <CAFCwf10jv4aMNefk_1Xj_Tg5Yjg8ekzWtZ94TssfHzaSN5CVAA@mail.gmail.com>
 <CAK8P3a3=1Rocb8jcG8XHadgcUCL6xXs8GRxc-Az6oyPqffYTpw@mail.gmail.com>
 <CAFCwf109SsyUVfvWAwA-j6HbqJ-QEZkWUhwirtX7dUf5CP_R7A@mail.gmail.com> <20190127083217.GB4561@kroah.com>
In-Reply-To: <20190127083217.GB4561@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Wed, 30 Jan 2019 00:49:10 +0200
Message-ID: <CAFCwf10nWdWdHT9m8xbdXDtP0y3FRk5PV09kepG46ZS8F1KvxQ@mail.gmail.com>
Subject: Re: [PATCH 01/15] habanalabs: add skeleton driver
To:     gregkh <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ogabbay@habana.ai
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2019 at 10:32 AM gregkh <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Jan 26, 2019 at 11:48:02PM +0200, Oded Gabbay wrote:
> > On Sat, Jan 26, 2019 at 11:14 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Sat, Jan 26, 2019 at 5:25 PM Oded Gabbay <oded.gabbay@gmail.com> wrote:
> > > >
> > > > On Sat, Jan 26, 2019 at 6:06 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > >
> > > > > On Wed, Jan 23, 2019 at 1:01 AM Oded Gabbay <oded.gabbay@gmail.com> wrote:
> > > > >
> > > > > > diff --git a/drivers/misc/habanalabs/include/habanalabs_device_if.h b/drivers/misc/habanalabs/include/habanalabs_device_if.h
> > > > > > new file mode 100644
> > > > > > index 000000000000..9dbb7077eabd
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/misc/habanalabs/include/habanalabs_device_if.h
> > > > >
> > > > > Since this is a apparently a user space ABI, the file should be in
> > > > > include/uapi/linux/,
> > > > > not in the driver directory.
> > > >
> > > > This is not a user space ABI. This is the ABI between the driver and the F/W.
> > >
> > > Ah, I see. In that case, you should get rid of all the bitfields and make the
> > > struct members all __le32/__le64/... to make it work on big-endian kernels.
> > >
> > I really don't want to start converting bitfields and structures to
> > use __le32/64.
> > As I wrote in one of the previous reviews, we don't support big-endian
> > architecture (what's left after POWER moved to support little endian
> > ?).  We actually do run on POWER9 but with ppc64le architecture
> > In any case, our software stack is so big that this minor change in
> > the driver won't have any impact on the overall ability to run
> > something on our H/W
>
> You don't have to do anything at the moment to "convert" to use a
> specific endian, but you do have to always mark such variables that are
> in a specific endian that this is the format they are expected in.
>
> Then, when you run a tool like sparse, you will be notified if you
> happen to be making any assumptions that might not be correct about
> those variables, and it's trivial to usually fix it up at that time.
>
> hope this helps,
>
> greg k-h

ok, understood, fixed.
Thanks,
Oded
