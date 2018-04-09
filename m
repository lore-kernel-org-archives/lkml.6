Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523236356-2-2054404859794327776
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
    1523236355; b=k9VrvbLRc4ZjlK4hPszgITOjIkfzD914H0gHksuy2qbQ+geA46
    d6HJpinav58BzOVmJOFneRZCS0AvJKDou3njWVAX+4NQPENUvqPOGbqG2pXlsPr/
    FCgFTXmMvhEIgWacpA+C3orYjSJpKnIiglAPol6LsjW6icNSPcRVIrysFcBs+DCR
    HSgbFUYCNnaDioxxycCmtqzov5e7+jDuOf/Xn1A4AC+7O1jSDo2hRHewxNEcvXSi
    OLIgbVBeT7eoVosOtbTRbw8LoXg78HH5O86VjiPJHakNjblUslowejQOWd1CrvRu
    L9S0hAfrSMZmIldWcT89BQF/8jg8QfeRZBdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236355; bh=Ho7g9+OqnT
    /q3kvQRcOOxz9RNGESi9fXP7IDt6pKcwk=; b=nXOGxifxq+kiSMUBAUrv7Rsajq
    qkuZifhvcp2y2D9xokXdXSiu+ELolMEsuk8cisIFZx80r5R74ypVxHalzLHaYaTj
    FiQ/yli4Lje1VwY4Ba+Bpq4SfpTv1WJXIHJN2OWO6uxfFaNq3pPDILi9wJw0gB0N
    qWIheBzn7NkMV4mamGqbZnBBH+mqPPGEiCj0Lb87xeaMXOP78l3D34EvdOPm1Rth
    BD/wFl5lrsM/oZAsOW41CHhmqclYvX1iL+13BglpFCJgzo4LiE8875aCvwadDQh2
    yVHl2liFSjnXlRhYQ/KoL66XQT3duGje7FLrUOT8sZKr1OIxcNoWPFugyxUw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=e2jMOMQ1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=e2jMOMQ1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNJx8xSP7WqPj+A0su0ZYo6ZL1Hcvon6lZ+HrRRYahv/3O8YxFe+Q4irSA1zj/qtWquUMwrXdhRkyJHaa/ld54rD3zoI3S3hOt2hVfppEcsZQQYWZd+T
    fm/ldXA1ldfG+sX4833cJRRC2Qt0vXpKQJnfOz+VzINJ7F8gyc48kEx+djWI1aV0bxmXyiwQQw+0QDu2E2m5B7ppW/DYQxtampdKwXut2hgxo++BhYQmAs2V
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8 a=Utfb4SCxKVlw79s-hMwA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755073AbeDIBMD (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:12:03 -0400
Received: from mail-co1nam03on0129.outbound.protection.outlook.com ([104.47.40.129]:43760
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932989AbeDIAil (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:38:41 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 129/162] scsi: fas216: fix sense buffer
 initialization
Thread-Topic: [PATCH AUTOSEL for 4.4 129/162] scsi: fas216: fix sense buffer
 initialization
Thread-Index: AQHTz5nQsIISFIovaEKhcaM0LAaenA==
Date: Mon, 9 Apr 2018 00:29:25 +0000
Message-ID: <20180409002738.163941-129-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:j5QP7AcTl3YE8OBe4Y+j1fDOukOq4KIumks3ruLWx9+LF3jw8a5HwAYG/Sxd9551b9QhkMYHh3U/2M4xFKPAQupasqmbJsK32mS7ezRykuicEPJZ4ymiz7U28jnAv7D3tjUD3J8oIQPDw/H0FwcR8/IFLc9L3YyN3IqucbUxMwwUOvwCQXqME1JVPH3Xg2OEQRQsEdw84X2371+mJWN78h7BibcP7QdVWSMXqCsQY8f8kkwUN8PFyW1XOc7kSAkj;20:bMBUAgzNGjd6TwFqruEAues5YyuKBO++9i+UkExT3mtwKtPZFtNlqZYyOvqfLWoqZythBMaN/XPkM98JHNhRYsqP8bLaF8KOaQnqB5iIreNLLRB8IY/aog+AP2o46IoujrjgMsh8bcX1X4zUsC20+F8J9RLbd6QZ20IY35TutF8=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1663cbcf-2687-4af7-c121-08d59db23a8a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1095B12ABD449A28FC61FE9DFBBF0@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(396003)(39860400002)(376002)(189003)(199004)(26005)(10090500001)(476003)(105586002)(86362001)(107886003)(11346002)(446003)(2616005)(102836004)(76176011)(6512007)(97736004)(36756003)(6666003)(6506007)(8676002)(59450400001)(99286004)(4326008)(10290500003)(81156014)(86612001)(81166006)(186003)(486006)(2900100001)(106356001)(1076002)(72206003)(478600001)(305945005)(8936002)(25786009)(3660700001)(7736002)(68736007)(66066001)(110136005)(316002)(54906003)(3280700002)(2906002)(3846002)(6116002)(6436002)(53936002)(6486002)(22452003)(2501003)(5250100002)(14454004)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: iLYuqqKqNdUfgItSw+KmkeU4mTOoSxlZIWUDuVnTJxB5sfzZWp6QL5DG6o1K0Pr7vxHn0gdY9z85Ur1rK2PCMVPMq1JgRs5PJ/Yr7BhzD1TQGcUiNJaoGbPpn8uygYKuK1negcXhm6ZtDurDt7SwVp1I+jwNZ4cLxoIXJOSqp8o9Xz7rftUDlDNK5eWpUzIQxOJ2eh4y5lTFKIylhfy0F+5IExsYiEwUH7kzXT2xGwaj4dKd9wZMGKPnRkFPj4WUIvyaIAd37W73Q1BKyUL4nO/MwCNFTqq0xfqnLSyEuOWDNBvoWb8NLso4Q/0dTOgoGK02uUXpPHVoQcwmETFKd2uEyAFP1qyHIn7249Tkhhpe8IyZ6lpDt8UdYus4AiZ32r2NM9iyvh/20LZddmpgsziMVgCm7GCHnTbBJS1lIPI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1663cbcf-2687-4af7-c121-08d59db23a8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:25.9900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 96d5eaa9bb74d299508d811d865c2c41b38b0301 ]

While testing with the ARM specific memset() macro removed, I ran into a
compiler warning that shows an old bug:

drivers/scsi/arm/fas216.c: In function 'fas216_rq_sns_done':
drivers/scsi/arm/fas216.c:2014:40: error: argument to 'sizeof' in 'memset' =
call is the same expression as the destination; did you mean to provide an =
explicit length? [-Werror=3Dsizeof-pointer-memaccess]

It turns out that the definition of the scsi_cmd structure changed back
in linux-2.6.25, so now we clear only four bytes (sizeof(pointer))
instead of 96 (SCSI_SENSE_BUFFERSIZE). I did not check whether we
actually need to initialize the buffer here, but it's clear that if we
do it, we should use the correct size.

Fixes: de25deb18016 ("[SCSI] use dynamically allocated sense buffer")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/arm/fas216.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/arm/fas216.c b/drivers/scsi/arm/fas216.c
index decdc71b6b86..f6d7c4712e66 100644
--- a/drivers/scsi/arm/fas216.c
+++ b/drivers/scsi/arm/fas216.c
@@ -2009,7 +2009,7 @@ static void fas216_rq_sns_done(FAS216_Info *info, str=
uct scsi_cmnd *SCpnt,
 		 * have valid data in the sense buffer that could
 		 * confuse the higher levels.
 		 */
-		memset(SCpnt->sense_buffer, 0, sizeof(SCpnt->sense_buffer));
+		memset(SCpnt->sense_buffer, 0, SCSI_SENSE_BUFFERSIZE);
 //printk("scsi%d.%c: sense buffer: ", info->host->host_no, '0' + SCpnt->de=
vice->id);
 //{ int i; for (i =3D 0; i < 32; i++) printk("%02x ", SCpnt->sense_buffer[=
i]); printk("\n"); }
 	/*
--=20
2.15.1
