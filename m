Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3F4C6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 12:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D55F2077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 12:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iABS1Buu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D55F2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbeJNUia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 16:38:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33413 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbeJNUia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 16:38:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id y18-v6so7897425pge.0;
        Sun, 14 Oct 2018 05:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QOh3/rAAMNg6qWlR3ockjsVxuDsHmKYoJ0FCAyRqfh4=;
        b=iABS1BuuIxLgQKHch2Dlc2zTZiMd5aUIeqllYaFVgeR7hoGPuvGN0BBSP3H1vOGBVn
         KnNmfDgbSWbJo+V1YyBGzEulGIQI4dKrQDtk/qd41E6RZlIfP2uxnp0+oBAtOmE4lG68
         x70+eGZP6uqx3qIucJWNiOGFfutGJX0zNuk02P85pVbzAfz/cdNnL7N6mjQ9px/1vLGR
         0JCrXbMG1TROv4dsnHtWFYQhX2S77DifFBaPTKHxH7wYOLvmaT9qB/OI8BYNCWShL/X9
         mFcN7LHngJUy/JxGOyjI6S48h8FN8nkPma5iSqUuYea8u+8O4wp45CoWdE8sNLx2J/u+
         jenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QOh3/rAAMNg6qWlR3ockjsVxuDsHmKYoJ0FCAyRqfh4=;
        b=OaJsWyv3iJfe+5wYy4VmOWcNlbFnLPobcedYWTYUv1c8auJIo6Y9LmqbSHg2shZkJu
         YTDG+umgj41xv+KOMz3SnRGox3zR2CRxQ+ngjOUVyvclxEIvl8OlXDhezswUzaFrNdDR
         e99nhdSUgclM/QE1pFbhx1eRz9bRsQK03bmEFJuGp2JIwWbOBPmOsjxSlMRpat9/K3yV
         FthWCtjNQNwNBq2GVeltOeenlbRHR6qgZOf5UuBOjYXl0OrXcuCs7jVCy2KDLRhu8XGG
         bGnCf6RPxnDF9ttot4/cp0NZY8/IgNbb43So0YnCnfKv/vjK0b0kMzQHJiPtMrPFJXUz
         atXA==
X-Gm-Message-State: ABuFfogs66iY69I6pXzPmVFLB6haw2yX6V5PpSn19X1Wog8/+T6Tayb4
        1omgKH8xrsf6ogPnRzWc9xNxQugQngPNuGAJwE0=
X-Google-Smtp-Source: ACcGV60zf0Hi3mZezp2hDEDaLIs17dXAsuvuc8YysL8650sEBPqrqgQAvzNYudsoqEWRyq2I1MEzwEjavgjecjVnptw=
X-Received: by 2002:a62:8910:: with SMTP id v16-v6mr13526160pfd.106.1539521853925;
 Sun, 14 Oct 2018 05:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
 <20181013145406.4911-3-Tianyu.Lan@microsoft.com> <4D709C3A-A91C-4CA7-922A-E77618EF21B4@oracle.com>
 <alpine.DEB.2.21.1810141014350.1438@nanos.tec.linutronix.de> <1BDC7949-CFED-46C2-9D05-42864B0AD0F0@oracle.com>
In-Reply-To: <1BDC7949-CFED-46C2-9D05-42864B0AD0F0@oracle.com>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Sun, 14 Oct 2018 20:57:22 +0800
Message-ID: <CAOLK0pxC9S7YzoC-YmE7bw2VyPEZfxZSCOW+hW+t3Mi8V6Y-RQ@mail.gmail.com>
Subject: Re: [PATCH V4 2/15] KVM/MMU: Add tlb flush with range helper function
To:     liran.alon@oracle.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        christoffer.dall@arm.com, marc.zyngier@arm.com, linux@armlinux.org,
        catalin.marinas@arm.com, will.deacon@arm.com, jhogan@kernel.org,
        ralf@linux-mips.org, paul.burton@mips.com, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devel@linuxdriverproject.org,
        kvm <kvm@vger.kernel.org>, michael.h.kelley@microsoft.com,
        vkuznets@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liran & Thomas:
              Thanks for your review.


On Sun, Oct 14, 2018 at 5:20 PM Liran Alon <liran.alon@oracle.com> wrote:
>
>
>
> > On 14 Oct 2018, at 11:16, Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Sun, 14 Oct 2018, Liran Alon wrote:
> >>> On 13 Oct 2018, at 17:53, lantianyu1986@gmail.com wrote:
> >>>
> >>> +
> >>> +static inline bool kvm_available_flush_tlb_with_range(void)
> >>> +{
> >>> +   return kvm_x86_ops->tlb_remote_flush_with_range;
> >>> +}
> >>
> >> Seems that kvm_available_flush_tlb_with_range() is not used in this pa=
tch=E2=80=A6
> >
> > What's wrong with that?
> >
> > It provides the implementation and later patches make use of it. It's a
> > sensible way to split patches into small, self contained entities.
> >
> > Thanks,
> >
> >       tglx
> >
>
> I guess it=E2=80=99s a matter of taste, but I prefer to not add dead-code=
 for patches
> in order for each commit to compile nicely without warnings of declared a=
nd unused functions.
> I would prefer to just add this utility function on the patch that actual=
ly use it.
>
> -Liran
>

Normally, I also prefer to put the function definition into the patch
which use it.
But the following patch "KVM: Replace old tlb flush function with new
one to flush a specified range"
and other patches which use new functions will change a lot of places.
It's not friendly for review and
so I split them into pieces.
--
Best regards
Tianyu Lan
