Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523241590-2-9195292116422255791
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523241589; b=FrG8n86vkmY3zYMOFQza+EDse4WvFv+ROKCae9bSVeTbW4w5o3
    vjeZ5w+NyHNMaNA9jQfRgDSGjcdNpUYf61ftUJAnfAOF3F7VmmEy6rXw/N5x7nLh
    Vj/J+MnB7JzEMSXAUFPU9oJoIBPOctnD3rzIiZ9pTNZhO4xUKD7omWcBPN9DjMuH
    eK/hnboRTfA1y5p3ua8LwXLBSbYNgMR++EnCnVNRYLWEZEzP6LixIJ1eEg0P+hHx
    HubsX95uRJ+NbUpssdv41KEk8Bl14zI3+DfX8feie2gUI1wW0wGHGd6FvQBWoxqo
    9wlmdrgj0SimG6+Y/K4ABg71x2B2jI9nkUnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241589; bh=Hj1IYhqL68
    jUFA0ME/bCW6j30j2T0hKXTqUh1pXutXg=; b=EEnZKhGMsM/F6Lb52+OsvFlfHE
    q+zZBcD0JRVHescXqcMbIR6G98xXVP5zSqAXwk9Pb/EjOLkJTiRGrI/l/9vbsfm0
    jPR6PRHFFr3r30mTqB7OnQ/CwYVn1KBGbPdu+PR4itryqPT6mqw7NNW6BQ6SQymk
    HnQisM6VtP5PvnFKwZUVURw5QVZKW130ZrNw0gP+FP/+SoRnsskPCzFUs9HB1ADg
    Ou/4iqqd8btlBlvL0bZKH6np/b6Y3bQLmSHc0wyEd7qUNPUVvxhpJFSqn9Oyfgua
    RmBZBEd1gc93txj56YItnB6uzP+leL1IUVSyAXvJYsBJW+DCuxjqsN1dQgVw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Q9GkTYH8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Q9GkTYH8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHnCesrrYE/UMdgQ8C7VBwDHIpXvQRsgRaQinF/Gu7q6lyK6pkgTrCT4FC2mwONwLx6dr4wlLWo9utg4+uaSBMdziffmzOya2qqBfyv3AFeSTER5or1L
    7rYDI2oItCdAbqDJXhNISm6+eApfxpC1kJNchnk0LZKu1q0/Ik5H4XAApMe/5K2rC+mq0aki6z8sxApth6goVLTzROxr+JOIzzLnabN7ZYKgjV3j2Lu5qnkm
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=cBQ9SC8uRl-JxL1Nw4AA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755568AbeDICje (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:39:34 -0400
Received: from mail-cys01nam02on0094.outbound.protection.outlook.com ([104.47.37.94]:22752
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755562AbeDIA11 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:27:27 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 039/293] cpuidle: dt: Add missing
 'of_node_put()'
Thread-Topic: [PATCH AUTOSEL for 4.9 039/293] cpuidle: dt: Add missing
 'of_node_put()'
Thread-Index: AQHTz5j2Wm3X629cGkGToGbcWkKKdA==
Date: Mon, 9 Apr 2018 00:23:20 +0000
Message-ID: <20180409002239.163177-39-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:tt+x2GW0GrOim8+aOz5mDDu2zCJ3bcP9//E3ki6kYnXfDPx72iAx1OwOi+w1cqcBxJCZqYZKandbdSrk2Z3LQwNjYeDY7QOxcHkhZN5MoDtusHWhntgDV8ZosNzP4TapJgMhlHbv76JWANpQIIs4gxUme50FG74ddolaNEYlVNpdolLgeJOd0EBP7h5tILVaOE8xocysDmejkb6kPhcEyYF/FSznaeH8Z2lvIMSGA4DKg9T8oqNaaGuCiLOQbBXB;20:ZAqymC98vGAd4bAnH87Vi1CBEeNCuhv8DhJZU9vNsrUtNhV+IZxb+85gZlJXaJkfI8TrD2ExaDrP8O8w8VYsTYvz1QG6wm1eh6VotMhwjTPBlmwS82z2xJdZIo6ba8th19swchLjZYiwvmffba+u8XY7SBsRNoiQPTivF/LIeq0=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: e239e1d7-3cfc-426f-aeb5-08d59db0a94f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031871304226855C7E357E0FBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(155761271638844)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(7736002)(11346002)(26005)(86612001)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(59450400001)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: F3rgZ0xZqK5U63SkZVOC3a6HowEW04va2xhOam3qiqwzALxMsVRN7EC3rlFamt1sPXVKGVv4mrbmG9mmnLgfM71iYijPgMqU++zYzuusP6GIrgGMTDgW4TTBUqxohKcsZ4RgQKhiHSV69GE2cW+ND1FcjlE66Nma8tovSDPI6TBMsXCubkhd6xc+4OlSP+GzhtQE5N5oorInyBp9A9YiJRx4MO7/FfsdI2hr4BKPgUbLFYNFwfxwXaWkgzOupAFUtVePChw8/3ReeF4cIIw/d6UbA6nT+Z2NF1YW24lAAH4J/kRNmbG8pK8Ojc5u6sFZYZAhQCxE5RBtTSzfL9wc54SmRqqQd6pz//40qFom/o+Llxib/dutoOPcMpe9zkQ2/TVtNVzuo4wvZTxuJhLXnclc5dBufjMgFuQfE4QTtrU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e239e1d7-3cfc-426f-aeb5-08d59db0a94f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:20.4248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christophe Jaillet <christophe.jaillet@wanadoo.fr>

[ Upstream commit b2cdd8e1b54849477a32d820acc2e87828a38f3d ]

'of_node_put()' should be called on pointer returned by
'of_parse_phandle()' when done. In this function this is done in all path
except this 'continue', so add it.

Fixes: 97735da074fd (drivers: cpuidle: Add status property to ARM idle stat=
es)
Signed-off-by: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/cpuidle/dt_idle_states.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_sta=
tes.c
index a5c111b67f37..ea11a33e7fff 100644
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -174,8 +174,10 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
 		if (!state_node)
 			break;
=20
-		if (!of_device_is_available(state_node))
+		if (!of_device_is_available(state_node)) {
+			of_node_put(state_node);
 			continue;
+		}
=20
 		if (!idle_state_valid(state_node, i, cpumask)) {
 			pr_warn("%s idle state not valid, bailing out\n",
--=20
2.15.1
