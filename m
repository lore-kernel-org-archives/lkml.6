Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521480187-2-14037442232795497461
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
    t=1521480187; b=aPS+s5ErGZ1TreDdmIhfjHyRjOCUa2Tk73nNSh71z+/lRIB
    CEKyTEuTI/Ec9+Xy++98b4zPYn6HY/iiqe9XyQ5wf2DO8er6X0CgJY5gvvyrXeIj
    lH9xqgp2LBeksYyWPd86TFNKQl913ScejcoG+dYN+ZqgEBu1BCqnmV+zOyANkOOb
    76SyYoBnzU/BzkXwhNEKaxQ8D6yygO6vcz8c7cte1h/XRii6d5wykNjhtsBh3hut
    4D74Vt5zHeMcjbSDuOON2T2tUbi6tfIaAPTjywS7yD+xjLYQOzu6rduGDmJENus2
    ps8PyKRT9tmutyTkdZ+m+mnEQGSqbP37BtEEbog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480187; bh=Y6ueIK
    owli7sEnyvmfatWx8WzTom3RZX/T7nQv/ossM=; b=WV20D6SIK6cuCupjQr35Rh
    DhBrmoEyMjsP6WA/dl5x74uNaJHgC+QTXn4w2qEdTBCWFO8yMFGdPevLwLGmwm+I
    jeZMjeRMinJDeXLgN93LBGroYTaMNB0eWtvRDvW6jN9pQ02q3o+QFr36NNrVgmA4
    N1tcVUEKbNsNBGcpfyGzqn0muOgTrNbHVj2dkqcD7t5tnRmdOe2ihbv4FsEJhGLY
    0f0+z7mHy8N8SvPm/91rsOZK9febuVmDJUnYv0nKmoAKEYVdO3I9+ntxAmvRITzv
    WDbWPg5uA08uptraERyifG25acxOQU3V0ak36mFLi7dCXNUg5J1TtwiItuwRf8gw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=epv+DEuP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejieehtdenucevlhhushhtvghrufhiiigvpedule;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=epv+DEuP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejieehtdenucevlhhushhtvghrufhiiigvpedule;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967985AbeCSRVn (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:21:43 -0400
Received: from mail-bn3nam01on0106.outbound.protection.outlook.com ([104.47.33.106]:7584
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966393AbeCSQJH (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:09:07 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: linzhang <xiaolou4617@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 081/167] net: llc: add lock_sock in
 llc_ui_bind to avoid a race condition
Thread-Topic: [PATCH AUTOSEL for 4.4 081/167] net: llc: add lock_sock in
 llc_ui_bind to avoid a race condition
Thread-Index: AQHTv5xSx+VkzBI5lUGTf3C3S4lj5w==
Date: Mon, 19 Mar 2018 16:07:03 +0000
Message-ID: <20180319160513.16384-81-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:Jfz5vhQE8TwPkRm4PJk9Xt1Hhlyi1DNIXiNEFrJxY2d7eVwWhgyJBccI/FdQ2mAJbJPtosn4nUHAxXaGrJw65wd3B23EPAaWIfHap1VhEJRRCTp4gVJcxxC6tOCy2ZbnjKpDrtvvkvWaGjc8A5N+AAd9M54+ppTrJXzQTuXku4IeKco5cvLuUL0tVTuhg7FPFMIWNxDtOKX9NiOgicvLbCMWXTcocVrEkYKds6FGhLI6n6GpWRUFIqjx5giXWHy3;20:bt1zLEmkAyLNG71hXBqZfl0m5HVhEJvoaUhN5sFRI7IFoqNKQnDVLCKNmUMcI8ixiu9gKI3N5SJ5PHCh3CX0YgHvKBNp6BwWRuj9GtDMAENpnEv7+vmMBM2KSRW+LxzNc42W3T7I47m11OVVaVMKbEiASsAfBU1qSiEvxGDceOM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 51edadf9-9f42-4db1-65e1-08d58db3bcb5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB109579DAB075F34C18E9F2C9FBD40@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(396003)(39380400002)(189003)(199004)(305945005)(316002)(1076002)(7736002)(14454004)(86612001)(25786009)(8936002)(2950100002)(110136005)(66066001)(186003)(10090500001)(5250100002)(39060400002)(2501003)(99286004)(76176011)(86362001)(4326008)(68736007)(3660700001)(105586002)(8676002)(81166006)(81156014)(106356001)(3280700002)(72206003)(10290500003)(478600001)(2900100001)(59450400001)(97736004)(54906003)(6512007)(53936002)(6506007)(102836004)(6436002)(5660300001)(6486002)(107886003)(26005)(2906002)(22452003)(6116002)(3846002)(36756003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: UzeRU18VEMdEg1Q3w52Eyo9xAQOqyt7zoiaM96yDvcq2A8xw4KmscIndUcTRlAsZtaP2ceUTBen7lPD7Pm+Dv+MWUaVRpu40zOGc/KaVWoXzE+z5+DISIH9dbZgPGSDZMwrBjGSJwouzCQZD/JejGfQwHDBM40HE78Yjwbdsa0rGS11L5MeTOC9MhRqRlO+J9Di/ABeHjVvqIe/bS0EEUOojpNJaMYFGfIFkjM5AKoqJLdN118Mfx0lUhgDANBHsW9sVxK30tCj7bp0hVpYubIDu8LsJfXWuorZ3mCE5ZPw5MwrkwlzwI0j5eBpR5RClc7rV41YnwSj4n7pd80sXEQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51edadf9-9f42-4db1-65e1-08d58db3bcb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:03.8733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: linzhang <xiaolou4617@gmail.com>

[ Upstream commit 0908cf4dfef35fc6ac12329007052ebe93ff1081 ]

There is a race condition in llc_ui_bind if two or more processes/threads
try to bind a same socket.

If more processes/threads bind a same socket success that will lead to
two problems, one is this action is not what we expected, another is
will lead to kernel in unstable status or oops(in my simple test case,
cause llc2.ko can't unload).

The current code is test SOCK_ZAPPED bit to avoid a process to
bind a same socket twice but that is can't avoid more processes/threads
try to bind a same socket at the same time.

So, add lock_sock in llc_ui_bind like others, such as llc_ui_connect.

Signed-off-by: Lin Zhang <xiaolou4617@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/llc/af_llc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index bb8edb9ef506..1e698768aca8 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -309,6 +309,8 @@ static int llc_ui_bind(struct socket *sock, struct sock=
addr *uaddr, int addrlen)
 	int rc =3D -EINVAL;
=20
 	dprintk("%s: binding %02X\n", __func__, addr->sllc_sap);
+
+	lock_sock(sk);
 	if (unlikely(!sock_flag(sk, SOCK_ZAPPED) || addrlen !=3D sizeof(*addr)))
 		goto out;
 	rc =3D -EAFNOSUPPORT;
@@ -380,6 +382,7 @@ static int llc_ui_bind(struct socket *sock, struct sock=
addr *uaddr, int addrlen)
 out_put:
 	llc_sap_put(sap);
 out:
+	release_sock(sk);
 	return rc;
 }
=20
--=20
2.14.1
