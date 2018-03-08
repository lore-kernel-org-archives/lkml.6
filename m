Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520492248-2-15264632775866988044
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
    t=1520492248; b=S0VxHmD72lhMcnSBqpZ1kABLlkNV/TrYVDpXHS6BdAoE1u7
    vAKASkmE21csI081UG1KHiwqTKLSx2e8OzEW4knJfF8GPYvXLNla4JmzfxhLHkrV
    wy9xUQe+5t4SrQI77R7fnksRNESqTza3XhISSryR3W63TZfdNh0AJmnNgSBOsE0n
    j+pOVX7guU8w5k4/G2PdG4QblZwhMiYweqPeTiek4phNfP2ZDtxy88nWCo/qNJnS
    mdQ5I2lGH6drGTJLYVlZ7T2KArzN7Z72MaTd3oouLN5pqcOxhkT04OWEYrLQqjaM
    1xrNr2PD1+QGtJYF4tQZo3ni21OTuFB9Snb4qfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492248; bh=JkwXXT
    01fCRVqcDRBhgGnSoYC2nPxFJbNukPLwlkyjg=; b=eOMtZLDg6oVzrMmfI1Dq03
    LlmOV/vwumvkVM0Ph/JO5LP/YIkgaHmUDEnBsG6lfaelparu6ovFfePxoUgheLs3
    woPO2n2crZvYlv7GeacdL01OlXjg3Q6oz6bP0/IJJVZ6jLrL6uFgYxYd5X4ppjAa
    YREuAm2Xi05o+wXEnJ1hdBV6ZXeKuETqjFoK5hhlHRl2tp5zL5Nw2ZtsfyaV0K60
    9bFeMfIqldLP0KIuBh/6j/QPhAZ4zKi6usSKvZEeUsiRl61z+mHenVghOksKrIZq
    j3KFU4eQYXO7TN6ZfMOXGAznK3W04HzVkt3SaSALV73WqFG8A1ILhnqsCTfPVJLw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DPHWDWdN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DPHWDWdN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935169AbeCHG4Z (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:56:25 -0500
Received: from mail-sn1nam01on0120.outbound.protection.outlook.com ([104.47.32.120]:33969
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964956AbeCHE55 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:57:57 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Johan Hovold <johan@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 66/78] soc: qcom: smsm: fix child-node lookup
Thread-Topic: [PATCH AUTOSEL for 4.15 66/78] soc: qcom: smsm: fix child-node
 lookup
Thread-Index: AQHTtpnS7cK+ZxzGMUGxjGe6r9e3Ng==
Date: Thu, 8 Mar 2018 04:56:30 +0000
Message-ID: <20180308045525.7662-66-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0888;7:/IiUjpfwIq+PEkVPrLT2CA678EgtFlku0dcwGpjHsToEWMjaCvBtcdEDUmEMrMc6etmTPLj5QW8shGVwTG1XnULsdrtMESvwd3PJp5OPuKrjQSetJSgXoKDidPlIBP8FIXgKdbkAXhDx/cATkwypmmU33Jao7LZWhTB6dc1AqRXljYq54U/zFmtIDjGbGGtNqnedEQnen7Djf8jQA1zDAYnmNKVIf9ERJ3xH+b50UsjviE0vA4/DO5eD9XUXB0/c;20:G/JtNFcdQh+d5jbdYVvrajBTuUKS3Vvs4787ZcWGpJL5oTfDUzDG0rdVQmhANsub2Z1HmqrLCh1o8f0UskceylD4A0r3TXKJUfV22J9fWZ7cmtCxY6Wdjdwfb8GgccLm3Y61xOdpw6NZWbi2QqSCSQ66W6Bvl56SmTQSmIDKl+k=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 035a6d42-8496-4e61-31de-08d584b127ce
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0888;
x-ms-traffictypediagnostic: DM5PR2101MB0888:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0888321AEF16A1A37F17A938FBDF0@DM5PR2101MB0888.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0888;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0888;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(39380400002)(396003)(189003)(199004)(6116002)(99286004)(2950100002)(6512007)(6666003)(10290500003)(36756003)(5660300001)(106356001)(1076002)(22452003)(39060400002)(3846002)(97736004)(316002)(53936002)(68736007)(105586002)(4326008)(25786009)(54906003)(478600001)(2501003)(186003)(66066001)(76176011)(3280700002)(86362001)(14454004)(2900100001)(5250100002)(110136005)(305945005)(7736002)(72206003)(3660700001)(6436002)(2906002)(26005)(6486002)(10090500001)(8676002)(81156014)(107886003)(81166006)(86612001)(6506007)(8936002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0888;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: a4xp5+k/nfUIoA7L9W/w/7snTKNh9Tzkp8eGq/1viYqqiQ9cWYK5x7/poxpWgco7XZ0EJPd4S3/guAFEZ+Ni+ZSlUXWLG7wtG6E+0QzROQO0YS0C6fr0nVKquz6Qmla25lUiPDWLCRzbZbUJQi64yCvdFjaNM4nC2U/8JLRH4CtHb4i708Qk8xnUXO+d5TZCHKxpXRM+a/vGBjO3NDiNU7PwTEoYxtgsgLW/1rWFyGP0gzD8G2CYLc1+SU6pG6GS7c6tZSbQ6+x2hGFYDDMER1NMfB9hgOhwgjqKA3c64SPR3d22lHbWIYln5/9AWkMe4BO7IZspV3qiGrDlw4attA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 035a6d42-8496-4e61-31de-08d584b127ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:30.5702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0888
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
