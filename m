Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A60DC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C872086B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="REQGXvVS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C872086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbeHOToe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 15:44:34 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:33330 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729650AbeHOToe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 15:44:34 -0400
Received: by mail-pf1-f176.google.com with SMTP id d4-v6so752223pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 09:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2w38piqzLfuMQZT6N2ceqvVw20xgZyYBNz1J15/zuzs=;
        b=REQGXvVSzM4JIWp0ri3/lQWIMBNG/UCtwg5ji6Lp3OtzmdFCkLT//CxdIT7kSd3z4K
         MoMb5r+ZRRja9nkm5SI2wDpC0kEbIIjtFdTSPjEAeKcDiBeFIgZ58kIgv0DwuktdOJGg
         9jVXJxK4Ky3wxJwABRx0lGrzs9qKAm/M1hk3fLILiyCZm+RzYJ3RDh8FoFSdkzLXi7a0
         72hIn/M59bO78Lg5twSvYGKqPNahHS8uJFfZE+zrZ/mBKUczVrLiaz3V5dTeYvONgarE
         a0OruviJG/7GlLYgKAEZdOQEliCu397KYQXzM2aK/pgJRghtXNmQ0vH6McWxP5FXxiP0
         3afg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2w38piqzLfuMQZT6N2ceqvVw20xgZyYBNz1J15/zuzs=;
        b=uGke1pnd4m8JyVrioB2eHYTbqydGd2Na0ghIpLXTvRMpre7dt5h/eQQDMciGPNPB5+
         W7zS73iVOCpM8oJ3VSndc6VLMKuM0cHcUNRxMlwpQMfspJrNSXVNMjOKutqBOdFh3qWF
         LBr+PuomghbXGvYwOgEkdSL5/Fvdsmv11dRyQAhTVxnXEyAjJrV2k+Ep1q5hHHADDhJe
         1S7MjIpF6e+ouFNWSrq0QwLqxny5gmdBA/UhRiEARPMLpquwzorU0bQGI6Sgz2FU6aIG
         ZQrkgg486SkYPLcBz3eBfYB7PLXo2BZ4fWHtZCdmOj3joe+RbnemjPeXMmf1DEbsZE/g
         i4bQ==
X-Gm-Message-State: AOUpUlFT8it+CNHY2s9sotyc0DIYO4Vj6ye8TRZCXfKtSIsAo09MvkQj
        /31nBuC/0478QY+Khaf01pQhdw==
X-Google-Smtp-Source: AA+uWPyVoAzgORLFf2AQjwvJBBDKWsAYmMHWKFVBHn/4IihAOnf/zMyVH+51qQQjPAJ8aXxpy4BVHg==
X-Received: by 2002:a63:b213:: with SMTP id x19-v6mr25592505pge.393.1534351899223;
        Wed, 15 Aug 2018 09:51:39 -0700 (PDT)
Received: from ?IPv6:2600:1010:b010:3fbd:7d76:67ee:fa0f:6b7f? ([2600:1010:b010:3fbd:7d76:67ee:fa0f:6b7f])
        by smtp.gmail.com with ESMTPSA id v3-v6sm61566635pgb.54.2018.08.15.09.51.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 09:51:37 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: Should we split the network filesystem setup into two phases?
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <17763.1534350685@warthog.procyon.org.uk>
Date:   Wed, 15 Aug 2018 09:51:36 -0700
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        sfrench@samba.org, steved@redhat.com, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org,
        "Eric W. Biederman" <ebiederm@redhat.com>,
        linux-api@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <DCE0E619-68F8-4906-8062-68D63DDED665@amacapital.net>
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk> <17763.1534350685@warthog.procyon.org.uk>
To:     David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 15, 2018, at 9:31 AM, David Howells <dhowells@redhat.com> wrote:
>=20
> Having just re-ported NFS on top of the new mount API stuff, I find that I=

> don't really like the idea of superblocks being separated by communication=

> parameters - especially when it might seem reasonable to be able to adjust=

> those parameters.
>=20
> Does it make sense to abstract out the remote peer and allow (a) that to b=
e
> configured separately from any superblocks using it and (b) that to be use=
d to
> create superblocks?
>=20
> Note that what a 'remote peer' is would be different for different
> filesystems:

...

I think this looks rather nice.  But maybe you should generalize the concept=
 of =E2=80=9Cpeer=E2=80=9D so that it works for btrfs too. In the case where=
 you mount two different subvolumes, you=E2=80=99re creating a *something*, a=
nd you=E2=80=99re then creating a filesystem that references it. It=E2=80=99=
s almost the same thing.

>=20
>=20


>=20
>    fs =3D fsopen("nfs", 0);
>    fsconfig(fs, FSCONFIG_SET_PEER, "peer.1", NULL, peer1);

As you mention below, this seems like it might have namespacing issues.

>    =20

> In terms of alternative interfaces, I'm not sure how easy it would be to m=
ake
> it like cgroups where you go and create a dir in a special filesystem, say=
,
> "/sys/peers/nfs", because the peers records and names would have to be net=
work
> namespaced.  Also, it might make it more difficult to use to create a root=
 fs.
>=20
> On the other hand, being able to adjust the peer configuration by:
>=20
>    echo 71 >/sys/peers/nfs/server.home/timeo
>=20
> does have a certain appeal.
>=20
> Also, netlink might be the right option, but I'm not sure how you'd pin th=
e
> resultant object whilst you make use of it.
>=20

My suggestion would be to avoid giving these things names at all. I think th=
at referring to them by fd should be sufficient, especially if you allow the=
m to be reopened based on a mount that uses them and allow them to get bind-=
mounted somewhere a la namespaces to make them permanent if needed.

> A further thought is that is it worth making this idea more general and
> encompassing non-network devices also?  This would run into issues of some=

> logical sources being visible across namespaces and but not others.

Indeed :)

It probably pays to rope a btrfs person into this discussion.

