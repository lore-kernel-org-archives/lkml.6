Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523245634-2-1601187279283581028
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
    1523245633; b=kmG8SRKyWb2OfbH9G8TYlRu4YxEKtVRM/uhP6DkU7jVBnv0s9a
    Phq6MYqXmmOKS7eEL7fsVQh9fAgwmLl8ppnGNqn9o++i45ipHh+XXvtrJsfFQ48z
    +jts5ybvZADq24fUN8cjNBuNhGndUML+9ITOsjF98QODc8DIgsPaqv2xSNN8vj/J
    +RCoMQVWaBf8eXBMT5XN+xbngb/gqIj269y+94mX9QQ/un8vDze34DwFp0icAkht
    g0JeJvcNBsV86T5aDr5DZkeQOiYkp7hGyiHMrg+BHKeahJ2WQIOGtxWQh//S1SkL
    1qc67oJBfX4nJo2UkpQdnKgAju3JVtQnLQJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245633; bh=CkBk/9riT7
    cAP1BwWcAlKGpOMu8RzngJ2O0iYhw7xpM=; b=dL/pz+8kKzqlfnjQEOdio9tdhY
    ucigjQFrygarREGZjYnoiIumPU59hyG5mYV7Rg1cOKyv74aBr6JCdaCYVnFC0YoU
    iqhRC9eBFdl69SO+Xc5j7t0Uy9WFa2cffQtmxztNm8RK96sH2uBpNhPaMRh0TuT7
    wFpABYezdffkLdlQldUez/Fa9GUi02hTyd6Et7wcEBQzlWTL9xsrrTXmqTY0j3U3
    WAYWJHGU7T5LlPv/pndFaDlTyimDj+D45SpsV0Lre3VpdhcICtldPi0cBl+hKcll
    /DcmXyKs6R36BMXXXQ7LyHIUsaTWL3ZLCjAPK+JUi4js6hSty6zUO1GB59xQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lYwcVGIE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lYwcVGIE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLDBHaOzcMiEbMVkMYnWV3w7eRNpLoPMY+ibkJ7DQjdOfeRB30xrrWAHii7zg5SnkClASKqjrQpL2FbT3AYXb/Z9cgAeYbVcxmlKEdRIVJOW/mHSVsox
    AaI1QbwG8SojFQb7dFElxZkUQYtH1JIOSTeaTISgloMHsSCFvavKUrVKwbYJuo/he9RV8WEjdD41UoVtSf5wRVuMlHTeRr84aX7IJiJ+lKgxZIsRqzVi6EcS
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=1RPgKQ-OxboPECsly6cA:9 a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751969AbeDIDqk (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:46:40 -0400
Received: from mail-bn3nam01on0125.outbound.protection.outlook.com ([104.47.33.125]:5792
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754175AbeDIAUO (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:20:14 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Desnes Augusto Nunes do Rosario <desnesn@linux.vnet.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 127/189] ibmvnic: fix firmware version when
 no firmware level has been provided by the VIOS server
Thread-Topic: [PATCH AUTOSEL for 4.15 127/189] ibmvnic: fix firmware version
 when no firmware level has been provided by the VIOS server
Thread-Index: AQHTz5hID6xX8kBQ6UyzLBnVHm8mEA==
Date: Mon, 9 Apr 2018 00:18:28 +0000
Message-ID: <20180409001637.162453-127-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0726;7:fGhDCutDhEEEvfAhN+fA7jN2vJtc7JCE+Jj+09xzHhVlqNxpkECTj0uCNoRPZ6AIUr6ZHNenjdw0yENfUB78bH6HevlS7iH/dB2R/EjBy5V50DppcPR3hV2dwVR4OxtKBuNPpodz14g8YRESw+7ag+LvTL2OIyMg0QshtGJBHpYmozpVHitG/b8Mv3095BaHC7vv6dqFu8AKgEji4jB9soOD4cGHzNvhzsWPnn8qYRqssZdfl6Qt9wv83p+fB6s+;20:V+sIs1qUMBOCJeuO8Rc74nmvfIyVoLhH9Crxty6IQCKiefUFskrY70VQGnVryncOTOR4/U/xv1gvnpl/h4Hm5j5myBP5DVRXlwmx50tuQ1Fv5EuGGyuZyIqJeVODAI3yyRNEQJl9kHIpTKMKg8JFOcK3dJ7TuS28k5VYmS8bSBc=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 415ac0f5-f327-495d-0ce4-08d59dafa60f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0726;
x-ms-traffictypediagnostic: DM5PR2101MB0726:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07261720395D5CFA005B7432FBBF0@DM5PR2101MB0726.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0726;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0726;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(39860400002)(396003)(376002)(199004)(189003)(6486002)(26005)(6512007)(4326008)(81166006)(6666003)(6436002)(81156014)(8676002)(97736004)(186003)(36756003)(72206003)(53936002)(107886003)(2906002)(86362001)(575784001)(76176011)(110136005)(305945005)(10090500001)(486006)(3660700001)(102836004)(5660300001)(14454004)(476003)(86612001)(446003)(99286004)(68736007)(66066001)(11346002)(54906003)(2616005)(1076002)(7736002)(5250100002)(25786009)(8936002)(478600001)(2900100001)(2501003)(3280700002)(105586002)(59450400001)(316002)(106356001)(22452003)(6506007)(3846002)(10290500003)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0726;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 1Lc/5xOoVroez20SsgTqVYmpGRjbuB97nSk1Onzt5/zmLTgqjjljiJLdI+mOMkFd7t7vLYy1v5KasUm+MqJqEoBceW9wqBMCDmFNCPDp/GF1C1+tCIeI98dwQilKfsJF0hvddEwF08LJ0y9FhemQ60gRaR6tl0pa7mxNJ+ARhWj89Ay4KYNyBx2E+gV5UXJfvwOnPB5QuxxpY0aJSnSQzAFToj2F+c9nV4C8nGjVpBb92GZNDdI2l16GSC5YRnnYQAf9hahGgjk//nI2PAj/kpJJIXRrTCMlNjiGpLHRRVlMpPG7hmKdHafj48nb+nvK2+7BBN9cT4dNLWSfber0RRmmEstwhCyCq9cs1cfPaAI9Upb9g1L+4qgaJu+n8U9RdXvXVMfx+qESJN3i4Pn5SDdnnP8T6R2PArn2X2FDtGw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 415ac0f5-f327-495d-0ce4-08d59dafa60f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:28.3789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0726
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Desnes Augusto Nunes do Rosario <desnesn@linux.vnet.ibm.com>

[ Upstream commit a107311d7fdf6b826f3737c4a90fd0e0046e7a3a ]

Older versions of VIOS servers do not send the firmware level in the VPD
buffer for the ibmvnic driver. Thus, not only the current message is mis-
leading but the firmware version in the ethtool will be NULL. Therefore,
this patch fixes the firmware string and its warning.

Fixes: 4e6759be28e4 ("ibmvnic: Feature implementation of VPD for the ibmvni=
c driver")
Signed-off-by: Desnes A. Nunes do Rosario <desnesn@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/=
ibmvnic.c
index d4e87333bac2..4ba49a98c689 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -3294,7 +3294,11 @@ static void handle_vpd_rsp(union ibmvnic_crq *crq,
 	 */
 	substr =3D strnstr(adapter->vpd->buff, "RM", adapter->vpd->len);
 	if (!substr) {
-		dev_info(dev, "No FW level provided by VPD\n");
+		dev_info(dev, "Warning - No FW level has been provided in the VPD buffer=
 by the VIOS Server\n");
+		ptr =3D strncpy((char *)adapter->fw_version, "N/A",
+			      3 * sizeof(char));
+		if (!ptr)
+			dev_err(dev, "Failed to inform that firmware version is unavailable to =
the adapter\n");
 		goto complete;
 	}
=20
--=20
2.15.1
