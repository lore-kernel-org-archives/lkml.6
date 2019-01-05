Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136E6C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 23:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB184222BB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 23:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfAEX3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 18:29:09 -0500
Received: from wes1-so1-b.wedos.net ([46.28.106.43]:51535 "EHLO
        wes1-so1.wedos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726364AbfAEX3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 18:29:09 -0500
Received: from localhost (ip4-46-39-182-135.cust.nbox.cz [46.39.182.135])
        by wes1-so1.wedos.net (Postfix) with ESMTPSA id 43XHss1pWhzYk;
        Sun,  6 Jan 2019 00:29:05 +0100 (CET)
Date:   Sun, 6 Jan 2019 00:28:59 +0100
From:   Otto Sabart <ottosabart@seberm.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] doc: networking: prepare offload documents for
 conversion into RST
Message-ID: <e993b00cd16b724973afba4790a6c17739365c2d.1546730285.git.ottosabart@seberm.com>
References: <cover.1546730285.git.ottosabart@seberm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <cover.1546730285.git.ottosabart@seberm.com>
X-PGP-Key: http://seberm.com/pubkey.asc
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add small number of markups which are sufficient for conversion
into reStructuredText.

Unfortunately there was necessary to restructure all sections
in checksum-offloads.txt file and create paragraphs separated
by newline. There also must not be a space at the
beginning of paragpraph.

There are no semantic changes.

Signed-off-by: Otto Sabart <ottosabart@seberm.com>
---
 .../networking/checksum-offloads.txt          | 179 ++++++++++--------
 .../networking/segmentation-offloads.txt      |  46 +++--
 2 files changed, 130 insertions(+), 95 deletions(-)

diff --git a/Documentation/networking/checksum-offloads.txt b/Documentation=
/networking/checksum-offloads.txt
index 27bc09cfcf6d..1a1cd94a3f6d 100644
--- a/Documentation/networking/checksum-offloads.txt
+++ b/Documentation/networking/checksum-offloads.txt
@@ -1,122 +1,143 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 Checksum Offloads in the Linux Networking Stack
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
=20
 Introduction
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-This document describes a set of techniques in the Linux networking stack
- to take advantage of checksum offload capabilities of various NICs.
+This document describes a set of techniques in the Linux networking stack =
to
+take advantage of checksum offload capabilities of various NICs.
=20
 The following technologies are described:
- * TX Checksum Offload
- * LCO: Local Checksum Offload
- * RCO: Remote Checksum Offload
+
+* TX Checksum Offload
+* LCO: Local Checksum Offload
+* RCO: Remote Checksum Offload
=20
 Things that should be documented here but aren't yet:
- * RX Checksum Offload
- * CHECKSUM_UNNECESSARY conversion
+
+* RX Checksum Offload
+* CHECKSUM_UNNECESSARY conversion
=20
=20
 TX Checksum Offload
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-The interface for offloading a transmit checksum to a device is explained
- in detail in comments near the top of include/linux/skbuff.h.
+The interface for offloading a transmit checksum to a device is explained =
in
+detail in comments near the top of include/linux/skbuff.h.
+
 In brief, it allows to request the device fill in a single ones-complement
- checksum defined by the sk_buff fields skb->csum_start and
- skb->csum_offset.  The device should compute the 16-bit ones-complement
- checksum (i.e. the 'IP-style' checksum) from csum_start to the end of the
- packet, and fill in the result at (csum_start + csum_offset).
-Because csum_offset cannot be negative, this ensures that the previous
- value of the checksum field is included in the checksum computation, thus
- it can be used to supply any needed corrections to the checksum (such as
- the sum of the pseudo-header for UDP or TCP).
+checksum defined by the sk_buff fields skb->csum_start and skb->csum_offse=
t.
+The device should compute the 16-bit ones-complement checksum (i.e. the
+'IP-style' checksum) from csum_start to the end of the packet, and fill in=
 the
+result at (csum_start + csum_offset).
+
+Because csum_offset cannot be negative, this ensures that the previous val=
ue of
+the checksum field is included in the checksum computation, thus it can be=
 used
+to supply any needed corrections to the checksum (such as the sum of the
+pseudo-header for UDP or TCP).
+
 This interface only allows a single checksum to be offloaded.  Where
- encapsulation is used, the packet may have multiple checksum fields in
- different header layers, and the rest will have to be handled by another
- mechanism such as LCO or RCO.
+encapsulation is used, the packet may have multiple checksum fields in
+different header layers, and the rest will have to be handled by another
+mechanism such as LCO or RCO.
+
 CRC32c can also be offloaded using this interface, by means of filling
- skb->csum_start and skb->csum_offset as described above, and setting
- skb->csum_not_inet: see skbuff.h comment (section 'D') for more details.
+skb->csum_start and skb->csum_offset as described above, and setting
+skb->csum_not_inet: see skbuff.h comment (section 'D') for more details.
+
 No offloading of the IP header checksum is performed; it is always done in
- software.  This is OK because when we build the IP header, we obviously
- have it in cache, so summing it isn't expensive.  It's also rather short.
+software.  This is OK because when we build the IP header, we obviously ha=
ve it
+in cache, so summing it isn't expensive.  It's also rather short.
+
 The requirements for GSO are more complicated, because when segmenting an
- encapsulated packet both the inner and outer checksums may need to be
- edited or recomputed for each resulting segment.  See the skbuff.h comment
- (section 'E') for more details.
+encapsulated packet both the inner and outer checksums may need to be edit=
ed or
+recomputed for each resulting segment.  See the skbuff.h comment (section =
'E')
+for more details.
=20
 A driver declares its offload capabilities in netdev->hw_features; see
- Documentation/networking/netdev-features.txt for more.  Note that a device
- which only advertises NETIF_F_IP[V6]_CSUM must still obey the csum_start
- and csum_offset given in the SKB; if it tries to deduce these itself in
- hardware (as some NICs do) the driver should check that the values in the
- SKB match those which the hardware will deduce, and if not, fall back to
- checksumming in software instead (with skb_csum_hwoffload_help() or one of
- the skb_checksum_help() / skb_crc32c_csum_help functions, as mentioned in
- include/linux/skbuff.h).
-
-The stack should, for the most part, assume that checksum offload is
- supported by the underlying device.  The only place that should check is
- validate_xmit_skb(), and the functions it calls directly or indirectly.
- That function compares the offload features requested by the SKB (which
- may include other offloads besides TX Checksum Offload) and, if they are
- not supported or enabled on the device (determined by netdev->features),
- performs the corresponding offload in software.  In the case of TX
- Checksum Offload, that means calling skb_csum_hwoffload_help(skb, feature=
s).
+Documentation/networking/netdev-features.txt for more.  Note that a device
+which only advertises NETIF_F_IP[V6]_CSUM must still obey the csum_start a=
nd
+csum_offset given in the SKB; if it tries to deduce these itself in hardwa=
re
+(as some NICs do) the driver should check that the values in the SKB match
+those which the hardware will deduce, and if not, fall back to checksummin=
g in
+software instead (with skb_csum_hwoffload_help() or one of the
+skb_checksum_help() / skb_crc32c_csum_help functions, as mentioned in
+include/linux/skbuff.h).
+
+The stack should, for the most part, assume that checksum offload is suppo=
rted
+by the underlying device.  The only place that should check is
+validate_xmit_skb(), and the functions it calls directly or indirectly.  T=
hat
+function compares the offload features requested by the SKB (which may inc=
lude
+other offloads besides TX Checksum Offload) and, if they are not supported=
 or
+enabled on the device (determined by netdev->features), performs the
+corresponding offload in software.  In the case of TX Checksum Offload, th=
at
+means calling skb_csum_hwoffload_help(skb, features).
=20
=20
 LCO: Local Checksum Offload
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
=20
 LCO is a technique for efficiently computing the outer checksum of an
- encapsulated datagram when the inner checksum is due to be offloaded.
-The ones-complement sum of a correctly checksummed TCP or UDP packet is
- equal to the complement of the sum of the pseudo header, because everythi=
ng
- else gets 'cancelled out' by the checksum field.  This is because the sum=
 was
- complemented before being written to the checksum field.
+encapsulated datagram when the inner checksum is due to be offloaded.
+
+The ones-complement sum of a correctly checksummed TCP or UDP packet is eq=
ual
+to the complement of the sum of the pseudo header, because everything else=
 gets
+'cancelled out' by the checksum field.  This is because the sum was
+complemented before being written to the checksum field.
+
 More generally, this holds in any case where the 'IP-style' ones complement
- checksum is used, and thus any checksum that TX Checksum Offload supports.
+checksum is used, and thus any checksum that TX Checksum Offload supports.
+
 That is, if we have set up TX Checksum Offload with a start/offset pair, we
- know that after the device has filled in that checksum, the ones
- complement sum from csum_start to the end of the packet will be equal to
- the complement of whatever value we put in the checksum field beforehand.
- This allows us to compute the outer checksum without looking at the paylo=
ad:
- we simply stop summing when we get to csum_start, then add the complement=
 of
- the 16-bit word at (csum_start + csum_offset).
+know that after the device has filled in that checksum, the ones complemen=
t sum
+from csum_start to the end of the packet will be equal to the complement of
+whatever value we put in the checksum field beforehand.  This allows us to
+compute the outer checksum without looking at the payload: we simply stop
+summing when we get to csum_start, then add the complement of the 16-bit w=
ord
+at (csum_start + csum_offset).
+
 Then, when the true inner checksum is filled in (either by hardware or by
- skb_checksum_help()), the outer checksum will become correct by virtue of
- the arithmetic.
+skb_checksum_help()), the outer checksum will become correct by virtue of =
the
+arithmetic.
=20
 LCO is performed by the stack when constructing an outer UDP header for an
- encapsulation such as VXLAN or GENEVE, in udp_set_csum().  Similarly for
- the IPv6 equivalents, in udp6_set_csum().
+encapsulation such as VXLAN or GENEVE, in udp_set_csum().  Similarly for t=
he
+IPv6 equivalents, in udp6_set_csum().
+
 It is also performed when constructing an IPv4 GRE header, in
- net/ipv4/ip_gre.c:build_header().  It is *not* currently performed when
- constructing an IPv6 GRE header; the GRE checksum is computed over the
- whole packet in net/ipv6/ip6_gre.c:ip6gre_xmit2(), but it should be
- possible to use LCO here as IPv6 GRE still uses an IP-style checksum.
+net/ipv4/ip_gre.c:build_header().  It is *not* currently performed when
+constructing an IPv6 GRE header; the GRE checksum is computed over the who=
le
+packet in net/ipv6/ip6_gre.c:ip6gre_xmit2(), but it should be possible to =
use
+LCO here as IPv6 GRE still uses an IP-style checksum.
+
 All of the LCO implementations use a helper function lco_csum(), in
- include/linux/skbuff.h.
+include/linux/skbuff.h.
=20
 LCO can safely be used for nested encapsulations; in this case, the outer
- encapsulation layer will sum over both its own header and the 'middle'
- header.  This does mean that the 'middle' header will get summed multiple
- times, but there doesn't seem to be a way to avoid that without incurring
- bigger costs (e.g. in SKB bloat).
+encapsulation layer will sum over both its own header and the 'middle' hea=
der.
+This does mean that the 'middle' header will get summed multiple times, but
+there doesn't seem to be a way to avoid that without incurring bigger costs
+(e.g. in SKB bloat).
=20
=20
 RCO: Remote Checksum Offload
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
=20
-RCO is a technique for eliding the inner checksum of an encapsulated
- datagram, allowing the outer checksum to be offloaded.  It does, however,
- involve a change to the encapsulation protocols, which the receiver must
- also support.  For this reason, it is disabled by default.
+RCO is a technique for eliding the inner checksum of an encapsulated datag=
ram,
+allowing the outer checksum to be offloaded.  It does, however, involve a
+change to the encapsulation protocols, which the receiver must also suppor=
t.
+For this reason, it is disabled by default.
+
 RCO is detailed in the following Internet-Drafts:
-https://tools.ietf.org/html/draft-herbert-remotecsumoffload-00
-https://tools.ietf.org/html/draft-herbert-vxlan-rco-00
-In Linux, RCO is implemented individually in each encapsulation protocol,
- and most tunnel types have flags controlling its use.  For instance, VXLAN
- has the flag VXLAN_F_REMCSUM_TX (per struct vxlan_rdst) to indicate that
- RCO should be used when transmitting to a given remote destination.
+
+* https://tools.ietf.org/html/draft-herbert-remotecsumoffload-00
+* https://tools.ietf.org/html/draft-herbert-vxlan-rco-00
+
+In Linux, RCO is implemented individually in each encapsulation protocol, =
and
+most tunnel types have flags controlling its use.  For instance, VXLAN has=
 the
+flag VXLAN_F_REMCSUM_TX (per struct vxlan_rdst) to indicate that RCO shoul=
d be
+used when transmitting to a given remote destination.
diff --git a/Documentation/networking/segmentation-offloads.txt b/Documenta=
tion/networking/segmentation-offloads.txt
index aca542ec125c..1794bfe98196 100644
--- a/Documentation/networking/segmentation-offloads.txt
+++ b/Documentation/networking/segmentation-offloads.txt
@@ -1,4 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
 Segmentation Offloads in the Linux Networking Stack
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
+
=20
 Introduction
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -15,6 +20,7 @@ The following technologies are described:
  * Partial Generic Segmentation Offload - GSO_PARTIAL
  * SCTP accelleration with GSO - GSO_BY_FRAGS
=20
+
 TCP Segmentation Offload
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
@@ -42,6 +48,7 @@ NETIF_F_TSO_MANGLEID set then the IP ID can be ignored wh=
en performing TSO
 and we will either increment the IP ID for all frames, or leave it at a
 static value based on driver preference.
=20
+
 UDP Fragmentation Offload
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
@@ -54,6 +61,7 @@ UFO is deprecated: modern kernels will no longer generate=
 UFO skbs, but can
 still receive them from tuntap and similar devices. Offload of UDP-based
 tunnel protocols is still supported.
=20
+
 IPIP, SIT, GRE, UDP Tunnel, and Remote Checksum Offloads
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
=20
@@ -71,17 +79,19 @@ refer to the tunnel headers as the outer headers, while=
 the encapsulated
 data is normally referred to as the inner headers.  Below is the list of
 calls to access the given headers:
=20
-IPIP/SIT Tunnel:
-		Outer			Inner
-MAC		skb_mac_header
-Network		skb_network_header	skb_inner_network_header
-Transport	skb_transport_header
+IPIP/SIT Tunnel::
+
+             Outer                  Inner
+  MAC        skb_mac_header
+  Network    skb_network_header     skb_inner_network_header
+  Transport  skb_transport_header
=20
-UDP/GRE Tunnel:
-		Outer			Inner
-MAC		skb_mac_header		skb_inner_mac_header
-Network		skb_network_header	skb_inner_network_header
-Transport	skb_transport_header	skb_inner_transport_header
+UDP/GRE Tunnel::
+
+             Outer                  Inner
+  MAC        skb_mac_header         skb_inner_mac_header
+  Network    skb_network_header     skb_inner_network_header
+  Transport  skb_transport_header   skb_inner_transport_header
=20
 In addition to the above tunnel types there are also SKB_GSO_GRE_CSUM and
 SKB_GSO_UDP_TUNNEL_CSUM.  These two additional tunnel types reflect the
@@ -93,6 +103,7 @@ header has requested a remote checksum offload.  In this=
 case the inner
 headers will be left with a partial checksum and only the outer header
 checksum will be computed.
=20
+
 Generic Segmentation Offload
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
=20
@@ -106,6 +117,7 @@ Before enabling any hardware segmentation offload a cor=
responding software
 offload is required in GSO.  Otherwise it becomes possible for a frame to
 be re-routed between devices and end up being unable to be transmitted.
=20
+
 Generic Receive Offload
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
@@ -117,6 +129,7 @@ this is IPv4 ID in the case that the DF bit is set for =
a given IP header.
 If the value of the IPv4 ID is not sequentially incrementing it will be
 altered so that it is when a frame assembled via GRO is segmented via GSO.
=20
+
 Partial Generic Segmentation Offload
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
@@ -134,6 +147,7 @@ is the outer IPv4 ID field.  It is up to the device dri=
vers to guarantee
 that the IPv4 ID field is incremented in the case that a given header does
 not have the DF bit set.
=20
+
 SCTP accelleration with GSO
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
=20
@@ -157,14 +171,14 @@ appropriately.
=20
 There are some helpers to make this easier:
=20
- - skb_is_gso(skb) && skb_is_gso_sctp(skb) is the best way to see if
-   an skb is an SCTP GSO skb.
+- skb_is_gso(skb) && skb_is_gso_sctp(skb) is the best way to see if
+  an skb is an SCTP GSO skb.
=20
- - For size checks, the skb_gso_validate_*_len family of helpers correctly
-   considers GSO_BY_FRAGS.
+- For size checks, the skb_gso_validate_*_len family of helpers correctly
+  considers GSO_BY_FRAGS.
=20
- - For manipulating packets, skb_increase_gso_size and skb_decrease_gso_si=
ze
-   will check for GSO_BY_FRAGS and WARN if asked to manipulate these skbs.
+- For manipulating packets, skb_increase_gso_size and skb_decrease_gso_size
+  will check for GSO_BY_FRAGS and WARN if asked to manipulate these skbs.
=20
 This also affects drivers with the NETIF_F_FRAGLIST & NETIF_F_GSO_SCTP bits
 set. Note also that NETIF_F_GSO_SCTP is included in NETIF_F_GSO_SOFTWARE.
--=20
2.17.2


--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEb6VOpv2s03VHGoilgjuumfi+HjwFAlwxPbsACgkQgjuumfi+
HjyCcA/9EJ8vwLiukMuR2nfDaR3L0l2HeoO4oss9w8FlW8LM6v+So+vP3x9qdG+x
Sra11f1RjVU/EifW7bxsVMSfj3MBm31dYP6U9mhSU5MvdkSLOrcnjoJ1GsxQaVwe
CGqex7mHb8kqrDASZ4X4xPlXOTUeugABL6uANrZtigY8fq55Q/87RFp5/gK+Qzjg
voj6wElPMSFg1obCXldsXl51WCvLQslZFbcnhPuAudtuXn+fvgP9vIChm+mHvqPW
v93Qtbtlb+x2vkMdcHtTQWlQs/fy6YWW61zcgLWTxRtdiNLRKh0OtCgz/HyReHZT
uZGXgMUE4EZxTS8ZSWIo1R6EX74bhL9dW5D5NzFufue2yj4QLaR6VvqViiOmZSmJ
iU6T+OnjcuEj78JMSrRTdbs2cnPsNn66XhWv8fgD6t0TFORYFaRvAfTsDJ1FVS5S
/RJbtQBpbXCrATa55MscSF1NdqjBV0vQR3MfUMyszeqOQXgY8y5KxcN5k9d0lFog
+sEopYJmZ6NcOwbdwXkRMBaN+ql4l1eplQtgUvqulmygllbNrfWCGsf4HaT1zPt/
yyByB1jG3ax8kAg2y5+xAChFfL3fOO9ZTZiZ9CzxdJwSPmjlcx2OV88efHyDg6rf
gOVvmJQ+edYO0ZH7YtrQiGRCUgn/9Ee66RGJXfreKBD3wzizOKI=
=9rGp
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
