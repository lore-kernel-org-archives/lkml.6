Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4122441-1523246295-2-3928449634097715387
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
    1523246294; b=n1IbVic/eKHHo9GDzWDQ7+3lin5uk3LLyF1m8iRFU4Kij8F9hr
    IaCE6jFDsc67GWqx51JDGQXNdIAyPGzFc5GapfCpWzNa/qc6A76JL5FAH3ZVpYuK
    0mI/Qco9CNs0EUD905ugE/2ZynjRmySoFPnAHo239nuReZvn/axvgffEy9LoNxIW
    +R4VsCB/qPgh/y1KuJoutx2vV/8wBwr9xBP2zjTj6fJSpJKWg6PeCTdL9QwjnKdn
    OfVc28uxtN2yJqJm5KxS7KDt3IYNm/qRWJCD2BUT5Z18vWXCc7LiGuD5icOTEiD+
    FGs31lujEWHRRN+evt5S9nQa8n4uEQSwEaIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246294; bh=JrZlP1LNfC
    vfcFgx75Yp7WZLD1ONIdpNnq34ca9XnmA=; b=iJE71PldNsNvmOtD16SYy+HOvD
    am9TVapClWBXedAzlYkK8smhtLQMlxJqVjiiRbm+fsuerWbyRBb1+1KrpwadycSK
    I+yixtN0EoJpmnC1q0Ve4ZtJYkOMS/NlPqerLaO+aaM/nw+AXSQLzaC5PTYpmwcO
    jkj4zuchfkd5B7bRMiaqinO2PCNmwocFOnTC5Q3o8/HYb2+jb07KqLUxeaSSRgeU
    4E7/jXVVXOkaqGiZLSpXonuf8Ybh4PaYRiMdcv/tZjRDzPiwqM00y/D804zglGjW
    rIhBcTFNOHBh15b3hMSNSmYCtHmAsrdjk+0fZtHnb5qqIqNlj2/0Vm2nU27w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XYu0wb3r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XYu0wb3r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNHH1bj9FvcxctrEvwRl1ALRoSpAI8sY5CKvtuQ6NjPnG9sraZhzgjg70+4hNCATzohB1LdgZkhzvFz0Jtue0ow9ejQxczJC0fKGvr6D2hj393u3cuZb
    Tp/cW21mYMoHqezqUK+djGD+TjRXAK+4agMYbnu9BpUN0+qc4UCWWM+ctsF3JmZyqSHINbT46Z+eXCeKvGLxfSDnINx0z711ftpRp8cZVsGG4jABenEUeC60
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8 a=Utfb4SCxKVlw79s-hMwA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753653AbeDIASi (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:18:38 -0400
Received: from mail-bn3nam01on0092.outbound.protection.outlook.com ([104.47.33.92]:62923
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753651AbeDIASg (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:36 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 071/189] scsi: fas216: fix sense buffer
 initialization
Thread-Topic: [PATCH AUTOSEL for 4.15 071/189] scsi: fas216: fix sense buffer
 initialization
Thread-Index: AQHTz5gs2rk9mt+1K0WTigtL2+2RBA==
Date: Mon, 9 Apr 2018 00:17:40 +0000
Message-ID: <20180409001637.162453-71-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1128;7:ZhtAL8ao2esnzUJ030i0GtjVNp44e5UwhegzbnQU0LIrCHTvyqRI3adSoye8TJTUUQtm1/kL71uJnCFA6whWINRFn7cU9JpeYSGM1soyXgf6wwGJ381n+4CqqU42IqM50HacCrgv+Bi26r81BHyseYJCwmBnWeEA7DvQjXsdtG4/gfo2aTQ7iukj96gtCGiiioAJhOBEXyzQpf7Mvt+WngMFGKni0+S2RDkpLXHd8jV5jlIbIjnZogZakK1YoOp0;20:F6VyFicORVU33qM4VoQVn/GYZsUnb2Kg6qcBtxZm4+VtOrJ/CbFl/J408QSYWLauL4+VoWN8o71FlV8Q3nZWLzftOz8JR6YIWW+L3Y3C+aQRH5Eozy5zmeO7djPr9sp9J6WchVrNFdNRoQO7WuYlN02Cz3Fr+7jNA23cNqHXRbs=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0b481ede-335f-4308-6612-08d59daf6e56
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1128;
x-ms-traffictypediagnostic: DM5PR2101MB1128:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1128355BB99DEFB67E69AF8CFBBF0@DM5PR2101MB1128.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1128;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1128;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(376002)(366004)(39380400002)(199004)(189003)(66066001)(86362001)(59450400001)(3660700001)(3280700002)(2900100001)(25786009)(36756003)(6506007)(76176011)(2906002)(6486002)(86612001)(99286004)(102836004)(1076002)(7736002)(97736004)(2616005)(446003)(486006)(11346002)(476003)(26005)(305945005)(6666003)(6512007)(4326008)(107886003)(478600001)(6436002)(5660300001)(10290500003)(5250100002)(22452003)(316002)(105586002)(186003)(8676002)(110136005)(54906003)(72206003)(53936002)(2501003)(68736007)(14454004)(6116002)(8936002)(3846002)(81156014)(10090500001)(106356001)(81166006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1128;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: rwbVFjLdxV1BlPKscujAHKk+TZZQXFIuXE4RSaen42fZSuNN1QhznvBetPlVCJVJRLwAgcTGHaVMVpK8FyOclEiq38g2NCutQEDj/E9rPTPVLXypGyezIbP8TFeZxSEklR+Ql4egsDAEfpeaay5NFZm7KnV0aII9f5EBMwzlEBbFPWZ1SHMt4ZftTJ5YtDdCYVW8p3q9bIxEmRpQaFYMYAG3ZbpI3sQ0cKD+ynY+0l2SEPgDEaURRM+2XWKNRfAtfqmz6mpdtGVJxG5MI8Cma876y2WD08BSN8Lo3mJcdV9DSVeaEQQ2m0Nc71soz/o7WQKcJM1dyGIyiC1rlw7b9RM8yBtg6IDIoJwyQMy1ZFtp+bou+OPgl5y5oGNh7u98AT5utYIRlsEWAKriJdo9rW7xBJ/r4gZz7r53y7v8bQU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b481ede-335f-4308-6612-08d59daf6e56
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:40.9460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1128
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
index f4775ca70bab..27bda2b05de6 100644
--- a/drivers/scsi/arm/fas216.c
+++ b/drivers/scsi/arm/fas216.c
@@ -2011,7 +2011,7 @@ static void fas216_rq_sns_done(FAS216_Info *info, str=
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
