Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521494719-2-4364964864151643658
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES daensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521494719; b=GI6QA9CVglAw4DZ9yVTQEOuxRu4I0c+2gr2wO2q5XIf8IuD
    0Iulu2iPJUogSZKZi6Yt/P6iWL7+r2FoJwFzQJXfrx1QQMhoBid3TxrsUA4j16nO
    9O1shtgfav8zWz1upe+JLglYYLuJjq4l4Hx/NZjE1Q9TL22NmJwPyWrdE8a/wkec
    6vnRY94+xp29TvzZKhBGNUQS2wOaZikTAMaaoak8R3kJatZL+PR8u1PRLHfNpv5b
    dHQF8+Mo5ZNKKZ6mqLMsVJubz7CEg01y5pRVyRUIYQK8nXG5d5LjQUDoNwxgWXq6
    2l/HrEi19XF3cYcpekTKBdkTD0Cl2j5NC+QsqNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494719; bh=JW/S30
    BKP7tDULn8lC8HpWIUkCp1zs4HwqCL8GgDzvo=; b=wtL6eJnbJj3oPfV0tSe9os
    eXKXFDvKQdYqc1bqnvDSTy6vB5qfnBPr+QN1m44gLAPifyD2sUcpdmAFTgPb8ltA
    A+W68RdSIT+keYp+tRcJVteG/dJd12LbDlQ46Jf6eUlKLlbXHJb3dnQVBJrsAsMd
    xVh5WpCr5xwtpaQX/ZWzmDkl1xvUJh9LI5b5+fWQ0kwnrpifJEmFDFnx7Ailjylm
    xG/h+og/FR1NVbPWww8sHNrn0j8bOWfZrkMDNU6ypc6dkTqEQr3rfXXDvSGIUqKC
    Ong+208pLJ1f1ZDVfr/jKY0OTpP5G/XIGxHqv8+QZS01yBIHBKLYLZCjr+79Q+9w
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FAGdIIYi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdejfeenucevlhhushhtvghrufhiiigvpedutdej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FAGdIIYi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdejfeenucevlhhushhtvghrufhiiigvpedutdej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031617AbeCSVZQ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:25:16 -0400
Received: from mail-sn1nam02on0093.outbound.protection.outlook.com ([104.47.36.93]:41904
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934834AbeCSQAW (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:22 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Guoqing Jiang <gqjiang@suse.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Shaohua Li <shli@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 088/281] md-cluster: fix potential lock issue
 in add_new_disk
Thread-Topic: [PATCH AUTOSEL for 4.9 088/281] md-cluster: fix potential lock
 issue in add_new_disk
Thread-Index: AQHTv5tHrCFhvVYV1UuS53aUNgbNRw==
Date: Mon, 19 Mar 2018 15:59:36 +0000
Message-ID: <20180319155742.13731-88-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:4a/JJ5wR6cY4xhpKO46uGURz8APqAvYaX2N6UBqiZTiNsaN67EFGFYMvjiijYVZtkFSXG8oVGphwF/m+zPPttIdaO5cZLdN9c/yd+cT+iwWlOs/af8ohb+H/LC0aEIrSySr3ai2CC/Cvm4/RlfKKZ8cFGHWoIq3J1vuANXYQn7MCMTjZ9NoGtRlSilAbSz5Hh9O+2HNxH55s5ZXtz2bEKJGh5UmWL7LfPdfNKWhVLIu9hIALCfg2WsE06uOXGviG;20:IeZf/t5d2aSKEUXC7ZSt1c5OBqB2mGSJJ65giQd0jEYr/0Dq+QddML2yHUORCUnCI8cqOau4IDXMlcElq5svQOtgE3ljHWe3+9fiGFt7PCvhxtazQ31kRM/N16/SGULTp6+ydRm7qwCNrWkn106LLgquJ65ywNr8Yn/RD0GhtTk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e576d012-7567-41c0-8401-08d58db27cdc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09841DA9FEFCB218D89CEBD2FBD40@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(39860400002)(39380400002)(396003)(189003)(199004)(6116002)(25786009)(6486002)(97736004)(1076002)(4326008)(2950100002)(6666003)(66066001)(3846002)(36756003)(81166006)(8676002)(6436002)(106356001)(8936002)(81156014)(2900100001)(105586002)(5250100002)(2501003)(305945005)(7736002)(10090500001)(5660300001)(14454004)(54906003)(68736007)(99286004)(26005)(186003)(6506007)(3280700002)(478600001)(3660700001)(86362001)(575784001)(107886003)(10290500003)(6512007)(86612001)(72206003)(53936002)(76176011)(316002)(22452003)(102836004)(110136005)(2906002)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: mxseNpe+hG0ksSMLzCVxGdep0/AXRySfXSl1073YmWZ1mbs29OuHwFbe4BVVlQRH3yPquyN0Fp3On/zI6VA+EsH1GAsMwRTwKRfxxKy4bWGO9sdWfEMZ1oHpxTvIVvBMxKiRTz8K2FHUkFFkiyTDStRhK84FUSBIOD9ySzhac4SrrP6GzOfViGAnugLt9Tps/dO2VfNEVSnn+YgoaoPvnegSbYCZcQeP6GzJ938YBR2QdKk5Gs7gzQsI7k6amPlapEIlwQ9uKnUaL0aaJa3KjjkP2pvW1u/bs+gSlZXxE1uTE96ALQqkCSErE2KyZKKDvRSaF7uvhmNpflz5ZnCB6Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e576d012-7567-41c0-8401-08d58db27cdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:36.0502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Guoqing Jiang <gqjiang@suse.com>

[ Upstream commit 2dffdc0724004f38f5e39907747b53e4b0d80e59 ]

The add_new_disk returns with communication locked if
__sendmsg returns failure, fix it with call unlock_comm
before return.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
CC: Goldwyn Rodrigues <rgoldwyn@suse.com>
Signed-off-by: Guoqing Jiang <gqjiang@suse.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/md/md-cluster.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
index ba7edcdd09ce..fcc2b5746a9f 100644
--- a/drivers/md/md-cluster.c
+++ b/drivers/md/md-cluster.c
@@ -1122,8 +1122,10 @@ static int add_new_disk(struct mddev *mddev, struct =
md_rdev *rdev)
 	cmsg.raid_slot =3D cpu_to_le32(rdev->desc_nr);
 	lock_comm(cinfo);
 	ret =3D __sendmsg(cinfo, &cmsg);
-	if (ret)
+	if (ret) {
+		unlock_comm(cinfo);
 		return ret;
+	}
 	cinfo->no_new_dev_lockres->flags |=3D DLM_LKF_NOQUEUE;
 	ret =3D dlm_lock_sync(cinfo->no_new_dev_lockres, DLM_LOCK_EX);
 	cinfo->no_new_dev_lockres->flags &=3D ~DLM_LKF_NOQUEUE;
--=20
2.14.1
