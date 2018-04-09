Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523239326-2-10959433587176160271
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523239325; b=lStDUngtvxahobO14ZWlvZ9rh5VvmM9vg1CAwaPoXohl6B24VZ
    GZXf56hunQeuXAQByWY4tmmjFpYtge+p26F3MSNY7fAsbBtEwyYulGmGj+UP6tTY
    zPg8D806d51Q8V2bDF8d9jxReEJX1pCQvijnNNpqwhBS0XjeYnCIP4Ela1qa4/i5
    LTr0HtAeHrKjmhtwoSdojSvkwNIh/4XUfi8ki0fqnD8lzPAMHYkeV5ObJ4KYZzYu
    /bDsvK6NoHjedI5llfbZnZ/yKopwvlYq80p7tDpn3VsPyaTnQJRqaSdCNRRekPhp
    ngUPecWngKj7pzfgtkB4U18zOWdomA3dIXdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239325; bh=3pT+yLVSQR
    SrrHhHWd0KcabLHfgIsxHV1ndtmS1C31M=; b=pNIwiytnzfLPkcklINsTBJvtyq
    zhnc9IORCiInxdKBHTOmIY6xWhgaO7uLy3ua62r3TUcom0TfhxlwGDx+YelWHvBs
    MNS4XJSBZ3QaOQenfvmMHAl4H4ik8OEcC6crt/Y6terr0BgSUyAEM7oc4IMztTUP
    ++s/wP1QoYzSp1SVZ5H5+rcrq2vZDsCz1k1iHHcVpe5q4mLQRm8F3Xm8h+HIZsic
    4+ycueZNL8Pr2RMK5UBplp4Dot5w8iCQw0G2gT74RS3v1VwQS4Od0XdfqjCnN/aX
    PTYC/IqsmeWaMaiNitdJMU2xjgGU2RI1kRi2HChtsU+FSJgshYlUuckkAQGw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=maOIk32V x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=maOIk32V x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDXkNRXhS53aFLHGVYXGFHRSmHQHI6XT54DpGjWUIhCcvFWUtxsBmWFEg7MhWZTPpQDK5X5JELx3Q6slM0bOt4G9l8FuqbJ3d25r4ggb+ee7XfZfjKRI
    zdo787z9r9QI10LhXoVLQzgRt4XPktW2pWmRyckK+C3MEPY1a/YD3OO3mVRhYIgdnzYV0kA3jk1ucZm9Kcvva8egX/7h/XuiZY1EAH6RAQfDBQC0UclgaY8C
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=mpaa-ttXAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=QER8AZv0ysrd_nsxg4cA:9 a=i9puoj4HavGUnEGk:21 a=lKBKt6IsNm4Tedw7:21
    a=wPNLvfGTeEIA:10 a=6heAxKwa5pAsJatQ0mat:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757626AbeDICBn (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:01:43 -0400
Received: from mail-sn1nam01on0103.outbound.protection.outlook.com ([104.47.32.103]:45281
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756455AbeDIAcN (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:13 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Sean Wang <sean.wang@mediatek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 201/293] net: ethernet: mediatek: fixed
 deadlock captured by lockdep
Thread-Topic: [PATCH AUTOSEL for 4.9 201/293] net: ethernet: mediatek: fixed
 deadlock captured by lockdep
Thread-Index: AQHTz5lErdtSKt2nF06XNNtp3Z4q+A==
Date: Mon, 9 Apr 2018 00:25:31 +0000
Message-ID: <20180409002239.163177-201-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:gVJkjmj1mhMnwqm0YsX8aUQcEEc2Fg0APD2+oHnGx05i0uaEvfFMJN9zD+JKYEOEFKRy2i807ZNV79i3vw9oF3YCAAGDtVey4Y9/NSPFuT+cjATUfM7XORVwmeo4TG7b2JCWawJbrozNlnmd3biOAypcr3T7mAcrVxN6FaDHV09Fn9nILexOuWNOkWL9KO/oD+c/IvBT8HgEDuKtvRCr0SMU2zjn0uKmJgGNqiOqn6QPLj+mOEg6QU+rmGlsV+kA;20:Q5YvdO3tS7sx9iZUH8nwIiSIR0ioGSOVe8Gp26tqlpb9PGTQEeCQfKu7xixf/4d3dAGX3wwAnD+SXe4XDwLvjYa3vbPv3wsAW4SwnTxjU6Y5O6OPKKBFe7OawkfyAb6fuSvqJssoH4fgTVUgxqmTN25HTLsZeBYZm9xWHRKbqmM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: e6d6c820-8152-4a5e-8db1-08d59db15398
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0870015B16CB1744B4327901FBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(39860400002)(366004)(396003)(39380400002)(376002)(199004)(189003)(53936002)(2906002)(6512007)(102836004)(2616005)(76176011)(14454004)(446003)(10090500001)(11346002)(476003)(486006)(107886003)(59450400001)(2900100001)(97736004)(66066001)(6506007)(6436002)(106356001)(99286004)(105586002)(3660700001)(6116002)(86612001)(3280700002)(6666003)(2501003)(10290500003)(26005)(8676002)(8936002)(478600001)(68736007)(5250100002)(5660300001)(316002)(4326008)(72206003)(186003)(110136005)(6486002)(7736002)(25786009)(3846002)(86362001)(36756003)(22452003)(81156014)(81166006)(305945005)(54906003)(1076002)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: W5j32HTcIzfSCVM1BGDvemKUPfZR8PSlBtwkiSrMqU3tjZOyByX9Dd4WKnvQ4QG1ys2lIlMmLIfG6CKz4gHN+hu37aGKHGvc8JYFWRLu46VmLcTAScOoxPb4AK1v1QwSRrWRhr/4I8+VDjnK8iVaf0Bk2coIg1xPDxNgkWAvuCmAe6aK4jdfUNDw458ykVGYNFTUws9ujhjBIfFYTOPLhq+AAPvadDub93OXBWWVh3E881ByNFyyymBWLqTdbrEJAZd9vkK+wta3cjg3NxSKNxo4NBsCMk3Z8Tl/V3PSog2Nhirx6MFknBHKlOmAh+wPzjAtH2rVcXV7mQhSLuTriTmRLWKAxEMCgwU7Og9ie5nHkvw/k9zWnxAYnp8CwrxcZ46oX+kWaNE+cAeQgSq31lXGtFohV+yQ/KgIOzhWKC0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d6c820-8152-4a5e-8db1-08d59db15398
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:31.1440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sean Wang <sean.wang@mediatek.com>

[ Upstream commit 8d32e0624392bb4abfbe122f754757a4cb326d7f ]

Lockdep found an inconsistent lock state when mtk_get_stats64 is called
in user context while NAPI updates MAC statistics in softirq.

Use spin_trylock_bh/spin_unlock_bh fix following lockdep warning.

[   81.321030] WARNING: inconsistent lock state
[   81.325266] 4.12.0-rc1-00035-gd9dda65 #32 Not tainted
[   81.330273] --------------------------------
[   81.334505] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
[   81.340464] ksoftirqd/0/7 [HC0[0]:SC1[1]:HE1:SE0] takes:
[   81.345731]  (&syncp->seq#2){+.?...}, at: [<c054ba3c>] mtk_handle_status=
_irq.part.6+0x70/0x84
[   81.354219] {SOFTIRQ-ON-W} state was registered at:
[   81.359062]   lock_acquire+0xfc/0x2b0
[   81.362696]   mtk_stats_update_mac+0x60/0x2c0
[   81.367017]   mtk_get_stats64+0x17c/0x18c
[   81.370995]   dev_get_stats+0x48/0xbc
[   81.374628]   rtnl_fill_stats+0x48/0x128
[   81.378520]   rtnl_fill_ifinfo+0x4ac/0xd1c
[   81.382584]   rtmsg_ifinfo_build_skb+0x7c/0xe0
[   81.386991]   rtmsg_ifinfo.part.5+0x24/0x54
[   81.391139]   rtmsg_ifinfo+0x24/0x28
[   81.394685]   __dev_notify_flags+0xa4/0xac
[   81.398749]   dev_change_flags+0x50/0x58
[   81.402640]   devinet_ioctl+0x768/0x85c
[   81.406444]   inet_ioctl+0x1a4/0x1d0
[   81.409990]   sock_ioctl+0x16c/0x33c
[   81.413538]   do_vfs_ioctl+0xb4/0xa34
[   81.417169]   SyS_ioctl+0x44/0x6c
[   81.420458]   ret_fast_syscall+0x0/0x1c
[   81.424260] irq event stamp: 3354692
[   81.427806] hardirqs last  enabled at (3354692): [<c0678168>] net_rx_act=
ion+0xc0/0x504
[   81.435660] hardirqs last disabled at (3354691): [<c0678134>] net_rx_act=
ion+0x8c/0x504
[   81.443515] softirqs last  enabled at (3354106): [<c0101944>] __do_softi=
rq+0x4b4/0x614
[   81.451370] softirqs last disabled at (3354109): [<c012f0c4>] run_ksofti=
rqd+0x44/0x80
[   81.459134]
[   81.459134] other info that might help us debug this:
[   81.465608]  Possible unsafe locking scenario:
[   81.465608]
[   81.471478]        CPU0
[   81.473900]        ----
[   81.476321]   lock(&syncp->seq#2);
[   81.479701]   <Interrupt>
[   81.482294]     lock(&syncp->seq#2);
[   81.485847]
[   81.485847]  *** DEADLOCK ***
[   81.485847]
[   81.491720] 1 lock held by ksoftirqd/0/7:
[   81.495693]  #0:  (&(&mac->hw_stats->stats_lock)->rlock){+.+...}, at: [<=
c054ba14>] mtk_handle_status_irq.part.6+0x48/0x84
[   81.506579]
[   81.506579] stack backtrace:
[   81.510904] CPU: 0 PID: 7 Comm: ksoftirqd/0 Not tainted 4.12.0-rc1-00035=
-gd9dda65 #32
[   81.518668] Hardware name: Mediatek Cortex-A7 (Device Tree)
[   81.524208] [<c0113dc4>] (unwind_backtrace) from [<c010e3f0>] (show_stac=
k+0x20/0x24)
[   81.531899] [<c010e3f0>] (show_stack) from [<c03f9c64>] (dump_stack+0xb4=
/0xe0)
[   81.539072] [<c03f9c64>] (dump_stack) from [<c017e970>] (print_usage_bug=
+0x234/0x2e0)
[   81.546846] [<c017e970>] (print_usage_bug) from [<c017f058>] (mark_lock+=
0x63c/0x7bc)
[   81.554532] [<c017f058>] (mark_lock) from [<c017fe90>] (__lock_acquire+0=
x654/0x1bfc)
[   81.562217] [<c017fe90>] (__lock_acquire) from [<c0181d04>] (lock_acquir=
e+0xfc/0x2b0)
[   81.569990] [<c0181d04>] (lock_acquire) from [<c054b76c>] (mtk_stats_upd=
ate_mac+0x60/0x2c0)
[   81.578283] [<c054b76c>] (mtk_stats_update_mac) from [<c054ba3c>] (mtk_h=
andle_status_irq.part.6+0x70/0x84)
[   81.587865] [<c054ba3c>] (mtk_handle_status_irq.part.6) from [<c054c2b8>=
] (mtk_napi_tx+0x358/0x37c)
[   81.596845] [<c054c2b8>] (mtk_napi_tx) from [<c06782ec>] (net_rx_action+=
0x244/0x504)
[   81.604533] [<c06782ec>] (net_rx_action) from [<c01015c4>] (__do_softirq=
+0x134/0x614)
[   81.612306] [<c01015c4>] (__do_softirq) from [<c012f0c4>] (run_ksoftirqd=
+0x44/0x80)
[   81.619907] [<c012f0c4>] (run_ksoftirqd) from [<c0154680>] (smpboot_thre=
ad_fn+0x14c/0x25c)
[   81.628110] [<c0154680>] (smpboot_thread_fn) from [<c014f8cc>] (kthread+=
0x150/0x180)
[   81.635798] [<c014f8cc>] (kthread) from [<c0109290>] (ret_from_fork+0x14=
/0x24)

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethe=
rnet/mediatek/mtk_eth_soc.c
index 20de37a414fe..d76f65f9d8dd 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -470,9 +470,9 @@ static struct rtnl_link_stats64 *mtk_get_stats64(struct=
 net_device *dev,
 	unsigned int start;
=20
 	if (netif_running(dev) && netif_device_present(dev)) {
-		if (spin_trylock(&hw_stats->stats_lock)) {
+		if (spin_trylock_bh(&hw_stats->stats_lock)) {
 			mtk_stats_update_mac(mac);
-			spin_unlock(&hw_stats->stats_lock);
+			spin_unlock_bh(&hw_stats->stats_lock);
 		}
 	}
=20
@@ -2151,9 +2151,9 @@ static void mtk_get_ethtool_stats(struct net_device *=
dev,
 		return;
=20
 	if (netif_running(dev) && netif_device_present(dev)) {
-		if (spin_trylock(&hwstats->stats_lock)) {
+		if (spin_trylock_bh(&hwstats->stats_lock)) {
 			mtk_stats_update_mac(mac);
-			spin_unlock(&hwstats->stats_lock);
+			spin_unlock_bh(&hwstats->stats_lock);
 		}
 	}
=20
--=20
2.15.1
