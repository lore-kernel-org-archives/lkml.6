Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA587C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9517621A5D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Oeh4kmwk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9517621A5D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbeHGFBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 01:01:45 -0400
Received: from ozlabs.org ([203.11.71.1]:36605 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbeHGFBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 01:01:45 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41kzWK1yDzz9ryt;
        Tue,  7 Aug 2018 12:49:32 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533610175;
        bh=sHzQieQ4vNlzPEMBt8LV2N/ND4bNx7w3EHk8R72aAPQ=;
        h=Date:From:To:Cc:Subject:From;
        b=Oeh4kmwkVuxoO+YWnHRuEyU5JQKismt/NsaOP0GSHZ/MBKLTR+7G9uNhnoW7B8Cou
         4rCVkutlS6lPIV/sZSZE3UC/nbmDMvrY8KjuUCqGTXwptGoVYUeFJlCOa8u3wbcDSq
         qnKx+uIkX4pG2Q7ryyZSiY4aEmEx4zH05z61pGkpSrFqnyuLikNeLc1B/R17fPojMJ
         rqNby7UtCicr+gIgHJxzcXhpTX/oXTyvIjukJSXmjsV77OsRtE5VKr5s4XPdYZMycj
         A95cQhWAJMNakeNukpF8lbkv5Sc7M/zyq3Fym3duHlDecXbk/ai+Vyj9OK4WrTB0TU
         Mzj+g11JMFLpg==
Date:   Tue, 7 Aug 2018 12:49:32 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matteo Croce <mcroce@redhat.com>, Julian Anastasov <ja@ssi.bg>
Subject: linux-next: manual merge of the net-next tree with the netfilter
 tree
Message-ID: <20180807124932.73422224@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/5oHuR.sWIpxOyl4ZQBWjMrI"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5oHuR.sWIpxOyl4ZQBWjMrI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/netfilter/ipvs/ip_vs_conn.c

between commit:

  16e98cec49a4 ("ipvs: don't show negative times in ip_vs_conn")

from the netfilter tree and commit:

  ec1b28ca9674 ("ipvs: provide just conn to ip_vs_state_name")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc net/netfilter/ipvs/ip_vs_conn.c
index 615286dcf4c0,0edc62910ebf..000000000000
--- a/net/netfilter/ipvs/ip_vs_conn.c
+++ b/net/netfilter/ipvs/ip_vs_conn.c
@@@ -1107,10 -1122,8 +1122,10 @@@ static int ip_vs_conn_seq_show(struct s
  				&cp->caddr.in6, ntohs(cp->cport),
  				&cp->vaddr.in6, ntohs(cp->vport),
  				dbuf, ntohs(cp->dport),
- 				ip_vs_state_name(cp->protocol, cp->state),
+ 				ip_vs_state_name(cp),
 -				(cp->timer.expires-jiffies)/HZ, pe_data);
 +				jiffies_delta_to_msecs(cp->timer.expires -
 +						       jiffies) / 1000,
 +				pe_data);
  		else
  #endif
  			seq_printf(seq,
@@@ -1120,10 -1133,8 +1135,10 @@@
  				ntohl(cp->caddr.ip), ntohs(cp->cport),
  				ntohl(cp->vaddr.ip), ntohs(cp->vport),
  				dbuf, ntohs(cp->dport),
- 				ip_vs_state_name(cp->protocol, cp->state),
+ 				ip_vs_state_name(cp),
 -				(cp->timer.expires-jiffies)/HZ, pe_data);
 +				jiffies_delta_to_msecs(cp->timer.expires -
 +						       jiffies) / 1000,
 +				pe_data);
  	}
  	return 0;
  }
@@@ -1173,10 -1184,9 +1188,10 @@@ static int ip_vs_conn_sync_seq_show(str
  				&cp->caddr.in6, ntohs(cp->cport),
  				&cp->vaddr.in6, ntohs(cp->vport),
  				dbuf, ntohs(cp->dport),
- 				ip_vs_state_name(cp->protocol, cp->state),
+ 				ip_vs_state_name(cp),
  				ip_vs_origin_name(cp->flags),
 -				(cp->timer.expires-jiffies)/HZ);
 +				jiffies_delta_to_msecs(cp->timer.expires -
 +						       jiffies) / 1000);
  		else
  #endif
  			seq_printf(seq,
@@@ -1186,10 -1196,9 +1201,10 @@@
  				ntohl(cp->caddr.ip), ntohs(cp->cport),
  				ntohl(cp->vaddr.ip), ntohs(cp->vport),
  				dbuf, ntohs(cp->dport),
- 				ip_vs_state_name(cp->protocol, cp->state),
+ 				ip_vs_state_name(cp),
  				ip_vs_origin_name(cp->flags),
 -				(cp->timer.expires-jiffies)/HZ);
 +				jiffies_delta_to_msecs(cp->timer.expires -
 +						       jiffies) / 1000);
  	}
  	return 0;
  }

--Sig_/5oHuR.sWIpxOyl4ZQBWjMrI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltpCLwACgkQAVBC80lX
0GxyAQf+NVGK9Cmolhg6Gv6zrJRV/cCYPTo4/aigQUpVa/0YkaABbnb0oRtwUw7v
06uT4YcyVZH6OncGq7z54Ee1JrkpkH/jTVqpogSuHTZOls9NIlXRV2u8+BzNE+In
3Jx2YiWniH37bCt8nCXnf8GzAKNxfG+uLQyfSgfUyWjPtY6kzr9KfP1T03Pmx7iN
hdmo9ffjqnO1GByGvjeE6sBXFA8lUibR1citQj9ix8hi5fzgcAwQCKX27qVINv7z
9BiNQytzZPIz52SWIHEaJBmsnrl3FAuWyfc4xlbnCLaE0DcOJjvxh/6M/2BnkN/T
TRE/J9t7SmAVyySR6VK34XZaOyBO0w==
=OpEJ
-----END PGP SIGNATURE-----

--Sig_/5oHuR.sWIpxOyl4ZQBWjMrI--
