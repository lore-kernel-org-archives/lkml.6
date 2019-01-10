Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2F9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E788B20879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbfAJTnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 14:43:14 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44135 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfAJTnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 14:43:13 -0500
Received: by mail-ot1-f68.google.com with SMTP id f18so10988725otl.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 11:43:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sPgfEhYHHNB7vBHfMgCSXcBGQ+fLWI4pdLUmG15pdOo=;
        b=Z01mGryTn2LVWK4Gem1ASodh457cXAxfkz7G/8lNFnBYStU72J1Gsvs4lItVNuhPU0
         2AgFKKhnd5Nl2rQnqMrV/Mytuv4zadTlDzXjg7DDDlS4dpKhfmn0/8sZFJpMIRK7JQFa
         GR9HVvj//7GErXFqFVYt29TOlO/CbaKP2I8mYjwlj6MztKxJyqZsXOrKbsL88119b1Md
         GOJsBB7Sfy2eugb8cvYsJVnhicJE0IAZ1aPQqsdzXoOwryBDWOv7OXdw5N3WJPCCFAJy
         N3/FLpFC/in1Y7029k/UyFItWBHW4L7aftGjwVCf68YsjfnvyAf+v+qjEsdZZwRjZZ8j
         ZPxg==
X-Gm-Message-State: AJcUukc3KRaUoQGwgzvacXspqArZZpGcWC/BctfjvpE8OSisvfDHbKuE
        sL9ABqnA36LwTidEvWx4Su23iDQm
X-Google-Smtp-Source: ALg8bN4zKgCYYmIaOb/PKqyWj/l41r3Cv+QVhxAxSI3AQERO3li8wwSgbI+goSCigMN2BvvLR4klEQ==
X-Received: by 2002:a9d:7a8:: with SMTP id 37mr7932163oto.142.1547149393045;
        Thu, 10 Jan 2019 11:43:13 -0800 (PST)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com. [209.85.210.51])
        by smtp.gmail.com with ESMTPSA id b18sm33710763otl.33.2019.01.10.11.43.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 11:43:12 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id 32so10982760ota.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 11:43:12 -0800 (PST)
X-Received: by 2002:a9d:2387:: with SMTP id t7mr7303236otb.68.1547149392367;
 Thu, 10 Jan 2019 11:43:12 -0800 (PST)
MIME-Version: 1.0
References: <1544170963-8386-1-git-send-email-hofrat@osadl.org>
 <98aba52405a63829ee79c775c8b749f8431f5d2a.camel@buserror.net> <20181222075944.GA26155@osadl.at>
In-Reply-To: <20181222075944.GA26155@osadl.at>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Thu, 10 Jan 2019 13:43:01 -0600
X-Gmail-Original-Message-ID: <CADRPPNTeLH1ChyYgP3fwqkHLTYCcV48tY1W+91nufFJu+yFKrA@mail.gmail.com>
Message-ID: <CADRPPNTeLH1ChyYgP3fwqkHLTYCcV48tY1W+91nufFJu+yFKrA@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: guts: us devm_kstrdup_const() for RO data
To:     Nicholas Mc Guire <der.herr@hofr.at>
Cc:     Scott Wood <oss@buserror.net>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Nicholas Mc Guire <hofrat@osadl.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 2:02 AM Nicholas Mc Guire <der.herr@hofr.at> wrote:
>
> On Fri, Dec 21, 2018 at 08:29:56PM -0600, Scott Wood wrote:
> > On Fri, 2018-12-07 at 09:22 +0100, Nicholas Mc Guire wrote:
> > > devm_kstrdup() may return NULL if internal allocation failed, but
> > > as  machine  is from the device tree, and thus RO, devm_kstrdup_const()
> > > can be used here, which will only copy the reference.
> >
> > Is it really going to only copy the reference?  That would require that
> > is_kernel_rodata(machine) be true, which it shouldn't be since it's not part
> > of the kernel image.
> >
> I had tried to figure out what is RO and what not but was not
> able to determine that - from the discussion it seemed that the
> assumption of RO is correct though I did not ask if it would
> satisfy is_kernel_rodata() so that explains the incorrect assertion.
> see https://lkml.org/lkml/2018/12/6/42
> So then the only option is to check the return and cleanup
> on allocation failure as the orriginal patch proposed.

Thanks for the good discussion. I will drop the previous patch. But
would it also be good to just have "soc_dev_attr.machine = machine"
directly?

Regards,
Leo
