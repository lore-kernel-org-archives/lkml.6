Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520491059-2-12028642858281441351
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
    t=1520491059; b=YVwTVoQkxZ3cF9pEaURZ6zcE1Sc3vuG8GC6GhMVpyldCFNm
    UIJB1kLGOyJPI5i68gUQjFcS474dBKLvsys32Dst4bJZbJfG4wszt2MBpoadX7H9
    hcHgOWKuXBKsbFXTxmHeblytv1D0c+KZM+UUNceC0SkKI3JxnQLHM6aDcmIGrSOj
    6VIwvjJR5Na+RMRPmbn8F8epFK4BeoHQnnA3vfEm+4vulDcy9sAqKwcjLCQaQAe4
    vIlMmeVGbLq2CtknLaVhNX0wMJoPgii9CKRCwFEfT0wJ4EGMlzcRt/311dIn+1gN
    uAl2iVom3vwIBvhbZ3kiqiLkXSNlKquiRaKrY6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491059; bh=JkwXXT
    01fCRVqcDRBhgGnSoYC2nPxFJbNukPLwlkyjg=; b=E88wDKDCHB1rhY4/84OGpN
    lyZ7sg10WatJvryg7s5GaDGV0EmiX8FyR+FWQ33ARyxnSbkvpKaichoYD1Zdrwpz
    HMgJqbbCyHRVm13EqBrBhwCKclqqeICHtLsPkL7LAo/in+BCSa3J5SsBpAXmV4Rr
    N6mMOU2jK2qiXJwVlzGE9FpG24bgrLxvAtjBwDb9MfDEe6ZTZvJf2dLj4lA5gBpQ
    O+2HWEhjHCircSXpKg63JEq9hnH4k0qwgC/mn+ZdnvkTxg7KX43iKhiCiEHdyGCJ
    75vn0vHfNyjh4K5v0fa/nzvzs/R01noTqDu70evjoyB4rvJKim5sPgo8mKzrD5vg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Mg/4mTUC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Mg/4mTUC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755558AbeCHGhg (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:37:36 -0500
Received: from mail-co1nam03on0126.outbound.protection.outlook.com ([104.47.40.126]:14720
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965341AbeCHE7O (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:59:14 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Johan Hovold <johan@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 56/67] soc: qcom: smsm: fix child-node lookup
Thread-Topic: [PATCH AUTOSEL for 4.14 56/67] soc: qcom: smsm: fix child-node
 lookup
Thread-Index: AQHTtpoFMsEwNkQ8n0yM3wRpkauhSg==
Date: Thu, 8 Mar 2018 04:57:56 +0000
Message-ID: <20180308045641.7814-56-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0999;7:Ru3FyBvnZ+dnM/27lpG1cL4S9sq8MV8Qbzlgn6B7jDOMsoW10ZV1soOT1c0iKPjXTM8d54dk6hFEcgrdbbyeUdJQKaaRwMDeGfzGcucymPsQyit/cMFtPTa5zdFUY/TwGbK94zPefNlyew1Zl29KJdq0W5doa7c+y2422xNUJr27vjZ/leBev60VwbNRA4SYw7/wRRlP6CfL7PHa9vi0mBJvQ8mXs0P99lB+4vPE6VYl81LqAVqpqJoUvPE7yZzP;20:YjfTqX/y7JfV6eWuvR2StfUJgkKwZKHwQgxZrQol9jT3B5zyAXmuZHUJSWJCHt8F+XclPA8jgqVl/hmy4TpscLTlBdZF2VDigSm4kDWKRaPfs9Y+QXfbU8eO6X3oBhU3rIHIfB0t1j10aJBCjJipycr6JOyFs38NBAMs9pPMijw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 12481e0f-bb21-4390-fc88-08d584b154d8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0999;
x-ms-traffictypediagnostic: DM5PR2101MB0999:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB099944DC756C378060ACF474FBDF0@DM5PR2101MB0999.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0999;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0999;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(39380400002)(376002)(396003)(346002)(189003)(199004)(72206003)(3846002)(106356001)(8676002)(6116002)(1076002)(6512007)(14454004)(81156014)(66066001)(2906002)(3660700001)(478600001)(10290500003)(8936002)(6486002)(305945005)(7736002)(36756003)(2900100001)(81166006)(4326008)(25786009)(6436002)(5250100002)(105586002)(54906003)(22452003)(76176011)(5660300001)(10090500001)(110136005)(316002)(39060400002)(6506007)(86362001)(186003)(2950100002)(97736004)(3280700002)(102836004)(99286004)(107886003)(68736007)(86612001)(53936002)(26005)(6666003)(2501003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0999;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: rrNzgP0qvWKNlpfXatLAMNDqqmppNgSugWr3Wcgt8xw3K5e+ChzdMLvkzcJFnOYimrRotMFIF448OCBy9WxlQpzGHKxwK+mMp54VghuVp+RoYLMqO6poat4wJhmd1muwpzFGAXEETN+4stBoa4OaOxT1u/y60pw2QFwVW/BaWl1l+lyC6P8gLAM/eM1FCokbpyHHg8CVLyOIyV/fsyIr3VPTGCNUEXZtIoU8vwGLT1L1a+yCm623QSv4qwDxeAryTrx8I/r8wFIUHk7bq3/qKavmpVVzZnwmSPGAqBZYN3IwTdFrrznMY9c7c04+vn6G1JXnC/MmjJlYKPLndw4HNQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12481e0f-bb21-4390-fc88-08d584b154d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:56.4072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0999
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 8804517e9fc16c10081ff5e42e7d80704973a8e2 ]

Fix child-node lookup during probe, which ended up searching the whole
device tree depth-first starting at the parent rather than just matching
on its children.

Note that the original premature free of the parent node has already
been fixed separately.

Also note that this pattern of looking up the first child node with a
given property is rare enough that a generic helper is probably not
warranted.

Fixes: c97c4090ff72 ("soc: qcom: smsm: Add driver for Qualcomm SMSM")
Fixes: 3e8b55411468 ("soc: qcom: smsm: fix of_node refcnting problem")
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/soc/qcom/smsm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/smsm.c b/drivers/soc/qcom/smsm.c
index 403bea9d546b..50214b620865 100644
--- a/drivers/soc/qcom/smsm.c
+++ b/drivers/soc/qcom/smsm.c
@@ -496,8 +496,10 @@ static int qcom_smsm_probe(struct platform_device *pde=
v)
 	if (!smsm->hosts)
 		return -ENOMEM;
=20
-	local_node =3D of_find_node_with_property(of_node_get(pdev->dev.of_node),
-						"#qcom,smem-state-cells");
+	for_each_child_of_node(pdev->dev.of_node, local_node) {
+		if (of_find_property(local_node, "#qcom,smem-state-cells", NULL))
+			break;
+	}
 	if (!local_node) {
 		dev_err(&pdev->dev, "no state entry\n");
 		return -EINVAL;
--=20
2.14.1
