Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523243800-2-2343777505512750097
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
    1523243800; b=Hjmh16lb/WDyD/6Lm4lO8uoe2KUmntdNnRJasxoJVGwdgkUAJl
    z/CEA6D/E09xQgP3ZndgpBOeVxQYgenG90mEl0rBzH1rrRIHKti/IFZKr7Ga/ez1
    LRbbuNMHUxib8zhMPanH2W2gkxtZKpJTZkkPwPfuE1Wn2gA4Y/IA6DpykO6u6xgr
    tCb0IlJVjxQHzwk5vXdnxNu/APNyp2LSGu2i3COcGYQ7KcghoF7kRCf0OaRVois5
    DOwEJDXv8r/e3ZvnN9uhTyODQFzHoqk01pgQUGiLBNqDTZEGREAgCwUp5YVrl0DG
    JZSgUwriYk9YI08Gw8J9DkEUUIxmyumn1b9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243800; bh=p44Q0AJwQk
    mk0095t7yPQyR85uY2JVSVx+gSug4WRZ8=; b=XpJA4YGVYwbKW8LnZjzvdvoYf3
    +oCvZETCYJ4WiYpyh2/V4NtwH/mJQ5HPfcGgY6+n2WMKznSc0rDd4XCmEpl2xN3d
    BCUa3tClePcz6FnfZkPtmgNLZdZHNuKinGSWG+RUg54T5lnpfdJwo425bZhtFl9k
    aHgrr+yZiOZs+FadFheu4zPQ/rkl2aPt3vaOCkmuPcykclmXWanYPiH961DufkkV
    e8HmMjHO8iVXRq73IDD2WjcN9F2wf6/mJE2FyOC2ijHOk+OzrNoZoC2mXMZ4iAif
    87A9zSyh3RnmR1SKeJSBzkkHNddt/nI7Ej5tRpfa8UAWJMLiDk33r9q4EGJw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Raeq2b/O x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Raeq2b/O x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGwHuJ1cen+rgtc2HHAEAEveZeRBox22pjOfYWTYijcfjkznGVrafes1MWImfjKQYbGB5bptQ5HIvQvf1bC+GxeBn/xu5S5pXTMsJOlr9sCg8KHXjP0w
    NS9cGgtm1bRG/MdAhhu/yEnYO/x36TGDohrLlY95NftO/hjMghkUxICITV5TzSxtQnMUjxoRstRR2SeZboOzfk3kFR3t7NNtURvFouMkI0SXXb7mhryrzSic
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=i0EeH86SAAAA:8 a=LD2kUS3hAAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=RSO0-gUth4KjHVd8v3gA:9 a=cfNw1LOEE2Me2ayw:21
    a=PmnZ8jsOwSV0899g:21 a=wPNLvfGTeEIA:10 a=FTB9xuwByZgvWSGbqjUc:22
    a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751757AbeDIDQY (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:16:24 -0400
Received: from mail-by2nam03on0115.outbound.protection.outlook.com ([104.47.42.115]:29467
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753922AbeDIAXl (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:23:41 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Wei Yongjun <weiyongjun1@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 063/161] nfp: fix error return code in
 nfp_pci_probe()
Thread-Topic: [PATCH AUTOSEL for 4.14 063/161] nfp: fix error return code in
 nfp_pci_probe()
Thread-Index: AQHTz5iVAlEOKFAR6kSKG1kvChIy+g==
Date: Mon, 9 Apr 2018 00:20:37 +0000
Message-ID: <20180409001936.162706-63-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1080;7:enmbcHt7L+ascoYiZPOBmDrLT3kRSBiajenOOwFW33yCb5pf36nTTvtfOhEaqlabJY/gojF4BAQdfGIcUxPA35wEInJQeEgUomyusY3ujtXMLyZNaGkqE5MwU0M6KpGcoFsApdmZNOqXqGricQfHxJtrI4PNPuB7otOEo3J+bK64YlZa2lMNJVWGwyTTdXVkW46etySA2GGnNXHEj8gtcPB2cRJZqtEaZFhrMArMJwbFz4tAievsd8ZM19fWTdAx;20:FIU5FWk24FFc7s55JvPr1qqsuf1cDQAXgyPJNT/whF+5Z1XC3/IA0IQGN/+qWz2wuK7tFHODLBfb6rPLvnROfM9gE1ZicUZJ16t8Bsi6oAPfLTTjg+GINOW0BUdUxkiueVwUi55vqQnm8ezmdXE+hIXwPC+CSz2OW8mhc1N7eGo=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 82779a38-4951-4a3d-40a0-08d59db02384
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1080;
x-ms-traffictypediagnostic: DM5PR2101MB1080:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB108098477E8F1618D0FEE77EFBBF0@DM5PR2101MB1080.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1080;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1080;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39380400002)(366004)(39860400002)(199004)(189003)(2501003)(5250100002)(8936002)(10090500001)(5660300001)(3660700001)(446003)(107886003)(14454004)(36756003)(6436002)(476003)(3280700002)(2616005)(11346002)(4326008)(53936002)(6512007)(22452003)(305945005)(10290500003)(316002)(102836004)(2906002)(6116002)(66066001)(6506007)(3846002)(7736002)(486006)(54906003)(110136005)(186003)(72206003)(26005)(1076002)(105586002)(2900100001)(6486002)(97736004)(478600001)(81156014)(81166006)(86612001)(8676002)(106356001)(99286004)(86362001)(575784001)(76176011)(59450400001)(68736007)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1080;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Rk7Lb2DmtVjDTUnmqWVYyuf1Kav5AS/xSiX04u5X0+wvV8DFcpeNEAG2a4y3AJJIftVGI2DmNVzm04rd3j4jZHsTcVtkIgvfGy36+amIlVeTwHsoXnkeacikL2vC3eAG1eC3bAdeV5XnopkdXx4cnjVBSktxGG/Xe85B6O+MsSVXiz3j7edy2MrMvPcyCkgJLFvxwMKAoY8GRAM2yKphHwymlP2Cz4Dgofqb7wd+bFcD1NKMXpN9RXzGXoB2Y9oDbMkXBlhCZlFL8MVgzLdekMdysaaMSs9dGoRpbEnCebo0ph4malNzJnH/+SY/iEKhtnCuhJ94em5jalj+KMMgmhvNJXyNm86inuG6ynCoSj1uyq7lEJlwccLgc5qFIZwAEC71/KSoltkPZvShQUmwNjc3hKEN6QvhhwnsmAsKLoQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82779a38-4951-4a3d-40a0-08d59db02384
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:37.4254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1080
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit e58decc9c51eb61697aba35ba8eda33f4b80552d ]

Fix to return error code -EINVAL instead of 0 when num_vfs above
limit_vfs, as done elsewhere in this function.

Fixes: 0dc786219186 ("nfp: handle SR-IOV already enabled when driver is pro=
bing")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.c b/drivers/net/et=
hernet/netronome/nfp/nfp_main.c
index f8fa63b66739..a1a15e0c2245 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.c
@@ -492,6 +492,7 @@ static int nfp_pci_probe(struct pci_dev *pdev,
 		dev_err(&pdev->dev,
 			"Error: %d VFs already enabled, but loaded FW can only support %d\n",
 			pf->num_vfs, pf->limit_vfs);
+		err =3D -EINVAL;
 		goto err_fw_unload;
 	}
=20
--=20
2.15.1
