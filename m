Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F717C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED1320821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbrVd9/r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED1320821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbeKABDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:03:11 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39157 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729440AbeKABDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:03:10 -0400
Received: by mail-it1-f195.google.com with SMTP id m15so18998648itl.4;
        Wed, 31 Oct 2018 09:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6/5Fvol5/w5tCddIGIMKsLSJ+D+Oc0lQRTz0vXRM994=;
        b=QbrVd9/rRXbHu6HEOpEcPR7i8M9AvUKajJ/fyep1IMi5wdQSRDogbaqiEcdM/jzwxP
         98M5XH3TNnNw/0IZXf+rRe80+J7n00tMHUx5qPiYFe3jQz5SPdJ7vV8c/MoXNIR52r9Z
         Fg6sUgc+R7yRzEn8IwKxAXPrHmuB+Iw+l16zGnUCrEkqZ0RkMQKK+LgpaNcfxf6yv041
         4q3KLbuA179jLbU5787kT7hpAZnf7WDxS9z9k/Q5Y25tHZbBUrQqCVRwXro2jHxHcHTh
         qY2V/VyiO7GPIYkBMo+dYpB075up2zVQCtwvbga/ZGIcKhq1RsjrMITzDZd7ZxjzQKYj
         zicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6/5Fvol5/w5tCddIGIMKsLSJ+D+Oc0lQRTz0vXRM994=;
        b=AH5VGHz64wSEnJ+nLg+fH63aTI9ehbinKBrL8xytseK2fh9M6v0QB1Fn1fUDNysyfx
         s4nGf7vUt2FudQigsjvpYE07hjllBO1+YK0/mte5Ddj06pFmKM17QxaCMhnJvnXMQhqe
         p6Ehhkis0nOPQ3fD5WDFcoh/0603s8D5VFcEDh78HU9UPwetAezNJsJbNFhok0iWRwOt
         osFkse5fSyJDYVVEPaeuiOfLGRvDKJ2eA+TxTCetC9LMIihPchnpQXtOD/5aRD1dCwgt
         QKgyv9a4dIodLtTRa/O/uUJemulG4F45CB/ybERuuyoI3Px1iGj6ixzQKk1NSMCAQliS
         jAEw==
X-Gm-Message-State: AGRZ1gKzNzGapvAE0LQZTBLHxFBlnW2NxgpJWcwpZlyT22AE2u34fkR1
        aUwqAp7RIJv/wObzqHHTBaUI7jSiTzzkaJoz64I=
X-Google-Smtp-Source: AJdET5fO+G/HwsD0kwvDZbfhvKZM+7ClWBVMCtYIANkNSporbZK6LsQd6ryYBoMNxHJ7urSOdmuGhgs9QYwF9U/H4rY=
X-Received: by 2002:a05:660c:190:: with SMTP id v16mr2508486itj.92.1541001872522;
 Wed, 31 Oct 2018 09:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <20181026151223.16810-1-ahmedsoliman0x666@gmail.com>
 <20181026151223.16810-2-ahmedsoliman0x666@gmail.com> <20181029164229.GA27144@linux.intel.com>
In-Reply-To: <20181029164229.GA27144@linux.intel.com>
From:   Ahmed Soliman <ahmedsoliman0x666@gmail.com>
Date:   Wed, 31 Oct 2018 18:02:59 +0200
Message-ID: <CAAGnT3bJUSEnoZotJsMx1ZEMzKF94Fnx8jo=zx4q+uA7mjfLQg@mail.gmail.com>
Subject: Re: gRe: [PATCH V5 1/5] KVM: X86: Memory ROE documentation
To:     sean.j.christopherson@intel.com
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        nathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?6rmA7J246rK4?= <ovich00@gmail.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        nigel.edwards@hpe.com, Boris Lukashev <blukashev@sempervictus.com>,
        Hossam Hassan <7ossam9063@gmail.com>,
        Ahmed Lotfy <A7med.lotfey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2018 at 18:42, Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Fri, Oct 26, 2018 at 05:12:19PM +0200, Ahmed Abd El Mawgood wrote:
> > Following up with my previous threads on KVM assisted Anti rootkit
> > protections.
>
> All of the changelogs in this series need to be rewritten to adhere to
> Documentation/process[1].  In particular, use imperative mood and
> describe why/what is being done in a self-contained manner, e.g. the
> above line isn't very helpful without a lot of prior context.
>
> [1] https://github.com/torvalds/linux/blob/master/Documentation/process/submitting-patches.rst#2-describe-your-changes
>
> > The current version doesn't address the attacks involving pages
> > remapping. It is still design in progress, nevertheless, it will be in
> > my later patch sets.
>
> This series should be tagged RFC if its design is a WIP.
Ops my bad, the current description is obsolete and I forgot to remove
it. I will have this fixed as well as your other comments in the next
patch series.
