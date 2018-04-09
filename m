Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523233959-2-12267579897031586182
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233959; b=rcdpe6p9ZJ3L3pFmxRGKGpBd6P21Zu18tt9nqxIr6+9whFbUqL
    SxTS6m3/LdbU9SGSLB/tygY3g2sCP7IWmS/agmRhbazlEqY2CGBTWCOgtxQniATn
    pZFPeLOSvaAVXlugN3zpNDO2/mkPoZ3ekjwZ5k80Gul+9DwI+UywIW8xtsvm+bQR
    uXLLN/NLsuMst+fV0s0XaQjwgu2UbKbapmIoh1Q9XEYx8JtNgbBCHCp/8Hy7rNDA
    Nn1GptOoiakMmnOSj1EJEkXCtUbHknIz4Syerrm7qvY+rIt0ZwsVneFoF03NsbMZ
    xZ3ugu7uswOH28O5F1Fw12/E+lIqv6AafbGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233959; bh=pTTMAMSl2o
    wG853ZhpPBT6lVxrcyzBBsiEWRcfJwQTQ=; b=cH9pPz4UJ4vUxuGkDdnZiiekZo
    bW9YZwr1xVgsYhD1olettcbvL3lmJEGKrmPGdiQHmsBqopXm6SJ/tawuK4Hy4H99
    PBXsjFdHSdPcMEpE4lRkCHDzh4RDQYFqhFASumsCOVe0kGYoizWYOowh74xK8sW9
    nma9i0dC/fm2TXVVH3iUYRqP5LISFyEwOiy8Adw/Kf0X5En5nr3PxdrgjtxdGWLH
    7eo4TH8ODgRc5kvbz1LdSvd4nsJkTa8YtW3mE2quuzhH8xZX/QuqNxfb95n4q97h
    QBWEMMDy1/S5Tg3A/jRHpxK6g9RxEaN8I7Ek7sDSIXKFEHNvEV0O0xP0D9JQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=B/+GI3ND x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=B/+GI3ND x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLsksqaFUYRMbhGqhxSbGjJ68mCb7X7WwJyIgx8KcOFYNWL2RTyjE1JND4Z/EYB5rpIKH8rnGcvTtZcuvbq8chh9DB2qutlUK02zZCGBR1k5/91B1reM
    fl7jKzrWVCHnsifHE9ZtL5qAZRhdCoxT35r2LOckP3cSqjIObHbzuIfnY0ZLEoDH4+WrIXkIEK6Pib/8pxZ00Tzl0VjHZZpWBPrn9+zXvPzzN6EZ/BJ0Opoi
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=xjQjg--fAAAA:8 a=HH5vDtPzAAAA:8 a=U7UbAiMzAAAA:8
    a=hD80L64hAAAA:8 a=yMhMjlubAAAA:8 a=mX7iJj9eJ85zrJ8fbVoA:9 a=wPNLvfGTeEIA:10
    a=L4vkcYpMSA5nFlNZ2tk3:22 a=QM_-zKB-Ew0MsOlNKMB5:22 a=cNtvukwP7kaFzDVqf0Q5:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754988AbeDIAce (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:32:34 -0400
Received: from mail-sn1nam01on0103.outbound.protection.outlook.com ([104.47.32.103]:45281
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756493AbeDIAcS (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:18 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Alan Hourihane <alanh@fairlite.demon.co.uk>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 209/293] vmlfb: Fix error handling in
 cr_pll_init()
Thread-Topic: [PATCH AUTOSEL for 4.9 209/293] vmlfb: Fix error handling in
 cr_pll_init()
Thread-Index: AQHTz5lIBdPIbCpXfUqYmF/6CK06lQ==
Date: Mon, 9 Apr 2018 00:25:37 +0000
Message-ID: <20180409002239.163177-209-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:gXRNWS1fyFLvGtMvinLLqShGQqaVMidXISrya8hHXO7oXkQWK/bvQpv+ad0+y6rjryJYpUx7jUie5zXGBvvQRIexEJI5Y1ZrphWhpt8iosomwegnRGQYCkQAbGkiYjr5T1WoZ8y8LnQRR//7ZRw8SB8S/e7zf+BvT2d70VQQYPDxGOEjlcYlOKW+M1yYBNfgUHK0M4z+q53ZUwLOJGvqGk4TB7FfdUeOg24+iXy98C9jG9tfr/mlGp0pGSz/TamK;20:s28yLAKyK168oOIc79lG1lYYwQQr17OAQ2rGGim4iIOcjlYf/xX5oA37e/zou0VSWF0PCeZBQdd4Y+NmX4yK7U7DTAp9yTo23hLeS/js706XOIcopILk9FKmTot3N80CNbtmwQ5r2BART0Gb1z8qVWwxn3sHnaFwdpUwdJ8zeH0=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7bad82fa-bfd7-4333-9583-08d59db15668
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08708E053DFF766B5494B6C0FBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(396003)(39380400002)(376002)(199004)(189003)(53936002)(4477795004)(2906002)(6512007)(102836004)(2616005)(76176011)(14454004)(446003)(10090500001)(11346002)(476003)(486006)(107886003)(59450400001)(2900100001)(97736004)(66066001)(6506007)(6436002)(106356001)(99286004)(105586002)(3660700001)(6116002)(86612001)(3280700002)(6666003)(2501003)(10290500003)(26005)(8676002)(8936002)(478600001)(68736007)(5250100002)(5660300001)(316002)(4326008)(72206003)(186003)(110136005)(6486002)(7736002)(25786009)(3846002)(86362001)(36756003)(22452003)(81156014)(81166006)(575784001)(305945005)(54906003)(1076002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: FWSCcggJsUrVjI0kKIgxxeNx1+/UGEMFti0KzmKn/Cl/oTwLnR8Ev3/Uxuib78Lavf+0pAHLNjqgZOlu1hwmZOteNgs4wXtx6vKWHswA1SN4uN7j0QFBL4cnehwj8SbwyKoHesaKH5E/z3jtibkh0aCCb30xwpvU7sAUDn3ReT9gBE/bgIKmWLNsgAxu9QeAycNQTfTPDtjpxcJ8rvUIwN1k3np/LtA3B3Bd/VW8RX2vpYa0enb9a2p0/QjGAMNiEZj7DD1KDc6KdWBKftH/nlWOn8rFRMW+zrhSM0liITWKdLAapg2rvsblMeOjSiHVFTyGbUnaVde+P1tmEesi3Dz3amvf92CInbCD7uvh1ZQEZHmFE8mS7E1kJM8VB4VCKQ3Wr5/9uMNdIKd/HfgIoQJA7qXAOK979wcElTxLVKI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bad82fa-bfd7-4333-9583-08d59db15668
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:37.2534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alexey Khoroshilov <khoroshilov@ispras.ru>

[ Upstream commit 6af574e826740bf17663b48ba3f8fadb81d2113f ]

There is an error path, where iomemory is left mapped.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Alan Hourihane <alanh@fairlite.demon.co.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/video/fbdev/vermilion/cr_pll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/vermilion/cr_pll.c b/drivers/video/fbdev/v=
ermilion/cr_pll.c
index ebc6e6e0dd0f..ba105c876bed 100644
--- a/drivers/video/fbdev/vermilion/cr_pll.c
+++ b/drivers/video/fbdev/vermilion/cr_pll.c
@@ -185,6 +185,7 @@ static int __init cr_pll_init(void)
 	if (err) {
 		printk(KERN_ERR
 		       "Carillo Ranch failed to initialize vml_sys.\n");
+		iounmap(mch_regs_base);
 		pci_dev_put(mch_dev);
 		return err;
 	}
--=20
2.15.1
