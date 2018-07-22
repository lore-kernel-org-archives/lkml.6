Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31318C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 23:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4EF20850
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 23:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA4EF20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbeGWAMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 20:12:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:52562 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730673AbeGWAMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 20:12:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A5267ACE8;
        Sun, 22 Jul 2018 23:13:53 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     paulmck@linux.vnet.ibm.com
Date:   Mon, 23 Jul 2018 09:13:43 +1000
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] rhashtable: don't hold lock on first table throughout insertion.
In-Reply-To: <20180722215446.GH12945@linux.vnet.ibm.com>
References: <153086169828.24852.10332573315056854948.stgit@noble> <153086175009.24852.7782466383056542839.stgit@noble> <20180720075409.kfckhodsnvktift7@gondor.apana.org.au> <20180720144152.GW12945@linux.vnet.ibm.com> <87muulqq8q.fsf@notabene.neil.brown.name> <20180722215446.GH12945@linux.vnet.ibm.com>
Message-ID: <87h8kqrhi0.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Sun, Jul 22 2018, Paul E. McKenney wrote:
>
> One issue is that the ->func pointer can legitimately be NULL while on
> RCU's callback lists.  This happens when someone invokes kfree_rcu()
> with the rcu_head structure at the beginning of the enclosing structure.
> I could add an offset to avoid this, or perhaps the kmalloc() folks
> could be persuaded Rao Shoaib's patch moving kfree_rcu() handling to
> the slab allocators, so that RCU only ever sees function pointers in
> the ->func field.
>
> Either way, this should be hidden behind an API to allow adjustments
> to be made if needed.  Maybe something like is_after_call_rcu()?
> This would (for example) allow debug-object checks to be used to catch
> check-after-free bugs.
>
> Would something of that sort work for you?

Yes, if you could provide an is_after_call_rcu() API, that would
perfectly suit my use-case.
Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAltVD6cACgkQOeye3VZi
gbkh7Q//fsTYBjgz2oplH1RRGFA//cfC7hQhEyQPRdNKAou+es+pLmgE2v4aikms
sMHT0AObn6iLv12ZV/Geg0fb1NMRiaFThlC1Lb8sfaA6Hczsgl0YtJEHBvEWIX43
687mapwo51GhdSRQGPkva611qaebO8NOaDWYuhYGONuxCJUl6CLWHqjM4XR2Bug6
RVVd4m7o5RYSwSMVBZb868uHwqRf7R/XnrfNpg4SZAZa0eOeiWK78VJRkdteHYvl
9vsipbhTM6RBi+Zy8qi6AryH/m9RuN3T1D62GKN6cxY6RNJEjzeOqbVGdS2wkjMQ
CIsUtYSbjUmd46f1mGJ2AJR/OVU7BJRWLNVutveWH6C++CfscTP3zNuSDtGTzK6u
rg19q73dRkfItyvd6E4H2rBInNf3PnzHbhOVEqQIq9zD4ayWl5KQbJyKc09Zjhfa
dewwDcKsA+uyIUUFVaA8llpDXVNXboxGT0pXKvmmVIpUEcGGLUA5qc7tIJ95b4ZY
efRSL64MdcPlWpPvVv8BKaClpJskfK7S1qpCfj0So6uzh2DmrGUDyLJLspqvfIN/
WRPezvw3RXByV0Xf9oqzboixSfVrDv5MlmJXuP8OiEdYowRxfT4VS78VU1nN/QQs
fD7keSNyRIgssEnQBNgxgGmsaYr3C6fKrHzkB2aOjwpii3vTzr4=
=AiZF
-----END PGP SIGNATURE-----
--=-=-=--
