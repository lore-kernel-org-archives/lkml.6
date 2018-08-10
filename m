Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCA6C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4746522403
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IfHId3yp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4746522403
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeHJM5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 08:57:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44125 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbeHJM5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 08:57:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16-v6so7811613wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 03:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aVaMG9YONH9oFLKiba2QQTEYT7Q0A2zdjraX40VgwGg=;
        b=IfHId3ypN1ZOh8NDRdpAUum8tMauAsVS/ICnHX9O87dAq1yCoKYBWLCrqIO+4AzkBL
         HVGmgWU9Tm5Yp+08uygYh01IRRnNRqLJhxHUuddB6Tne8z1X/hOzpR5DBcv41VD3NhkR
         EiFrtr5NcEjMhNE+6o8LdJVcWtWwEb0BNhav4A/lEwp1/XFCgG39PboxF0TXHCVbYRNR
         K5TKZT6+VUbGPt6azFw6QSl73jIYcaRx3Kncq8OtpIRmMBn67OIF4HCpeJYTDzjiLD1r
         qsAXHu775xB0MxJjNlywQvvARI7ZrtjBCBLORUtuM+sMtG8LqdybaIeJIytRpdThUmCt
         R1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aVaMG9YONH9oFLKiba2QQTEYT7Q0A2zdjraX40VgwGg=;
        b=XDEKq6JtbgeFpK5APbHGHedXWOrVXzejdfcn1MSf/QYZ1Av2qn7ABym5/4Vb0xHrR2
         fO775uqpfPT1fmEEtUNBpYVzpOUOzpxKbEDX1gLD3bBXo+K4AOLH4SLZJL5sJ1GZYYwO
         PYWhLSpl4c8R18NT+s2KI/8cC9VOXDG38Vf3h2LDth4GrphShmXo4dWIOhdbrth73fNx
         juM84dSfqwDPpf605hQ/GhisOkbDHROGR8lEZgcKYOa7+wNSxa+zxkdfMYGRor2P6Rc/
         25khy2Ju5qBqy5I9xCps6xjGaZtdG9RmWU5Bvufr/qvQuIdiFp6erazy+lCzYYVjbwlD
         9EFQ==
X-Gm-Message-State: AOUpUlF+Iy2iOxWBz4z1qfIsl5b71lLuNSAcJSLIoUci/Qv7wO/wllyK
        v0JuufV4ic7Hy2KMgxi/bak5tIJKdGuDREkBlkIJjQ==
X-Google-Smtp-Source: AA+uWPx/7c9qwnSPaFChxiAvIDSm92eJb0NCCGUm/e9TPZTmZm0S/3PsuZlw0i+zTBd1dVP+Ttv4kfWiNwNhJP/Imok=
X-Received: by 2002:a5d:6b01:: with SMTP id v1-v6mr3623645wrw.208.1533896894712;
 Fri, 10 Aug 2018 03:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180810032111.197743-1-toddpoynor@gmail.com> <20180810032111.197743-2-toddpoynor@gmail.com>
 <CAOmRg6P53DdsmMKOXpB2RWueU5d2Otzg_gyWgcX+5cPf+wSJ7w@mail.gmail.com> <20180810061422.GB1062@kroah.com>
In-Reply-To: <20180810061422.GB1062@kroah.com>
From:   Todd Poynor <toddpoynor@google.com>
Date:   Fri, 10 Aug 2018 03:28:03 -0700
Message-ID: <CAAW3YpZQFKuWZO8jnXNc7m6DNYpffRiOxaGawi413B5ZgUbbBw@mail.gmail.com>
Subject: Re: [PATCH 01/16] MAINTAINERS: Switch a maintainer for drivers/staging/gasket
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     John Joseph <jnjoseph@google.com>,
        "toddpoynor@gmail.com" <toddpoynor@gmail.com>,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        Rob Springer <rspringer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 9, 2018 at 11:14 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Aug 09, 2018 at 08:40:06PM -0700, John Joseph wrote:
> > Acked-by: John Joseph <jnjoseph@google.com>
>
> Why are you acking something you supposidly already signed-off on?

Sorry, my fault, wasn't sure what the protocol was for these so I
suggested he send an Acked-by as well, can drop that.

>
> > On Thu, Aug 9, 2018 at 8:20 PM, Todd Poynor <toddpoynor@gmail.com> wrote:
> > > From: Todd Poynor <toddpoynor@google.com>
> > >
> > > Todd Poynor takes over for John Joseph.
> > >
> > > Signed-off-by: John Joseph <jnjoseph@google.com>
> > > Signed-off-by: Todd Poynor <toddpoynor@google.com>
>
> Did you not really provide your signed-off-by here?

We generated this together, the S-o-b is valid,

>
> totally confused,
>
> greg k-h
