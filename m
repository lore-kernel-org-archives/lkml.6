Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085A6C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF65208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s6fcQhwV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF65208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbeH0Tyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 15:54:41 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42181 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbeH0Tyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 15:54:41 -0400
Received: by mail-lj1-f194.google.com with SMTP id f1-v6so12820073ljc.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 09:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ditRqlRrj18LC77XfO6ow3uOwxGoZIS5tDinhHKEV+I=;
        b=s6fcQhwVG3+XwHGQX5TiBC8jX8titB08pPHqFr3xRxeAgIIEKgrSlf7ZLL81dmMJeN
         TSa4mlvxtNOMWYbTB2sdB3NTdhYk7v0ikgm2UmjLDYgwnZlLSWYw9k/4g73QIhZ/6nOh
         2+ALMyMAsejrV5BcIG5SWgrLn0ophc4Pj75GGu4bXXdk5kWZ0hwnHCJOcisRmABU/RI/
         q817jw1whBOxGK+k7V1tWaxdARBWRwUzZKwzZ91RpOvotZgua1xZjFMNnKKYbMOdOATu
         Pr+WkSuENdQvH+PoXTgK1F4c6g8Ty/eNe7VVgUnvlfWQq/cdnS1Fpw2w0myoRjofkrc6
         Fe0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ditRqlRrj18LC77XfO6ow3uOwxGoZIS5tDinhHKEV+I=;
        b=JbjecEE1fedaq/fmfmQcgN5+H9itw1K08gmDOtGPX8PAP3JKeJYWAvLTY6DawoOmEi
         28JtB9BvfW7f2JpGjZiJfjsXPD6VdFE+wRlusLtNFuCh0ZAOOIKFUTtGTcI1V02RrhWL
         MxTfPBp1hiNFbqepDJC4SgmbSQo2cE3s3otXrYHCpDN4lP4CUHJVKOcrLGFUlLarqHaM
         PrY/b52nr/NB4P9godLfEFIf4fEUcvsBuFXVaAwgXWmJMsY5msqGaG3cOFMLKJqT7Op8
         MG3S5jS/rLFgkAjI+L6BYoASDSvs/f0NxhmryB4jo1bDefEwfqafOHs6R2eo5GworFpf
         M87A==
X-Gm-Message-State: APzg51DzXMzTco23o7zuIH2O11jJRw5CmBMKZ7qFv8vyHmjC/M5DGgb7
        03RVB13p0WrOYVuxu4COErjXCzgoLZTGes7GhVA=
X-Google-Smtp-Source: ANB0VdYiXd7rCCN71+BMLn91HzPFsn+ECsy6rRKacKHQIPCZ+sz66wQIT29BeRd7VLsaj6aXx9Q6IpmTmo258/9dlMc=
X-Received: by 2002:a2e:93c4:: with SMTP id p4-v6mr8778038ljh.150.1535386046242;
 Mon, 27 Aug 2018 09:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180821153755.30462-1-jgross@suse.com> <CAKf6xps=OoS_S22KAiRwBdUeJE8b=EruiLJpc95b28+Ku3246w@mail.gmail.com>
In-Reply-To: <CAKf6xps=OoS_S22KAiRwBdUeJE8b=EruiLJpc95b28+Ku3246w@mail.gmail.com>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Mon, 27 Aug 2018 12:07:14 -0400
Message-ID: <CAKf6xpso+LuN2npRvD8qB=b4eX8=uVc+5-ynEC3iNXBZpG0WWA@mail.gmail.com>
Subject: Re: [Xen-devel] [PATCH v2 0/2] x86/xen: avoid 32-bit writes to PTEs
 in PV PAE guests
To:     Juergen Gross <jgross@suse.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>, x86@kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 12:03 PM Jason Andryuk <jandryuk@gmail.com> wrote:
>
> On Tue, Aug 21, 2018 at 11:40 AM Juergen Gross <jgross@suse.com> wrote:
> >
> > While the hypervisor emulates plain writes to PTEs happily, this is
> > much slower than issuing a hypercall for PTE modifcations. And writing
> > a PTE via two 32-bit write instructions (especially when clearing the
> > PTE) will result in an intermediate L1TF vulnerable PTE.
> >
> > Writes to PAE PTEs should always be done with 64-bit writes or via
> > hypercalls.
> >
> > Juergen Gross (2):
> >   x86/xen: don't write ptes directly in 32-bit PV guests
> >   x86/pae: use 64 bit atomic xchg function in native_ptep_get_and_clear
> >
>
> I tested both patches on 4.14, changing patch 2 to atomic64_xchg since
> arch_atomic64_xchg doesn't exist.
>
> I haven't seen https://bugzilla.kernel.org/show_bug.cgi?id=198497
> trigger since incorporating these patch. Without the patches, I would
> have seen it trigger by now.  Also, I've confirmed Xen does not enable
> page table shadowing.  For what it's worth, the PTEs that would
> trigger Xen shadowing (0x8000'0002'0000'0000) are the same as those
> that triggered bug 198497.  There was at least 1 non-Xen user affected
> by 198497, but this at least seems to fix it for me.
>
> Tested-by: Jason Andryuk <jandryuk@gmail.com>

Also, can these patches be Cc: stable@vger.kernel.org?

Thanks,
Jason
