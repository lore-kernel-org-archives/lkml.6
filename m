Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F89C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E14320657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Xz+lJwED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfAQB1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 20:27:17 -0500
Received: from ozlabs.org ([203.11.71.1]:49599 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbfAQB1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 20:27:17 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43g5z56VfVz9sCh;
        Thu, 17 Jan 2019 12:27:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547688433;
        bh=yRMfFrOTJ+HyAApa4z7s+SBF/beLrNq8VXc7I7ZndDc=;
        h=Date:From:To:Cc:Subject:From;
        b=Xz+lJwED/H7rgVApcdijKZaC9eXdEGnpM4nP8yNJFcVfCbQsWbac/IzTkiEHDpasP
         OFmdS7U5EtxFQxtSRCzT4YKPZEsQ1WO3ebTdmmNHioMZNwt8fco2QAZLkv8ECEPott
         Lejoj2zwQX5g5oEoGjucrH8zdt1f4TNP1kogygjjDVHt89CyMCRQaTrmi1UQyvfDph
         LdLgFRjDKRvzX5Dlz427uHvE9jcAj4FnBld2+IkAfBnnOo+wwA+p3NViPcmHesLGtT
         VkjqVjKCLqCft35+BaFVgJhKkmIF6gaBRxOUaV2GLd4r/u8L6N+zpNpz9tm6NXJDGu
         wsvYGNKTbkYmA==
Date:   Thu, 17 Jan 2019 12:27:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yupeng <yupeng0921@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20190117122713.217bbb58@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Ztw5Y5ttJV6y=_wwZ/jROak"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ztw5Y5ttJV6y=_wwZ/jROak
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  Documentation/networking/snmp_counter.rst

between commit:

  a6c7c7aac2de ("net: add document for several snmp counters")

from the net tree and commit:

  ae5220c67218 ("networking: Documentation: fix snmp_counters.rst Sphinx wa=
rnings")

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

diff --cc Documentation/networking/snmp_counter.rst
index fe8f741193be,486ab33acc3a..000000000000
--- a/Documentation/networking/snmp_counter.rst
+++ b/Documentation/networking/snmp_counter.rst
@@@ -336,27 -364,8 +364,27 @@@ time client replies ACK, this socket wi
  to the accept queue.
 =20
 =20
 -TCP Fast Open
 +* TcpEstabResets
 +Defined in `RFC1213 tcpEstabResets`_.
 +
 +.. _RFC1213 tcpEstabResets: https://tools.ietf.org/html/rfc1213#page-48
 +
 +* TcpAttemptFails
 +Defined in `RFC1213 tcpAttemptFails`_.
 +
 +.. _RFC1213 tcpAttemptFails: https://tools.ietf.org/html/rfc1213#page-48
 +
 +* TcpOutRsts
 +Defined in `RFC1213 tcpOutRsts`_. The RFC says this counter indicates
 +the 'segments sent containing the RST flag', but in linux kernel, this
 +couner indicates the segments kerenl tried to send. The sending
 +process might be failed due to some errors (e.g. memory alloc failed).
 +
 +.. _RFC1213 tcpOutRsts: https://tools.ietf.org/html/rfc1213#page-52
 +
 +
 +TCP Fast Path
- =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  When kernel receives a TCP packet, it has two paths to handler the
  packet, one is fast path, another is slow path. The comment in kernel
  code provides a good explanation of them, I pasted them below::
@@@ -582,7 -612,8 +630,8 @@@ The TCP stack receives an out of order=20
  DSACK to the sender.
 =20
  * TcpExtTCPDSACKRecv
+=20
 -The TCP stack receives a DSACK, which indicate an acknowledged
 +The TCP stack receives a DSACK, which indicates an acknowledged
  duplicate packet is received.
 =20
  * TcpExtTCPDSACKOfoRecv
@@@ -589,59 -621,10 +639,60 @@@
  The TCP stack receives a DSACK, which indicate an out of order
  duplicate packet is received.
 =20
 +invalid SACK and DSACK
- =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 +When a SACK (or DSACK) block is invalid, a corresponding counter would
 +be updated. The validation method is base on the start/end sequence
 +number of the SACK block. For more details, please refer the comment
 +of the function tcp_is_sackblock_valid in the kernel source code. A
 +SACK option could have up to 4 blocks, they are checked
 +individually. E.g., if 3 blocks of a SACk is invalid, the
 +corresponding counter would be updated 3 times. The comment of the
 +`Add counters for discarded SACK blocks`_ patch has additional
 +explaination:
 +
 +.. _Add counters for discarded SACK blocks: https://git.kernel.org/pub/sc=
m/linux/kernel/git/torvalds/linux.git/commit/?id=3D18f02545a9a16c9a89778b91=
a162ad16d510bb32
 +
 +* TcpExtTCPSACKDiscard
 +This counter indicates how many SACK blocks are invalid. If the invalid
 +SACK block is caused by ACK recording, the TCP stack will only ignore
 +it and won't update this counter.
 +
 +* TcpExtTCPDSACKIgnoredOld and TcpExtTCPDSACKIgnoredNoUndo
 +When a DSACK block is invalid, one of these two counters would be
 +updated. Which counter will be updated depends on the undo_marker flag
 +of the TCP socket. If the undo_marker is not set, the TCP stack isn't
 +likely to re-transmit any packets, and we still receive an invalid
 +DSACK block, the reason might be that the packet is duplicated in the
 +middle of the network. In such scenario, TcpExtTCPDSACKIgnoredNoUndo
 +will be updated. If the undo_marker is set, TcpExtTCPDSACKIgnoredOld
 +will be updated. As implied in its name, it might be an old packet.
 +
 +SACK shift
- =3D=3D=3D=3D=3D=3D=3D=3D=3D
++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 +The linux networking stack stores data in sk_buff struct (skb for
 +short). If a SACK block acrosses multiple skb, the TCP stack will try
 +to re-arrange data in these skb. E.g. if a SACK block acknowledges seq
 +10 to 15, skb1 has seq 10 to 13, skb2 has seq 14 to 20. The seq 14 and
 +15 in skb2 would be moved to skb1. This operation is 'shift'. If a
 +SACK block acknowledges seq 10 to 20, skb1 has seq 10 to 13, skb2 has
 +seq 14 to 20. All data in skb2 will be moved to skb1, and skb2 will be
 +discard, this operation is 'merge'.
 +
 +* TcpExtTCPSackShifted
 +A skb is shifted
 +
 +* TcpExtTCPSackMerged
 +A skb is merged
 +
 +* TcpExtTCPSackShiftFallback
 +A skb should be shifted or merged, but the TCP stack doesn't do it for
 +some reasons.
 +
  TCP out of order
- =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  * TcpExtTCPOFOQueue
+=20
  The TCP layer receives an out of order packet and has enough memory
  to queue it.
 =20
@@@ -728,66 -721,12 +789,66 @@@ unacknowledged number (more strict tha
  .. _RFC 5961 section 4.2: https://tools.ietf.org/html/rfc5961#page-9
  .. _RFC 5961 section 5.2: https://tools.ietf.org/html/rfc5961#page-11
 =20
 +TCP receive window
- =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 +* TcpExtTCPWantZeroWindowAdv
 +Depending on current memory usage, the TCP stack tries to set receive
 +window to zero. But the receive window might still be a no-zero
 +value. For example, if the previous window size is 10, and the TCP
 +stack receives 3 bytes, the current window size would be 7 even if the
 +window size calculated by the memory usage is zero.
 +
 +* TcpExtTCPToZeroWindowAdv
 +The TCP receive window is set to zero from a no-zero value.
 +
 +* TcpExtTCPFromZeroWindowAdv
 +The TCP receive window is set to no-zero value from zero.
 +
 +
 +Delayed ACK
- =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 +The TCP Delayed ACK is a technique which is used for reducing the
 +packet count in the network. For more details, please refer the
 +`Delayed ACK wiki`_
 +
 +.. _Delayed ACK wiki: https://en.wikipedia.org/wiki/TCP_delayed_acknowled=
gment
 +
 +* TcpExtDelayedACKs
 +A delayed ACK timer expires. The TCP stack will send a pure ACK packet
 +and exit the delayed ACK mode.
 +
 +* TcpExtDelayedACKLocked
 +A delayed ACK timer expires, but the TCP stack can't send an ACK
 +immediately due to the socket is locked by a userspace program. The
 +TCP stack will send a pure ACK later (after the userspace program
 +unlock the socket). When the TCP stack sends the pure ACK later, the
 +TCP stack will also update TcpExtDelayedACKs and exit the delayed ACK
 +mode.
 +
 +* TcpExtDelayedACKLost
 +It will be updated when the TCP stack receives a packet which has been
 +ACKed. A Delayed ACK loss might cause this issue, but it would also be
 +triggered by other reasons, such as a packet is duplicated in the
 +network.
 +
 +Tail Loss Probe (TLP)
- =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 +TLP is an algorithm which is used to detect TCP packet loss. For more
 +details, please refer the `TLP paper`_.
 +
 +.. _TLP paper: https://tools.ietf.org/html/draft-dukkipati-tcpm-tcp-loss-=
probe-01
 +
 +* TcpExtTCPLossProbes
 +A TLP probe packet is sent.
 +
 +* TcpExtTCPLossProbeRecovery
 +A packet loss is detected and recovered by TLP.
 =20
  examples
- =3D=3D=3D=3D=3D=3D=3D
+ =3D=3D=3D=3D=3D=3D=3D=3D
 =20
  ping test
- --------
+ ---------
  Run the ping command against the public dns server 8.8.8.8::
 =20
    nstatuser@nstat-a:~$ ping 8.8.8.8 -c 1

--Sig_/Ztw5Y5ttJV6y=_wwZ/jROak
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw/2fEACgkQAVBC80lX
0Gx1NAf7BICTYblB81TceB4noKjd8xfczJYlsSZnOhEf3Nb5v2OJeAbAugAG1naR
EfNTlL5P9niY9Pg959WQY9YNXIe+WCAeWAKHq9KEe6Sc/6B+7M4FN8H3jic45ITG
HARF+yP6Mu4a5YErMdokw84XZ3d82rFGdBcnvkq8EMruNALecBtJuLepYXaPqh7s
8Db6lL9XCd7WLZlks0pIil7Lci8SkRVOkzNcfqu3zw4ysT8gyl6dTAfVRJFFK9Wl
ktSh5jJCk61j1Z0ehMhy+TEnK1NgKFFdOnMax1k4eyHp8kIHpVa/2ierbGUCo80H
DXfjCeyZ5h2xygc5ZvE3IdFAcdwDZQ==
=DAUr
-----END PGP SIGNATURE-----

--Sig_/Ztw5Y5ttJV6y=_wwZ/jROak--
