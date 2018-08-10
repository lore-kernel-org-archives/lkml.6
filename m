Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA21DC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D5F21E25
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="cWGPdesv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D5F21E25
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeHJRGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 13:06:30 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:38684 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbeHJRGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 13:06:30 -0400
Received: by mail-pf1-f181.google.com with SMTP id x17-v6so4625025pfh.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 07:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Od3N1wcXJvUpd0PxTTwy6ZnytWciK1KR8OXq83jCjNw=;
        b=cWGPdesvVHmNUSRMPGrJd49EcCmb3Y/WsXAKLQ8qrVL228cU2SkpHBws+jZT5tu/69
         PDs5kTBPAVEeq6r7p0kBGhINDnOF/qd5IHE4LOhlSHluWBIx8bIWOIE2CtX7bw3DBCJ0
         LD3kppSQzFQeqz58R/tYRKQjIkYGUTjZBMcOS8yW7cG9NIMK7m76EJlK1mpCtQwe9xV4
         YL3YPBEClvCJsgUrFWCZxhHzUWXpjlLw2d4UZcj0A+ZnpGBOZ7o8Z6s+nM2zaggN79XM
         VJTUqR2Udsaw6ZzDlaqdigMeaETUEtEUWAap4EHUnPOqUBc5OpNMSqpV4/jL5oVorcPP
         EbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Od3N1wcXJvUpd0PxTTwy6ZnytWciK1KR8OXq83jCjNw=;
        b=HDqNV+Iv90N/s+3LkS4no4jFe5Wu0gNNzoHuHFsVqnek1cNvf+zhoWwapon/rHMihC
         SFqrcH7bnsoIR3BC4kRhqm4l1wpwLqM/VvRl7eiLsVZ2j3Q32j0/Bwl4vys05heQQ2wW
         vJtgUvUL58qLfEzb3lU5zjp4lPnuNpfr3NRUbHMDcU0ipX8spNu1DpgBYmNs50Afyy9N
         5mSSchTT8ouDljEV5WhZkZxiV3eUi33MlC258JrGGVMORkpVLNVps7B9HUzpVy085Lg+
         gLF+6a1cqWjTb3jhATCfCWEwJ7ccd+ly01eNrqOZXdMG9xQi62jLoG6nyJvYIkrWuEhR
         csDQ==
X-Gm-Message-State: AOUpUlFzI67hhLItHy2MMfRtAg9/S0DUqlBC5QceHXlMss26PDZaJg5z
        tloXVruXe1U150cp43YxPmFV4g==
X-Google-Smtp-Source: AA+uWPxRTjXs2PcLibPICdjrTlb1UGkS8ALK+cDsLwvn8Enaa5aZTYBzSK+8RUEBkoBXt/ux2GCMsg==
X-Received: by 2002:a62:f0d:: with SMTP id x13-v6mr7246949pfi.123.1533911779369;
        Fri, 10 Aug 2018 07:36:19 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:308a:3596:3d07:5420? ([2601:646:c200:7429:308a:3596:3d07:5420])
        by smtp.gmail.com with ESMTPSA id u17-v6sm21235294pfa.176.2018.08.10.07.36.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 07:36:18 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: BUG: Mount ignores mount options
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <87d0uqpba5.fsf@xmission.com>
Date:   Fri, 10 Aug 2018 07:36:17 -0700
Cc:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk,
        John Johansen <john.johansen@canonical.com>,
        Tejun Heo <tj@kernel.org>, selinux@tycho.nsa.gov,
        Paul Moore <paul@paul-moore.com>,
        Li Zefan <lizefan@huawei.com>, linux-api@vger.kernel.org,
        apparmor@lists.ubuntu.com,
        Casey Schaufler <casey@schaufler-ca.com>, fenghua.yu@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-security-module@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        tomoyo-dev-en@lists.sourceforge.jp, cgroups@vger.kernel.org,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0F2FA70F-8C7E-4D7D-B685-244A76BDB459@amacapital.net>
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk> <87d0uqpba5.fsf@xmission.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 10, 2018, at 7:05 AM, Eric W. Biederman <ebiederm@xmission.com> wro=
te:
>=20
>=20
> There is a serious problem with mount options today that fsopen does not
> address.  The problem is that mount options are ignored for block based
> filesystems, and any other type of filesystem that follows the same
> pattern.
>=20

> /dev/loop0 /root/loop0-noacl-noquota-nouser_xattr ext4 rw,relatime,nouser_=
xattr,noacl 0 0
> /dev/loop0 /root/loop0-acl-quota-user_xattr ext4 rw,relatime,nouser_xattr,=
noacl 0 0

To make sure I understand correctly: the problem is that the second mount ig=
nored the options because the device was already mounted, right?

For the new API, I think the only remotely sane approach is to refuse to mou=
nt or init or whatever you call it an already mounted bdev. If user code gen=
uinely needs to bind-mount an existing mount that is known only by its bdev,=
 we can add a specific API just for that.=
