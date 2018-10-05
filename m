Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C54DC64EBC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 00:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFB420854
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 00:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="EX3tQ3nK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFB420854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbeJEG5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 02:57:33 -0400
Received: from ozlabs.org ([203.11.71.1]:40935 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbeJEG5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 02:57:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42R90F6CqGz9s9m;
        Fri,  5 Oct 2018 10:01:33 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538697694;
        bh=rD6uTwyy9SQfDsonn0qA1+gu9kcEZ+4bAyBTe23bq+I=;
        h=Date:From:To:Cc:Subject:From;
        b=EX3tQ3nKut7W57RysYbbY6cId9P+7TiVv1fx5gSeR+j9PZEOIuYYWyU5wBnWomR0b
         lV2IpIiBwnL1EwYXNB95xL5Jpu8P7lqe6USSBUlQbpCJFSkX2dUu7jOdH3mdqJ4G3b
         V+gztNGEMFLgLfEpbEJLoCndw7fEVp35aLHrt5LE+6ByuYth3EzurL4WAD3Rw9MgOS
         BK9iDOpBNPdx9a/vfaebRBnBf55iXrwAVgq09oExCpFsj8rCxsEP6g9GdhjOFQkFnq
         kQJGOnqZGeHcK5UVhj2C7kmoySopdLi4V/qizrdqskOFp14zYoHJB5ac/Yh/oeYiS9
         HQV4aX5HnTK5g==
Date:   Fri, 5 Oct 2018 10:01:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Trond Myklebust <trondmy@gmail.com>
Subject: linux-next: build failure after merge of the nfsd tree
Message-ID: <20181005100133.755de185@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/jxa2=ZjHkFTVspsf9xwGDb_"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jxa2=ZjHkFTVspsf9xwGDb_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the nfsd tree, today's linux-next build (x86_64
allmodconfig) failed like this:

fs/nfs/dns_resolve.c: In function 'nfs_dns_ent_put':
fs/nfs/dns_resolve.c:119:11: error: passing argument 1 of 'call_rcu_sched' =
from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
  call_rcu(item, nfs_dns_ent_free_rcu);
           ^~~~
In file included from include/linux/srcu.h:33,
                 from include/linux/notifier.h:16,
                 from include/linux/memory_hotplug.h:7,
                 from include/linux/mmzone.h:758,
                 from include/linux/gfp.h:6,
                 from include/linux/umh.h:4,
                 from include/linux/kmod.h:22,
                 from include/linux/module.h:13,
                 from fs/nfs/dns_resolve.c:36:
include/linux/rcupdate.h:59:38: note: expected 'struct callback_head *' but=
 argument is of type 'struct nfs_dns_ent *'
 void call_rcu_sched(struct rcu_head *head, rcu_callback_t func);
                     ~~~~~~~~~~~~~~~~~^~~~

Caused by commit

  fd497f1e40d9 ("NFS: Lockless DNS lookups")

I have used the nfsd tree from next-20181004 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/jxa2=ZjHkFTVspsf9xwGDb_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu2qd0ACgkQAVBC80lX
0Gx9oAgAkdjhijF3k9BvB4j8hdCTr3SaSvIphdH95W1zmsBTayyUkKwrmQbG5sba
rva9iMUifWqiAZ4/xBOnx9tCNqP5qGWXDyknqOdFVBE4sqwZT4IvqN6F/6iE7aNX
yBgf7hVzqWhlTdIh0kAMiLSi1KQrEiVtDBVq0Qv+bj61yWwqcuG7GmUwVZ0pILWg
UK/qBoro7cMt+nA8AGFUERwi7WLD97kcbwPC0GWyj3/fxc79F4yvRw/R4QAIvx+L
EvVsBm8tF0ta4Qln7+GfHhOgcGuiElqGu8hhtENdzYwtrMn8dKSMpJ7ELd79P31r
FjUOsefz2MhMVeQ2mCS+XrrvWqY0dw==
=kaZY
-----END PGP SIGNATURE-----

--Sig_/jxa2=ZjHkFTVspsf9xwGDb_--
