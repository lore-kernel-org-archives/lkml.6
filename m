Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB764C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E03B2177B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfAIT5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:57:31 -0500
Received: from wes1-so2-b.wedos.net ([46.28.106.45]:46699 "EHLO
        wes1-so2.wedos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728612AbfAIT52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:57:28 -0500
Received: from localhost (ip4-46-39-182-135.cust.nbox.cz [46.39.182.135])
        by wes1-so2.wedos.net (Postfix) with ESMTPSA id 43Zfzp0nHPzSp;
        Wed,  9 Jan 2019 20:57:26 +0100 (CET)
Date:   Wed, 9 Jan 2019 20:57:22 +0100
From:   Otto Sabart <ottosabart@seberm.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 1/3] doc: networking: prepare scaling document for conversion
 into RST
Message-ID: <9a37aecf3f7e5b0df579f4c72885b0716f5abd6c.1547063330.git.ottosabart@seberm.com>
References: <cover.1547063330.git.ottosabart@seberm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <cover.1547063330.git.ottosabart@seberm.com>
X-PGP-Key: http://seberm.com/pubkey.asc
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add markups which are necessary for successful conversion into
reStructuredText.

There are no semantic changes.

Signed-off-by: Otto Sabart <ottosabart@seberm.com>
---
 Documentation/networking/scaling.txt | 131 +++++++++++++++++----------
 1 file changed, 85 insertions(+), 46 deletions(-)

diff --git a/Documentation/networking/scaling.txt b/Documentation/networkin=
g/scaling.txt
index b7056a8a0540..0ce13ed103bd 100644
--- a/Documentation/networking/scaling.txt
+++ b/Documentation/networking/scaling.txt
@@ -1,4 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 Scaling in the Linux Networking Stack
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
=20
 Introduction
@@ -10,11 +14,11 @@ multi-processor systems.
=20
 The following technologies are described:
=20
-  RSS: Receive Side Scaling
-  RPS: Receive Packet Steering
-  RFS: Receive Flow Steering
-  Accelerated Receive Flow Steering
-  XPS: Transmit Packet Steering
+- RSS: Receive Side Scaling
+- RPS: Receive Packet Steering
+- RFS: Receive Flow Steering
+- Accelerated Receive Flow Steering
+- XPS: Transmit Packet Steering
=20
=20
 RSS: Receive Side Scaling
@@ -45,7 +49,9 @@ programmable filters. For example, webserver bound TCP po=
rt 80 packets
 can be directed to their own receive queue. Such =E2=80=9Cn-tuple=E2=80=9D=
 filters can
 be configured from ethtool (--config-ntuple).
=20
-=3D=3D=3D=3D RSS Configuration
+
+RSS Configuration
+`````````````````
=20
 The driver for a multi-queue capable NIC typically provides a kernel
 module parameter for specifying the number of hardware queues to
@@ -63,7 +69,9 @@ commands (--show-rxfh-indir and --set-rxfh-indir). Modify=
ing the
 indirection table could be done to give different queues different
 relative weights.
=20
-=3D=3D RSS IRQ Configuration
+
+RSS IRQ Configuration
+~~~~~~~~~~~~~~~~~~~~~
=20
 Each receive queue has a separate IRQ associated with it. The NIC triggers
 this to notify a CPU when new packets arrive on the given queue. The
@@ -77,7 +85,9 @@ affinity of each interrupt see Documentation/IRQ-affinity=
=2Etxt. Some systems
 will be running irqbalance, a daemon that dynamically optimizes IRQ
 assignments and as a result may override any manual settings.
=20
-=3D=3D Suggested Configuration
+
+Suggested Configuration
+~~~~~~~~~~~~~~~~~~~~~~~
=20
 RSS should be enabled when latency is a concern or whenever receive
 interrupt processing forms a bottleneck. Spreading load between CPUs
@@ -105,10 +115,12 @@ Whereas RSS selects the queue and hence CPU that will=
 run the hardware
 interrupt handler, RPS selects the CPU to perform protocol processing
 above the interrupt handler. This is accomplished by placing the packet
 on the desired CPU=E2=80=99s backlog queue and waking up the CPU for proce=
ssing.
-RPS has some advantages over RSS: 1) it can be used with any NIC,
-2) software filters can easily be added to hash over new protocols,
+RPS has some advantages over RSS:
+
+1) it can be used with any NIC
+2) software filters can easily be added to hash over new protocols
 3) it does not increase hardware device interrupt rate (although it does
-introduce inter-processor interrupts (IPIs)).
+   introduce inter-processor interrupts (IPIs))
=20
 RPS is called during bottom half of the receive interrupt handler, when
 a driver sends a packet up the network stack with netif_rx() or
@@ -135,21 +147,25 @@ packets have been queued to their backlog queue. The =
IPI wakes backlog
 processing on the remote CPU, and any queued packets are then processed
 up the networking stack.
=20
-=3D=3D=3D=3D RPS Configuration
+
+RPS Configuration
+`````````````````
=20
 RPS requires a kernel compiled with the CONFIG_RPS kconfig symbol (on
 by default for SMP). Even when compiled in, RPS remains disabled until
 explicitly configured. The list of CPUs to which RPS may forward traffic
-can be configured for each receive queue using a sysfs file entry:
+can be configured for each receive queue using a sysfs file entry::
=20
- /sys/class/net/<dev>/queues/rx-<n>/rps_cpus
+  /sys/class/net/<dev>/queues/rx-<n>/rps_cpus
=20
 This file implements a bitmap of CPUs. RPS is disabled when it is zero
 (the default), in which case packets are processed on the interrupting
 CPU. Documentation/IRQ-affinity.txt explains how CPUs are assigned to
 the bitmap.
=20
-=3D=3D Suggested Configuration
+
+Suggested Configuration
+~~~~~~~~~~~~~~~~~~~~~~~
=20
 For a single queue device, a typical RPS configuration would be to set
 the rps_cpus to the CPUs in the same memory domain of the interrupting
@@ -163,7 +179,9 @@ and unnecessary. If there are fewer hardware queues tha=
n CPUs, then
 RPS might be beneficial if the rps_cpus for each queue are the ones that
 share the same memory domain as the interrupting CPU for that queue.
=20
-=3D=3D=3D=3D RPS Flow Limit
+
+RPS Flow Limit
+``````````````
=20
 RPS scales kernel receive processing across CPUs without introducing
 reordering. The trade-off to sending all packets from the same flow
@@ -187,29 +205,33 @@ No packets are dropped when the input packet queue le=
ngth is below
 the threshold, so flow limit does not sever connections outright:
 even large flows maintain connectivity.
=20
-=3D=3D Interface
+
+Interface
+~~~~~~~~~
=20
 Flow limit is compiled in by default (CONFIG_NET_FLOW_LIMIT), but not
 turned on. It is implemented for each CPU independently (to avoid lock
 and cache contention) and toggled per CPU by setting the relevant bit
 in sysctl net.core.flow_limit_cpu_bitmap. It exposes the same CPU
-bitmap interface as rps_cpus (see above) when called from procfs:
+bitmap interface as rps_cpus (see above) when called from procfs::
=20
- /proc/sys/net/core/flow_limit_cpu_bitmap
+  /proc/sys/net/core/flow_limit_cpu_bitmap
=20
 Per-flow rate is calculated by hashing each packet into a hashtable
 bucket and incrementing a per-bucket counter. The hash function is
 the same that selects a CPU in RPS, but as the number of buckets can
 be much larger than the number of CPUs, flow limit has finer-grained
 identification of large flows and fewer false positives. The default
-table has 4096 buckets. This value can be modified through sysctl
+table has 4096 buckets. This value can be modified through sysctl::
=20
- net.core.flow_limit_table_len
+  net.core.flow_limit_table_len
=20
 The value is only consulted when a new table is allocated. Modifying
 it does not update active tables.
=20
-=3D=3D Suggested Configuration
+
+Suggested Configuration
+~~~~~~~~~~~~~~~~~~~~~~~
=20
 Flow limit is useful on systems with many concurrent connections,
 where a single connection taking up 50% of a CPU indicates a problem.
@@ -280,10 +302,10 @@ table), the packet is enqueued onto that CPU=E2=80=99=
s backlog. If they differ,
 the current CPU is updated to match the desired CPU if one of the
 following is true:
=20
-- The current CPU's queue head counter >=3D the recorded tail counter
-  value in rps_dev_flow[i]
-- The current CPU is unset (>=3D nr_cpu_ids)
-- The current CPU is offline
+  - The current CPU's queue head counter >=3D the recorded tail counter
+    value in rps_dev_flow[i]
+  - The current CPU is unset (>=3D nr_cpu_ids)
+  - The current CPU is offline
=20
 After this check, the packet is sent to the (possibly updated) current
 CPU. These rules aim to ensure that a flow only moves to a new CPU when
@@ -291,19 +313,23 @@ there are no packets outstanding on the old CPU, as t=
he outstanding
 packets could arrive later than those about to be processed on the new
 CPU.
=20
-=3D=3D=3D=3D RFS Configuration
+
+RFS Configuration
+`````````````````
=20
 RFS is only available if the kconfig symbol CONFIG_RPS is enabled (on
 by default for SMP). The functionality remains disabled until explicitly
-configured. The number of entries in the global flow table is set through:
+configured. The number of entries in the global flow table is set through::
+
+  /proc/sys/net/core/rps_sock_flow_entries
=20
- /proc/sys/net/core/rps_sock_flow_entries
+The number of entries in the per-queue flow table are set through::
=20
-The number of entries in the per-queue flow table are set through:
+  /sys/class/net/<dev>/queues/rx-<n>/rps_flow_cnt
=20
- /sys/class/net/<dev>/queues/rx-<n>/rps_flow_cnt
=20
-=3D=3D Suggested Configuration
+Suggested Configuration
+~~~~~~~~~~~~~~~~~~~~~~~
=20
 Both of these need to be set before RFS is enabled for a receive queue.
 Values for both are rounded up to the nearest power of two. The
@@ -347,7 +373,9 @@ functions in the cpu_rmap (=E2=80=9CCPU affinity revers=
e map=E2=80=9D) kernel library
 to populate the map. For each CPU, the corresponding queue in the map is
 set to be one whose processing CPU is closest in cache locality.
=20
-=3D=3D=3D=3D Accelerated RFS Configuration
+
+Accelerated RFS Configuration
+`````````````````````````````
=20
 Accelerated RFS is only available if the kernel is compiled with
 CONFIG_RFS_ACCEL and support is provided by the NIC device and driver.
@@ -356,11 +384,14 @@ of CPU to queues is automatically deduced from the IR=
Q affinities
 configured for each receive queue by the driver, so no additional
 configuration should be necessary.
=20
-=3D=3D Suggested Configuration
+
+Suggested Configuration
+~~~~~~~~~~~~~~~~~~~~~~~
=20
 This technique should be enabled whenever one wants to use RFS and the
 NIC supports hardware acceleration.
=20
+
 XPS: Transmit Packet Steering
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
=20
@@ -430,20 +461,25 @@ transport layer is responsible for setting ooo_okay a=
ppropriately. TCP,
 for instance, sets the flag when all data for a connection has been
 acknowledged.
=20
-=3D=3D=3D=3D XPS Configuration
+XPS Configuration
+`````````````````
=20
 XPS is only available if the kconfig symbol CONFIG_XPS is enabled (on by
 default for SMP). The functionality remains disabled until explicitly
 configured. To enable XPS, the bitmap of CPUs/receive-queues that may
 use a transmit queue is configured using the sysfs file entry:
=20
-For selection based on CPUs map:
-/sys/class/net/<dev>/queues/tx-<n>/xps_cpus
+For selection based on CPUs map::
+
+  /sys/class/net/<dev>/queues/tx-<n>/xps_cpus
+
+For selection based on receive-queues map::
+
+  /sys/class/net/<dev>/queues/tx-<n>/xps_rxqs
=20
-For selection based on receive-queues map:
-/sys/class/net/<dev>/queues/tx-<n>/xps_rxqs
=20
-=3D=3D Suggested Configuration
+Suggested Configuration
+~~~~~~~~~~~~~~~~~~~~~~~
=20
 For a network device with a single transmission queue, XPS configuration
 has no effect, since there is no choice in this case. In a multi-queue
@@ -460,16 +496,18 @@ explicitly configured mapping receive-queue(s) to tra=
nsmit queue(s). If the
 user configuration for receive-queue map does not apply, then the transmit
 queue is selected based on the CPUs map.
=20
-Per TX Queue rate limitation:
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+
+Per TX Queue rate limitation
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
=20
 These are rate-limitation mechanisms implemented by HW, where currently
-a max-rate attribute is supported, by setting a Mbps value to
+a max-rate attribute is supported, by setting a Mbps value to::
=20
-/sys/class/net/<dev>/queues/tx-<n>/tx_maxrate
+  /sys/class/net/<dev>/queues/tx-<n>/tx_maxrate
=20
 A value of zero means disabled, and this is the default.
=20
+
 Further Information
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 RPS and RFS were introduced in kernel 2.6.35. XPS was incorporated into
@@ -480,5 +518,6 @@ Accelerated RFS was introduced in 2.6.35. Original patc=
hes were
 submitted by Ben Hutchings (bwh@kernel.org)
=20
 Authors:
-Tom Herbert (therbert@google.com)
-Willem de Bruijn (willemb@google.com)
+
+- Tom Herbert (therbert@google.com)
+- Willem de Bruijn (willemb@google.com)
--=20
2.17.2


--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEb6VOpv2s03VHGoilgjuumfi+HjwFAlw2UiIACgkQgjuumfi+
Hjy+yg//YCCisKgd2r2xzUyAmFaArdlD4sculURwQbndyFdfEJqJlI2Nt2seV62X
REhgPiyJEHVR/sIDaM27Pm3WTH1Nu26YNyqQyT6z3w0tgLRS5+8TqfLCUr59B8IF
jBaYp2Pn9iQK1QGTqhFgk4OsJHvY9NA7TYKWDfTXTwLF7kG/AIkIBgJFqKfYcxjw
OdgbeLIWh7IALsnWETJCyOKbTmGs4MZHc4ju+tIvFP2QImbpIE+/Zu5LqrMOIUhB
VI+i6LHNHR4axeQZS/Mj9uo3+qwo74d3ewSm6F/obo+5EJ5mhT2gp6rRS64c66Gn
ogPO5Gj0pbURlgwIPEkek8+2oCVwfcud9Id6nj8w66Y6KF4+3ogwPMGC5Ri98uPI
UhBRQUAsKg6yrptwASyGOyHPZp6htIQPfzxbWO0GuUvLxv8IP7IXCGa6lNhw6QBL
2ta0G1qg6Sx94ZpfxUkHhM5bYfpKdhi8sZBVWWvLYyAj5cdDM6xMPEOtBHq6OeC3
pqHMsSFxvcPZFQRbKnkJ+rnhz9rmaQL01t5GTtfMjeZNcBXfGZUYkp3DwOmo5LYc
myGjUhjjt0A6VENYmjRMK3cqhBgSFeseKSKihi+SqOV+oF1G7IXlSQUKHQktnd69
GuitmL9Gj1Y21QqZyhruJu9nvhUmyY9MZk0ioTAC9rMqgmrCQrw=
=atPd
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
