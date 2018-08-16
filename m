Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAFBC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F1D2147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQRML6m5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F1D2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeHPVgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:36:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:47000 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeHPVga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:36:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id f14-v6so2430825pgv.13;
        Thu, 16 Aug 2018 11:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/liKSTknX/gmM/wkBQoDje8mWaRjo2SjCqgInwvJeiU=;
        b=aQRML6m5RlpRbdvuPpiVejCxsGqD9YyZWq5QD4Op3rjWRlu03gC0Akp/6dZFrSBP60
         vrYVqQNASAU31ViTQQl+c+Ex2c//nM3RR/+girCjSGsv9MUp7UXVkXVOwYarAJJ7Wa/R
         z//9mfjHX9GOV2Wll0nzwpXBIUVzlc5ykfF1pTBpMm9kRK0/EDe6KFQB0iOlW3cEubKs
         8FTUoiStK9KaCH5Rkr/1myBtlEWll1+NXENUl+diNcGl/lphecvmR9iLDyf/y06dpZG0
         s6d0GWh2gJqLeMe/u5rNIqzh+YEMCm4eyC/7bOHdMM93Dvd1iVNj67IAOIsEI8yHpp+G
         o5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/liKSTknX/gmM/wkBQoDje8mWaRjo2SjCqgInwvJeiU=;
        b=JicVCGi6J4QLRKZF61T+ubkJHbn2wZCBKbi8WBhcr+eTqkJabbavg8FKYGyISE7uJj
         vuy+qgVAz3Jn6DpJypgwccgS1Na3djwz41SHed8gWxMFreXRKRA0ujeqSdciaZM1cVKA
         G/I72ZH2z6IraU7wNJ2Nz/jjYws4fXEAm3cFtfYxHqo1hkXG/HmXImvC+nc90VETooXk
         aTWUq7hGQNgdJMprElM7bB+5w/fxkFE0j55NLAU7rIJzbGua1nImoefedWHhcAahpGNw
         78fgRsnElS2NotiWWUxnSO/+SQ02SxkWf8LUMHrrqoKIH/CXM3Lc0z9GIM66AsunVd3A
         WIfA==
X-Gm-Message-State: AOUpUlEQK+YKoNlCH8Wx17WlXFgposx6sBCZwo6rAl4XCIjvO+eRwiTX
        ULlXDT+DG9oYqEhWEvzSY9C5muWitf0QZPoBH6s=
X-Google-Smtp-Source: AA+uWPwOuTlw1FwAawk2C1fDV+FUsHQK4LxqaxesbwL+h524cCrWLsF0qZi4WduJlcPN/LBdvyudEnXb0fQPH/Uvv/k=
X-Received: by 2002:a63:2643:: with SMTP id m64-v6mr2696766pgm.55.1534444584486;
 Thu, 16 Aug 2018 11:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <17763.1534350685@warthog.procyon.org.uk> <87pnyiew8x.fsf@xmission.com>
 <CAH2r5muKOWBe9zMM8duNJ3rp1bzQh-mUj5zYoARO5pmc4de_+A@mail.gmail.com> <87tvnuz0ms.fsf@suse.com>
In-Reply-To: <87tvnuz0ms.fsf@suse.com>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 16 Aug 2018 13:36:13 -0500
Message-ID: <CAH2r5mvLSf2Cqdi9LwVre2MyiSh+7ZxGgRp_Am3D_090oFDCzw@mail.gmail.com>
Subject: Re: Should we split the network filesystem setup into two phases?
To:     =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        David Howells <dhowells@redhat.com>,
        trond.myklebust@hammerspace.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Steve Dickson <steved@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ebiederm@redhat.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-nfs@vger.kernel.org,
        CIFS <linux-cifs@vger.kernel.org>, linux-afs@lists.infradead.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 12:23 PM Aur=C3=A9lien Aptel <aaptel@suse.com> wrot=
e:
>
> Steve French <smfrench@gmail.com> writes:
> > In cifs we attempt to match new mounts to existing tree connections
> > (instances of connections to a \\server\share) from other mount(s)
> > based first on whether security settings match (e.g. are both
> > Kerberos) and then on whether encryption is on/off and whether this is
> > a snapshot mount (smb3 previous versions feature).  If neither is
> > mounted with a snaphsot and the encryption settings match then
> > we will use the same tree id to talk with the server as the other
> > mounts use.  Interesting idea to allow mount to force a new
> > tree id.
>
> We actually already have this mount option in cifs.ko, it's "nosharesock"=
.

Yes - good point.  It is very easy to do on cifs.  I mainly use that to sim=
ulate
multiple clients for testing servers (so each mount to the same server
whether or not the share matched, looks like a different client, coming
from a different socket and thus with different session ids and tree
ids as well).

It is very useful when trying to simulate multiple clients running to the s=
ame
server while using only one client machine (or VM).

> > What was the NFS mount option you were talking about?
> > Looking at the nfs man page the only one that looked similar
> > was "nosharecache"

The nfs man page apparently discourages its use:

"As of kernel 2.6.18, the behavior specified by nosharecache is legacy
caching behavior. This is  considered  a  data risk"


--=20
Thanks,

Steve
