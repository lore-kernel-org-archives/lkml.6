Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520492397-2-6207050591739890152
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
    t=1520492396; b=TYVBIdzpf4TeERykGwn8LK5yrWs36JU7lRHp8pMp+jxxUI3
    KBiBZM3OFommOLJWeZvtZAvk77IevH7UaLoH43fdbMvveJze+XFmeRbsp1NIRUSw
    kkNXhYAmnGr9t2YabiR0tGrrd29dN2CQBJXFAm1AmB0SGF75+q998C5SO0/7r7Tp
    /h0vxSYOL5TuWAk4yKRmEjFbmyhIbXSjfLzXkWTImW3t1NXR+hnz+HbV2fcm08+m
    vaKCeqA/dAjexEI426Hui6WNmqfsV1vtC6Zg3NPb3c7ehyGHzDnXNcQfQdSetfyN
    O27ehl8bnWij6M/SAnXGJXbSp0cTWQyMY8g+2pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492396; bh=Upuyc6
    WgJFqkaWNQFG2bggMtqHnc0JfISOFbqJB9vOY=; b=ktYjDvqBPzsGE+nuPKcZOR
    A3DhoBWe+YasLBu2P5L7HfnJG/1XnFBK1NgIjWksxsmJzaMtDuyOu1cu/+BPRRey
    Gve9RyU7rlH0dwq7RkxHkrKG9YHP3BvEv3h/izCfuR4Us/2z3xXQidWXLKIs1pEd
    mxnTqFTmBx6f6ONJ1bqa4ConbFA6AVTkS3fXPHzcGAX4VYpRQ/DVP8IIqUiAZoYl
    MZQQSvosihdvP2nvh720r+p/lvMqcisQskIM7C+DNUoKomL/RabK9eAy8Wknr/ph
    qB5VcB/kl8ZH4WRp/k/YS3p+v0hGPjathWMGX5mEblHPGIpXvzBQlD5KSgpIOTjg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hTKS+dm/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hTKS+dm/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935016AbeCHG72 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:59:28 -0500
Received: from mail-sn1nam02on0127.outbound.protection.outlook.com ([104.47.36.127]:4352
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935005AbeCHE5W (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:57:22 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 56/78] media: davinci: fix a debug printk
Thread-Topic: [PATCH AUTOSEL for 4.15 56/78] media: davinci: fix a debug
 printk
Thread-Index: AQHTtpnPp4NPP8b5I0KOQhAc33hd+A==
Date: Thu, 8 Mar 2018 04:56:25 +0000
Message-ID: <20180308045525.7662-56-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:f5GMZZUDSJapjkrXGK+ecVbjhHHE6HJDLgMNYteNXjda/rr2JoV8fvakrRAzHon+XEj55QtVhQxMwzM/0QrMiw1WpDl5paa2ye5Iptl4X/xGTOzsBnGtSXNQOt4JrF5UhA6tYkqoqTBslrZzEdpZpguqMLwHD9j7ffVsBlNPhlIAsj4lf9ASQXxK2jqKKBteG4iC104DD171qhk8KS0Q+jNbdC9mbnxJEVfhWiSeD2T6XKTXPEmO7Rk28oy6HKpK;20:hyKxiAuU0yyqBqDDCmz7Swkgjteq6WfDymeIbc7nr8A5kW0Q0NZMI1Ip9XsiMZi8p7aTsck12bvCwSUSXpCAj6jLBGAXL4CnElkmw8wDlfk2UQgujFuCssuCgO3McaHE3UMPfylGGM/NhDcqqokGS7ZjCqT60ew/lt+/l/5rDes=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: be8133eb-90fb-4307-ae31-08d584b10fed
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10322D1E3173D5FF01C8565DFBDF0@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(39380400002)(366004)(396003)(199004)(189003)(97736004)(36756003)(8936002)(105586002)(2950100002)(2501003)(6666003)(186003)(8676002)(5250100002)(86362001)(2900100001)(3846002)(5660300001)(6116002)(10090500001)(2906002)(7736002)(22452003)(81156014)(26005)(6506007)(1076002)(102836004)(575784001)(81166006)(305945005)(3280700002)(72206003)(110136005)(86612001)(54906003)(99286004)(10290500003)(316002)(107886003)(4326008)(25786009)(68736007)(6486002)(6436002)(6512007)(53936002)(76176011)(66066001)(3660700001)(478600001)(14454004)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: jejpejtFLWqjNk2eFeIudgGyPLyTzLoY9kLPdUdR24E/sGRhLfuXdLOG/3DZEjEEQn9qsSkZdId23854oV3DAMIGSB6pQnC85mOa+Ga59ORrXZEfYXskqNvdgy/OBzNID9fY/6Zzp5uMcompC0WxElSGOCYmgsYi/bFyY+fMHGbK1H0wtZOT9Zna5XhlS/awxLjgWwDOTKJ9/15uHlDy6IE78wD1Wp2j7eSqeWZ/5l6NLoyNvhtzSUAvZe63WIVohRrrOC4+NcN7kj5niI3NPXCaO8jR/R1o26t3h3MvTfq9oGqDK/AavsvjOPAGR1jJeKMnjji1Fu8X032hVjhWIg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be8133eb-90fb-4307-ae31-08d584b10fed
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:25.9760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mauro Carvalho Chehab <mchehab@s-opensource.com>

[ Upstream commit 4f6c11044f512356cb63d3df0f3b38db79dc6736 ]

Two orthogonal changesets caused a breakage at a printk
inside davinci. Commit a2d17962c9ca
("[media] davinci: Switch from V4L2 OF to V4L2 fwnode")
made davinci to use struct fwnode_handle instead of
struct device_node. Commit 68d9c47b1679
("media: Convert to using %pOF instead of full_name")
changed the printk to not use ->full_name, but, instead,
to rely on %pOF.

With both patches applied, the Kernel will do the wrong
thing, as warned by smatch:
	drivers/media/platform/davinci/vpif_capture.c:1399 vpif_async_bound() erro=
r: '%pOF' expects argument of type 'struct device_node*', argument 5 has ty=
pe 'void*'

So, change the logic to actually print the device name
that was obtained before the print logic.

Fixes: 68d9c47b1679 ("media: Convert to using %pOF instead of full_name")
Fixes: a2d17962c9ca ("[media] davinci: Switch from V4L2 OF to V4L2 fwnode")

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Acked-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/platform/davinci/vpif_capture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/davinci/vpif_capture.c b/drivers/media/=
platform/davinci/vpif_capture.c
index fca4dc829f73..4efabfcd34b1 100644
--- a/drivers/media/platform/davinci/vpif_capture.c
+++ b/drivers/media/platform/davinci/vpif_capture.c
@@ -1397,9 +1397,9 @@ static int vpif_async_bound(struct v4l2_async_notifie=
r *notifier,
 			vpif_obj.config->chan_config->inputs[i].subdev_name =3D
 				(char *)to_of_node(subdev->fwnode)->full_name;
 			vpif_dbg(2, debug,
-				 "%s: setting input %d subdev_name =3D %pOF\n",
+				 "%s: setting input %d subdev_name =3D %s\n",
 				 __func__, i,
-				 to_of_node(subdev->fwnode));
+				vpif_obj.config->chan_config->inputs[i].subdev_name);
 			return 0;
 		}
 	}
--=20
2.14.1
