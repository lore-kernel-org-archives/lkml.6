Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520118761-2-2079069738899189343
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520118761; b=T19FXCH+0kFuWcuqTcHQMW3uNovJnPc/d367Y6/JJaGyv+n
    vAjIBCScT1jUAog6Fc7AIGFDgdUtQgMHNYe0BFNQ+2+JKOHlRb7f7acAQpNi5T0l
    a4AlKnnBqDMyXpD/JqbenSdQdOR98xPmaYOqHf41f1IpkcPaYVmgt/0Lh0kLXMRJ
    hA+AbqU+dWDeleUJbtvIVh5J/fpdUcEkD6qlCauTNynOuUfW5yoVswzgvGG39wUs
    vTUm6xdcP+62pkeEgpBXYJZWJ2EmghkyOqY6f2bc91ocRxNob0FWBrmBVbcNm8kO
    Fqyswtl6es+3pFgIHojnsZ1+jnYjAT+aao5nzEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118761; bh=As9Lo7
    8e1k4mTTSnlPQ4cJtKCu1ZKKL/kOL578lu+DA=; b=Wxy5WCaqQ0TTVJqcbM6sZx
    bVF+zCu1Hz8Xw356IxDoKCMRmoF8wyAWUvSLLTDGh8AOy+p3CMxojR5T54BeqR3N
    jdHgO5mu0sH9tubhchFWB93wwQXGFlwGpiNJkC/W2+SSMrMNzoJiaqMk3su01RBI
    LM0hpbK9KvROI1k3CnwR6/ZC7g3x6ATmvWk74vpCrrbE1iL0xcDb5WKcejkDYRJX
    nr3fqGQm1PkOpWz+libSZkoEnUUYjLXRtnH1geCoQI47HkmNSeLhoSvK+t/fGMEH
    hVy5JOuOYzQHrpfTmW3iVbIqbr7xmoxDz7zXbsyPVn0ZM64HWYlzQhZF0SBxTPBw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TnVdsshs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TnVdsshs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932509AbeCCXM0 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:12:26 -0500
Received: from mail-by2nam01hn0231.outbound.protection.outlook.com ([104.47.34.231]:38014
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935046AbeCCWjR (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:39:17 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 047/115] NFC: nfcmrvl: double free on error
 path
Thread-Topic: [PATCH AUTOSEL for 4.4 047/115] NFC: nfcmrvl: double free on
 error path
Thread-Index: AQHTsz9XTzoODMz9/kCtOXqzsbOEPQ==
Date: Sat, 3 Mar 2018 22:31:16 +0000
Message-ID: <20180303223010.27106-47-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0938;6:24mid5t8SV8Vt7ZI9/ttceLilzm1jeVTXE36gCmChB8/sfsd0lkatA7MtBHMW9CWKGp8ZilIKQ0VOpGQevBAIYBeFe6XeOhEBNnitflrBq7dWB7d2/j2066/7ehYwSkPR72ynglgd4C99VjHW0gSdD0j7Hm/FKxXBIosKhV4DQhZT5LMe/Y4aZd+OC/KsBu7oqTdlIGuEv761VS9WRvlsRsNbGqxolCTB2gZHd50QqjZ8knwDnEMwmTsBvjBXT91IRE3PcMyNnMSj2OEwcNhu1i0AM1ZWmCLWsQobkk98lfFyq+3Q/uus+E4ALjdMifGQydxJSMXQhkr2FjKA1XaGsUek5xLQpuRUwrcqq7iyPbttBiZNcgmB4lUonX/s/Aa;5:VOQZjzpMjFqW5e3nq2XA/m+/4fgC5FiilydZNG6roA8sqXP9LsdTyyIrmiMwSvQws7d2SX0KrnBPNxduE1O27MOJR8xMbAwn6i4iEfBFyEBTX/e6YILjED5WhdqYx18hg7PCmSezLDp4obAMUSaerzCbvRQdxYM2s43Jv7dTq2U=;24:BXZ02yjKAhyBPL0SjQ7NTUGS6fqY8qDcEcbFyWwsPZTgRR/jU3Nnc3C72H1rpDqyjfyh9hEZ3G+hAi5Ykoj2SQ==;7:q8PTDPFPSIOkRo2AGgQBb+opZ4IRD5lyFaox32BARAGWHqiOPuB6Xc/ZhbmfzDohGgDIPqjO+HHZrlaLIvF9lrDyEMHc4ol+uftiVJLPZqbSVbG7yEUuVk00L4KWG+ukwLRjDF8rCEIuvj9vt/RSoy4aKjD4TliySPLpS8KMc6G3d2636y8PEmUmtitablErPyYDFAL7QcCkzbY5DLISneWbSVUnXH7/sjxc9Ssyy0Z8GRpsefID9byk6pRSYjff
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 42f30c27-32ce-4fe1-4feb-08d5815797fd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0938;
x-ms-traffictypediagnostic: MW2PR2101MB0938:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0938666CE3E99521CCDB2294FBC40@MW2PR2101MB0938.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0938;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0938;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(199004)(189003)(54906003)(4326008)(72206003)(22452003)(478600001)(25786009)(66066001)(6436002)(6512007)(14454004)(53936002)(2906002)(6486002)(105586002)(99286004)(10290500003)(3846002)(106356001)(6116002)(305945005)(5660300001)(110136005)(1076002)(36756003)(316002)(2900100001)(2501003)(5250100002)(10090500001)(102836004)(68736007)(2950100002)(26005)(97736004)(186003)(6506007)(8676002)(107886003)(3660700001)(7736002)(575784001)(86362001)(81166006)(86612001)(81156014)(76176011)(8936002)(3280700002)(22906009)(290074003)(133343001);DIR:OUT;SFP:1501;SCL:5;SRVR:MW2PR2101MB0938;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: GZijPFdeuIrLosLodti+f0s6tW+8sSNkTT9MffpqIyZBJeeBe2UgsaODaRBgVVzYRiwt58dvRZfL8p1NiWLSpEaJ5Hjf/NFi2K9rJPXeTKkUfLXOvwjA/5YCHAbCG0ZHNe/e/7S8/44oVZb8K6TcO2g2TK0dA6/jSWoX1zOQEc8=
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f30c27-32ce-4fe1-4feb-08d5815797fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:16.2915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0938
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit ca42fb9e52d155547e6cf18cf26bce3e1a6af4ea ]

The nci_spi_send() function calls kfree_skb(skb) on both error and
success so this extra kfree_skb() is a double free.

Fixes: caf6e49bf6d0 ("NFC: nfcmrvl: add spi driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/nfc/nfcmrvl/spi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/spi.c b/drivers/nfc/nfcmrvl/spi.c
index a7faa0bcc01e..fc8e78a29d77 100644
--- a/drivers/nfc/nfcmrvl/spi.c
+++ b/drivers/nfc/nfcmrvl/spi.c
@@ -96,10 +96,9 @@ static int nfcmrvl_spi_nci_send(struct nfcmrvl_private *=
priv,
 	/* Send the SPI packet */
 	err =3D nci_spi_send(drv_data->nci_spi, &drv_data->handshake_completion,
 			   skb);
-	if (err !=3D 0) {
+	if (err)
 		nfc_err(priv->dev, "spi_send failed %d", err);
-		kfree_skb(skb);
-	}
+
 	return err;
 }
=20
--=20
2.14.1
