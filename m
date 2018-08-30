Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A254BC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 02:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95DE3205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 02:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzNE0+sX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95DE3205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeH3GPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 02:15:24 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:43455 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbeH3GPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 02:15:24 -0400
Received: by mail-oi0-f66.google.com with SMTP id b15-v6so12750719oib.10;
        Wed, 29 Aug 2018 19:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7ZJiIu9/XYP4OcbTPRlsSzHZaHYFu9kC3euTdU/LsVc=;
        b=KzNE0+sXdpscHY4EOUYrBRbp8riD5wFDrju5O2yNWR1RF09YKGyydP0iwE45XGsmt/
         GMKwl7bIsIXJSOF46bfSTMlVIjxG/TIQU/v+pqSgyumJE3ox0vdUYzQ07izej6/Iml04
         U0k/4U9ELDm5kaVCYGZ5ISr5v1I13lz1zPIbTWhoZDOkMrDf8anZNax1YmGnAU4iZniZ
         6911bxfaubii9JGIX6ggwbLe0yuxiiUIyMCWjXD0+DUK74NzD6VsaysY/ycQEyVQWFiB
         kinhjxKNDNhvpYMFduC492fRuIbt2yKjNHx4gz0+n+SnYw/+gVqoX4BFtf9V0/cB00TD
         Jkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7ZJiIu9/XYP4OcbTPRlsSzHZaHYFu9kC3euTdU/LsVc=;
        b=T+/h2RdUMFvG/KMCI7ya7ByKf9aBJ0xQuyw7laXPD70xmP6grg7Ea+xDW0mFTmgHUY
         WAB4pqAieGD8vDFdUCwI0IyqCtGFj/gCnRojjd245U4mfAVG/Q2FEHSPYqsVCeqwF6oJ
         FM8JqbRY8akteqkV+Le0IZT+YtLvwXwGrcS46YP7S7Srs3j2N7XcL4CafDq8VY+0ge6w
         A3YAHJg6qo4kuOvrBa7vamfgQgcTTFWxZgRTu2R77jOPU5X+lzznVisB9UpdesCkYx4G
         Jv8lqooF9zrfuwaMLd0Wm8RAak5vZ/BVLGjTFAr3kQe/n/Zg9/NWLFRovrFPfavnyju7
         6bUA==
X-Gm-Message-State: APzg51CswLu5gnzI2pglq5QOaIrnXu+NvF1hBd794Ik/QdS2BbsiIx02
        qIIYOkLQxm1DeYfWStN2Ofd/VReGDqk/04IkEK0=
X-Google-Smtp-Source: ANB0VdYGuct5hx4nQV1bRQ9jDTW1qKHHrKf4i7AO1Zrcadet12Vb/oWu/HAG3frieK1JDN199/UwgQT+/K1AKCwx4O0=
X-Received: by 2002:aca:55cd:: with SMTP id j196-v6mr525178oib.202.1535595337030;
 Wed, 29 Aug 2018 19:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <1535521943-5547-1-git-send-email-wanpengli@tencent.com>
 <A523C29C-C3E8-4FEF-8620-96365F774582@oracle.com> <20180829101205.jsp53e2wq7fc6ukd@mwanda>
 <20180829101822.qo3u7lsmghs3kcuf@mwanda> <CANRm+Cy9n=2Ssy_cEWRtnoQJczjdqB+m-dA6zesz75r0h532iA@mail.gmail.com>
 <20180829102910.rkyato47chayt22s@mwanda> <20180829154246.GB19487@flask>
In-Reply-To: <20180829154246.GB19487@flask>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Thu, 30 Aug 2018 10:15:39 +0800
Message-ID: <CANRm+CzYyKVcktssQuY9HHvbsfYXXYoSg37ry30NG=Rsy0pyMg@mail.gmail.com>
Subject: Re: [PATCH] KVM: LAPIC: Fix pv ipis out-of-bounds access
To:     Radim Krcmar <rkrcmar@redhat.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Liran Alon <liran.alon@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018 at 23:42, Radim Krcmar <rkrcmar@redhat.com> wrote:
>
> 2018-08-29 13:29+0300, Dan Carpenter:
> > On Wed, Aug 29, 2018 at 06:23:08PM +0800, Wanpeng Li wrote:
> > > On Wed, 29 Aug 2018 at 18:18, Dan Carpenter <dan.carpenter@oracle.com=
> wrote:
> > > >
> > > > On Wed, Aug 29, 2018 at 01:12:05PM +0300, Dan Carpenter wrote:
> > > > > On Wed, Aug 29, 2018 at 12:05:06PM +0300, Liran Alon wrote:
> > > > > > > arch/x86/kvm/lapic.c | 17 +++++++++++++----
> > > > > > > 1 file changed, 13 insertions(+), 4 deletions(-)
> > > > > > >
> > > > > > > diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> > > > > > > index 0cefba2..86e933c 100644
> > > > > > > --- a/arch/x86/kvm/lapic.c
> > > > > > > +++ b/arch/x86/kvm/lapic.c
> > > > > > > @@ -571,18 +571,27 @@ int kvm_pv_send_ipi(struct kvm *kvm, un=
signed long ipi_bitmap_low,
> > > > > > >   rcu_read_lock();
> > > > > > >   map =3D rcu_dereference(kvm->arch.apic_map);
> > > > > > >
> > > > > > > + if (unlikely((s32)(map->max_apic_id - __fls(ipi_bitmap_low)=
) < min))
> > > > > > > +         goto out;
> > > > > >
> > > > > > I personally think =E2=80=9Cif ((min + __fls(ipi_bitmap_low)) >=
 map->max_apic_id)=E2=80=9D is more readable.
> > > > > > But that=E2=80=99s just a matter of taste :)
> > > > >
> > > > > That's an integer overflow.
> > > > >
> > > > > But I do prefer to put the variable on the left.  The truth is th=
at some
> > > > > Smatch checks just ignore code which is backwards written because
> > > > > otherwise you have to write duplicate code and the most code is w=
ritten
> > > > > with the variable on the left.
> > > > >
> > > > >       if (min > (s32)(map->max_apic_id - __fls(ipi_bitmap_low))
> > > >
> > > > Wait, the (s32) cast doesn't make sense.  We want negative min valu=
es to
> > > > be treated as invalid.
> > >
> > > In v2, how about:
> > >
> > > if (unlikely(min > map->max_apic_id || (min + __fls(ipi_bitmap_low)) =
>
> > > map->max_apic_id))
> > >     goto out;
> >
> > That works, too.  It still has the off by one and we should set
> > "count =3D -KVM_EINVAL;".
>
> I'd prefer to ignore destinations that are not present and deliver the
> rest, possibly nothing, instead of returning an error.
> (It's closer to how the real hardware behaves and we already return the
>  number of notified VCPUs, so the caller can tell whether something went
>  wrong.)
>
> Either in the form that I have posted earlier, or as:
>
>         if (min > map->max_apic_id)
>                 goto out;
>
>         for_each_set_bit(i, &ipi_bitmap_low, MIN(BITS_PER_LONG, map->max_=
apic_id - min + 1))

Do it in v2.

Regards,
Wanpeng Li
