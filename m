Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B699BC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 17:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B2E214D5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 17:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U0IUwNkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B2E214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967519AbeF1RSi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 13:18:38 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:46161 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967499AbeF1RSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 13:18:36 -0400
Received: by mail-oi0-f46.google.com with SMTP id y207-v6so5889289oie.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 10:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CUz0G7il+vN90b6CihMzU/deiZXEMNZKwlRfQpN9ODs=;
        b=U0IUwNkm8Uz4SOlaZIkNrNd+NgJ01LBSagvZVY+c7EDDG3mG7yugOhAHhhuhmuYPk+
         wcIupJjYbWWL+5IC8fvEbf4KFj08BNElUfXILzl0pAYnxoSo4D7i5qgQLQRA4KQKdvbd
         btJ7vXstnd4lzcDBNcHV9yGSK67wPdO3Iir0zSZsh1QETxY6ayx9Xkj6p8t4A7e608TL
         PW3JLouu8VlUkR3E++JPM8JjhrzDsUBmhX4qR7+d34AksLTAuJ0o72UexaGcCwD8iIql
         NG4ZGjpXqeG2JNkH0TUlA0eP817YE3gkE7QYaMjL4ruBkk4b+7R9CLPEDwSPO+vVvWzF
         5shg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CUz0G7il+vN90b6CihMzU/deiZXEMNZKwlRfQpN9ODs=;
        b=gYbfTSJdqKHJ7uTdB8/Zj91sH9vpLs1YtVHivDof9oxQ15cied33mThqi5qSoyi5Mm
         OzrUr8iassWXieOW3G9wQSF9KBM+PMy4+t/KWoP5FMIBqkIu0UE0Pm+/5k0tR2OWi7dZ
         3LE7Xb31czwM2WlNWE+I8HTIaSWzswgYIv76QN2VLU2+uaakWe32yDDkWFzLo90xagPK
         SXRN/hlAOicGYgZ66efVcDGKvMJ5WhLvTjzPL6km77OP0EkgnwYa3bPAjQktZ/UQiqGt
         SxNKUGLQAPydgrTUXt7W4+V3Z80s1AAcQVWi+blJDErjibeG8q0wVdJMX2duyc3AkBOC
         PaBg==
X-Gm-Message-State: APt69E3++iUqYOlb5z6hIUoe44pvpbejc8wSysO2j7OwDhE2o+bXKTzv
        E9FA8Jvy9am5JyEMDJLjDG9fH0MQzVAK+fi1xEdfSAJ81D0=
X-Google-Smtp-Source: AAOMgpfe6cmw1yVknPS9uf69GlTsqtW8lUHFcyoWvUYrJO4Fu58Ml+sycZiShRaefm3pVtBuw7Fuh7VN2nnbnylEXh4=
X-Received: by 2002:aca:ef8b:: with SMTP id n133-v6mr6747980oih.70.1530206315428;
 Thu, 28 Jun 2018 10:18:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:3404:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 10:18:34
 -0700 (PDT)
In-Reply-To: <CACT4Y+bnUNtn3jO5fYMB5dSqA=vbc8KfnTmbajA6SYKex4KFoQ@mail.gmail.com>
References: <883d24f79ad8fd475f0569a39ba6@google.com> <00000000000037b58a0569c49b70@google.com>
 <CACT4Y+bnUNtn3jO5fYMB5dSqA=vbc8KfnTmbajA6SYKex4KFoQ@mail.gmail.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 28 Jun 2018 10:18:34 -0700
Message-ID: <CALMp9eSDP3XRMU-ZvSPRqgyQrtOCajz90HyQ8GM7Mg2oNuBAHw@mail.gmail.com>
Subject: Re: general protection fault in vmx_vcpu_run
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+cc483201a3c6436d3550@syzkaller.appspotmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  22: 0f 01 c3              vmresume
  25: 48 89 4c 24 08        mov    %rcx,0x8(%rsp)
  2a: 59                    pop    %rcx

<rip>:
  2b: 0f 96 81 88 56 00 00 setbe  0x5688(%rcx)
  32: 48 89 81 00 03 00 00 mov    %rax,0x300(%rcx)
  39: 48 89 99 18 03 00 00 mov    %rbx,0x318(%rcx)

%rcx should be pointing to the vcpu_vmx structure, but it's not even
canonical: 1ffff10035842e78.
