Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1587535-1526343922-2-3956358456979860358
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526343922; b=IATTCd1J9j79DXrAEJ2EcsJ74HaG5TZOGUo0tlbPtd2oPox19D
    HpwLENbEyid4Xho9VhGRk1q+EPrqJiWGwQLwl5I610nizrQoP6w1kBJlDGT1xZGt
    Z9e8lCzZWlikd2wh+7wqDvMR+dKVfm8Xk5+A3nW/HOriQFoEYOctnXTME9eO0frK
    umv/beEEOk90W3pNIgzPuQ0ssLKZF7xaQfXVgiG/fxlU+ClW1I7E7apozMZUEqYK
    ywSPiHHVxswtZ9QLFqOXDmpj0AQmFo1NRAllOTEsvAqFw4FNK7tSFckUpFWMiRiF
    UyZbuJiDazwjTmQnypHsuT5dzHpiVfBw7j5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526343922; bh=lzCq4
    0C65eotuBxS8URKCcuPrQmfBhOfUBGLjE1tfo0=; b=fb0l1zeW4w6Bxn5upohBZ
    uIi5zlncq0YV0JNvHNNuMMdESubpSKFDQ/if+su+G5Ztv9nmjBOJPeVeM8CjIw70
    oTkMHeBL+L1GTbSQ/u1QP4B1V121Xn/3teHUZ7Skxm0EyRZnKwiCtAHZsEzGZJPa
    JQE3a/UBR+tuBsVAPoWnMl3CKOOS0XzU8hISfhH3xJFR9Z3v+CyxSjSlHsyn4V0W
    uIm1FS43mAQo7OlvpoyE/mJ+QKbwnRmAMz4YiQoye8VfjiixNrCYAAcmrXwqth2N
    X92/Gz2J1AqWTFhu3/A/ADSlvSsYm43qJ3/CARM9AwL6mM935umPs9xISkiVB/OW
    g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=microsoft.com header.i=@microsoft.com header.b=KGmQShKy
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject)
    header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=microsoft.com header.i=@microsoft.com header.b=KGmQShKy
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject)
      header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAsvGxZ6YwgsXUYICrdzhYlz/C9kbTjW2Fm1XanQip057tKDVlvM0jd/A7tibvDMrMjB35SHvmzq5BtpPM5F705lLKIXX+4BWysU+7ur/DwioSqiBQ9T
    J9/Az3FXZf1qoIMSDhvYJcQ5Ccvp9AMQwIzjJMMpcoy9aTxJnIoWIE2Sn0UgVlPGd8MDeJlSVQ+mEZOhuhwBqVRKxsDUbb71z2x5FyzJpR8OFyVRox7Ce95I
    vwpZrhXYACKc2o8Y4yKMdw==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=R4fxTKrshSIA:10 a=6RrQ652yKWUA:10
    a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10 a=Lf-vpJhqX20A:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8 a=DDOyTI_5AAAA:8
    a=OpXvc4x00e8ULcQZp8cA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Dexuan Cui <decui@microsoft.com>
To: "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
 "'driverdev-devel@linuxdriverproject.org'"
 <driverdev-devel@linuxdriverproject.org>, KY Srinivasan <kys@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH] Drivers: hv: vmbus: Removed an unnecessary cast from void *
Thread-Topic: [PATCH] Drivers: hv: vmbus: Removed an unnecessary cast from
 void *
Thread-Index: AdPr4pAN7o7LkGFsSAGAZTut+Dz8ug==
Date: Tue, 15 May 2018 00:25:01 +0000
Message-ID: <SG2P15301MB00156C41A4CBCFCC94EB8061BF930@SG2P15301MB0015.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-05-15T00:24:50.7199404Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [2001:4898:80e8:1::7a8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; SG2P15301MB0015;
 7:P9/wMaOPSpmjzN4Pwpzhjko8/Sw/+2w8EWyIzerjlO5IncrXiKltjl5eJrx7nyEZGyN2w++i1BCA3PGttWkBT8jFJ9M+ZeoN3Yd7egVq0WwHVdcmMWgk4B6dvZJSA6B8ZSXffo/kN4gluOEE9c7SRmTW/aGkAnZCzJ4ubNn4K6SbkN9NzU+tQCy+14L5S2frHuQdHClBAqB3C/3QpNPZpZXQimLh932xnVvo6TGDfmlw2D3SSn9MpFZ194nAiFd1;
 20:LJWw0ItMFCLGSvjMy4AcobcrSjiuW/iWVhnzlHWoUr3Q1deWaKbIzpa6RSj+GdJKBmyWVF01e0iDWmVvMY8BQ41W/q5pQ/jO+qHCsDZEorNfcJmMiRQIFZmFCnOD/PB22NpIt90DEopIlCq593GbYuYzbIlJge1aUY5H1OprWLo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:SG2P15301MB0015;
x-ms-traffictypediagnostic: SG2P15301MB0015:
x-microsoft-antispam-prvs: <SG2P15301MB00152B0A779ED1351C3655EABF930@SG2P15301MB0015.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);
 SRVR:SG2P15301MB0015; BCL:0; PCL:0; RULEID:; SRVR:SG2P15301MB0015;
x-forefront-prvs: 0673F5BE31
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(376002)(346002)(39380400002)(39860400002)(396003)(366004)(189003)(199004)(8990500004)(6436002)(305945005)(8936002)(46003)(6116002)(7696005)(10090500001)(25786009)(14454004)(6636002)(74316002)(6506007)(86362001)(86612001)(5250100002)(99286004)(53936002)(186003)(1857600001)(316002)(22452003)(68736007)(10290500003)(81166006)(81156014)(3660700001)(478600001)(476003)(102836004)(3280700002)(2900100001)(110136005)(1511001)(486006)(55016002)(33656002)(7736002)(8676002)(9686003)(4326008)(2906002)(59450400001)(97736004)(5660300001)(105586002)(106356001)(491001)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SG2P15301MB0015;
 H:SG2P15301MB0015.APCP153.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
x-microsoft-antispam-message-info: h2lrcDTO68WSdXm1dxh4+8gl5mBulB+LPq6RKUD07Fws0UnhUzcNQjWoMjGTjCdE69UIydKclEE80QGeu3QXHFYUF8pWUIz25tG6vwgQ8Z9NiTRiETjnlEWcSOQxsEVT4ScFD+bzgtxci+r7BgDbc3Iz05dr4J9xR+5M6T3d4daoOE/mioUNKTNO3fy6+T0c
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: dde64171-5960-4bba-b221-08d5b9fa4c97
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dde64171-5960-4bba-b221-08d5b9fa4c97
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2018 00:25:01.6191 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0015
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


In C, we don't need such a cast.

Fixes: ae20b254306a ("Drivers: hv: vmbus: enable VMBus protocol version 5.0")
Reported-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
---

Thanks Stephen Hemminger for pointing this out!

So far, ae20b254306a ("Drivers: hv: vmbus: enable VMBus protocol version 5.0") only
appears in the char-misc tree's char-misc-testing and char-misc-next branches. If 
possible, please merge both patches into one.

 drivers/hv/connection.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 19e0468..ced0418 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -409,7 +409,7 @@ int vmbus_post_msg(void *buffer, size_t buflen, bool can_sleep)
 			 * HV_STATUS_INVALID_CONNECTION_ID and we should
 			 * return an error immediately without retrying.
 			 */
-			hdr = (struct vmbus_channel_message_header *)buffer;
+			hdr = buffer;
 			if (hdr->msgtype == CHANNELMSG_INITIATE_CONTACT)
 				return -EINVAL;
 			/*
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
