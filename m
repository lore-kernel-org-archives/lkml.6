Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCD2C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6322083C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edMvYHB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6322083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbeH2OTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 10:19:23 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38155 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbeH2OTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 10:19:22 -0400
Received: by mail-oi0-f65.google.com with SMTP id x197-v6so8222185oix.5;
        Wed, 29 Aug 2018 03:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KzrJP4isoB6FmN9vrxNHMZqkcX8et6IZ/Tw04la4lgU=;
        b=edMvYHB3Pn/DZPxGveRX5uejCyr/rHxj+GeSMcxCmoohvwoKkTNXaq+NV1Lx3+9dcm
         NtOqFrCFYpzl7Fi9gNuGfyVvaOF5GfDKE/iaQ1ROr+P/JWjpUKf1QFhW31iLw3XsCPjI
         sVoWnDrg1czP+zdQGeN/97qPdsJ7QY5RRHXTxjMfEzgj94Okxvm8L06ASNOMpV3U9J/r
         fhbmBHhYFboGbcSfSUZEW9FH+PnN8LZZpEeJQE9R5tzm51vNTl4iI8cf7VBJkwEE9JYg
         5rk1GAErQmGPrxLhxSZezntzbRzyLnVhFM51d7Tj47QDQgb+vSk5Nxh/TpFdhlIYX8BX
         gpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KzrJP4isoB6FmN9vrxNHMZqkcX8et6IZ/Tw04la4lgU=;
        b=JrrwL6YUWKErKRB6njbtg+f4ODM5tQVUgK6rdmy3fCj/b8pJ3wPciMkOL6WW1Ib6hy
         L9qjxfoSku85JWFWMaTP3r/iTpfL5hcaTbqMDTDI5I1a9N0mDnAu4etennIvtuhJ+D17
         piOpQcaE3/3AB71f/0ST6dCyfYikKgM0ysWkOYrMMLf02PjHEJ/J5KifFbSoJ+oZ+VOh
         PYDacTdE+8TC3A85mZ0Ms9cwgygjqAUR2NDsYyX92xa5viIgvKa9hO9KY43p4uz2burb
         pHCOvfnGU8Jr2aID3SDWFIa6xXJeSqmm1lepVY7FwOHGlgTFyw40QJvz5GzdDp6rCJp4
         LHAw==
X-Gm-Message-State: APzg51ADvddOqECW9bJjW2VdoT1xOyxl26xSLoeZrf+sDgTFndgA2TkN
        CzfloAa2B80agoQ+auqLR5Gcn5P9Xfm2lRYatC0=
X-Google-Smtp-Source: ANB0VdYbFD8gkfYYdYuCyf3VIWbADG947Z9NjhqJzLFUCtRrPzCda0oYNLht+Fw9xr8v+1yFSG7+vSnArYhaGZNiubI=
X-Received: by 2002:aca:dc82:: with SMTP id t124-v6mr1957066oig.189.1535538190001;
 Wed, 29 Aug 2018 03:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <1535521943-5547-1-git-send-email-wanpengli@tencent.com>
 <A523C29C-C3E8-4FEF-8620-96365F774582@oracle.com> <20180829101205.jsp53e2wq7fc6ukd@mwanda>
 <20180829101822.qo3u7lsmghs3kcuf@mwanda>
In-Reply-To: <20180829101822.qo3u7lsmghs3kcuf@mwanda>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Wed, 29 Aug 2018 18:23:08 +0800
Message-ID: <CANRm+Cy9n=2Ssy_cEWRtnoQJczjdqB+m-dA6zesz75r0h532iA@mail.gmail.com>
Subject: Re: [PATCH] KVM: LAPIC: Fix pv ipis out-of-bounds access
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Liran Alon <liran.alon@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018 at 18:18, Dan Carpenter <dan.carpenter@oracle.com> wrot=
e:
>
> On Wed, Aug 29, 2018 at 01:12:05PM +0300, Dan Carpenter wrote:
> > On Wed, Aug 29, 2018 at 12:05:06PM +0300, Liran Alon wrote:
> > > > arch/x86/kvm/lapic.c | 17 +++++++++++++----
> > > > 1 file changed, 13 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> > > > index 0cefba2..86e933c 100644
> > > > --- a/arch/x86/kvm/lapic.c
> > > > +++ b/arch/x86/kvm/lapic.c
> > > > @@ -571,18 +571,27 @@ int kvm_pv_send_ipi(struct kvm *kvm, unsigned=
 long ipi_bitmap_low,
> > > >   rcu_read_lock();
> > > >   map =3D rcu_dereference(kvm->arch.apic_map);
> > > >
> > > > + if (unlikely((s32)(map->max_apic_id - __fls(ipi_bitmap_low)) < mi=
n))
> > > > +         goto out;
> > >
> > > I personally think =E2=80=9Cif ((min + __fls(ipi_bitmap_low)) > map->=
max_apic_id)=E2=80=9D is more readable.
> > > But that=E2=80=99s just a matter of taste :)
> >
> > That's an integer overflow.
> >
> > But I do prefer to put the variable on the left.  The truth is that som=
e
> > Smatch checks just ignore code which is backwards written because
> > otherwise you have to write duplicate code and the most code is written
> > with the variable on the left.
> >
> >       if (min > (s32)(map->max_apic_id - __fls(ipi_bitmap_low))
>
> Wait, the (s32) cast doesn't make sense.  We want negative min values to
> be treated as invalid.

In v2, how about:

if (unlikely(min > map->max_apic_id || (min + __fls(ipi_bitmap_low)) >
map->max_apic_id))
    goto out;

0xFFFFFFFF is converted to int min =3D -1;

Regards,
Wanpeng Li
