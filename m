Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6321C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B962086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+5NQgQ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfARBpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 20:45:49 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40204 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfARBps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 20:45:48 -0500
Received: by mail-it1-f193.google.com with SMTP id h193so3858673ita.5;
        Thu, 17 Jan 2019 17:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Lz6AnJMYxCrhSmDim5KOg2l8OFTIoaJZ8Kmz167VyfY=;
        b=J+5NQgQ0tPDPhszvWLVHFpjg+WC1SlNONqiBpo2RmBQU8Liw05KCbCRMGYmw/Ss4Bo
         h9J8aQ7e8YiYw6cmOs9nezBc0sBEv+gnrT+sWzdfJVTdXQiFkkhLvpLVu5krBAo4EJ4P
         /xRv4xutRQjuxpkyG/G52gfhYyp7CBDy7kgQhp5wJPuvsjqxMmVVikVJ9Js41SNx0xlT
         XM1u3VYkLNnO6su1xLQrb1A6HvyzYBdhYBv4TdtP25GMus+OTF9Klv+wsR7oB0Ea8QRg
         oz0JwwOrYM/c4puok/AdbAbU03LOlGTx9WAwEBTEHw/t82nwdRJwaSvyTqlqEbJokKcR
         Xjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Lz6AnJMYxCrhSmDim5KOg2l8OFTIoaJZ8Kmz167VyfY=;
        b=KlcPJxQHshulvV4wnOpjo+I08cifiQMFJSovAHMgP6jJaGS7gub4Vfatv06Qm1A1xw
         1IgSMYTmGxtSgrg9H0n6OFt5dMVolalpxIm3muFCLnOFBilp7O/yFkhAw5fBdaOw//9w
         uaLZYWdeiHJka54oEEMNNFzykhntQFMgfh4HiZoh+hToo5rPLIwGw4DTiJVkYOHtYYcy
         2+VWZTpMAfW8Pi4xn5fxUDTC6fXjDMAp9CHL8PO4oKqKscnRILIsMHmYb7RTtRXCf53q
         sAROkIq/LZKICh6OhoRkp8PYUHZst85QZJppd/8k+G2EZziViJnpyV8YCFeJYyslLhTm
         CtwA==
X-Gm-Message-State: AJcUukfnKc6EciB4h1j8nngOqwTkiTi+KZ6VLXn9Z1iwnsl2ee9GAx2C
        P1hmgsx3OMFnNNAxocMjL4TV8xZMvsWVd0b+dgQ=
X-Google-Smtp-Source: ALg8bN79SQ0e4eH7uAYUlvnO3qqhLweRqJkHjXJrkcaau/84eVmDeVbthZKyhWqrp/Hm4bcLbax131OJbvIa3tSCi9w=
X-Received: by 2002:a24:b34f:: with SMTP id z15mr9537852iti.61.1547775947990;
 Thu, 17 Jan 2019 17:45:47 -0800 (PST)
MIME-Version: 1.0
References: <1546225404-6775-1-git-send-email-chenhc@lemote.com>
 <alpine.DEB.2.21.1901151959060.1655@nanos.tec.linutronix.de>
 <tencent_7CB943266ADCFDB06DDDE6EF@qq.com> <alpine.DEB.2.21.1901161016270.1655@nanos.tec.linutronix.de>
 <tencent_0985E6EE28C337614825A2C1@qq.com>
In-Reply-To: <tencent_0985E6EE28C337614825A2C1@qq.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 18 Jan 2019 09:52:00 +0800
Message-ID: <CAAhV-H7=E_uwvGJF5-J7r0LLG4-=MEqOSnyR6ajThp8Qy0UUdg@mail.gmail.com>
Subject: Re: [PATCH] genirq/affinity: Assign default affinity to pre/post vectors
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        wuzhangjin <wuzhangjin@gmail.com>,
        stable <stable@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        Michael Hernandez <michael.hernandez@cavium.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 9:14 AM =E9=99=88=E5=8D=8E=E6=89=8D <chenhc@lemote.=
com> wrote:
>
> =E9=99=88=E5=8D=8E=E6=89=8D
> =E6=B1=9F=E8=8B=8F=E4=B8=AD=E7=A7=91=E6=A2=A6=E5=85=B0=E7=94=B5=E5=AD=90=
=E7=A7=91=E6=8A=80=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8/=E8=87=AA=E4=B8=BB=
=E5=AE=89=E5=85=A8=E4=BA=8B=E4=B8=9A=E9=83=A8/=E8=BD=AF=E4=BB=B6=E9=83=A8
> =E6=B1=9F=E8=8B=8F=E5=B8=B8=E7=86=9F=E8=99=9E=E5=B1=B1=E9=95=87=E6=A2=A6=
=E5=85=B0=E6=9D=91
>
>
>
> ------------------ Original ------------------
> From:  "Thomas Gleixner"<tglx@linutronix.de>;
> Date:  Wed, Jan 16, 2019 05:26 PM
> To:  "=E9=99=88=E5=8D=8E=E6=89=8D"<chenhc@lemote.com>;
> Cc:  "linux-kernel"<linux-kernel@vger.kernel.org>; "Fuxin Zhang"<zhangfx@=
lemote.com>; "wuzhangjin"<wuzhangjin@gmail.com>; "stable"<stable@vger.kerne=
l.org>; "Christoph Hellwig"<hch@lst.de>; "Michael Hernandez"<michael.hernan=
dez@cavium.com>;
> Subject:  Re: [PATCH] genirq/affinity: Assign default affinity to pre/pos=
t vectors
>
> Chen,
>
> On Wed, 16 Jan 2019, =E9=99=88=E5=8D=8E=E6=89=8D wrote:
>
> > please do not top-post and use line breaks around 78 char.
>
> > I'm not removing all return NULL of irq_create_affinity_masks(), so the=
 ......
>
> > > Moved content to the place where it belongs so the context is preserv=
ed.
>
> > ------------------ Original ------------------
> > From:  "Thomas Gleixner"<tglx@linutronix.de>;
> > Date:  Wed, Jan 16, 2019 03:10 AM
> > To:  "Huacai Chen"<chenhc@lemote.com>;
> > Cc:  "linux-kernel"<linux-kernel@vger.kernel.org>; "Fuxin Zhang"<zhangf=
x@lemote.com>; "wuzhangjin"<wuzhangjin@gmail.com>; "stable"<stable@vger.ker=
nel.org>; "Christoph Hellwig"<hch@lst.de>; "Michael Hernandez"<michael.hern=
andez@cavium.com>;
> > Subject:  Re: [PATCH] genirq/affinity: Assign default affinity to pre/p=
ost vectors
>
> > And please configure your e-mail client to NOT copy the full headers in=
to
> > the reply.
>
> > > > On Mon, 31 Dec 2018, Huacai Chen wrote:
> > > >
> > > > > Generally, irq_create_affinity_masks() assign default affinity to=
 pre/
> > > > > post vectors correctly. However, it ignore the case that there ar=
e only
> > > > > pre/post vectors (when nvecs =3D=3D affd->pre_vectors + affd->pos=
t_vectors)
> > > > > and return NULL. This case usually happens when nvecs =3D 1 (e.g.=
 in nvme
> > > > > driver when MSI-X is unavailable and fallback to MSI) and will tr=
igger
> > > > > the warning in pci_irq_get_affinity(). This patch fix the corner =
case.
> > > >
> > > > Errm. This is just wrong. When this function returns NULL, then it =
has
> > > > failed and the caller or any subsequent code is not supposed to use=
 the
> > > > result.
> > > >
> > > > The function can return NULL for other reasons, e.g. when the memor=
y
> > > > allocation failed. How are you going to duct tape that one?
> > >
> > > I'm not removing all return NULL of irq_create_affinity_masks(), so t=
he
> > > memory allocation failure still return NULL. I just handle the case t=
hat
> > > there are not enough irq vectors. E.g. in nvme driver, the caller may=
 call
> > > irq_create_affinity_masks() with nvecs=3D1,pre_vectors=3D1,post_vecto=
rs=3D0. In
> > > this case, the only one vector's default affinity assigning is skippe=
d.
> >
> > I did not say that you removed all NULL returns. I said that this funct=
ion
> > can return NULL for other reasons and then the same situation will happ=
en.
> >
> > If the masks pointer returned is NULL then the calling code or any
> > subsequent usage needs to handle it properly. Yes, I understand that th=
is
> > change makes the warning go away for that particular case, but that's n=
ot
> > making it any more correct.

Hi, Thomas,

I don't think "nvecs =3D=3D affd->pre_vectors + affd->post_vectors" is an E=
RROR,
so it should be different with "return NULL for other reasons" to the calle=
r. If
the caller fallback from MSI-X to MSI, it is probably "nvecs=3D1,pre_vector=
s=3D1,
post_vectors=3D0". The caller can work perfectly, if pre/post vectors are f=
illed
with the default affinity.

Huacai

> > Thanks,
>
> > tglx
