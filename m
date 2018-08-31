Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB33C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 02:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15EDE2082C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 02:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U8vbCqx7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15EDE2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbeHaGoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 02:44:22 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36575 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeHaGoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 02:44:22 -0400
Received: by mail-oi0-f65.google.com with SMTP id r69-v6so19185120oie.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 19:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cYDmEEYw+tWM+pjJaVrgu2mCCDmIgLjzvZQ8UQa04XU=;
        b=U8vbCqx7ldbSCyBG1SJ+kbmwxL8kV+J3ajiN7W5WW2cfmC0aoenlyg4XsZXDHeYB6k
         tUzEy6YEksH6lJuouziKvC+xeJ6ZrMvn0ObMYPlbKQ4+dOEFqJGstS+WBCPQOT6pcLaL
         LGIuCl97jmxJPW5qhZXnbHKOK9eN5FB6dk/0elVhcZheHuVwIiUimsWJPWd5AL/ZmnCG
         SdjlU/T3u6lxl/fAbiC+hBg3mtT/jRRFLFtqYzighyTsHKpoWrGkH5IJPAzbUf3/+Eyk
         OSMJM6D7bPl98Y3fwCU6+dV+sUxoS/3jSaBi+bnoqLg7pQqXaXVsGQgrXyA5aKbqyxoH
         cO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cYDmEEYw+tWM+pjJaVrgu2mCCDmIgLjzvZQ8UQa04XU=;
        b=CvHOwDB+u6fD4vlFZZU32eJCbpQ+uKMPGFoSEqICCe+HYwrNThCAjSMxPD2wKW957W
         yA+wfn5gTNaEygnOxmiOY/bdKLlT6OEQXWFPLpNslqDegD03XJgclxCyzindobOmIUfe
         UUkUvqaU4WHFp9P9ysqzEvCUATvF/4ZI8esVhU3igNxi9azqT2RFjdvSHinBBjZGZ0qS
         sSCAQjLMfdjlRk+3N2vcgupgfNj1VwLlORAcg/Z1CGA3FEdXs5xpc4yYJ94iNy19ZAF4
         1gFnsiqgQkjM5wFEbPKGxD/7v12tueSGNEk6xYN9k2MJ7rbo+dZs73n86wrp33oUby7w
         4G2w==
X-Gm-Message-State: APzg51ArOxmgFMuYwjkWGdAggAp+Pmr7TuuvMatKqpDOBSqyuvmyPw6d
        6/YvU7GRnch1zZw+ISXvmLE9/kjJGm4QCCgrK9goUA==
X-Google-Smtp-Source: ANB0VdbFMOy/YZQkTrFIkEOTUNJ3T/6xcm6xqsBU2aDqsyTFtUhBONQfYzmj9i0nsF6oGCdgZouLG1dgcO7Cp1Bu0MQ=
X-Received: by 2002:aca:4784:: with SMTP id u126-v6mr5394889oia.229.1535683151872;
 Thu, 30 Aug 2018 19:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180807172920.8766-1-sean.j.christopherson@intel.com> <b7fe6fad-7ce4-c7c1-31d7-cb609cf45b2f@intel.com>
In-Reply-To: <b7fe6fad-7ce4-c7c1-31d7-cb609cf45b2f@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 31 Aug 2018 04:38:44 +0200
Message-ID: <CAG48ez1iPr0q-PBYnc9Q4GA0uMEyph9THiV2CrN6aRMzqpEfng@mail.gmail.com>
Subject: Re: [PATCH] x86/pkeys: Explicitly treat PK #PF on kernel address as a
 bad area
To:     Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     sean.j.christopherson@intel.com,
        kernel list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Aug 2018 Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 08/07/2018 10:29 AM, Sean Christopherson wrote:
> >       if (unlikely(fault_in_kernel_space(address))) {
> > +             /*
> > +              * We should never encounter a protection keys fault on a
> > +              * kernel address as kernel address are always mapped with
> > +              * _PAGE_USER=0, i.e. PKRU isn't enforced.
> > +              */
> > +             if (WARN_ON_ONCE(error_code & X86_PF_PK))
> > +                     goto bad_kernel_address;
>
> I just realized one more thing: the vsyscall page can bite us here.
> It's at a fault_in_kernel_space() address and we *can* trigger a pkey
> fault on it if we jump to an instruction that reads from a
> pkey-protected area.
>
> We can make a gadget out of unaligned vsyscall instructions that does
> that.  See:
>
> 0xffffffffff600002:  shlb   $0x0,0x0(%rax)
>
> Then, we turn off access to all pkeys, including pkey-0, then jump to
> the unaligned vsyscall instruction, which reads %rax, which is a kernel
> address:

Andy got rid of the (native) vsyscall page in
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=076ca272a14cea558b1092ec85cea08510283f2a
('x86/vsyscall/64: Drop "native" vsyscalls') a few months ago, right?
At this point, the vsyscall page should never be executable.
