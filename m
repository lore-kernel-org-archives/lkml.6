Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D849CC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 23:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D61F208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 23:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Pnt+Rqhi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D61F208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbeJPH27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 03:28:59 -0400
Received: from ozlabs.org ([203.11.71.1]:58209 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbeJPH27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 03:28:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Yw1x5lGFz9s9h;
        Tue, 16 Oct 2018 10:41:25 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539646885;
        bh=hBjDyVqSbow5nf98vfb38QiBSgtoVlA1H1TwMEIp6kU=;
        h=Date:From:To:Cc:Subject:From;
        b=Pnt+RqhiJPqfFS04eoMSSnooFCBB+8jt3huN7yc94XE/ynpEs4jQ62sZjHImkblqq
         +29aEkw3DSmGHF64lf9jQijdkJG11y70gZprUafhTgRp2uC1IAyHueKyqnJIYx5DKi
         d8XlkvmQ8jGEDRGL3nU0H9cUt/CmEkhvXgP6GDEDtd53T5Xr9Wuda5pej6UvPNab8V
         rdyvT2+QDvsEdt+JD8mgo+fMG4exSP7G8m0hPlLaEqnEG+7Wms6LQ2f12A7cfWuJ+Q
         WOthZgZq/P7/KoAcXFZ/JNQiRHwggvmGda0LAHCF0txU5+96GGMkQq/m2JHGelPHst
         e2FhLZXdZzwSQ==
Date:   Tue, 16 Oct 2018 10:41:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: linux-next: build failure after merge of the netfilter-next tree
Message-ID: <20181016104125.2a299bc5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Pz9NZM4HjnQuGcakoiEtXrk"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Pz9NZM4HjnQuGcakoiEtXrk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the netfilter-next tree, today's linux-next build (x86_64
allmodconfig) failed like this:

net/ipv4/netfilter/ipt_ECN.c: In function 'set_ect_tcp':
net/ipv4/netfilter/ipt_ECN.c:58:28: error: 'IPT_ECN_OP_SET_ECE' undeclared =
(first use in this function); did you mean 'IPT_ECN_OP_MATCH_ECE'?
  if ((!(einfo->operation & IPT_ECN_OP_SET_ECE) ||
                            ^~~~~~~~~~~~~~~~~~
                            IPT_ECN_OP_MATCH_ECE
net/ipv4/netfilter/ipt_ECN.c:58:28: note: each undeclared identifier is rep=
orted only once for each function it appears in
net/ipv4/netfilter/ipt_ECN.c:60:28: error: 'IPT_ECN_OP_SET_CWR' undeclared =
(first use in this function); did you mean 'IPT_ECN_OP_MATCH_CWR'?
      (!(einfo->operation & IPT_ECN_OP_SET_CWR) ||
                            ^~~~~~~~~~~~~~~~~~
                            IPT_ECN_OP_MATCH_CWR
net/ipv4/netfilter/ipt_ECN.c: In function 'ecn_tg':
net/ipv4/netfilter/ipt_ECN.c:84:25: error: 'IPT_ECN_OP_SET_IP' undeclared (=
first use in this function); did you mean 'IPT_ECN_OP_MATCH_IP'?
  if (einfo->operation & IPT_ECN_OP_SET_IP)
                         ^~~~~~~~~~~~~~~~~
                         IPT_ECN_OP_MATCH_IP
net/ipv4/netfilter/ipt_ECN.c:88:26: error: 'IPT_ECN_OP_SET_ECE' undeclared =
(first use in this function); did you mean 'IPT_ECN_OP_MATCH_ECE'?
  if (einfo->operation & (IPT_ECN_OP_SET_ECE | IPT_ECN_OP_SET_CWR) &&
                          ^~~~~~~~~~~~~~~~~~
                          IPT_ECN_OP_MATCH_ECE
net/ipv4/netfilter/ipt_ECN.c:88:47: error: 'IPT_ECN_OP_SET_CWR' undeclared =
(first use in this function); did you mean 'IPT_ECN_OP_MATCH_CWR'?
  if (einfo->operation & (IPT_ECN_OP_SET_ECE | IPT_ECN_OP_SET_CWR) &&
                                               ^~~~~~~~~~~~~~~~~~
                                               IPT_ECN_OP_MATCH_CWR
net/ipv4/netfilter/ipt_ECN.c: In function 'ecn_tg_check':
net/ipv4/netfilter/ipt_ECN.c:101:25: error: 'IPT_ECN_OP_MASK' undeclared (f=
irst use in this function); did you mean 'IPT_ECN_IP_MASK'?
  if (einfo->operation & IPT_ECN_OP_MASK)
                         ^~~~~~~~~~~~~~~
                         IPT_ECN_IP_MASK
net/ipv4/netfilter/ipt_ECN.c:107:27: error: 'IPT_ECN_OP_SET_ECE' undeclared=
 (first use in this function); did you mean 'IPT_ECN_OP_MATCH_ECE'?
  if ((einfo->operation & (IPT_ECN_OP_SET_ECE|IPT_ECN_OP_SET_CWR)) &&
                           ^~~~~~~~~~~~~~~~~~
                           IPT_ECN_OP_MATCH_ECE
net/ipv4/netfilter/ipt_ECN.c:107:46: error: 'IPT_ECN_OP_SET_CWR' undeclared=
 (first use in this function); did you mean 'IPT_ECN_OP_MATCH_CWR'?
  if ((einfo->operation & (IPT_ECN_OP_SET_ECE|IPT_ECN_OP_SET_CWR)) &&
                                              ^~~~~~~~~~~~~~~~~~
                                              IPT_ECN_OP_MATCH_CWR

Caused by commit

  25038aaf0cbf ("UAPI: netfilter: Fix symbol collision issues [ver #2]")

I used the netfilter-next tree from next-20181015 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/Pz9NZM4HjnQuGcakoiEtXrk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvFJaUACgkQAVBC80lX
0GwDEggAn6sCOZxM6kIdtWt1DY1v8e8/G0KXE+ar4SjwcYytEGHzy/H+D2r2lqfB
JdJen4sKIaEjTdnWomqkNdxTA05dhrkbOH73TV6Vy9TEjGQ/N6il5036cyxhLJ1E
y/SfunckvN5paFyzqC7wyRGcKAAepXWaZLf3ZdYU97PwogTU42aUGPER9Vowd0PX
xYWCgBuMs1qOJ9ogvyxXs2DplMXbmTrYZhCTNnWB1EuSfmIeURmroHHM01otId7V
wz5jCy5OHupkdWaa9pLvkWb4N5dqV6wplgWuDmDbtrSkrw87DHCsotFFV+9ocRbi
OBbD3vw7cSmeO4PYvGdaIv3efTkTAg==
=Xf9r
-----END PGP SIGNATURE-----

--Sig_/Pz9NZM4HjnQuGcakoiEtXrk--
