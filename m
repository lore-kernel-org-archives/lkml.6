Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523241020-2-5886082489333536197
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523241020; b=HL9R8qdM/qYDi1O/TlRByA/g1PLRhMpCq0BXYRp0a65m/WHdNx
    hpqjfkKAwnPk0jD8Q5457IE9Tg+WGs/ZJbislfupTSQgzwrIguEwQsoBNWtbh8ar
    CPnOKJOB9ByMKQh8gl8FxlHMIK3AiGvbVVOfTESS0G/UgHe9rhy8YwfJUrUlWpSE
    P1eJI62/56JkGRiQCzjf8TGh3DAZ02whS28KxLGWRLtoCDJtZJ7F+qcrFa6zIP8+
    b0QfNwIc9wADvB1YDNFL56npKou7d/A9pmn525sMIk0pTjCGXhkj3FFiGnCCs/k8
    G9+od+Rm2oe44CJK8/vnUuM6p+fCxvW4/j5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241020; bh=2gzdbIZyFn
    UkK9N9cRZ8jPuXQbGUR5WYr4QVAieXB+A=; b=SrT6oac7FVK3g1OiJtDWM9Kxid
    eJJI2wXJsrFmJ6whBqx/qOR+d1zob9nk3LDYw3BH599tHOLe73kHKJkqEQ65vV/x
    Ub2+RCmdsqPFKjMTsI2wiNShdkZl3qw3oc78MqwpmS+CBdVRFiUbV6uJk8+GL/zM
    BhqvbuaR64tY1E0YcwKYlJ8W8RYN2NP+DHgpGF2tCyTGJVrc1xiZZlyHp6m8qFjK
    xQvCStIrBSS+cboTqOeNyfapDMsEco8JdY9uRVQtmRaviXMlvVfYOTVmy0PWjO6f
    ZX3ahxrk+067tT3FAtC8EQwseJup5BIxFUORE0MZS5tOZYHXav8sJlkl775Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ajiT6chu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ajiT6chu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPARbgxPAPrySj3XwtHDrEX8yDy5w1xH3vuo+uK+zApcIKAJ2EzvjxxY7uTgrS7tOEgj4mLB8J1Kl6B0PASa1F2SaqrzScVjIN+OvevgvEj+Lr3Xdof9
    ouVMfkbHfjnibITGI7ZTPxdayYE8gjX3SZ4Ve2y+2vLvIjtQselJ15Scj6tbMT680K3guRbPZnb/LOUGJRXJI2iqLMltJzKG1jPOwPZCr2fcMCIPGE2yPxaG
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=aanow4ppfTB0XD_NjqQA:9
    a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755871AbeDIA2g (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:28:36 -0400
Received: from mail-bn3nam01on0096.outbound.protection.outlook.com ([104.47.33.96]:38912
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754315AbeDIA2b (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:28:31 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 074/293] of: Provide dummy
 of_device_compatible_match() for compile-testing
Thread-Topic: [PATCH AUTOSEL for 4.9 074/293] of: Provide dummy
 of_device_compatible_match() for compile-testing
Thread-Index: AQHTz5kJEQty8ZQVh02P0CeS7eHXcQ==
Date: Mon, 9 Apr 2018 00:23:52 +0000
Message-ID: <20180409002239.163177-74-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:6kH5pcghmHLrq8syoWuDTASCxmoL6XS9R6PYQpbZcayB5m8hFUvb0For2kMxyi35zukHxVJtodJa8PyJ0A/UrDA/pumzvCjB07VRg9vwSZo4zHQs3QXwQGeTvnXr0pHaN+LnvqYZi0HIFedmvetXE8XdwCFiIlScVtDgwBK+pBJI0qoXM2ZyPa8aHdautpXwOdLHXTsnFJYm6yLoUVLF8e2iOnD+g09To3xiiqqj49tGNS/PFdr1+HwX3DJ7WshU;20:cdshIIE0ZPzZBCicxTzKjwxfyymjFRqquqOpdCLmZlrnTp4fTwG9rz/AUZ2DWKQwktdoS8GVO8+N5wI54g36unURKY/cvDXNKNj5iHnonueObUm+8IwBM0UYiKcJ3vAOS2SEf7FbuvwHoH1KGZcQjMhs30l6IbqpsveNq7akgzg=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: ec2e3bde-ea88-441d-6ffb-08d59db0d061
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08076D05B6B7A51E40D91095FBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(6512007)(478600001)(3660700001)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Nxn0TM4P4mJ4PfxnufuYa+Jdpb69M4UDlPZT0WVFIXM6aZ0Xj2Rg3/co/YPzMSWhHkaKvqEpt8SCjD3SGSbc6bRHLFCh+0Hj/lbz6fulj/N9FNmg9U8wIj5oLe4kKjSyDqggAhXBbpSdSiPy9pEYCiqeRVqOeLSM87N72CMemK5XOlvdnSE0Lzi4rb/tYVqsIZ7SQaLtX6UdwCl+LFmc+jTGksP7zl5wfahij1PXT0i55TndQ1x+DlLtJK2wGFrOj7ejp1JBBveoY4uVpH0zvibdFr+vU6a1i6XtHkPTjIRkd0OBzuqBiuScFc1QZA6U3V/Wz6cf2htoNcNgVl/yX+Ih7BZuXXK6gBDaEjAq4JV0Ku336U4bLNk50qhuv2smONyrdNBi2W/kAeFEiZAGZg0unKdvqjUKg+CaCwZRUnw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2e3bde-ea88-441d-6ffb-08d59db0d061
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:52.0343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 3bc1630774bc9f202308ae04608a32c366b41caf ]

Most of_device_*() functions have dummy versions for CONFIG_OF=3Dn,
but of_device_compatible_match() hasn't.  Fix that to improve the
ability to do compile-testing.

Fixes: b9c13fe32faaa71c ("dt: Add of_device_compatible_match()")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/linux/of.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index 299aeb192727..283eea3e5261 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -619,6 +619,12 @@ static inline int of_device_is_compatible(const struct=
 device_node *device,
 	return 0;
 }
=20
+static inline  int of_device_compatible_match(struct device_node *device,
+					      const char *const *compat)
+{
+	return 0;
+}
+
 static inline bool of_device_is_available(const struct device_node *device=
)
 {
 	return false;
--=20
2.15.1
