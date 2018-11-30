Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E48C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8E82081C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBHA9RvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA8E82081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbeK3Xya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 18:54:30 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45769 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbeK3Xya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 18:54:30 -0500
Received: by mail-wr1-f67.google.com with SMTP id v6so5141821wrr.12;
        Fri, 30 Nov 2018 04:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=6PxXGR5QHSPFscWczZD9AyzzffisG0Ux+8919OGyUhU=;
        b=iBHA9RvPZNwZcIY4wNgY5DnpdcPbcKwSnyOCV+VGEXDAjjSCeLEn5JfjjGI1XO0Uwa
         KE1O/cHmhReVtDAaLJrUrEGPzGz89pYuVnjkyMgcOkiUcSU8AoGLSwKHmXlTOVgWiCmP
         jR0z3V5WM/31VgoU3tO8w7Py8C8bm4EvSuQRA9IbSyGCwCnPOFsTxgBcEYKqAfBwkkrM
         oUGMCsH41ciGo4Hz/EE6RSJ2MlZBMFla9Sq/tnbnbF3PyaH3Nk/jIKnpdsuZn8hlbrox
         kiUBZCmJdAvUBoiBliPQU8pwTr0lemQ3xSIsgz3cAwjzXwiPVQQFQubZfVLXsyqHe3wN
         peXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=6PxXGR5QHSPFscWczZD9AyzzffisG0Ux+8919OGyUhU=;
        b=Wxt1yGzIFaqkIVmJs91jzJDhGKtr6hKAGYvqF1PDvgVa67BQSc2vIfGQ0l21haC0kU
         /MzlGdb+dGXALKLsZYe8l/1y2oT4aOv/yBaZKDlQLFEDtwAmLWbuKTN7Qz1ns9MfQqYp
         2HMGxykSyNsoLHcLi1YWkc1T04cAvz29ai6A68VGSK1DbSIQTT3etIFqf1bf8Xn181Qg
         +BaBL70J2DFGM/VQSioddLtMa5knlMH4sN/HgwGrsq3htAS4aO1B7+g1qzLus2HGlWHI
         r1PmHZLknTtWacqElK5moKkrIGeSC/gKtt6nF9qHhnPdRoMohcAi9EaoBow1zWRnI6l6
         usiA==
X-Gm-Message-State: AA+aEWafOatLJKrg8+PP5vhI9L/KkA/qTN1xoL6/c76TD/kNevb/hXWS
        Yz8asVfBte0ebETo+zadk3k=
X-Google-Smtp-Source: AFSGD/Utw5ebTcGqd7xsa2qWt/cX12F7QkSnhbW3ngARNEo58k3zHOX4YKp4FipSKRTHu38pt6C6jQ==
X-Received: by 2002:adf:9786:: with SMTP id s6mr4775772wrb.283.1543581917477;
        Fri, 30 Nov 2018 04:45:17 -0800 (PST)
Received: from korsan.localdomain ([212.174.243.194])
        by smtp.gmail.com with ESMTPSA id 6-v6sm4246096wmd.45.2018.11.30.04.45.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 04:45:17 -0800 (PST)
Date:   Fri, 30 Nov 2018 15:44:55 +0300
From:   Numan =?UTF-8?B?RGVtaXJkw7bEn2Vu?= <if.gnu.linux@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     jason.low2@hpe.com, Waiman.Long@hpe.com,
        paulmck@linux.vnet.ibm.com, tglx@linutronix.de,
        dmitry.torokhov@gmail.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>,
        "Waiman.Long@hpe.com" <Waiman.Long@hpe.com>,
        "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>
Subject: Re: [regression, bisected] Keyboard not responding after resuming
 from suspend/hibernate
Message-ID: <20181130154455.21578c4d@korsan.localdomain>
In-Reply-To: <20181028220654.7e77e5d7@ubuntu>
References: <20180831215121.1b1f66bf@korsan.localdomain>
        <20181019102031.77015d44@korsan.localdomain>
        <20181025074903.GA9323@amd>
        <20181028220654.7e77e5d7@ubuntu>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/T3r/f7.Qz1nIOR7uPeG1YpL"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/T3r/f7.Qz1nIOR7uPeG1YpL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Sun, 28 Oct 2018 22:06:54 +0300 tarihinde
Numan Demird=C3=B6=C4=9Fen <if.gnu.linux@gmail.com> yazd=C4=B1:

>Thu, 25 Oct 2018 09:49:03 +0200 tarihinde
>Pavel Machek <pavel@ucw.cz> yazd=C4=B1:
>
>> Hi!
>>=20
>> Here's problem bisected down to:
>>=20
>> commit 9d659ae14b545c4296e812c70493bfdc999b5c1c
>> Author: Peter Zijlstra <peterz@infradead.org>
>> Date:   Tue Aug 23 14:40:16 2016 +0200
>>=20
>>     locking/mutex: Add lock handoff to avoid starvation
>>=20
>>     Implement lock handoff to avoid lock starvation.
>>=20
>> Numan, I assume revert of that patch on the 4.18 kernel still makes
>> it work?
>>  =20
>
>Unfortunately, I could not revert
>9d659ae14b545c4296e812c70493bfdc999b5c1c on kernels from 4.18.16 to
>4.10-rc1 because there were too much conflicts, which I could not solve
>as an "average Joe". I tried a3ea3d9b865c2a8f7fe455c7fa26db4b6fd066e3
>which is parent of 9d659ae14b545c4296e812c70493bfdc999b5c1c and
>succeeded to compile kernel.
>
>git checkout a3ea3d9b865c2a8f7fe455c7fa26db4b6fd066e3
>
>Then, I compiled kernel and rebooted with it. I tried a couples of
>times suspending and resuming, all of the time keyboard worked as
>expected.
>

With this one line patch from Takashi Iwai, keyboard is working as
expected after resuming from suspend/hibernate.

--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -59,7 +59,7 @@ EXPORT_SYMBOL(__mutex_init);
  * Bit2 indicates handoff has been done and we're waiting for pickup.
  */
 #define MUTEX_FLAG_WAITERS	0x01
-#define MUTEX_FLAG_HANDOFF	0x02
+#define MUTEX_FLAG_HANDOFF	0x00
 #define MUTEX_FLAG_PICKUP	0x04
=20
 #define MUTEX_FLAGS		0x07


Thanks in advance and regards,
--=20
Numan Demird=C3=B6=C4=9Fen

--Sig_/T3r/f7.Qz1nIOR7uPeG1YpL
Content-Type: application/pgp-signature
Content-Description: Dijital OpenPGP imzası

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEKU9fayrDgTGfA1OV4Dh9jqVujDIFAlwBMMcACgkQ4Dh9jqVu
jDKDjAf8D7qxf+fdnacPE31M4QXEPbTRTXip8nTO6iblMI11/8VtOSxsjn1ZKfVX
Pqb887mRmmiHk7ywg2qQYjmO03O2sa/u4/yUljRgVuZaANkhTCrZeZ4yzOfK74BT
RPA7m3KaHdAONby/08HofPaOS3VoUQgKruB/kioGTnW404G5KpZjy1/mEj4NNZAw
QqppjbIeOXmkiQ0C6nPS/KPSVEphhYbcBStmT4gOAIUXQyn6iaXxD4THb6yl2hwp
P+MV+UCA7QR+Xp55R8Mxe35GPb1sfM8oV19401wOUn/gwvA5n9GlCFl8MVuet8YN
g6p6ouahNo+DWONnqJ/yiKY0syEYBw==
=oD5S
-----END PGP SIGNATURE-----

--Sig_/T3r/f7.Qz1nIOR7uPeG1YpL--
