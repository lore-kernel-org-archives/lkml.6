Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D432C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BE620833
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cB8jhdsO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4BE620833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbeH2OjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 10:39:01 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42448 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbeH2OjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 10:39:00 -0400
Received: by mail-oi0-f67.google.com with SMTP id k81-v6so2151672oib.9;
        Wed, 29 Aug 2018 03:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eZCzj2NzqF8CZNvB+7xgBqRwG2CmLOELnIsKVCVIqGs=;
        b=cB8jhdsOSgHDPIWJhRb0ABf7WEZkDMTcT9yXbH7CfhexooSpVP0PgE/jmvFZwQbZul
         Y20srf0wrn5yQBMsxUgu/E4bnEekpWT3JJFziOmnVkl5OJDoi7crKnJddvaTlbvpiDty
         QTE04d4A+3CNvrd3eQEp0B8FcGtgo5DRlItOG7RfCSH8i3Sj4o+y8D3A8HUApu0vcC00
         w7sVVVYvOv+bq/UT+MKvuhJ2Ku4w/V/5o4FIeguq0cNhEnAs2jPfomf/07jl34rpAhZE
         vuiWkVZG77XHntHjiVVXaRUCRvBxtdQN7O36EKcaXMeiQ9f1NIFbLBKCg5bQwndqC3Qw
         VDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eZCzj2NzqF8CZNvB+7xgBqRwG2CmLOELnIsKVCVIqGs=;
        b=f2veR78UXPiQv2z6jv+zxdpusK1MnjeaBwt8XeL7wRNQDhXX7fDB7XmGPXdu+8vEgz
         ToNUh3DJMdNg8jgJBj7REdzyhcEsthf7Xf5eWbq9UT+tIdj1spjRrs+PsUWhvDvCo5Go
         JzOzcs6iXgw6Z/LnoNOdIXriU7zMDgU+AG06Jiy8MewyZhq97v/4C950vJy5PFNBD0OG
         lwp08Djfl4Qfrnpen6mPY+PS4XQN2J3bS5jOFLGcOdgmDXxNEQ2QzkGo7EoH2pTYQ3I1
         t0Zl+V1sZwSSsjxiwSh3IJeqoom6vr9wMh75ape4yFQmkDJOjZfM9TO8JVDOSNG0f/kT
         Vfqw==
X-Gm-Message-State: APzg51A8qfvHHqR3ubc9TA/lofybUkTQc3MYuNC5yZ6nRwPsEXk0fxvf
        p3TiDzxpLwpM5rTpneJAtkeyLKozV93tOO2ORKI=
X-Google-Smtp-Source: ANB0VdYP2PXGYKoyPn9d+eUh9Km0v4Af0zFbFmXj0kPvjZE1Gxl44Jlr302SfNCNWqGjUb7vxB1Kw2WsxYnpIxkT7dg=
X-Received: by 2002:aca:dc82:: with SMTP id t124-v6mr2018264oig.189.1535539363722;
 Wed, 29 Aug 2018 03:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <1535521943-5547-1-git-send-email-wanpengli@tencent.com>
 <A523C29C-C3E8-4FEF-8620-96365F774582@oracle.com> <20180829101205.jsp53e2wq7fc6ukd@mwanda>
 <20180829101822.qo3u7lsmghs3kcuf@mwanda> <CANRm+Cy9n=2Ssy_cEWRtnoQJczjdqB+m-dA6zesz75r0h532iA@mail.gmail.com>
 <20180829102910.rkyato47chayt22s@mwanda>
In-Reply-To: <20180829102910.rkyato47chayt22s@mwanda>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Wed, 29 Aug 2018 18:42:42 +0800
Message-ID: <CANRm+CwszD_9xsHjxQPSuDQ00P1+rsx8vTWoyp-kespeUK1YqA@mail.gmail.com>
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

On Wed, 29 Aug 2018 at 18:29, Dan Carpenter <dan.carpenter@oracle.com> wrot=
e:
>
> On Wed, Aug 29, 2018 at 06:23:08PM +0800, Wanpeng Li wrote:
> > On Wed, 29 Aug 2018 at 18:18, Dan Carpenter <dan.carpenter@oracle.com> =
wrote:
> > >
> > > On Wed, Aug 29, 2018 at 01:12:05PM +0300, Dan Carpenter wrote:
> > > > On Wed, Aug 29, 2018 at 12:05:06PM +0300, Liran Alon wrote:
> > > > > > arch/x86/kvm/lapic.c | 17 +++++++++++++----
> > > > > > 1 file changed, 13 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> > > > > > index 0cefba2..86e933c 100644
> > > > > > --- a/arch/x86/kvm/lapic.c
> > > > > > +++ b/arch/x86/kvm/lapic.c
> > > > > > @@ -571,18 +571,27 @@ int kvm_pv_send_ipi(struct kvm *kvm, unsi=
gned long ipi_bitmap_low,
> > > > > >   rcu_read_lock();
> > > > > >   map =3D rcu_dereference(kvm->arch.apic_map);
> > > > > >
> > > > > > + if (unlikely((s32)(map->max_apic_id - __fls(ipi_bitmap_low)) =
< min))
> > > > > > +         goto out;
> > > > >
> > > > > I personally think =E2=80=9Cif ((min + __fls(ipi_bitmap_low)) > m=
ap->max_apic_id)=E2=80=9D is more readable.
> > > > > But that=E2=80=99s just a matter of taste :)
> > > >
> > > > That's an integer overflow.
> > > >
> > > > But I do prefer to put the variable on the left.  The truth is that=
 some
> > > > Smatch checks just ignore code which is backwards written because
> > > > otherwise you have to write duplicate code and the most code is wri=
tten
> > > > with the variable on the left.
> > > >
> > > >       if (min > (s32)(map->max_apic_id - __fls(ipi_bitmap_low))
> > >
> > > Wait, the (s32) cast doesn't make sense.  We want negative min values=
 to
> > > be treated as invalid.
> >
> > In v2, how about:
> >
> > if (unlikely(min > map->max_apic_id || (min + __fls(ipi_bitmap_low)) >
> > map->max_apic_id))
> >     goto out;
>
> That works, too.  It still has the off by one and we should set

Sorry, why off by one?

> "count =3D -KVM_EINVAL;".
>
> Is the unlikely() really required?  I don't know what the fast paths are
> in KVM, so I don't know.
>
> regards,
> dan carpenter
>
