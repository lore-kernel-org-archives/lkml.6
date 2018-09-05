Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5165CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42DFC2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="rCgt5CGE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42DFC2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbeIETR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:17:59 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:30195 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbeIETR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1536158846;
        s=strato-dkim-0002; d=aepfle.de;
        h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=FTv0CyngqFs6Z+czb9UeIYUqDRo38KSm3DteWX8Kh5M=;
        b=rCgt5CGERmJI7udzJrNdyeTPg/ZX1Mi0A+werfHGILxWQR/BdxJ8ZpxAtHbmYn+I+d
        KbFmhl3Jhkicf10uVPYst0zMAMq/Ole3zEb7wlj4mq4ri1rK8XMLGtdrKuWhMyD/5GdD
        3cVNVo5F2lWZeKS7mnf8j28RmrGP93dVkdCiYV7rL17NwaML+UrGSuSlT1KpbPF/ed+7
        0oYRXKrYyFoD6MoLXAN2n5I+4SCAaOi1f72gU0jP23iyWIEKwlCUVp3AbL/VAML3HVZr
        2FF8Wjlph9R7yTKEilavB4ElodSYo4UQbOVYaTycV+z6gYL7BQQUZD3lY7y02dV7NICk
        qA/A==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4oc0Nr2ihluivsAQtyRsdRVZ54BGpAypu4eYvjwzPAqxRcXNDW+"
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 44.0 AUTH)
        with ESMTPSA id L0862bu85ElP6FA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 5 Sep 2018 16:47:25 +0200 (CEST)
Date:   Wed, 5 Sep 2018 16:47:19 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] xen: avoid crash in disable_hotplug_cpu
Message-ID: <20180905164719.52e02256.olaf@aepfle.de>
In-Reply-To: <7630aac8-8588-6e42-0807-f98b66ce37b5@suse.com>
References: <20180905104039.13512-1-olaf@aepfle.de>
        <7630aac8-8588-6e42-0807-f98b66ce37b5@suse.com>
X-Mailer: Claws Mail 3.16.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/LzNz=jnL/Kgv5MAft0yD6Bu"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LzNz=jnL/Kgv5MAft0yD6Bu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Wed, 5 Sep 2018 12:55:58 +0200
schrieb Juergen Gross <jgross@suse.com>:

> Instead of trying to fight the symptoms, I think avoiding to offline
> the last cpu would make more sense.

Well, apparently the fix is to leave cpu#0 online because of a backtrace li=
ke that:

WARNING: CPU: 0 PID: 83 at kernel/sched/cpudeadline.c:159 cpudl_clear+0xa5/=
0xb0
Workqueue: events cpuset_hotplug_workfn
RIP: e030:cpudl_clear+0xa5/0xb0
Code: 8b 43 48 c7 44 28 0c ff ff ff ff e8 d5 fd ff ff 48 8d 43 08 f0 4c 0f =
ab 20 4c 89 ee 48 89 df 5b 5d 41 5c 41 5d e9 0b 3b 79 00 <0f> 0b e9 76 ff f=
f ff 0f 1f 40 00 66 66 66 66 90 41 56 49 89 d6 41
RSP: e02b:ffffc900411cbc40 EFLAGS: 00010086
RAX: ffffffff810d09a0 RBX: ffff880106f1a100 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff880106f1a100
RBP: 0000000000000000 R08: 0000000000000000 R09: ffff8801068989b0
R10: ffff8801068989d0 R11: 0000000000000008 R12: 0000000000000000
R13: ffff8801f3800200 R14: 0000000000000001 R15: ffff8801f3823240
FS:  00007fd40d7f08c0(0000) GS:ffff8801f3800000(0000) knlGS:0000000000000000
CS:  e033 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055eff60fe098 CR3: 00000001edf24000 CR4: 0000000000002660
Call Trace:
 rq_offline_dl+0x36/0x80
 set_rq_offline+0x31/0x60
 rq_attach_root+0x98/0xc0
 cpu_attach_domain+0x107/0x320
 partition_sched_domains+0x117/0x347
 ? cpus_read_lock+0x2d/0x50
 rebuild_sched_domains_locked+0xe4/0x4e0
 ? __switch_to_asm+0x40/0x70
 ? xen_mc_flush+0x102/0x210
 rebuild_sched_domains+0x16/0x30
 cpuset_hotplug_workfn+0x45e/0xef0
 ? _raw_spin_unlock_irq+0x22/0x40
 ? finish_task_switch+0x75/0x250
 process_one_work+0x1fd/0x3e0
 worker_thread+0x2d/0x3d0
 ? rescuer_thread+0x340/0x340
 kthread+0x112/0x130
 ? kthread_create_worker_on_cpu+0x40/0x40
 ret_from_fork+0x3a/0x50

Initially I did not spot it because the kernel was booted with 'quiet'.

Olaf

--Sig_/LzNz=jnL/Kgv5MAft0yD6Bu
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCW4/seAAKCRBdQqD6ppg2
firCAKCurqB2wJM0WzkYjLbfuoLzrMzuCwCgxQbHlvePNXf47mnN3+/vAXBwqwc=
=cZSD
-----END PGP SIGNATURE-----

--Sig_/LzNz=jnL/Kgv5MAft0yD6Bu--
