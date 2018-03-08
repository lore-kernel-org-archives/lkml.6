Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520489460-2-9264688012703841949
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES endaro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520489459; b=nFXe/w5eXMVsJqFo4X12BfVwhOFzNqXtywdVoo7+5OKiGAC
    zAf48r6rovBkbN6wYF6XUA7mIH/Xcao8CUNKwoZ9m/HWGP/HfCDY5wJrmNMUGmKb
    sStJGSQzoqKFAl+XmGLSbTdZOZaDl3v4wPGpAo9OOziQeforKRUJzd9C2UXdFgzi
    sKw9nUXv1JmynwAqBn16JISxBSDfAvJpDtw4F4jAxawTfwLhXdCCz13bZT9W8Mcn
    FX30HWl+4qw+OIf9q9lnR5oX+xgifdDjjxu5/syzBybiudWE829tsVeSSgZ1gmG6
    ElrII0Hnzt3b8WMktVf42bEHfIWzEgRqbBM2zjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489459; bh=g8PLdo
    /8Jz/fCXeT34G1E3r3pm4jgvGabHipWrRpN4c=; b=D8kTYMKD4KhQfuA31KzBUp
    EKugvPv8gG0m0Y975pfGQytdBVipJo9Qc7zf/841t4NVinRVfJJg7dwStYjWV1sB
    ibUld2WwGgEHRl7VTEW4sjTQD7oCs637F+flqDRWkfyrrRmH9paHyk0SGhNe1Ts+
    J2TvO3peMmDJc6FCx/nzsJ4s5nk9j0Y+V1reBwurmlUMlrLkyx4okbl/gkuzhKFO
    JEBVjWOlM73fHyaxsnfKVBxVFw0GWSoea4rpzewgV93vBHgCXmixJPCptxvh6OTW
    Yual6Vj+YFchFm6v/Dc/JnTqMgwPLFDfTg8BiKy2kS6wNUsFIPdJ6MNILT2i20uw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=M0BuVGsw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=M0BuVGsw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755357AbeCHGKo (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:10:44 -0500
Received: from mail-co1nam03on0097.outbound.protection.outlook.com ([104.47.40.97]:43648
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965754AbeCHFBj (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:01:39 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Vlad Tsyrklevich <vlad@tsyrklevich.net>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 085/190] infiniband/uverbs: Fix integer
 overflows
Thread-Topic: [PATCH AUTOSEL for 4.9 085/190] infiniband/uverbs: Fix integer
 overflows
Thread-Index: AQHTtpo94q24Kbc1VkOZ44Z/KX6YZw==
Date: Thu, 8 Mar 2018 04:59:29 +0000
Message-ID: <20180308045810.8041-85-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0999;7:PffL5pvLSKLaW90AFFwrMCcy+7F5r/SE1wEOQ9iHABSzA4c1fN4UUN8092pgsmbiO/D++hvUa+ZNbMeEDtIyaciEdW2XVdoamk+EPgNQ25+7xR9a5garSfW3c6E7lN92h0QcyM7ehYzLDG150iP8E3Z1D5FF/yuNlf0YNqNNjxlw4X6+4hj30UOPlAMr+/xgHOc+Tkj+qFdm/4/IXYggRZ7gei/+fDYp3F+uRjYxcSqE3vm09n6TQaSV/4TXha4v;20:3ivkBxuzJuKix0fmlpP5Z3q0XoLVz+Kdd3wnB+iUw2waCLYrj5pVIPQvqfKYQTMIZG+qm+jGPDmRuALSrJTBdnxCqtVntu5DqRQDyR3G7pG1AQSwwbwAXjpsttBho4+6RAXM73j0x8Ydk4g9Mn8r090+rIltPm8arPYSZSJL4so=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f9e0e1ad-12a6-41f1-d6de-08d584b1a9ba
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0999;
x-ms-traffictypediagnostic: DM5PR2101MB0999:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09997C833DF603CF9198E477FBDF0@DM5PR2101MB0999.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0999;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0999;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(39380400002)(376002)(396003)(346002)(189003)(199004)(72206003)(3846002)(106356001)(8676002)(6116002)(1076002)(6512007)(14454004)(81156014)(66066001)(2906002)(3660700001)(478600001)(10290500003)(8936002)(6486002)(305945005)(7736002)(36756003)(2900100001)(81166006)(4326008)(25786009)(6436002)(5250100002)(105586002)(54906003)(22452003)(76176011)(5660300001)(10090500001)(110136005)(316002)(6506007)(86362001)(575784001)(186003)(2950100002)(97736004)(3280700002)(102836004)(99286004)(107886003)(59450400001)(68736007)(86612001)(53936002)(26005)(6666003)(2501003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0999;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: OwQ9jL28trhIvhITlsPIL0QNFrB/PXYCElPEPsVQsFFZmf9S68v93TQn77tXpD0acMJN35qSK79B3Ohfe8aky4yEA6JSZ+q6Yto1tgbZ8u86PVCIEIk3xO3zxGcwR3Fj/gIAhXAmyDmGdZ6HqeRsCGPvEe3gwm6vqQ5JcM8GTBBW7TrHBcrSs/KST5nP+ESRZHEmmftLoi4WfcVX/R9EejKGiUYAqTJSD0OfThNBrQsIcVSFlrWuUDCvxgXOlcJClzd7uBPsxcbNsJUWodhAriFq8loZ1NVcXhbmhRzE2ityuAfnTdVaOoEk1fHrxG8Ogmmw/t6yJQjMbfUGM3kPQA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e0e1ad-12a6-41f1-d6de-08d584b1a9ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:29.2136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0999
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vlad Tsyrklevich <vlad@tsyrklevich.net>

[ Upstream commit 4f7f4dcfff2c19debbcdbcc861c325610a15e0c5 ]

The 'num_sge' variable is verfied to be smaller than the 'sge_count'
variable; however, since both are user-controlled it's possible to cause
an integer overflow for the kmalloc multiply on 32-bit platforms
(num_sge and sge_count are both defined u32). By crafting an input that
causes a smaller-than-expected allocation it's possible to write
controlled data out-of-bounds.

Signed-off-by: Vlad Tsyrklevich <vlad@tsyrklevich.net>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core=
/uverbs_cmd.c
index d118ffe0bfb6..4b717cf50d27 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -2491,9 +2491,13 @@ ssize_t ib_uverbs_destroy_qp(struct ib_uverbs_file *=
file,
=20
 static void *alloc_wr(size_t wr_size, __u32 num_sge)
 {
+	if (num_sge >=3D (U32_MAX - ALIGN(wr_size, sizeof (struct ib_sge))) /
+		       sizeof (struct ib_sge))
+		return NULL;
+
 	return kmalloc(ALIGN(wr_size, sizeof (struct ib_sge)) +
 			 num_sge * sizeof (struct ib_sge), GFP_KERNEL);
-};
+}
=20
 ssize_t ib_uverbs_post_send(struct ib_uverbs_file *file,
 			    struct ib_device *ib_dev,
@@ -2720,6 +2724,13 @@ static struct ib_recv_wr *ib_uverbs_unmarshall_recv(=
const char __user *buf,
 			goto err;
 		}
=20
+		if (user_wr->num_sge >=3D
+		    (U32_MAX - ALIGN(sizeof *next, sizeof (struct ib_sge))) /
+		    sizeof (struct ib_sge)) {
+			ret =3D -EINVAL;
+			goto err;
+		}
+
 		next =3D kmalloc(ALIGN(sizeof *next, sizeof (struct ib_sge)) +
 			       user_wr->num_sge * sizeof (struct ib_sge),
 			       GFP_KERNEL);
--=20
2.14.1
