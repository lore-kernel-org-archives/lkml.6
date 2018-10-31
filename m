Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E261FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3D12081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="KGLqAFYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3D12081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbeKAERJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:17:09 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39643 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725731AbeKAERJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 00:17:09 -0400
Received: by mail-lf1-f67.google.com with SMTP id n18so4187583lfh.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 12:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RxOx4UxsJG5jgjaXfv1ilaOu021C+CnL1GguyaG3Z1o=;
        b=KGLqAFYUnHUQUzHettpzc4GrhaECEdMZ5CZiw0prPM4muAWosnLCV2NQjSWTp3V39T
         YggBvFms1BB/BetsIKrn0oPbLRyrMPRKhfg07VszQJ/ZRIRYHjvdxXrOQf8x+FH9mNF+
         nRgV50u1gdPR6KjGW5lZYiMXaVv8ct4e/KJHvUpeKYC9rCwsjuSkUKEDwbY8mr5DXcNu
         Rwnl2nukK03aekr79fBZXN3AwVrm9n75IvbOemwcpq5sj+JgXn/gWlpxN5iFse8eDkQr
         yv0kXbyfw77KTGcan344prLu2q440wI80A4moJxvWWhTpBpArqkhvAZqeN/lDvasCnop
         T+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RxOx4UxsJG5jgjaXfv1ilaOu021C+CnL1GguyaG3Z1o=;
        b=aiJ09xIB9LXEC+NamfGWrMjyai5kzb289+Yq5Ec6ai7hXQBsOZm30GvQUTsWFRYmBG
         50v3XSZbs/uPOoA9mCbXcevBCtcCZpW3NEb7PE/8aGgxizgAVNOKcsRjsIi92pYu/IpE
         2oXByGHEP3G6CmPaYs0Lhe3+m7pjPay5AtYPKQGE1z/mBwARt1P89p60x+LaaUonKKjK
         erbSEJTM0z96uFAHvCoVsJHQj2dr7Rgmj85PC2vCNVR3tJQHx3Dnox6JdjvbiGde0ayP
         pF+YIc36yjVy6USA+c6qe9c32wdnF83ZiPQv9vtKhO6qXfUMqMWzA8h468fvskLWv2g/
         NThA==
X-Gm-Message-State: AGRZ1gJ8/Wh7PGPindGMD5D5UQNR9UgN7V0AtNdx60GG/Nnec2AQm0qV
        DzFM3P7VmEXr0TXxwPgll98DksxSMEK9+XP93hbCZw==
X-Google-Smtp-Source: AJdET5dSoe4//31Qm227f2J+EV7MY7SGZDev3MiIl8xvED1E0f3UOxXOZjpMjwY5H/yxgS428SmGkbWLMXRyY5tiIaE=
X-Received: by 2002:a19:4c02:: with SMTP id z2-v6mr2593679lfa.48.1541013464409;
 Wed, 31 Oct 2018 12:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhSdy0Y_jdc=2Lf8epof_+7HigCfhDxMNe8EF0fHfncqhs-zA@mail.gmail.com>
 <mhng-01f0ac6a-c2fd-41be-9d53-44d1c139d453@palmer-si-x1c4>
In-Reply-To: <mhng-01f0ac6a-c2fd-41be-9d53-44d1c139d453@palmer-si-x1c4>
From:   Olof Johansson <olof@lixom.net>
Date:   Wed, 31 Oct 2018 12:17:32 -0700
Message-ID: <CAOesGMjHTRqqUWB9=XQADPxA+EWwcOSBrFsJB7c4m2b9kBAOmQ@mail.gmail.com>
Subject: Re: [RFC 0/2] RISC-V: A proposal to add vendor-specific code
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     anup@brainfault.org, vincentc@andestech.com,
        Albert Ou <aou@eecs.berkeley.edu>, zong@andestech.com,
        Arnd Bergmann <arnd@arndb.de>, alankao@andestech.com,
        greentime@andestech.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, deanbo422@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 10:27 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Wed, 31 Oct 2018 04:16:10 PDT (-0700), anup@brainfault.org wrote:
> > On Wed, Oct 31, 2018 at 4:06 PM Vincent Chen <vincentc@andestech.com> wrote:
> >>
> >>   RISC-V permits each vendor to develop respective extension ISA based
> >> on RISC-V standard ISA. This means that these vendor-specific features
> >> may be compatible to their compiler and CPU. Therefore, each vendor may
> >> be considered a sub-architecture of RISC-V. Currently, vendors do not
> >> have the appropriate examples to add these specific features to the
> >> kernel. In this RFC set, we propose an infrastructure that vendor can
> >> easily hook their specific features into kernel. The first commit is
> >> the main body of this infrastructure. In the second commit, we provide
> >> a solution that allows dma_map_ops() to work without cache coherent
> >> agent support. Cache coherent agent is unsupported for low-end CPUs in
> >> the AndeStar RISC-V series. In order for Linux to run on these CPUs, we
> >> need this solution to overcome the limitation of cache coherent agent
> >> support. Hence, it also can be used as an example for the first commit.
> >>
> >>   I am glad to discuss any ideas, so if you have any idea, please give
> >> me some feedback.
> >>
> >
> > I agree that we need a place for vendor-specific ISA extensions and
> > having vendor-specific directories is also good.
> >
> > What I don't support is the approach of having compile time selection
> > of vendor-specific ISA extension.
> >
> > We should have runtime probing for compatible vendor-specific ISA
> > extension. Also, it should be possible to link multiple vendor-specific
> > SA extensions to same kernel image. This way we can have a single
> > kernel image (along with various vendor-specific ISA extensions) which
> > works on variety of targets/hosts.
> >
> > As an example or runtime probing you can look at how IRQCHIP or
> > CLOCKSOURCE drivers are probed. The vendor-specific ISA extension
> > hooks should called in similar fashion.
>
> Yes, I agree.  My biggest concern here is that we ensure that one kernel can
> boot on implementations from all vendors.  I haven't had a chance to look at
> the patches yet, but it should be possible to:
>
> * Build a kernel that has vendor-specific code from multiple vendors.
> * Detect the implementation an run time and select the correct extra code.
>
> This is essentially the same as my feedback for the performance counter stuff,
> which IIRC is what prompted adding a vendor-specific extensions.
>
> If I was going to do this, I'd split it up such that the vendor-specific
> additions are per-subsystem.  That way we can focus on building a decent
> interface for each subsystem that needs vendor-specific support rather than
> just bundling everything together where the vendor-specific stuff will get all
> tangled together.

For short-term, powerpc's model of a machine descriptor with function
pointers that's either filled in at runtime, or set to the right
pre-defined structure per platform, should cover most of this I think?

Even if you have cases where an indirect branch isn't feasible,
performance-wise, _getting_ the function address from the table and
doing runtime alternatives-style patching still gives one place to
keep it.

I'm not sure if we need a table/struct per subsystem, or if one larger
shared one is sufficient to start. Since this is all in-kernel code
without external interface, I'd suggest starting simple and refactor
later if needed.


-Olof
