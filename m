Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565DAC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 04:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0312720838
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 04:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="PlLhV1Zh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0312720838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeJYNQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 09:16:33 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34654 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbeJYNQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 09:16:33 -0400
Received: by mail-pl1-f195.google.com with SMTP id f10-v6so3289476plr.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 21:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zJDdA/8Fw3EIaDDUKKYTssf0Ryvete4RrtcS9MP64q0=;
        b=PlLhV1Zhj5/SRR2a/Tq/28eFZRtzW8SdHiamBnGhLqjNcepYXK3ygxLHajfhEPbL1q
         3HSvuAq4kLwQnH6R5PGlccDsepkOc6+a3hkpzpVJo9E6BuHAZBZVYfnERsQUQ7LZgJEH
         gV5EyRZhMn0UVCQlIzJcc1XFas7L4Pb3MGQaoY2g7/RNDxVW7wpv0Bm+E0boXjuUT3pv
         5xRjBFM/PQJaGVgxeWGdhkZ2t3E9c6lmZBO3FJ8iD2ncTSVUUXUjwz1IEsU1Ve/2p9eq
         JTL7xvsm55HQt2ScWoLPxCZLZTsTFiHnaB7drWQPBkR3dDntJboT7X4q/JNdzm9M2+bV
         EHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zJDdA/8Fw3EIaDDUKKYTssf0Ryvete4RrtcS9MP64q0=;
        b=oEZE7J7Br69+qBoykZO4Ov8nBQt09g5aYjpVIfw+KIOm7gJW4M+9glv8WVcxEwdsnR
         8bTuW0AuN1ku+DKrkBcsTL/EMB+8U6YuXhOw72wRNN9OPKl9Uh63Mx6oytMME2NXzu67
         im6XmVoDn8UDK2IW9EZERctSkU77aCrHSTlgENgihQnOErws1NZTAzm9Ud5psT9L1wGO
         m82La+nYYSEXK2jZ6RC+5PyjlEQr3aeYNjEaJllenORl4KOJxr/ovtMYQ1u2ZHYHgrJy
         BZejyPCBfLhXPa0/zcTfRKRYoQgxa4nKigAjl2PQIKM0GlKTqGtInVhVFmP1OdhMvbR1
         Ec0Q==
X-Gm-Message-State: AGRZ1gLF1ZO9gZhnQr7L+WT+ksZNX5nDody1GS/GWpNaKxHJqjzAnDJm
        rKkNngpu84IDnOZfc7yRZWE1Zg==
X-Google-Smtp-Source: AJdET5e0EOaSmX+Ujqw64hZuO+h+1A2GVbaOa1upQSiFaWC55wHLjZiKuPd9N0ZeNaicF1WWP4gWsA==
X-Received: by 2002:a17:902:8342:: with SMTP id z2-v6mr29187pln.147.1540442733320;
        Wed, 24 Oct 2018 21:45:33 -0700 (PDT)
Received: from ?IPv6:2600:1010:b05c:3179:787a:b0d3:85f0:a03b? ([2600:1010:b05c:3179:787a:b0d3:85f0:a03b])
        by smtp.gmail.com with ESMTPSA id h65-v6sm6867934pgc.88.2018.10.24.21.45.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 21:45:31 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: in_compat_syscall() returns from kernel thread for X86_32.
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <87o9bi6632.fsf@notabene.neil.brown.name>
Date:   Wed, 24 Oct 2018 21:45:30 -0700
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andy Lutomirski <luto@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-tip-commits@vger.kernel.org, jsimmons@infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AD3CD642-C7D4-43C5-AB1B-F65FE916618F@amacapital.net>
References: <1460987025-30360-1-git-send-email-dsafonov@virtuozzo.com> <tip-abfb9498ee1327f534df92a7ecaea81a85913bae@git.kernel.org> <87h8hkc9fd.fsf@notabene.neil.brown.name> <CALCETrXB8PE4Ue0BeD0wUS9psLLjpv_pt+nj=SEaj+Nb_dZzUA@mail.gmail.com> <871s8ndg6a.fsf@notabene.neil.brown.name> <CALCETrWH342Y7jKHsYdT=_3fuyDkWhvQLK9z4PTs9jzbfoCVwg@mail.gmail.com> <871s8g6roy.fsf@notabene.neil.brown.name> <20181024131534.GD11606@thunk.org> <87o9bi6632.fsf@notabene.neil.brown.name>
To:     NeilBrown <neilb@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 24, 2018, at 8:46 PM, NeilBrown <neilb@suse.com> wrote:
>=20
>> On Wed, Oct 24 2018, Theodore Y. Ts'o wrote:
>>=20
>>> On Wed, Oct 24, 2018 at 12:47:57PM +1100, NeilBrown wrote:
>>>=20
>>> I doubt it was copied - more likely independent evolution.
>>> But on reflection, I see that it is probably reasonable that it
>>> shouldn't be used this way - or at all in this context.
>>> I'll try to understand what the issues really are and see if I can
>>> find a solution that doesn't depend on this interface.
>>> Thanks for your help.
>>=20
>> At least for ext4, the primary problem is that we want to use a 64-bit
>> telldir/seekdir cookie if all 64-bits will make it to user space, and
>> a 32-bit telldir cookie if only 32 bits will make it userspace.  This
>> impacts NFS as well because if there are people who are still using
>> NFSv2, which has 32-bit directory offsets, we need to constrain the
>> telldir/seekdir cookies we give to NFS to be a 32 has as opposed to a
>> 64-bit hash.
>=20
> NFSd uses FMODE_32BITHASH or FMODE64BITHASH to allow ext4 to do the
> right thing.  FMODE_32BITHASH is set for NFSv2 only.
>=20
> Maybe sys_getdents needs to set FMODE_32BITHASH, and sys_getdent64 needs
> to set FMODE_64BITHASH - or something like that.

It=E2=80=99s possible for a 32-bit process and a 64-bit process to share a d=
irectory fd, so I don=E2=80=99t think it=E2=80=99s quite that simple.

One option would be to add .llseek and .getdents flags or entire new compat o=
perations to indicate that the caller expects 32-bit offsets.

I wonder how overlayfs interacts with this whole mess.=
