Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDBFC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E662080F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpqAYoYw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E662080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbeLMHro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 02:47:44 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42461 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeLMHrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 02:47:43 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so652104plp.9;
        Wed, 12 Dec 2018 23:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U1kdblOkJeUGCFzl5KLv1H49TEpdl9qC6nK7L+3L29c=;
        b=TpqAYoYwMe1TJDoCr58p8u4c15c86tjuJio3/1Um7s9VeQMthzh84tY1nz/a74ZQxf
         MyvzBmj+EE/ZiEYbonVNj+PmNsVClYy1b14oQJAv2onUlwDS55YdHkWpnj4dpPAnvacM
         o/AoSNObkNYx66T/5FmPq3PhYzTv4hcle+nY6WzqoRFufR5Eah8MI/wyE3vfwgwidnYf
         OKSIbP0njF4oFHHqh5W8kGbIRdfQMhgyR3i6XX0CnAjkRvqvu3mTZikVUMzlNpAYrrMg
         aJVyi0JQfUAh5R5hZ3KxSiXN+eBjSOAQYWJOnRjfQ0dH003JGBrhvSkxJau7Z3UuXV6h
         8IFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U1kdblOkJeUGCFzl5KLv1H49TEpdl9qC6nK7L+3L29c=;
        b=WnaRG+OnJwWEHVd8k7yH5Dl4so/ZhBpyKPzdpyuhqx+Sp8Ln/yTHXXqs7BTIYGSRcf
         w4rq4JaGu7JU/R+3QgGV62rqAtFA07chEoGffU++LBGHtnNTvYq8tMW060YiSqte7IZT
         KrmHcNsx6IPHPu7fOgSiJZdZ+9YwlYUKl9RGvDnvudap9yhcqkSgMZlXwPP6Xxqfok2n
         6oovOXTgn7N9psUVtCkiX4hphpmQzf5cveqGHV5r+icXCxHM/APWMFifZ/ur8RsmUrSb
         Jo7fbFpwSjbJoA1VqNqKaotEJ/PCOJvgUy52bf0HuwtYnQEdaLbJ7xU7VHUFToKehB60
         kbqg==
X-Gm-Message-State: AA+aEWYK+PnZdx97ll2U/BmIbHPzBAFO+I1kJzPUaCPeHGbvLTv9mZ6d
        Dm4Azi8j0jW7dKukmcyGsp2tPmK3PuP6xR6om44=
X-Google-Smtp-Source: AFSGD/XaHQurPfiJZl0nifD8SVpllsWxHwP1gQEAMsEgMubG9uFN1wv4BtJUNE8J6a9nm+2+ylSuJ8ODlQsaQfiABOY=
X-Received: by 2002:a17:902:d806:: with SMTP id a6mr21675813plz.172.1544687262841;
 Wed, 12 Dec 2018 23:47:42 -0800 (PST)
MIME-Version: 1.0
References: <20181206132113.2691-1-Tianyu.Lan@microsoft.com>
 <20181206132113.2691-8-Tianyu.Lan@microsoft.com> <20181212050353.GF22265@blackberry>
In-Reply-To: <20181212050353.GF22265@blackberry>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Thu, 13 Dec 2018 15:47:31 +0800
Message-ID: <CAOLK0pyKsS2hLagZ6pumMdfRokPig2P+KJambVOq7p+NU-OqgA@mail.gmail.com>
Subject: Re: [Resend PATCH V5 7/10] KVM: Make kvm_set_spte_hva() return int
To:     paulus@ozlabs.org
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>, christoffer.dall@arm.com,
        marc.zyngier@arm.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, jhogan@kernel.org,
        ralf@linux-mips.org, paul.burton@mips.com,
        benh@kernel.crashing.org, mpe@ellerman.id.au,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm <kvm@vger.kernel.org>,
        michael.h.kelley@microsoft.com, kys@microsoft.com,
        vkuznets@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul:
             Thanks for your review.
On Wed, Dec 12, 2018 at 1:03 PM Paul Mackerras <paulus@ozlabs.org> wrote:
>
> On Thu, Dec 06, 2018 at 09:21:10PM +0800, lantianyu1986@gmail.com wrote:
> > From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> >
> > The patch is to make kvm_set_spte_hva() return int and caller can
> > check return value to determine flush tlb or not.
>
> It would be helpful if the patch description told the reader which
> return value(s) mean that the caller should flush the tlb.  I would
> guess that non-zero means to do the flush, but you should make that
> explicit.

OK. Thanks for suggestion and will update in the next version.

>
> > Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
>
> For the powerpc bits:
>
> Acked-by: Paul Mackerras <paulus@ozlabs.org>



-- 
Best regards
Tianyu Lan
