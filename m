Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD7FC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4C520818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="i2hxafI4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C4C520818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbeKJCQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:16:54 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38164 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbeKJCQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:16:54 -0500
Received: by mail-wm1-f65.google.com with SMTP id f2-v6so2490735wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 08:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hkyIsFd91VSAQCq2Qrt+qKgWNgQr776gPlob0ErCOKQ=;
        b=i2hxafI4qaQ0DcZK6vM/0OGBBDs7vOprSVJ9w5XgrjlSwLF5PHblOOaPPVFONsLhTA
         2s8wXmDpDT6RVPOnVn0Zploh30EPKXEh2RqAPyygKh1ApyElfX/N8bLtgjNm+N/UFr3d
         KqjB7UGeHAZmQbwsgYzS3WmY/wyWMZ0tVlhH5lHPsUP1CR/hl2IViouk7ujToNxlM2Ve
         i6aEi/LTfFgQcA/z/lnTY4Xz8pDL5vVK8MDn3cx43PAskTc04+kPGNleRtRFWoSCJ0IN
         cQOm6ycbFoTxVUO9o6hsARO2MoNLFsM4hWZY9LeaFn5YKk8eDmVPBpaPNi1X4SPPo0hS
         /PWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hkyIsFd91VSAQCq2Qrt+qKgWNgQr776gPlob0ErCOKQ=;
        b=Efmnklwltczb7/7UlBmxurAVHa3JxrrCmSjsW9NgRTqc1LPHPj7UGjFl75siGxdgbr
         cKw/gIi+TdyaoPZbonUUEJnjELnOUu72wLHjreW3mCa3U/0YdOk0uboigFeXwWFNGIa6
         tVuXITStGE750sNkTowBXbmFsQ2BXKyzCvsENKcDat2sCht6VvTWCjqJ1OgUS0kKTAiq
         lDj4UxWMiddBEruCdccfK5bwa9Se6Nl2IalJV+dY07snuKNRHuS23veEkIyQt2CA6R5G
         v0L7ej/Aa6hGtS0rQpR9OgtI5ArxahcvyZk+df8JYqLftwhJTn/2skHbk3b4ijWGgHOT
         NFXA==
X-Gm-Message-State: AGRZ1gIf/K1wegm2aiCnsP10cgUxfmL1OYdLTNkbcUUBD9ZYoIZg822O
        f/eNrhYSro+WTYu27YgDqu1y/j516YrbJAFbU76Alw==
X-Google-Smtp-Source: AJdET5cnsAChCkv3SDpt/U50s+OzJUzTOdvzjPb3pjvlhzFBSxt7Wzk05xAhCM80f48o5t8UffxWaMIjXBmMZhU2SOA=
X-Received: by 2002:a1c:954b:: with SMTP id x72-v6mr83686wmd.14.1541781333704;
 Fri, 09 Nov 2018 08:35:33 -0800 (PST)
MIME-Version: 1.0
References: <20181109031605.GF21511@altlinux.org> <e729da9ed78b6b62463a27d3012ac63c7b66be08.camel@synopsys.com>
 <CALCETrUzfOcLYDUW6s1Ra2xduDCQSbscKBw=vApCP2HNmfDmMw@mail.gmail.com>
 <456a69c6e01a6ab5b1af6d459a249388f8b4c1f5.camel@synopsys.com>
 <C6CF3942-3307-431F-B76C-B550BB48F472@amacapital.net> <215d66fd9a197b631973c9ff75943b4c1216b899.camel@synopsys.com>
In-Reply-To: <215d66fd9a197b631973c9ff75943b4c1216b899.camel@synopsys.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 9 Nov 2018 08:35:21 -0800
Message-ID: <CALCETrXCcBBTzcL_yz3agNhby1huZSn2UGtJ9Soo=8n8_rj1Tg@mail.gmail.com>
Subject: Re: [PATCH 06/13] arc: define syscall_get_arch()
To:     Alexey Brodkin <alexey.brodkin@synopsys.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-audit@redhat.com,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Eric Paris <eparis@redhat.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Elvira Khabirova <lineprinter@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 8:11 AM Alexey Brodkin
<alexey.brodkin@synopsys.com> wrote:
>
> Hi Andy,
>
> On Fri, 2018-11-09 at 07:56 -0800, Andy Lutomirski wrote:
> > > On Nov 9, 2018, at 7:27 AM, Alexey Brodkin <alexey.brodkin@synopsys.com> wrote:
> > >
> > > Hi Andy,
> > >
> > > > On Fri, 2018-11-09 at 07:17 -0800, Andy Lutomirski wrote:
> > > > On Fri, Nov 9, 2018 at 6:22 AM Alexey Brodkin
> > > > <alexey.brodkin@synopsys.com> wrote:
> > > > > Hi Dmitry,
> > > > >
> > > > > > On Fri, 2018-11-09 at 06:16 +0300, Dmitry V. Levin wrote:
> > > > > > syscall_get_arch() is required to be implemented on all architectures
> > > > > > that use tracehook_report_syscall_entry() in order to extend
> > > > > > the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.
> > > > > >
> > > > > > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > > > > > ---
> > > > > > arch/arc/include/asm/syscall.h | 6 ++++++
> > > > > > include/uapi/linux/audit.h     | 1 +
> > > > > > 2 files changed, 7 insertions(+)
> > > > >
> > > > > [snip]
> > > > >
> > > > > > diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> > > > > > index 818ae690ab79..a7149ceb5b98 100644
> > > > > > --- a/include/uapi/linux/audit.h
> > > > > > +++ b/include/uapi/linux/audit.h
> > > > > > @@ -375,6 +375,7 @@ enum {
> > > > > >
> > > > > > #define AUDIT_ARCH_AARCH64   (EM_AARCH64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
> > > > > > #define AUDIT_ARCH_ALPHA     (EM_ALPHA|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
> > > > > > +#define AUDIT_ARCH_ARC               (EM_ARC)
> > > > >
> > > > > Similarly here we need to have:
> > > > > ---------------------------->8-----------------------------
> > > > > +#define AUDIT_ARCH_ARC         (EM_ARC|EM_ARCV2)
> > > > > ---------------------------->8-----------------------------
> > > > >
> > > >
> > > > Huh?  How does the bitwise or of two ELF machine codes make any sense?
> > >
> > > Oops... I didn't read examples of AUDIT_ARCH_ALPHA above :(
> > > Indeed that was stupid.
> > >
> > > But what would be a proper fix then?
> > >
> > > Something like that?
> > > ---------------------------->8-----------------------------
> > > #define AUDIT_ARCH_ARC               (EM_ARC)
> > > #define AUDIT_ARCH_ARCV2             (EM_ARCV2)
> > >
> > >
> > > static inline int syscall_get_arch(void)
> > > {
> > > #ifdef __ARC700__
> > >       return AUDIT_ARCH_ARC;
> > > #else
> > >       return AUDIT_ARCH_ARCV2;
> > > #endif
> > > }
> > > ---------------------------->8-----------------------------
> > >
> >
> > Maybe, but I know basically nothing about ARC.  Is the syscall numbering or calling convention different on ARC vs ARCv2?
>
> Syscall numbering should be the same as we use UAPI for both ARCompact (AKA ARCv1)
> and ARCv2. As for calling convention I think it indeed differs.
>
> Note ARCompact and ARCv2 ISAs are binary incompatible!
>
> Even though assembly look pretty much the same (sans instructions
> available only for either ARCompact or ARCv2) encodings are different so
> in that sense these are completely different architectures.
>
> Also I'm wondering what could be other cases for use of syscall_get_arch().

The intent of syscall_get_arch() is that the tuple:

(arch, nr, arg1, ..., arg6)

fully identifies a system call and its arguments.  So it sounds like
we do indeed need to arch values.

>
> So I'd say it's better to report different values for ARC ISAs.
> And given we use the same values as in Binutils IMHO it would be good
> to not mix IDs here.
>
> -Alexey



-- 
Andy Lutomirski
AMA Capital Management, LLC
