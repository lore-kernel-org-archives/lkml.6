Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDA6C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 01:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81C020883
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 01:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81C020883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732042AbeG0CYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 22:24:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:55588 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731924AbeG0CYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 22:24:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4202FACBA;
        Fri, 27 Jul 2018 01:04:46 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     paulmck@linux.vnet.ibm.com
Date:   Fri, 27 Jul 2018 11:04:37 +1000
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] rhashtable: don't hold lock on first table throughout insertion.
In-Reply-To: <20180725152250.GN12945@linux.vnet.ibm.com>
References: <153086175009.24852.7782466383056542839.stgit@noble> <20180720075409.kfckhodsnvktift7@gondor.apana.org.au> <20180720144152.GW12945@linux.vnet.ibm.com> <87muulqq8q.fsf@notabene.neil.brown.name> <20180722215446.GH12945@linux.vnet.ibm.com> <87h8kqrhi0.fsf@notabene.neil.brown.name> <20180723205625.GZ12945@linux.vnet.ibm.com> <87r2jtpqm4.fsf@notabene.neil.brown.name> <20180724225825.GE12945@linux.vnet.ibm.com> <87in53oqzz.fsf@notabene.neil.brown.name> <20180725152250.GN12945@linux.vnet.ibm.com>
Message-ID: <87r2jpmqu2.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 25 2018, Paul E. McKenney wrote:
>>=20
>> Looks good ... except ... naming is hard.
>>=20
>>  is_after_call_rcu_init()  asserts where in the lifecycle we are,
>>  is_after_call_rcu() tests where in the lifecycle we are.
>>=20
>>  The names are similar but the purpose is quite different.
>>  Maybe s/is_after_call_rcu_init/call_rcu_init/ ??
>
> How about rcu_head_init() and rcu_head_after_call_rcu()?

Yes, I like those.
Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAltab6YACgkQOeye3VZi
gbkBnw/8CeuzYA5hyw2tgVVSLLbJENMQRI3ZCS4oRl1PFsFgHCJ4Mp5hjwuecZfh
fzvrc0Ug+acesG6QlswuIf34Xp2ved3gc+2gLPaUhMRixl0GlS0S9nDUXWZuIWvh
1PEJiV+GSxE9h3ETML+xGqbff3rW33cYx8ZSzUrVvvNbnaf2ZBN3Zt2oSdqgQPhB
BPGtU7XVrDapC7KTOM56p8lBf760L9gSP1Yx8AEQ7KCzBSdNXCw08UM3chvlVCrx
Am45SZfX4AwqvZFUN3Cvg3CmhD4zyLV+lwCdFuwsYn+O+TlVDOrEldm2WzCcZd2K
SipdmhhctYs7RusZZ9L1g/GDX5dLzuxiuriqqdUwGU0VQKg5H0FMGLrUDsYydXDQ
XDM2Dg8vbN/hjftqK2T24LVn27Mqs3g2bsGF896TE3zyxC1iGSGWst0tne3R6aRn
VwRzFCtXTa7T9cwly/XWjalKABNs2vkzbzBBokgOkf+kdrgVfx++NPQvt5tuv+Ch
zpGVsy8hRzrNmrWDyzC/qGnqDhggYbpjsBn7BETHQQZ5Joke9eSWfk4zW9r9Gi8J
oJuw3trqpZp84lEG2Hgd243vCpttXLIuTYr3nXuCbhAtXMhO67MkPmJ93oQRDo7l
QzZgZj2eQnIqRY9KGnGbjqmVuJLa6F2EAVRuFzrtmo85FBK7MJ8=
=DtVe
-----END PGP SIGNATURE-----
--=-=-=--
