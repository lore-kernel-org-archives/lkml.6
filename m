Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3274576-1521478465-2-16360391886832649273
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
    t=1521478464; b=pi6aE9p34YG+twFzSwrQULDQpSq16nsK64Gz0RvoEOpOMC0
    WQlYduDb/+vkbegOWVoMbQj44RPsjBjVKtvXxHWRCNCJajSiys5zHQinBrsiL4Yw
    pHoZwkfa2wduFVt5Zk6TnnInRyuWBIUGAvb50l6z2h0fvKmZsfoqO207ofD9cpcR
    id7xqUQVVKpiO6eIX5j9iyolWTLz7hnAiwMBR+8yLYByMlQ5lAONUg70hfV94xS2
    r5GzmBk/evAc7CGYWk1jjtrWHWo9sSXq0QF1J5BQ/hsvERjONFYbWN0xh+Z1U1rx
    qjifK28Lg0sH2p5KJAQBrK46ReZy53a6aPiweZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521478464; bh=yFSyvY
    XfViGKD79qvVKJVfiyD9w11pdwCP/K+2SkoCQ=; b=LMMzYd/PzCS3eTUw+vx+0Q
    AYR3bx+stAAHLjgciB0kPTKEvWxqYUDYu/H1PpKrGMqK+qc8NJUwRaZUwZcZFy32
    a2F/g2Jgxd9zkin236CVKI8h0LWFJf0TJ+VDNAcKmYT17iaByAlpi6CyGv4G1/Ns
    4MDwHEUKQTWE337ICTXxAYQaM6U8Vn0LvgkuLyI9EXPMhHz/cQnz6NdjGQIY4Ada
    2wm8i6sZ/K2VXAB/hsCoFzpzPwiPRXZOdQm1U8Kgr0cS0yxpIMnxtxIZQ1TsLtdD
    v7LvcTIWKu8j6ooy7zN2kKu2wezl+r9hBhk79tnsKzIB/Jv355qtpdd5fT9I4xuA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AThWFl8H x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedttddvnecuvehluhhsthgvrhfuihiivgepheej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AThWFl8H x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedttddvnecuvehluhhsthgvrhfuihiivgepheej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935125AbeCSQyU (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:54:20 -0400
Received: from mail-dm3nam03on0111.outbound.protection.outlook.com ([104.47.41.111]:6417
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934094AbeCSQLm (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:11:42 -0400
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
Subject: [PATCH AUTOSEL for 3.18 002/102] IB/srpt: Fix abort handling
Thread-Topic: [PATCH AUTOSEL for 3.18 002/102] IB/srpt: Fix abort handling
Thread-Index: AQHTv5zuNVBh8VxE3USQPGcrAUtqCQ==
Date: Mon, 19 Mar 2018 16:11:26 +0000
Message-ID: <20180319161117.17833-2-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:DlFn0Ub1rInK3289f56DhHt1siSakiEcdDlBO+hAREPVD7e9zHe6Sw/lo6s7rRXf2ds+zQnJSz9M9mDaAIy5OpVez074XW63/pgWxX4oEBwP2n/qXsOZov+k8oC3c3pvqrAEbboQt6s+YDAt+j3grAmWhaF2lmE9oZE+ZAms4np0Gm758wkHuAF6nbgzvZLd3sE0jDIYe13l8nRdDoBxOALl1rmL7sMhwdmkQUtpFuG3SiQl5Z0MuzQmycglUdKU;20:N8HuhlbDYpBIxjSx4RLKY9+1/b8YMBDxJKQX4cMrlTxTA5urmDQM6Sekx0kWi+bu9tt4OXwCYprPrrhHPizhPa6R+wAqk+5KZvxevDNhsKCdzDDBbgsDmjjMrOtHzdRKvwGytQgMKe4z88nhPL/zmIXiVjGq8dapcOWxI7FEpp8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d1ebe0e9-be8d-4a1d-11de-08d58db41392
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08054A6638ACED8AB227FDD5FBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42932892334569);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(575784001)(2950100002)(305945005)(186003)(86362001)(6506007)(3660700001)(6666003)(5660300001)(6116002)(8936002)(3846002)(1076002)(26005)(7736002)(6486002)(2900100001)(6436002)(2906002)(86612001)(68736007)(81166006)(81156014)(10090500001)(102836004)(8676002)(14454004)(105586002)(107886003)(25786009)(478600001)(2501003)(5250100002)(53936002)(3280700002)(316002)(54906003)(4326008)(6512007)(72206003)(66066001)(22452003)(10290500003)(99286004)(8656006)(76176011)(36756003)(97736004)(106356001)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: QozWbemqnEUI1q1IGuD4amepw6RaTuSKHkjO1zuXHWiR5w01g/KZsAS0kjrRh7gmGzcBr9ih2XEhlrtzP9G+/+s/4PrCfzwA/lrvL+UXxJUr03rfsa6UtV8SYbBENsV8OCB2Kd85KZmssLTt8WkR54fKmoDU3nsqy+RF6uGaII68aqqV0hEPPdM5+BJOtWrwrQQD1l80SwbCg6zKHXHw40QVChULxfs4jaxTgvXlAiOHlxz3W+siboLvGIwvMMJ2xwjk5qvpKSO+DzeTL+AJdr4C6BVC0TQ2prjaSoIJ8Paiz8EmNU9jFfePx7y0CWXi35KPVnGvN9nxxxKKfyrAxg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ebe0e9-be8d-4a1d-11de-08d58db41392
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:11:26.1131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
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
index 587311887d94..422e022dcbbb 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2986,12 +2986,8 @@ static void srpt_queue_response(struct se_cmd *cmd)
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
