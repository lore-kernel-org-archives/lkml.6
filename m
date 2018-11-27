Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7D4C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BAB208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvGEXVy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65BAB208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbeK0Xcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:32:41 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34501 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbeK0Xck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 18:32:40 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so8308892pfg.1;
        Tue, 27 Nov 2018 04:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y45q130fS/TxDRFjsRk4GQsRQWsmPIxqlM2WlMei9JA=;
        b=qvGEXVy+TmVHiDzQ6vk2+gkFO7+PC7KYLy04bPHCIgsk04EIEq+hVczwQdtICeROzA
         9cd2Sxpwnain8o9Jksg+Mqh8QLPfeqCGNRnyV3VPMP+2Q1WrnDU++csAzusonO6v88LI
         gJgS1gM4lHeRAzin0wfJNeKV2ypFRhjzNYf9ootqK0FR3Tdm+xPan2B8CB+aJ+VVyDfL
         oTs9rSEYqAC0WO6kcPbjoULQJ3nTWi/ataYrDTthBLL3xcs01voiN7akKHzZzVSVxid3
         amWd5lw3h+xL/B++R8lr45zczRycKQk+FX4AKpfs0BU9xxz+BW6Bq5R+EkBWvoy7kL69
         xZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y45q130fS/TxDRFjsRk4GQsRQWsmPIxqlM2WlMei9JA=;
        b=EVnSRXywMAplaR7Wf92BqaYq8ijGiiRPWAl+puJSxjHzbdn27kHKrBWeR+Ndx51hCn
         JXLwO7glwes2IauCc45H5ALA1et6snSuPh0KQhiIBHeZfBHopcJ10tcRsYKGPOuoDdnf
         uffBnHfNrbRjIKmyajCLVrvhmkvJCfmICedyXFzO3ojlnp4uugmw9fUB/iyh2/OXFUhH
         TNMu3CYJbvjdWu1difGNF7ad+21i+oP+aqLXqmrM6Sp4/WlreVz52R9pP8xxW9zvN9aS
         fSE0aIiIwETBlO9MTGUQkSFipyi6YK6qJSuZURvypxQ8rsiBXTpmhWtnR5U2M3RQ3M6c
         /Y8w==
X-Gm-Message-State: AA+aEWZgp/ofoq+yU8NQny0mymNEsUiU2J9lsSGVqsRXVV2MpMgw/wKR
        vprrNWCYXnEj8n2F9ZkSw/7CvaLJyKJpCWWg0vY=
X-Google-Smtp-Source: AFSGD/WUOf5DakCu9tDqJpZdbiE2MnMSBasGV0QI7FaRvcuOE1sg3HAFCXNpaQ6FKxZxF8G6aCI9KoAqgXspnh9ke7c=
X-Received: by 2002:a63:6506:: with SMTP id z6mr28940347pgb.334.1543322093121;
 Tue, 27 Nov 2018 04:34:53 -0800 (PST)
MIME-Version: 1.0
References: <20181108144259.10817-1-Tianyu.Lan@microsoft.com>
 <CAOLK0pyvtfhoGM+D7h=gXwNpNjXGZiDJKpuVi9HOwb++4asCXw@mail.gmail.com> <20181127121129.GR3088@unbuntlaptop>
In-Reply-To: <20181127121129.GR3088@unbuntlaptop>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Tue, 27 Nov 2018 20:34:41 +0800
Message-ID: <CAOLK0pzL6wKbGEH_EPQ9cO8NByx4URO09=XAuYo-vEgaYjtVBQ@mail.gmail.com>
Subject: Re: [PATCH V5 00/10] x86/KVM/Hyper-v: Add HV ept tlb range flush
 hypercall support in KVM
To:     dan.carpenter@oracle.com
Cc:     linux-mips@linux-mips.org, kvm <kvm@vger.kernel.org>,
        Radim Krcmar <rkrcmar@redhat.com>, benh@kernel.crashing.org,
        will.deacon@arm.com, christoffer.dall@arm.com, paulus@ozlabs.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvmarm@lists.cs.columbia.edu,
        sthemmin@microsoft.com, mpe@ellerman.id.au,
        "the arch/x86 maintainers" <x86@kernel.org>, linux@armlinux.org.uk,
        michael.h.kelley@microsoft.com, Ingo Molnar <mingo@redhat.com>,
        catalin.marinas@arm.com, jhogan@kernel.org,
        Tianyu Lan <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
        haiyangz@microsoft.com, kvm-ppc@vger.kernel.org, bp@alien8.de,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        ralf@linux-mips.org, paul.burton@mips.com,
        devel@linuxdriverproject.org, vkuznets@redhat.com,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 8:12 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Tue, Nov 27, 2018 at 07:59:22PM +0800, Tianyu Lan wrote:
> > Gentile Ping...
> >
> > On Thu, Nov 8, 2018 at 10:43 PM <lantianyu1986@gmail.com> wrote:
> > >
> > > From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> > >
> > > Sorry. Some patches was blocked and I try to resend via another account.
>
> The patches were still blocked?  They didn't show up on driver-devel.
>
> regards,
> dan carpenter
>

Hi Dan:
            Thanks for reminder. I double check kvm maillist archive
and this series is available.
https://marc.info/?l=kvm&m=154168821118117&w=2

-- 
Best regards
Tianyu Lan
