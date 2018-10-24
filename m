Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EA5C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751DD20824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="T0jxbwQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751DD20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=globallogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbeJXRZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:25:12 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38997 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727713AbeJXRZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 13:25:11 -0400
Received: by mail-qk1-f196.google.com with SMTP id e4so2650927qkh.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 01:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P5D5+wbYvFpm0tdJgRcE+2WrrJ+FHACmNE2eQnVA+Rs=;
        b=T0jxbwQ/IMtXTPmiRhxrz1dyHOaxB0otLcS6qSCgIoj/ZIb3gqrvQ8n0BBzlqTgQtv
         n2w94rrDc0HbzNRZo3fF9wCbHhKFY/okTC0mLazTecjsg6yeew3DOh6ZQFMB5gT8jiSm
         fbe+ePGG5l0r9wTKn+fKuAJC1lbS5y/F81yJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P5D5+wbYvFpm0tdJgRcE+2WrrJ+FHACmNE2eQnVA+Rs=;
        b=PCnhwG7tEJxVYY/9/rg9kEKiZ8oaKdGKI2a7dH4adye47Psz6pePq9pOJ4NVFZnf/9
         owQmAOQSSdn1sfbGb2v5Y8eJxqz1qLDxfzOsrfU+hH9l2qBZnsfpYRApB4EZLP+yEdqW
         fyWoLPF+nJTqy7LQdo2Ruf1fPimBrjFqE234davFD7eZDeUFMTDy8mrDtaXJH/nJLkBt
         TOCUN/Xba8a626bw8899m9ZouYRnofYeg+usWFzJWCEwnCzMBQWxeGLDc4m1qyz+y3Xu
         ZAW0HEdQ+Hra5naGFVhF0vMdtJ1SyVuSXiKs5uP5LFfzl2kfxDoYxWwB8bNOrpiNEFAg
         6kgQ==
X-Gm-Message-State: AGRZ1gK50sA3S5JLSJ86xpMs94k2vV4CY+QQXDPCwvxLchu1HYelfkLe
        1cmvOQM404QqTyOXsuGOFqnQLE23aFsDIKwpGxa2Hg==
X-Google-Smtp-Source: AJdET5e9VvhF6uwwaf7KJaXHG6ft6oCIpV7twnhvj5/91jdS+1Uk2+5SdTALGVsyBN2FJrWuHdYEDwZOODMoFMEZNEI=
X-Received: by 2002:a37:1b46:: with SMTP id b67mr1512491qkb.144.1540371475912;
 Wed, 24 Oct 2018 01:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <1538067309-5711-1-git-send-email-maksym.kokhan@globallogic.com>
 <20180929181725.GB27441@fifo99.com> <CAMT6-xiQ0vGcKpA+SiWHQWQFwU9Oo9j=Zin+UXDoPqKTz5fbeA@mail.gmail.com>
 <CAMT6-xj1rjVAy1AWFiMHc5wH36eu=TUSMtdKU=-qRtUbwr9bkg@mail.gmail.com> <20181023144815.GP30658@n2100.armlinux.org.uk>
In-Reply-To: <20181023144815.GP30658@n2100.armlinux.org.uk>
From:   Maksym Kokhan <maksym.kokhan@globallogic.com>
Date:   Wed, 24 Oct 2018 11:57:44 +0300
Message-ID: <CAMT6-xhvqy5PeQmkQ8tsLRiML_pNJTxyq7dizRRvZTEqc7uzgg@mail.gmail.com>
Subject: Re: [PATCH 0/8] add generic builtin command line
To:     Russell King <linux@armlinux.org.uk>
Cc:     Daniel Walker <dwalker@fifo99.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Walker <danielwa@cisco.com>,
        Andrii Bordunov <aborduno@cisco.com>,
        Ruslan Bilovol <rbilovol@cisco.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do you mean, that you haven't seen patch for ARM, which I sent on
September 27 along with cover and patch 1? It is strange, because
you was the one from recipients. If so, you can see this patch here:
https://lore.kernel.org/patchwork/patch/992779/
On Tue, Oct 23, 2018 at 5:48 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Tue, Oct 23, 2018 at 05:43:18PM +0300, Maksym Kokhan wrote:
> > We still have no response to patches for x86, arm, arm64 and powerpc.
> > Is current generic command line implementation appropriate for these
> > architectures?
> > Is it possible to merge these patches in the current form (for x86,
> > arm, arm64 and powerpc)?
>
> You may wish to consider your recipients - I seem to only have received
> the cover and patch 1 (which doesn't include any ARM specific bits).
> It may be that you're not getting responses because people haven't seen
> your patches.
>
> Thanks.
>
> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up
