Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B067FC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663C3213A2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="GUKqwg38"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 663C3213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbeJLVP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 17:15:28 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45440 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbeJLVP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 17:15:27 -0400
Received: by mail-ed1-f66.google.com with SMTP id v18-v6so11506824edq.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 06:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id;
        bh=9kl+AFhdfAuyYLrIxjH1tHnSVPLXqMk9wXDpKHphUiw=;
        b=GUKqwg38yWeBSUKo4vOp+XTPjirRVvA0NvpjqsNjLskgUI/n0EHcmsG6C6BPeHqhUj
         vsuSdAwIQuBg0mbuw/t0QPyzmSAvOEidNtW5wDLQ8/ipDa8h6U9gqS1tcVNFg6UsU1ez
         bSSLoCLVIXTKhc3p0pnFDxqRBNW42ppbc1UA2d0vD4lCi+JAaW25XkbG8SBvq6GD2ZHX
         W/6+OQ2S9esc3h6nxdL619sxOGg0Jfs4YBGS1JOviMuDR1DFqefBHQeDjxVaN2tEMCKz
         EK6sxoGJIjbd76Rr6WFS6IshgATTLacLEog6emY83kIZn2eFUehzkpEhHqJMMlu2UZI1
         Myfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9kl+AFhdfAuyYLrIxjH1tHnSVPLXqMk9wXDpKHphUiw=;
        b=haCroGCFj+NYOcJUJcmd3150bxMja4wt3ia1VG4SVsiEvZNnBvar193nHvp4nXeR9Q
         9XVLaEvQ34SyjkCjsUPcLQFdeKHEfsHEI2Elo4mC1DlYGWghMYO8J3dULRZ+A5QmNncp
         THQr3ZUNUhon7htKj6s5NvZYUxmkT9ODodHOIf9TUKp1Jg9KSP782cjkkqJT/Yap9pBl
         ahrztERx8vRYH7otGoRNw+a/m+GdSCop8CO4OB886VBLfb+nWBDcyJTF0FFiRxhTWn84
         UW4Cp4lU6o9yfLGJztVHb2gtUmu6AOcbpImeZa8CX7+tdm8ao1038Zqeu2bVBzucnijb
         eGQQ==
X-Gm-Message-State: ABuFfoidd6IDZ1e5hlu8if90Shtre33S+wEoZFx/sxQJyon+0cfxcfVs
        j+1dc8Zcu+RGKy9XkrqT1QRiNMKx/vU=
X-Google-Smtp-Source: ACcGV63iIyQoOyt/YpQ4LhjCIv7bgdXSTZbkqb7cNJtL5/FfjsGaGJ2BVzIy2RqGn28PY+245T0SFg==
X-Received: by 2002:a50:8881:: with SMTP id d1-v6mr8746464edd.156.1539351775147;
        Fri, 12 Oct 2018 06:42:55 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k42-v6sm577292ede.94.2018.10.12.06.42.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 06:42:54 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirsky <luto@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-efi@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC-resend 0/2] compat: in_compat_syscall() differs on x86
Date:   Fri, 12 Oct 2018 14:42:51 +0100
Message-Id: <20181012134253.23266-1-dima@arista.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading xfrm (ipsec) code I've found such code:

: #ifdef CONFIG_COMPAT
:         if (in_compat_syscall())
:                 return -EOPNOTSUPP;
: #endif

While I can read that it's false on native i386, it's a bit misleading
and in result it's better to introduce a helper for that.
Grepping other code, I've found that there are already such helpers.
And the uniq behavior of in_compat_syscall() on x86 is disturbing.

Adjusting it to generic with the following..

(on the first non-resend RFC I managed to forget Cc'ing Andy..
 sorry about that, was sure I did add him).

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andy Lutomirsky <luto@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Cc: linux-efi@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: Dmitry Safonov <0x7f454c46@gmail.com>

Dmitry Safonov (2):
  x86/compat: Adjust in_compat_syscall() to generic code under !COMPAT
  compat: Cleanup in_compat_syscall() callers

 arch/x86/include/asm/compat.h  |  9 ++++++++-
 arch/x86/include/asm/ftrace.h  |  4 +---
 arch/x86/kernel/process_64.c   |  4 ++--
 arch/x86/kernel/sys_x86_64.c   | 11 ++++++-----
 arch/x86/mm/hugetlbpage.c      |  4 ++--
 arch/x86/mm/mmap.c             |  2 +-
 drivers/firmware/efi/efivars.c | 16 ++++------------
 include/linux/compat.h         |  4 ++--
 kernel/time/time.c             |  2 +-
 net/xfrm/xfrm_state.c          |  2 --
 net/xfrm/xfrm_user.c           |  2 --
 11 files changed, 27 insertions(+), 33 deletions(-)

-- 
2.13.6

