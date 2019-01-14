Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EADEC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 04:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D6720659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 04:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="CoFafKY+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfANEQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 23:16:00 -0500
Received: from ozlabs.org ([203.11.71.1]:41307 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726306AbfANEQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 23:16:00 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43dKs9393nz9s2P;
        Mon, 14 Jan 2019 15:15:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547439357;
        bh=/vpAb7K7InaZQO7Rkz3RgeIKAh3MJcooyWZIyvqtz5g=;
        h=Date:From:To:Cc:Subject:From;
        b=CoFafKY+bgZEbLRkzurVvHfRF6G8u8Svgf+qOOPOjxFi3c7pACSeIWN8fnyeb6rCV
         /R6yqULJvNov8nJA50KQFCmk6X4jasj11+3Vg1jta0+VuzKIb64gMVrgp63QYL6FQQ
         dpXL/PhWNy40+5XNmzzBWu/4CYpu1CoCFDpYTTKcQp0wKnGOo+QQ5D68BHKbAzb9x6
         1Lq66eX6tMbzHaT0zsDh24RD4NGBq9tva+G3uqd3UAt59OCjCf5phJu1paperKvKQ6
         V5eAJR0i/0gW3+s9e/dax0gf2eI/Zjgy1OT1uiFwXCxFqM8Cy0LsZ58sI0pjKEb+wY
         4UgyXbBloDXWQ==
Date:   Mon, 14 Jan 2019 15:15:55 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Taehee Yoo <ap420073@gmail.com>
Subject: linux-next: build warning after merge of the net tree
Message-ID: <20190114151555.31c85f81@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/yf/8_zO68f+jchMjI852Q7E"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yf/8_zO68f+jchMjI852Q7E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net tree, today's linux-next build (powerpc
allyesconfig) produced this warning:

ld: warning: orphan section `.bpfilter_umh' from `net/bpfilter/bpfilter_umh=
_blob.o' being placed in section `.bpfilter_umh'

Introduced by commit

  61fbf5933d42 ("net: bpfilter: restart bpfilter_umh when error occurred")

--=20
Cheers,
Stephen Rothwell

--Sig_/yf/8_zO68f+jchMjI852Q7E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw8DPsACgkQAVBC80lX
0GxZZAf+LKIiJM5K2/Z7NO8P6PCxpZoyEltYlQpGJKl00rc5DVktCV1mvgrYE0zQ
qfNeQcjLYilRLq5ZCNWs0eNRDRkJTLeC5iYDKBUTQHfpw9UddDxtKRaUMf5yZ1G7
N084G0Rq+PZ86B5Km7mZqFVjXcbSEIktwQPnsxTktoeAAs9KJXZhdjyBFZRkb2IQ
YxswZXqczM/xNx+eYhclAeFi7Y7sxeHlPPKEz2ppobmg3brl/LRxKihaaYy8JrQo
1EIwu+sJ3+SvsJEFtbyb3+xHY9QzhzHWGXyE9nzJL9Eaje3FU1lM6z+EiX3CCiRV
yvT7dkJF5CWg6idv61IPMDP25qiqxQ==
=ZJU/
-----END PGP SIGNATURE-----

--Sig_/yf/8_zO68f+jchMjI852Q7E--
