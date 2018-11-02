Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B653C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF5120833
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApJMMtJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF5120833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbeKCAX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:23:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42943 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbeKCAX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:23:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id y15-v6so2342983wru.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 08:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:in-reply-to:references:date:message-id:mime-version;
        bh=UW89sDMLzvs8glIZmGdWNKbQvLEZQHkccE5W8BNzOMw=;
        b=ApJMMtJO081QTriXCVXKt9sms+T3cqESM2EkBSvFf3heJcBdElkj57XzouSR6m39PG
         UntMJ1sCIPmra7NUR+NRLk1K/Pp8jYnsxF+SoxLf/MgRBGq/+dN96BhG1GNp1gytbdwP
         BuJ3yvW6CqyRKXE/+2N2g4kVkXD9zLmvi6/v6GnaOUOmUc1LI3pgidGWI6PiUQ2sliJR
         uvZM8spC3px3LRiALOHTYPo/JkUkf04HJr5eBlpyHQ5xwsoY0XUpn4eMd9lnVRITjFq5
         hlI4zvetoGxIZm0lMm1z9yNDkj3yYPWcrVjmR9eeOyMvs/ckfZavDYcN+3MYYTuZ9cG6
         AEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=UW89sDMLzvs8glIZmGdWNKbQvLEZQHkccE5W8BNzOMw=;
        b=i9QoKIaeUbOGraamyFGgSauv1eV4uw4rJTBbrRtXShlp1b3kbF8ETmxdPz7uvikCgM
         5WzZfbU9FuRXdg2BlExSzaoPJtYt0NvET31s3uoKAK2AficIuChsXG0kctlPcJeJMcJ6
         pInilVNja2qH3/UHy4WoBvH314Q60h51UoCIEA8S45UIfOqiovu9NXMYzpgEVNyyFOMa
         JstA5PH+mTtLCuniphl9MBp7hB6/SEb5vRAAhdOXkUz396YpVMqkLGF5QH1/6ky6vvnY
         jxNnlnBvkbKCLzJuIip4XkLEhH5I3NtKzUg4guD6KSN6UePxUnKurYnN3BJxHoGRcyZQ
         hU3g==
X-Gm-Message-State: AGRZ1gIb6hgLO0pJgNP9GFxHxTpK6DIpLgMnUz9SHM5jD8QzF3Tp8sCP
        gDWBlOAw5FCEL2Ni6N/xZO47UTny
X-Google-Smtp-Source: AJdET5dpLtCEYbnbp+tBcUL0PlGq5Bm395Tf2JDiPWHy/zbKEJW619OcZWNm4FafONww3W8VdKAE5g==
X-Received: by 2002:adf:eb02:: with SMTP id s2-v6mr11258410wrn.201.1541171759917;
        Fri, 02 Nov 2018 08:15:59 -0700 (PDT)
Received: from localhost (p5B3F66DD.dip0.t-ipconnect.de. [91.63.102.221])
        by smtp.gmail.com with ESMTPSA id 195-v6sm34059861wmx.21.2018.11.02.08.15.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 08:15:58 -0700 (PDT)
From:   Holger Schurig <holgerschurig@gmail.com>
To:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Subject: Re: BUG: "do_IRQ: 0.39 No irq handler for vector" from a 16550 port
In-Reply-To: <87k1lvg2z4.fsf@gmail.com>
References: <87k1lvg2z4.fsf@gmail.com>
Date:   Fri, 02 Nov 2018 16:15:58 +0100
Message-ID: <87h8gzfr2p.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I said that kernel 4.9 doesn't show the issue. The same was for later
kernels up to 4.13.

I had a compilation issue with 4.14 (which I later solved, something
unrelated with tools/objcopy when compiling for a different
architecture), so I did a git bisect between v4.13 and v4.15. This is
the outcome:

$ git bisect log
# bad: [d8a5b80568a9cb66810e75b182018e9edb68e8ff] Linux 4.15
# good: [569dbb88e80deb68974ef6fdd6a13edb9d686261] Linux 4.13
git bisect start 'v4.15' 'v4.13'
# good: [425a08c67317acee103b3ad58f57c762e8834faf] mlxsw: spectrum_router: Prepare for large adjacency groups
git bisect good 425a08c67317acee103b3ad58f57c762e8834faf
# bad: [e60e1ee60630cafef5e430c2ae364877e061d980] Merge tag 'drm-for-v4.15' of git://people.freedesktop.org/~airlied/linux
git bisect bad e60e1ee60630cafef5e430c2ae364877e061d980
# bad: [4008e6a9bcee2f3b61bb11951de0fb0ed764cb91] Merge branch 'i2c/for-4.15' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/wsa/linux
git bisect bad 4008e6a9bcee2f3b61bb11951de0fb0ed764cb91
# bad: [3c073991eb417b6f785ddc6afbbdc369eb84aa6a] Merge tag 'devprop-4.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect bad 3c073991eb417b6f785ddc6afbbdc369eb84aa6a
# good: [2101dd64b304b034862f5ca40877c41b7ccb9c5e] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu
git bisect good 2101dd64b304b034862f5ca40877c41b7ccb9c5e
# good: [d6ec9d9a4def52a5094237564eaf6f6979fd7a27] Merge branch 'x86-asm-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good d6ec9d9a4def52a5094237564eaf6f6979fd7a27
# good: [7d58e1c9059eefe0066c5acf2ffa582f6f0180e3] Merge branch 'smp-hotplug-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 7d58e1c9059eefe0066c5acf2ffa582f6f0180e3
# good: [990a848d537e4da966907c8ccec95bc568f2911c] Merge branches 'pm-devfreq' and 'pm-tools'
git bisect good 990a848d537e4da966907c8ccec95bc568f2911c
# bad: [25e960efc63852b84d1c3739aef586285b177395] PCI/MSI: Set MSI_FLAG_MUST_REACTIVATE in core code
git bisect bad 25e960efc63852b84d1c3739aef586285b177395
# skip: [029c6e1c9df776fe1b2ba756a28fb65e9f9e9f69] x86/vector: Store the single CPU targets in apic data
git bisect skip 029c6e1c9df776fe1b2ba756a28fb65e9f9e9f69

- no network
- no USB keyboard
- therefore "git bisect skip"

# bad: [d6ffc6ac83b1f9f12652d89b9cb5bcbfbea7796c] x86/vector: Respect affinity mask in irq descriptor
git bisect bad d6ffc6ac83b1f9f12652d89b9cb5bcbfbea7796c
# good: [ef9e56d894eab99a33a06b96ba8057afa67d3702] x86/ioapic: Remove obsolete post hotplug update
git bisect good ef9e56d894eab99a33a06b96ba8057afa67d3702
# good: [8d1e3dca7de6e8513872799a748a1d47d8dce60d] x86/vector: Add tracepoints for vector management
git bisect good 8d1e3dca7de6e8513872799a748a1d47d8dce60d
# good: [5ba204a1817ba95a7b24dbe8ef2c7ddd4cea886e] iommu/amd: Reevaluate vector configuration on activate()
git bisect good 5ba204a1817ba95a7b24dbe8ef2c7ddd4cea886e
# good: [4900be83602b6be07366d3e69f756c1959f4169a] x86/vector/msi: Switch to global reservation mode
git bisect good 4900be83602b6be07366d3e69f756c1959f4169a
# bad: [2cffad7bad83157f89332872015f4305d2ac09ac] x86/irq: Simplify hotplug vector accounting
git bisect bad 2cffad7bad83157f89332872015f4305d2ac09ac
# bad: [464d12309e1b5829597793db551ae8ecaecf4036] x86/vector: Switch IOAPIC to global reservation mode
git bisect bad 464d12309e1b5829597793db551ae8ecaecf4036
# first bad commit: [464d12309e1b5829597793db551ae8ecaecf4036] x86/vector: Switch IOAPIC to global reservation mode




Greetings,
Holger
