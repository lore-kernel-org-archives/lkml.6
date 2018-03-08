Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520492155-2-14368314638369365275
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520492155; b=e/Gzf1Y+9UVEXhFV1FaceOxvEb/+1fsAZ9s0P8s9Ae6Hn6A
    NMb85tukmC3+SSmPaaCbXAmaB3oMNWcCBb5CHfmm6yWN9iz2x8stS3d7Hm1MSvIX
    2lpZCan9mh+MAEejpwsMsLcX0jJ3EfHxyyy1otkfWBvwuPtmKc1JkSBhx5/4rMrm
    M18aDIfmb5D6E7vjBp6nqaKANPcXeTdZcA6YTNH78Jdsy7iS41IojPgJUQGiU8YY
    4OSpXJ3Wt+WZnH0YBtDbQy9sB+p6wpZ5mdHRojb08vVGf0wV6mySfQ9ujedp0hjL
    KnZRyRYpYtrYkQDBJ/Z0zRZAbPDGeCJZsQfef2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492155; bh=vMrPe5
    FC1G6KZ++CM6ifRcj9v8mB/LmBE4oRcsEks5E=; b=ZEXPpvP5XxV6Rtjjvl4kpt
    BXuz0EZcj52v8t1QnhYeUGLYN9cUPEwNbd3uAIB91RPGzMn0IG8/0L4qPKSUKTVx
    Ie7b47TfPlj1gOMb1Elzo0iNqvcvoiSun4+1aiNxt/V6BVFFaZmZjVkDI9+Ctusy
    6Pio0LkPH/+H8e/ypePQsOWdVtdnboSsgs6bP2TnhMVYTGUCrY5ZfvaNZBqFg584
    ddlWjtBR3VjwxqSM43CECmrwL8wyBZmL2b60xnCIS4LjdniMGKDTScVEjDzmqZRV
    E572fqkoraGTz+sxWd6GlahnOP1K36QyodlocKsn47fMjTvlA6hJcZx2S4UFG+bw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Pn8YjPkP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Pn8YjPkP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965009AbeCHGzk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:55:40 -0500
Received: from mail-sn1nam02on0119.outbound.protection.outlook.com ([104.47.36.119]:48736
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935174AbeCHE6B (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:01 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 73/78] clk: Don't touch hardware when
 reparenting during registration
Thread-Topic: [PATCH AUTOSEL for 4.15 73/78] clk: Don't touch hardware when
 reparenting during registration
Thread-Index: AQHTtpnUzMIw9XDvFkKBFW1PjVhoEw==
Date: Thu, 8 Mar 2018 04:56:33 +0000
Message-ID: <20180308045525.7662-73-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:FZrkUe1HVJ1K03VN7RFkHAce3Z6hhsipYmpwpILJBtf3fWcD1lPvBmcaYrd2Dom+uZ3huqDGZ7xM1TM2mSHD+B/9nvTbw3ka5jKTT5WnPE7JtoBCsH3ohGC4jO1MqeUNv1mDLUys5wcEywmKAMOFQikubgYf2C57WwfzZmjkRXpnyjfhXkTzcqhmmnljFB7dulm+Thc5dxZEN2herhbS4wCmG6DpHKA7vuRkiffyXxKoxC7ubAb3UDh9pUpbwrLy;20:XdAoj7cUPENJ4u42WF59rYKDVKcwD5ApOmg6aV2psJS1HB7c510S4g4DpE+WDL51lGXcsgcoSE4EB8HQr9gEgsuZsrN/DeS16/MBasX5GeKFecYjShGP8j+o+sOR7nNmQwrp5ZKSniJHsiQhxTttxkGxRqp1x+CZdKyMC7KzQxw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bf908e75-048c-4fb2-6a80-08d584b12a00
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09362A27E6D910B89BD746C3FBDF0@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(39380400002)(346002)(376002)(199004)(189003)(478600001)(99286004)(575784001)(6506007)(59450400001)(3660700001)(36756003)(86362001)(54906003)(6116002)(110136005)(2950100002)(102836004)(1076002)(3846002)(6486002)(3280700002)(10090500001)(10290500003)(305945005)(72206003)(6436002)(6666003)(26005)(5250100002)(2906002)(186003)(2501003)(105586002)(76176011)(66066001)(7736002)(68736007)(25786009)(6512007)(106356001)(86612001)(8936002)(107886003)(81166006)(2900100001)(5660300001)(4326008)(81156014)(53936002)(14454004)(97736004)(316002)(22452003)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: HABNWlHl2u10gUERyTazYIBmGyvQShfrZ4Tki99UPR6l+kh0tsAsRfw98Cb8vSffwqs/9rQyRe0HGzsd0B7QJAuDP3W6ZSJnc1KCB/92OXDjeRN7CBHRB0zUWae83f6fkAmcPzkZ76Rb78WVOs5GngiqVc7bNGTvpkETqm0b06FaXMPNuuhjogtZ1l+bIwSNbbTLtD56aIzJqIa9ARqYweV9nJaecWHfmzEIy/3xfhGEw6rIqYEV4vg1NiRxRLB3eK/KUCDp3Yr2nBXNZpgSoKaYELz8HK1NVzQuypBeCmnscQeDIbN3Xepg93qeGYwSgbwdU0I5zCWMEWp0SP+tjg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf908e75-048c-4fb2-6a80-08d584b12a00
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:33.8735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Stephen Boyd <sboyd@codeaurora.org>

[ Upstream commit f8f8f1d04494d3a6546bee3f0618c4dba31d7b72 ]

The orphan clocks reparent operation shouldn't touch the hardware
if clocks are enabled, otherwise it may get a chance to disable a
newly registered critical clock which triggers the warning below.

Assuming we have two clocks: A and B, B is the parent of A.
Clock A has flag: CLK_OPS_PARENT_ENABLE
Clock B has flag: CLK_IS_CRITICAL

Step 1:
Clock A is registered, then it becomes orphan.

Step 2:
Clock B is registered. Before clock B reach the critical clock enable
operation, orphan A will find the newly registered parent B and do
reparent operation, then parent B will be finally disabled in
__clk_set_parent_after() due to CLK_OPS_PARENT_ENABLE flag as there's
still no users of B which will then trigger the following warning.

WARNING: CPU: 0 PID: 0 at drivers/clk/clk.c:597 clk_core_disable+0xb4/0xe0
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.11.0-rc1-00056-gdff1f66-dirty #=
1373
Hardware name: Generic DT based system
Backtrace:
[<c010c4bc>] (dump_backtrace) from [<c010c764>] (show_stack+0x18/0x1c)
 r6:600000d3 r5:00000000 r4:c0e26358 r3:00000000
[<c010c74c>] (show_stack) from [<c040599c>] (dump_stack+0xb4/0xe8)
[<c04058e8>] (dump_stack) from [<c0125c94>] (__warn+0xd8/0x104)
 r10:c0c21cd0 r9:c048aa78 r8:00000255 r7:00000009 r6:c0c1cd90 r5:00000000
 r4:00000000 r3:c0e01d34
[<c0125bbc>] (__warn) from [<c0125d74>] (warn_slowpath_null+0x28/0x30)
 r9:00000000 r8:ef00bf80 r7:c165ac4c r6:ef00bf80 r5:ef00bf80 r4:ef00bf80
[<c0125d4c>] (warn_slowpath_null) from [<c048aa78>] (clk_core_disable+0xb4/=
0xe0)
[<c048a9c4>] (clk_core_disable) from [<c048be88>] (clk_core_disable_lock+0x=
20/0x2c)
 r4:000000d3 r3:c0e0af00
[<c048be68>] (clk_core_disable_lock) from [<c048c224>] (clk_core_disable_un=
prepare+0x14/0x28)
 r5:00000000 r4:ef00bf80
[<c048c210>] (clk_core_disable_unprepare) from [<c048c270>] (__clk_set_pare=
nt_after+0x38/0x54)
 r4:ef00bd80 r3:000010a0
[<c048c238>] (__clk_set_parent_after) from [<c048daa8>] (clk_register+0x4d0=
/0x648)
 r6:ef00d500 r5:ef00bf80 r4:ef00bd80 r3:ef00bfd4
[<c048d5d8>] (clk_register) from [<c048dc30>] (clk_hw_register+0x10/0x1c)
 r9:00000000 r8:00000003 r7:00000000 r6:00000824 r5:00000001 r4:ef00d500
[<c048dc20>] (clk_hw_register) from [<c048e698>] (_register_divider+0xcc/0x=
120)
[<c048e5cc>] (_register_divider) from [<c048e730>] (clk_register_divider+0x=
44/0x54)
 r10:00000004 r9:00000003 r8:00000001 r7:00000000 r6:00000003 r5:00000001
 r4:f0810030
[<c048e6ec>] (clk_register_divider) from [<c0d3ff58>] (imx7ulp_clocks_init+=
0x558/0xe98)
 r7:c0e296f8 r6:c165c808 r5:00000000 r4:c165c808
[<c0d3fa00>] (imx7ulp_clocks_init) from [<c0d24db0>] (of_clk_init+0x118/0x1=
e0)
 r10:00000001 r9:c0e01f68 r8:00000000 r7:c0e01f60 r6:ef7f8974 r5:ef0035c0
 r4:00000006
[<c0d24c98>] (of_clk_init) from [<c0d04a50>] (time_init+0x2c/0x38)
 r10:efffed40 r9:c0d61a48 r8:c0e78000 r7:c0e07900 r6:ffffffff r5:c0e78000
 r4:00000000
[<c0d04a24>] (time_init) from [<c0d00b8c>] (start_kernel+0x218/0x394)
[<c0d00974>] (start_kernel) from [<6000807c>] (0x6000807c)
 r10:00000000 r9:410fc075 r8:6000406a r7:c0e0c930 r6:c0d61a44 r5:c0e07918
 r4:c0e78294

We know that the clk isn't enabled with any sort of prepare_count
here so we don't need to enable anything to prevent a race. And
we're holding the prepare mutex so set_rate/set_parent can't race
here either. Based on an earlier patch by Dong Aisheng.

Fixes: fc8726a2c021 ("clk: core: support clocks which requires parents enab=
le (part 2)")
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Reported-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/clk.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 0cca063f70e7..6c18fa7bcc23 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2597,14 +2597,17 @@ static int __clk_core_init(struct clk_core *core)
 	 */
 	hlist_for_each_entry_safe(orphan, tmp2, &clk_orphan_list, child_node) {
 		struct clk_core *parent =3D __clk_init_parent(orphan);
+		unsigned long flags;
=20
 		/*
 		 * we could call __clk_set_parent, but that would result in a
 		 * redundant call to the .set_rate op, if it exists
 		 */
 		if (parent) {
-			__clk_set_parent_before(orphan, parent);
-			__clk_set_parent_after(orphan, parent, NULL);
+			/* update the clk tree topology */
+			flags =3D clk_enable_lock();
+			clk_reparent(orphan, parent);
+			clk_enable_unlock(flags);
 			__clk_recalc_accuracies(orphan);
 			__clk_recalc_rates(orphan, 0);
 		}
--=20
2.14.1
