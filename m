Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475621-2-8414044214556323701
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
    t=1521475620; b=Q5d9lPmQjvvWRL2OU+4m86mn3xW+O48VoSt3kAIRl2jlNi2
    E58LTyXfMs0QTYE+NLIfYQbxXgK+u83SvbnCN08zBSl9DRr8+42h+Ml0yMcy33x+
    /s9OFsI63/y33E2NvNFZ7ZgPQEaR4sWghwR+I+56fk2NkhunwlbAK+V83I4NW3EH
    VweKPjkNnMGQxo5sgGFEeHSQ8x2PrbBKDp0E2Oqt+nJSDimf2jDsMVtvztFGhlQU
    A34BQ5nrL1f3lHEcUO6N4uhTuxfGtX0KCaUI19eeJI444BXd+tC2AGJWX5u0C0S4
    TnTcfsVdXJ/WYyiERsh+bdBXG6ihOyGheyilnFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475620; bh=p3OND3
    kotaUicMPeSAhfGXnHH0O+PSYzD/dC6RjYM2s=; b=UXPsf1AdRca9VBsEdd1Agw
    HLFNm00qvpvRHB1HxD4FxFfcSaevVLggN3OtvfZtug88to2xhVQzs9uRkmPm25kK
    KIqh7C6XR5izQJPWDuIJFF+jRhCedPSVFn6zdzw1gw4RxPHgMpaGEEX0B92pUrIX
    DmRlA3eBqfThtJgQ3R1rG5npLoinS/F1ycBsmFYap9Ix3kSH6Ozl1QHZ0or9ie6O
    fGl9fQ5EyT376aFIl8/nuTPPCyj9pQnAwhlY9R9VR7Y91SAWD+9FwJuOj+7VvFJt
    DHAcDCamKFBKpoLGxSSXDAw3rBRikAxGpDIE9uLwTGh5LH69tFp1tDDDozHXdHDg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=k82DCBLm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedttddunecuvehluhhsthgvrhfuihiivgepuddufe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=k82DCBLm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedttddunecuvehluhhsthgvrhfuihiivgepuddufe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966093AbeCSQGz (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:06:55 -0400
Received: from mail-by2nam03on0122.outbound.protection.outlook.com ([104.47.42.122]:28800
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965999AbeCSQGq (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:06:46 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Bart Van Assche <bart.vanassche@sandisk.com>,
        Doug Ledford <dledford@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andy Grover <agrover@redhat.com>,
        David Disseldorp <ddiss@suse.de>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 006/167] IB/srpt: Fix abort handling
Thread-Topic: [PATCH AUTOSEL for 4.4 006/167] IB/srpt: Fix abort handling
Thread-Index: AQHTv5wYMkjKAxRmckC/SqsN/uaU8g==
Date: Mon, 19 Mar 2018 16:05:27 +0000
Message-ID: <20180319160513.16384-6-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:I7uOkLod9TABbV+MGgzTvD502XiUf8SVee1aXQ9L3+VmlPNAUxoxYXHvep3JXvlkI2zj0/51FBavNsdLfhO5lE8yYiILo5sg4rp2TVoLhYJfVM9YrwN5bxX4+CVXOdknC8/zblixXxKeRJdrptqqb53cYI+xnaM50A7rntPbi0ag+lGi0JlaiHB8k+xbUUSZWRK3NtR5Ls0AG6x0hfMsIHZInyGqWc5aoowreKgdmOcNyi20GmjmbhlgWBWomL4t;20:8TYuCw3uFKWbT6oDHh05ZiiSqhJ+Qf8cFegk6qg6dCuFn07/PBlo0w+54Eg/JhmOAQs61jb6Wx+zPTae1SZO7d9909CL8k7VcyrDrcR2VHDXgDnosXtxe4mnSBb35P1Jx0SDm7dHmz1ElPu7ltYCezXCRGK2O/eHQui5PDW8HMk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 06813eef-7475-4238-eab0-08d58db367b3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920FB78483BCBF4C1547C43FBD40@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42932892334569);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(376002)(39860400002)(366004)(189003)(199004)(6512007)(14454004)(2906002)(2900100001)(8936002)(186003)(86362001)(5250100002)(316002)(97736004)(2501003)(6116002)(1076002)(3846002)(81166006)(6436002)(6506007)(6486002)(26005)(72206003)(81156014)(53936002)(102836004)(478600001)(10290500003)(8676002)(575784001)(107886003)(6666003)(4326008)(3660700001)(66066001)(25786009)(2950100002)(86612001)(36756003)(54906003)(110136005)(3280700002)(7736002)(305945005)(5660300001)(76176011)(68736007)(22452003)(10090500001)(105586002)(8656006)(106356001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: bEArSjirNRokgE2LpNAqpkEP4NhTxV1CC9CQbl2fZgq/aZrumEuH1FwS9jNZ6hc4WziV5EVZktXgVxDLS7EAKVUaniprPUW2XYs3zmwGPuQcBnHfU7JwjaeJsfGOBB0kum3GL/gaSmXLwh04yQuWQkj7UI6PbxKRTfZerz6mYi8I/kDP8Shw/31Jo776B/tYJOAQZpRuYJKWcFyzxkuF6DZxb1aMQlLfWoaXWb9iIi/r05zz0DkjAenzAF1tVy8UcU6skTGI8AJ1HgFD4NXIdrB6bwwV9FXgRfhLrlhEFY+2TnXiEFu5oODGAEz1UcfvxAuTXKPCKlxTmNwb2EpVOg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06813eef-7475-4238-eab0-08d58db367b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:05:27.5541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bart Van Assche <bart.vanassche@sandisk.com>

[ Upstream commit 55d694275f41a1c0eef4ef49044ff29bc3999490 ]

Let the target core check the CMD_T_ABORTED flag instead of the SRP
target driver. Hence remove the transport_check_aborted_status()
call. Since state =3D=3D SRPT_STATE_CMD_RSP_SENT is something that really
should not happen, do not try to recover if srpt_queue_response() is
called for an I/O context that is in that state. This patch is a bug
fix because the srpt_abort_cmd() call is misplaced - if that function
is called from srpt_queue_response() it should either be called
before the command state is changed or after the response has been
sent.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Andy Grover <agrover@redhat.com>
Cc: David Disseldorp <ddiss@suse.de>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp=
/srpt/ib_srpt.c
index a73874508c3a..cb3a8623ff54 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2974,12 +2974,8 @@ static void srpt_queue_response(struct se_cmd *cmd)
 	}
 	spin_unlock_irqrestore(&ioctx->spinlock, flags);
=20
-	if (unlikely(transport_check_aborted_status(&ioctx->cmd, false)
-		     || WARN_ON_ONCE(state =3D=3D SRPT_STATE_CMD_RSP_SENT))) {
-		atomic_inc(&ch->req_lim_delta);
-		srpt_abort_cmd(ioctx);
+	if (unlikely(WARN_ON_ONCE(state =3D=3D SRPT_STATE_CMD_RSP_SENT)))
 		return;
-	}
=20
 	dir =3D ioctx->cmd.data_direction;
=20
--=20
2.14.1
