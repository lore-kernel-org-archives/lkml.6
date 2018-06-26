Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35988C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B4022438
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="zEmGgM3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B4022438
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752897AbeFZV6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 17:58:15 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:47063 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752113AbeFZV6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 17:58:12 -0400
Received: by mail-pl0-f65.google.com with SMTP id 30-v6so9170874pld.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 14:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qznug5JFcOhQCnZSWddHf8n96lgsu+uYCNiLX7Wf31Y=;
        b=zEmGgM3Wc6E7/K/P6G/sN7rxwzvvr28FVIWUbkidfTsPKMTkwBv/nTX7kaKeL+y5cQ
         /2zVc9yHTYS68Mt05bHG6gjv25nAyQxD1/qIXrez8/E5CjJ8h5wVA0YpGjhIwB8VICDc
         isDhoAqyJCYwzjadmnCS1rg1ocO5d9NO/kg6GQHhSJ4znoBSsI87PXcmtMvJK41PEOHy
         Yv5GqFafeM+dNhJMyWNwkaOZagZWh09uPjTVswdAeIRObdeFtiFG6rPpVOnnwP11pyMe
         dsicp4Wqh8Wrsljix8r7WPd/gKL0SNyTr+eBZZpoop3iprY0AZi82K8f5s/BfLgzSfh3
         fEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qznug5JFcOhQCnZSWddHf8n96lgsu+uYCNiLX7Wf31Y=;
        b=e6SVEU1F3TqEdTXaHsm4GKqnUY0QUKk89+v1ZLLySQ/cVAGBsLCUsdG+IU402TfsE4
         /c74U5x699KVhfcHiZUKYCtMSD8S69W8Px3yIrE4aHvC4YlEkW1FCnp8XSGyXuR3wN/g
         B0zragb/qWpn3QYHu5FrU+2reboZk0FDD2bwhK19SrZcofXktztFmaWgBfGpbRCeE65l
         V+zqbvHq4qx5km7vmV1omQfh0Xws//hH39kBBQRAWUOjyK49TzFhWoUO24vsRx4i02To
         D5bOyoWxyx1ba+z9YgTnRBpxUNrciVzf5pk5EQm/1j603lsdk99kNQwic4wa2mUOHK+S
         dCog==
X-Gm-Message-State: APt69E1VAVyqu8y81CgpdXuc0EMwYox9YuK27bfnzqITo7f4z/K3Dwho
        MkR+mXoX/m9ugfwsw7G5Vfiu5A==
X-Google-Smtp-Source: ADUXVKJnW34ABTcYiYWwTWWcjEDL1Yj9+JUz/a8WEOJbONxwuM3DBiDg7Hvk5PxW21CH84paajWyGw==
X-Received: by 2002:a17:902:8210:: with SMTP id x16-v6mr3275759pln.307.1530050291528;
        Tue, 26 Jun 2018 14:58:11 -0700 (PDT)
Received: from ?IPv6:2600:1010:b01b:ac5e:f0d2:dd3c:5dff:6377? ([2600:1010:b01b:ac5e:f0d2:dd3c:5dff:6377])
        by smtp.gmail.com with ESMTPSA id w1-v6sm1156579pgo.72.2018.06.26.14.58.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 14:58:10 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH for 4.18 2/2] rseq: compat: clear high bits of rseq_cs fields
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <20180626211617.8933-2-mathieu.desnoyers@efficios.com>
Date:   Tue, 26 Jun 2018 14:58:08 -0700
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Joel Fernandes <joelaf@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Watson <davejwatson@fb.com>,
        Will Deacon <will.deacon@arm.com>,
        Andi Kleen <andi@firstfloor.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Chris Lameter <cl@linux.com>,
        Russell King <linux@arm.linux.org.uk>,
        Andrew Hunter <ahh@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Paul Turner <pjt@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Maurer <bmaurer@fb.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D9B93DE9-F61C-4488-B109-432C2DFDCEC2@amacapital.net>
References: <20180626211617.8933-1-mathieu.desnoyers@efficios.com> <20180626211617.8933-2-mathieu.desnoyers@efficios.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 26, 2018, at 2:16 PM, Mathieu Desnoyers <mathieu.desnoyers@efficios=
.com> wrote:
>=20
> Make the behavior rseq on compat tasks more robust by ensuring that
> kernel/rseq.c:rseq_get_rseq_cs() clears the high bits of
> rseq_cs->abort_ip, rseq_cs->start_ip and rseq_cs->post_commit_offset
> when a 32-bit binary is run on a 64-bit kernel.
>=20
> The intent here is that if user-space has garbage rather than zeroes
> in its struct rseq_cs fields padding, the behavior will be the same
> whether the binary is run on 32-bit or 64-bit kernels.
>=20
> Use in_compat_syscall() when rseq_get_rseq_cs() is invoked from
> system call context, and use is_compat_frame() when invoked from
> signal delivery.
>=20

And when it=E2=80=99s invoked due to preemption unrelated to a syscall or si=
gnal, you malfunction?

I think the only sane solution is to make these fields be u64, delete the LI=
NUX_FIELD_ macros, and possibly teach the x86 slowpath return to inject a si=
gnal if it=E2=80=99s trying to return to a 32-bit context with garbage in th=
e high bits of regs->ip so that we determistically fail if the user screws u=
p.

Rseq is brand new. It should not need compat code at all.=
