Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046B3C4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 16:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9020421A5E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 16:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="bJpkQKzj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9020421A5E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeHKTGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 15:06:15 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:33985 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbeHKTGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 15:06:15 -0400
Received: by mail-pl0-f43.google.com with SMTP id f6-v6so5260035plo.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Aug 2018 09:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IlIGVAaw0OhOF23kLB1Qyv8c0Nr0/MPjZqjsW4LhQng=;
        b=bJpkQKzjud0PprzC3nTiZJYJ60+7a1bY1m4JM7p105Xej9iSdzTcK9QdxIEvKlk+ME
         qia074Zzk2TWGrAPQQpZLwNSwMhU6xiT9k0X8ypaore5ZGN7K11ck66q9SXz7QlZcF7Z
         BaL52Z+Zc/3IwdNxbGAWlq4Rj91A/IFEeh3qtaJVVAg4Hhq0QXrEkV26WZFZQQGOKI+k
         +dvXAktVu48FGG8HEdCfsNzVkVHc5hzSnINIGgHTo/czm6pVcvUSRJYI6dhJhfbh5oKZ
         rph3dXhRJz893awwQnMfqno6BPL/sbfoh8KL0pfugww8a5RJLHW5fL6jIU0vdU7Wcr4w
         e73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IlIGVAaw0OhOF23kLB1Qyv8c0Nr0/MPjZqjsW4LhQng=;
        b=GXwUZYLeCqBmQxpSuh5JoYuklXYvtydXmotXqyBl4ndpGARGMe8hREPUO+Fb+36gFy
         Mzolzlx9fDcUzxEbQHDU5Y1q3veJz5twFuQhG9OImT2r/i9QQKhIaGEanCThnTGdAi8P
         kyS/vNHVZtBU5FuSHwaevOnhF5bhRIHKIHJO+9su5fR+JXu7YzAgEhQ636LxjzE4T67c
         B7ne7+J7kVWSgDakfChzfHJOMTHyw4ke2Ve8DR90LAzig45O9AXZetQs0pmf3MlAVDYm
         U55QROsE1CZu6R3XO/CO4AojIkRRxZ4cG5XqaIIiHB56JQBYPzgZeBjsWmN5LZwskQ7v
         nCnQ==
X-Gm-Message-State: AOUpUlHO5D2cLHRR3wO2y0bk86oaCR3k8MWrwYTnj2KV4d9OkjIKfTQs
        YiMczzMSfx+UDsVFWHzB3VmJrA==
X-Google-Smtp-Source: AA+uWPzF1/G1puF7LKPcS2icx1f8RjuWm+5UzBmcEPXKLk5XuivN2jjHUFfF4ejjTiKF/b5Gq830MQ==
X-Received: by 2002:a17:902:528a:: with SMTP id a10-v6mr10524113pli.199.1534005091569;
        Sat, 11 Aug 2018 09:31:31 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:886d:e507:15f4:6e8b? ([2601:646:c200:7429:886d:e507:15f4:6e8b])
        by smtp.gmail.com with ESMTPSA id q140-v6sm18968601pgq.11.2018.08.11.09.31.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Aug 2018 09:31:30 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: BUG: Mount ignores mount options
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <30365.1533972586@warthog.procyon.org.uk>
Date:   Sat, 11 Aug 2018 09:31:29 -0700
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        viro@zeniv.linux.org.uk,
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
Message-Id: <9B6E2781-484B-4C42-95F5-F900EA36CEA5@amacapital.net>
References: <87pnyphf8i.fsf@xmission.com> <87d0uqpba5.fsf@xmission.com> <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk> <22361.1533913891@warthog.procyon.org.uk> <30365.1533972586@warthog.procyon.org.uk>
To:     David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 11, 2018, at 12:29 AM, David Howells <dhowells@redhat.com> wrote:
>=20
> Eric W. Biederman <ebiederm@xmission.com> wrote:
>=20
>>> Yes, I agree it would be nice to have, but it *doesn't* really need
>>> supporting right this minute, since what I have now oughtn't to break th=
e
>>> current behaviour.
>>=20
>> I am really reluctant to endorse anything that propagates the issues of
>> the current interface in the new mount interface.
>=20
> Do realise that your problem cannot be solved through fsopen() until every=

> filesystem is converted to the new fs_context-based sget() since the flag h=
as
> to make it from the VFS through the filesystem to sget().
>=20
> I'm reluctant to add this flag till that point until that time unless we e=
rror
> out if the flag is set against a legacy filesystem.
>=20
>=20

I don=E2=80=99t see why we need all this fancy =E2=80=9Cdo the options match=
=E2=80=9D stuff.  For the handful of filesystems (like NFS) that do somethin=
g intelligent when multiple non-bind mount requests against the same underly=
ing storage happen,  we can keep that behavior in the new API. For other fil=
esystems that don=E2=80=99t have this feature, we should simply fail the req=
uest.

IOW I see so compelling reason to call sget() at all from the new API.  The o=
nly sort-of-legit use case I can think of is mounting more than one btrfs su=
bvolume. But even that should probably not be done by asking the kernel to s=
eparately instantiate the filesystem.

As another way of looking at it: for a network filesystem, mounting the same=
 target ip and path from two different Linux machines works, so mounting it t=
wice from the same machine should also work.  But mounting the same underlyi=
ng ext4 block device from two different Linux machines (using nbd, iscsi, et=
c) would be a catastrophe, so I see no reason that it needs to be supported i=
f it=E2=80=99s two mounts from one machine.

The case folding example is interesting, and I think it should probably have=
 a slightly different API. A program could open_tree a nocasefold mount and t=
hen make a request to create what is functionally a bind mount but with diff=
erent options.

mount(8) will presumably just keep using mount(2).=
