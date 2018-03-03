Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520120995-2-5679183791814420455
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
    t=1520120994; b=EEP9QV8sehHkTEG11e2/Cs/hsgFFtuPoXpnIbJ6IF1Jd3pN
    8KDNTcJ13Bg2kmZ0HS7nQvBG5uQ0zg6XF7rT3H+izCDyV7BL25iRpibCJF0KT4Dw
    Xp1SoTmTJXtP/feYsYr5DVv8XJYz0WdQ3vyyPn3LQqxT3/exFq/H0pvnKO7S1wC3
    hQxRYq5RCTuc+zNCPHZ8R+9FKGUy7HGKYb0s7fOq9ePV/jZfvR4l6PqWyCJLp6JR
    k4BylOJlkk80SLIkos/DCTHbcthC5U7vedf5PShbTaA4rVG3qoFE376agf1EYrRF
    3qRZect99dn1lWpBtJ2AQQvj2VkXGgU6CrakQ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120994; bh=As9Lo7
    8e1k4mTTSnlPQ4cJtKCu1ZKKL/kOL578lu+DA=; b=K83+oT1CTtXlFfqfCgsJzc
    i3uCleB3eb5fC7idL+vdsKQNYv17YR4pzdo0N5T8y8bAz42pQ2EP5qvuUOxteuK/
    IAqFjAp6tJ4rDfpLgbYAoMOmTOoW5jyKfD5ILlm8/TQkbqV1tG19XQFPbi37EwKq
    t1GQcq7uylNVtRz5Qk5Sxif7DJtPwZRTLIbPeBXBxnLWG5UlFqEZPE5JQggHbWs6
    NXzNXJ3upyyEkTNcshCL+yPK+BA7QLzLIP+wrsqjiVN7NNhm0k63QVdvOBNIHGFx
    xh4Hyylu/iGuz+10EaTtrifPrKr/H4n+5aABJBZF7ORC03zgXIPX1foJPuTKK/nw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kan2i8sl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kan2i8sl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933531AbeCCXtY (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:49:24 -0500
Received: from mail-by2nam03hn0249.outbound.protection.outlook.com ([104.47.42.249]:31942
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933639AbeCCWdy (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:33:54 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 094/219] NFC: nfcmrvl: double free on error
 path
Thread-Topic: [PATCH AUTOSEL for 4.9 094/219] NFC: nfcmrvl: double free on
 error path
Thread-Index: AQHTsz8A+eja3HPHC0+b7P8xL7wfxQ==
Date: Sat, 3 Mar 2018 22:28:50 +0000
Message-ID: <20180303222716.26640-94-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1065;6:IdbobFlgtnrdOgd3EjiqaYhMkF9aIh5kMeGsfPbPz5g0xciwfzvS7zyMtSXri013wxbFzz0qSBB5y3Gg4J9JFFDrNhCC6TQvw/xczy6Yw/VbgdGRPXWrELa/ogHPK1Xht7cY589Up8THrIeQ8XwQLKqbUT8PloxgpAIb1xYaWxyeDxbUJZvQPcca1lFADnPzNkQUU/NAvrodUHI6Rp/WdpLftjO1B97zeC3NBzivfjrJHoglNiwjnBs8a9R2rBa3VMsVywOD2a2Rrm4qWD07EZptM1I0P0a3Hyo/sbuQqzfLwnr3uGXPRIthdcODo8/GOtv5P1/gmeHd+/cgCEYE2kGmmYmh49reTC8ZrhAuEMkBfCdS6tofXDLmgfvtSIEJ;5:pxdvo/v5Kr9GTAQMYEuk61p/4wrJoY2lJQ968aYyh8sly1i9wl6s1UiF6rlmuMLUfuZJcwiwegmYjp2DUJAkZUYFnPqbWvXsy9wg+47lp27nxixlkcpfW0hw52sRXblFwGVMp3KccUutNkWgppdQbSFgvFtSZULlh8q3kizE5ks=;24:0kQcchTZqNVaRTkyqpjBzs/vCclYSl5jZ6A5iK0VXZsx++NaCjRjhLn3JPWn3Q1be4W9IzTbGuNSmdkN1VH0OQ==;7:NfpiEqAdoba+L9NnzvGQ3c5ugcBuvckuaw6uyCT8WLGegNuQubYzE5/IYcm9gj/9NA8wJVhcC0AEFSI7RE0AuhCT4yaxAIRlu3VnjJAQpjxj6kfWfAa1kMZHzMI6vupwSI+Jhpp50MMmWNdQPx4R7TETghtR7VLUC0hsI7rvQxyMXFEPwhEg2v02K3L1vpxGwHqF1jr3j0ge8gvFH++CGZq/wmHT3jjdOq3uIdqfiEUFHDSK43rDai2Kee2xfSiv
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 785d43f7-0e87-4dd0-adda-08d58156d771
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1065;
x-ms-traffictypediagnostic: MW2PR2101MB1065:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10653C5B94FA5E1375214C75FBC40@MW2PR2101MB1065.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1065;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1065;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(189003)(199004)(6506007)(22452003)(54906003)(25786009)(186003)(2950100002)(102836004)(5250100002)(2501003)(110136005)(97736004)(316002)(2900100001)(36756003)(76176011)(6436002)(6486002)(26005)(4326008)(99286004)(68736007)(6512007)(6116002)(10090500001)(106356001)(105586002)(478600001)(66066001)(107886003)(3660700001)(305945005)(86612001)(14454004)(81166006)(7736002)(86362001)(575784001)(1076002)(72206003)(2906002)(10290500003)(8676002)(8936002)(81156014)(3846002)(5660300001)(3280700002)(53936002)(22906009)(290074003)(133343001);DIR:OUT;SFP:1501;SCL:5;SRVR:MW2PR2101MB1065;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ahTmCD1ZcRRhn9KyfR3WFzuTHtThdeid1l4KSoH24T/BcR1wc8mNSht2eAzv1VEq4dnAZRFwyBMq/a8lZ/3wZFjW7H3ZQOiYfeZj2gUnW9XuTHDB8A7Epfgm8E1HIAyttK3/KWE7J4eY2lDsJRW4Z4MCYwUrZI430AFegUmS0Ns=
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 785d43f7-0e87-4dd0-adda-08d58156d771
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:50.2757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1065
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
