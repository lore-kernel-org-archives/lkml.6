Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58DDC476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6499E20878
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DPeYbYR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6499E20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732317AbeGLQBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:01:06 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51046 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbeGLQBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:01:06 -0400
Received: by mail-it0-f65.google.com with SMTP id w16-v6so7499853ita.0;
        Thu, 12 Jul 2018 08:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6RLpetGTQSicCgKE8CxZ0yq45gFSCyC5bQOMiL9k5vo=;
        b=DPeYbYR96SLQa4A0ewgGvsC5VtlB+mXZn5RVpHkQ444o/J5PVs2+hRMDDGn3EazL7m
         HVEb+PlHs7O8FMQHSdhGmbdon5He78PtNSaTGL86vAMl15k1H+rIIperWnKnn9SLExS7
         eOE+6p8C9BS8YJJLLzRCqIxKzr2Dlk0EBgCsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6RLpetGTQSicCgKE8CxZ0yq45gFSCyC5bQOMiL9k5vo=;
        b=dcB4d0t5E0bqry+RwCTlI1bkDZ9p0/OuG2/0taelMqxAxCCcfZmk+QSQykfUnmw+Jc
         AN6Ea27x63xwZAvoQkZjg0hzwb/w1zyJGTBvAm5urf6TOqT1kk/eNSUakMiMuvHokN/m
         83UAblLZyiHNPLbhISVcEQbe3w7QzBa8bU5+QJbXHUEQ/2quxilbRoSQarllKh+Zd/Jk
         wj9D7k9uC1ca+P2o5DXeNHO0uIteTi2v4JsUX4Fxmjq5eppgpPBNl5GRNeT7skKYhOoM
         TDxaMz0Y5zzU4ANEj5VVDW5esEsatu0Jx0Az2R4USevwSpM9QXBb1ME/p5Tkm1k87Pv1
         SaWw==
X-Gm-Message-State: AOUpUlGbjWxw5HsLHhFX/OfLz9orzyRhKPv6unpLC+OalnQgDM//ZYhB
        GjjS8mcyKoqMOP6e5yBZUWO9uqSC9yiLtlUO5d8TnQ==
X-Google-Smtp-Source: AAOMgpdl28Zdcgr7dALFY/CWGAXa6/ln8s55ME11M76HI3ZA418EXwC8moJTtqobA6kmik+qYaqqECnvqIoR60vqdlM=
X-Received: by 2002:a02:1bdc:: with SMTP id 89-v6mr2003994jas.72.1531410657333;
 Thu, 12 Jul 2018 08:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
 <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk>
 <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net> <22370.1531293761@warthog.procyon.org.uk>
 <CALCETrU3kbh-ZRHDj7-Asq+OH-35dQ2p_erpHpYUvN5+BdAoVQ@mail.gmail.com> <7002.1531407244@warthog.procyon.org.uk>
In-Reply-To: <7002.1531407244@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Jul 2018 08:50:46 -0700
Message-ID: <CA+55aFx+xm333ZZ7d2Z39QuhDu=0XM6nTMChbHvWQOXNk32yxw@mail.gmail.com>
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for
 superblock creation [ver #9]
To:     David Howells <dhowells@redhat.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 7:54 AM David Howells <dhowells@redhat.com> wrote:
>
> I think we *have* to open the source files/devices with the creds of whoever
> called fsopen() or fspick() - that way you can't upgrade your privs by passing
> your context fd to a suid program.  To enforce this, I think it's simplest for
> fscontext_write() to call override_creds() right after taking the uapi_mutex
> and then call revert_creds() right before dropping the mutex.

No.

Don't play games with override_creds. It's wrong.

You have to use file->f_creds - no games, no garbage.

But "write()" simply is *NOT* a good "command" interface. If you want
to send a command, use an ioctl or a system call.

Because it's not just about credentials. It's not just about fooling a
suid app into writing an error message to a descriptor you wrote. It's
also about things like "splice()", which can write to your target
using a kernel buffer, and thus trick you into doing a command while
we have the context set to kernel addresses.

Are we trying to get away from that issue? Yes. But it's just another
example of why "write()" IS NOT TO BE USED FOR COMMANDS.

Only use write() for data.

That's final. We're not adding yet another clueless fuck-up of an
interface just because people cannot understand this very simple rule:
"write()" is for data, not for commands.

No more excuses.

                 Linus
