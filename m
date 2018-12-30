Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13419C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 11:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826C320855
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 11:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="KxcvwfBh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbeL3LAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 06:00:23 -0500
Received: from narfation.org ([79.140.41.39]:37324 "EHLO v3-1039.vlinux.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbeL3LAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 06:00:23 -0500
Received: from sven-edge.localnet (unknown [IPv6:2a02:2454:8871:1700:6a17:29ff:fee0:e6ec])
        by v3-1039.vlinux.de (Postfix) with ESMTPSA id 9EF621100E2;
        Sun, 30 Dec 2018 12:00:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=narfation.org;
        s=20121; t=1546167620;
        bh=HXT3m1sM64lWWOehuQeHMIaR3wFvFq3iPZgFwbtInOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KxcvwfBhRCq2iS0UJN5jjqpjr/zQSCyDV3HAPW8FCC1XR+rq45kc/xcjwngGB/vZA
         gbwZBIlO65O3WkV/qJVb6mFClHTLqlkE45mYlPS+DgvlWmGeLLDHXU+2M9Ns5QrY0C
         iLtRUUmGDa34+Qju8hB+GRqUUBp3j2a0hbc5c3ss=
From:   Sven Eckelmann <sven@narfation.org>
To:     syzbot <syzbot+c764de0fcfadca9a8595@syzkaller.appspotmail.com>
Cc:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        mareklindner@neomailbox.ch, netdev@vger.kernel.org,
        sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in batadv_is_on_batman_iface
Date:   Sun, 30 Dec 2018 12:00:12 +0100
Message-ID: <3100603.HWLWhOUWpG@sven-edge>
In-Reply-To: <000000000000d89413057e3aeec2@google.com>
References: <000000000000d89413057e3aeec2@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1873944.72WfFfbkSa"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1873944.72WfFfbkSa
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, 30 December 2018 11.41.03 CET syzbot wrote:
[...]
> HEAD commit:    d8924c0d76aa Merge tag 'devprop-4.21-rc1' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=122a373f400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=91a256823ef17263
> dashboard link: https://syzkaller.appspot.com/bug?extid=c764de0fcfadca9a8595
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16fd1d67400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+c764de0fcfadca9a8595@syzkaller.appspotmail.com

What is the bug here? The kernel module showed a warning because the parent 
device cannot be found in the same netns using __dev_get_by_index.

The test system was just configured to panic on warnings. So are we now 
expected to show warnings or what is the expected behavior?

This behavior was added with commit b7eddd0b3950 ("batman-adv: prevent using 
any virtual device created on batman-adv as hard-interface") - 3d48811b27f5 in 
the out-of-tree module.

Kind regards,
	Sven

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b7eddd0b3950ea9dc863f1cbfa30d172dbf772f4
--nextPart1873944.72WfFfbkSa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlwopTwACgkQXYcKB8Em
e0YQMBAAltYX12JxNeyzwU/NpF0YYohNL71mWTCotYpuPntVwfcUHt8iJzdWTMed
F45oQfZXtt2M9ruWxf5PuFbDLhOipHuMT49eGKrKSmBn8P3LAZrQ3LLBhp7wOwU+
o9ueQy39Y7qbnbc+Xw4efv6Mg82MjVXDWpmLTc9EEjg6v5JImkmGIUg+cUrWtlrs
zAEVHvivGWDOhDNFWHrqKPhQl37nIl5ejkSC7VxDRsRzOnT8j+PG7UyUkYOW2XmI
UrySPu/ZycG94xze37bvWN+z5ta63QvpIPiTtmyiqN0PEgtrbM0xaMtfB53qdqt6
oBFJVs+VKH6ojcybbIK+LTD3Aj8BIBPaQP4NmcB2B6K8a/7v4wiuf40dXTgj2Bj3
I0XJ2QJZgdYmMtkvvyNHaY29QPvd+Pww+6ynSRL9hS7Ol4PGJ6nasJPH91k/ve6E
MgEIibTKM25Qp9rmLoaNnTv4d4xBmh0gcDeSaOdt3kRjf5l8r/o6lNfolepKoDvz
AxhpilApMsTrFLsbDeTeH/NERK2rcZaZyWeFOjAQoz8cGU+OyM6L924NFGmmGCbP
rukjTuP1Wj2Bb2pYV5QsBnV4t8LWOXca+VhK2CQ+/pGAnVym4g2SjWi0jeAS9O6W
MG7gIAZFRoMQLNx2y2cwTjeN8tKjakuFi0IRHMrbiSVyl1SvqJg=
=r+Bq
-----END PGP SIGNATURE-----

--nextPart1873944.72WfFfbkSa--



