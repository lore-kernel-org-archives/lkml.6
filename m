Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3274576-1521478124-2-17410887087436718666
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
    t=1521478123; b=K2QtExANUwlctr6+LasD2D40fefzSOVpwvqj6gRwkCw8K0O
    KxgbnUO9qUjqDCqS90S947Cy6IuZVw5YZY/lMyDXmWdjic4rT2rspnOIX/8iLK/V
    rNCkwi2rJLRCT1s5iHa4AQChyYjzWkgTt2O3SdnmBP4Z5iC1TvXok/+ZSOw81slk
    V4IWEzPl46Feet+A4lJNzuOOoRxqZSAU68tElKFTDCp6cA3nyOffPSaWDJeYe2Kn
    Ls5kifUCLgUVfs2Tg+8vmvkFMy2oNVASMoykoSLh/9edKFUM68UOKXIQ5V6XY25t
    1XqminqZaNnHaz22MzbOyqCGEfCWPI9lrJ7E90A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521478123; bh=/yk8xX
    cibu52+sKozK1QNrxMW+sk1lWQNpwYTqlzZeA=; b=GriGdQF3dPK07+Ue08bfmp
    l0Qg2LgklxRYUb4zFh+CkU0H+R/Wd8F0sK5CXF02wWk0u56BrZIGFZ/4DwuYAqC0
    PMmvspDxK21gz3S+KXw18o8mecOdY/HSrSbaoeqrMv68aW2RDaFa3bhVXkeJeD2v
    WzpmZDLo6bQLTWQN2aYoUvYLt3GSbfKmbApuMvoELOMV+0pBgaup3rrFrERW41VV
    utgithMamFWUCriUQzdzqkscdzfJHEhqEFcAJsrCDgGnIB6du6l7J/TUjula31Mf
    nmHskMSAq/lOMklaI6gIaqmiakVQIqaN+PDRZwobV/Tb5Ek7q0OSSZdHbrYOkXIg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Pjrxh5UP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedvvddvnecuvehluhhsthgvrhfuihiivgepvdel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Pjrxh5UP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedvvddvnecuvehluhhsthgvrhfuihiivgepvdel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966777AbeCSQsi (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:48:38 -0400
Received: from mail-co1nam03on0108.outbound.protection.outlook.com ([104.47.40.108]:50303
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966741AbeCSQMA (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:12:00 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Neil Horman <nhorman@tuxdriver.com>,
        Shrikrishna Khare <skhare@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 017/102] vmxnet3: ensure that adapter is in
 proper state during force_close
Thread-Topic: [PATCH AUTOSEL for 3.18 017/102] vmxnet3: ensure that adapter is
 in proper state during force_close
Thread-Index: AQHTv5z7lA2Re/axWkaGdByY/Q1/sg==
Date: Mon, 19 Mar 2018 16:11:48 +0000
Message-ID: <20180319161117.17833-17-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1014;7:KINJDRdMujvPmYv97+23L9ofEWJf4+W41CugzLpmkALIjV2GnO6Lfw3TBCpY9SQDiKW3byLWsuP/TJDmftk81GmkEerKQw9i9XtgpQYhqap2llNd/kazAhTu6EUAs4shmphPP6U12oze2EaAdOGa62dgSIfGR7H6BEKmq1Co+4ptruBI2/qP9vtf6iQlVO177lGRQ53bWSHeuGtLvpB5y+JH/kOe13vscfbczUkm0xyjELvOrjxJtCaMKvsclP/B;20:ZEtpdP4TvUmmQd7xKClGh22jElST/HXmf2UQYMHh6USwD6Ebu1H5Kw1kgZN4Fs9tqjIu5reY3BZxeuxmxgeZuFLYA9yb6UV4tG3cZwr3AGggs3SPBtuw36ptXSMK8lN0D2UceXOCPit3wXYYlTYJtVkzu0YgCAwwqNQOD6rWI/I=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bfa4018d-0540-4416-e632-08d58db41e8c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1014;
x-ms-traffictypediagnostic: DM5PR2101MB1014:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10146BAD4DECD8EE2598080BFBD40@DM5PR2101MB1014.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(61668805478150)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1014;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1014;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(199004)(189003)(2501003)(6486002)(478600001)(5250100002)(102836004)(86612001)(1076002)(97736004)(86362001)(99286004)(72206003)(2906002)(6436002)(107886003)(66066001)(6116002)(81156014)(10090500001)(81166006)(305945005)(8676002)(7736002)(68736007)(3846002)(110136005)(54906003)(26005)(3280700002)(105586002)(316002)(186003)(53936002)(8936002)(76176011)(2900100001)(59450400001)(6506007)(10290500003)(22452003)(2950100002)(36756003)(25786009)(5660300001)(106356001)(3660700001)(4326008)(14454004)(6512007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1014;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: x2cVQGmoaKYIckOKMBwqquPfRXsXnxrMbeyW7IVhVgLRI8YJZFercVr15LgRL/1bPbr7xkqU7SI+06g1ouAd9Pyfh7SOjMQcxkz+bmNDKIp2BNNhTssU0rkpB+2SosHGKTGbfNpenvo+dVq9kMvRh4KIq5o7pXfsID0ND4wM9WWtn+5iCKya1QfHT91ZPfIYz1ZfDNtvDVpFRs01VOKnGCFIHw86Ix3O5vu3GtF1QJxVOOIYL8WxGB3xVssv+5e2PrSSQMS9MrvX3CFMkDIx6kJexM6BFXqSAW3LCVbjWq3hE6v7yLPNjfb+ilIYDsourPMZAsltgy521k844Lw+Tw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa4018d-0540-4416-e632-08d58db41e8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:11:48.7702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1014
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Neil Horman <nhorman@tuxdriver.com>

[ Upstream commit 1c4d5f51a812a82de97beee24f48ed05c65ebda5 ]

There are several paths in vmxnet3, where settings changes cause the
adapter to be brought down and back up (vmxnet3_set_ringparam among
them).  Should part of the reset operation fail, these paths call
vmxnet3_force_close, which enables all napi instances prior to calling
dev_close (with the expectation that vmxnet3_close will then properly
disable them again).  However, vmxnet3_force_close neglects to clear
VMXNET3_STATE_BIT_QUIESCED prior to calling dev_close.  As a result
vmxnet3_quiesce_dev (called from vmxnet3_close), returns early, and
leaves all the napi instances in a enabled state while the device itself
is closed.  If a device in this state is activated again, napi_enable
will be called on already enabled napi_instances, leading to a BUG halt.

The fix is to simply enausre that the QUIESCED bit is cleared in
vmxnet3_force_close to allow quesence to be completed properly on close.

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
CC: Shrikrishna Khare <skhare@vmware.com>
CC: "VMware, Inc." <pv-drivers@vmware.com>
CC: "David S. Miller" <davem@davemloft.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet=
3_drv.c
index a26ae97f755d..56a2bc86c439 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -2648,6 +2648,11 @@ vmxnet3_force_close(struct vmxnet3_adapter *adapter)
 	/* we need to enable NAPI, otherwise dev_close will deadlock */
 	for (i =3D 0; i < adapter->num_rx_queues; i++)
 		napi_enable(&adapter->rx_queue[i].napi);
+	/*
+	 * Need to clear the quiesce bit to ensure that vmxnet3_close
+	 * can quiesce the device properly
+	 */
+	clear_bit(VMXNET3_STATE_BIT_QUIESCED, &adapter->state);
 	dev_close(adapter->netdev);
 }
=20
--=20
2.14.1
