Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1469102-1523555528-2-5308965246256145690
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523555527; b=UDQrf4A42ivLcpp99bxa6siMppHNFDgG6GghFTdo+5vcjsRvJu
    eszMjxxPY4C5lw0Y1AReXmhUQ5J+UWSYRia22e8yRTfUJJxmnOOUxbkCWl06tGw/
    mJD85uNPEM74+dSZrbAkT1ALi0dxqi6OHyCscJY+BLUYhVqQV5RyAVCE19apfJ1j
    36SMfxjbsdKKPIgzb2MWTnBF+iis15/qGAF/DBPS9ilu4QLphe0lIoyltdb7e2LK
    HOQU9lP5yErrj6M2v4jz3lPExSAwqLceGjz4Mar7BKj5iJl7sGg0OkmyqfYgTqG0
    XDvTHVkahUKNJ1P5fvSByczHMNmzKLbwKyWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523555527; bh=if3iVJwQGoRlugQS7V7hghd+J8BpUCwQotQ85EGRMMs=; b=
    aqcu6tT5prMc+vw0BCu0ry9FnHhfeQDuUZzONX6uOR9tKivsoOWr1L905dDcuVcd
    aCCvwX4xdYueOgQwHZWCkCq1nPFHjGIdzhhkbbHwLs8vRbc/tDPBQgZGE4ZswlQS
    W/DsuYz5VBgGaVF6E7mE4XLbd8JN9POlz2N8qp/GC+bCXCSRcgEHiiT2WwSnyqRH
    c8vuuwPACrcz+jtn9Z4eIbfQUIDZzifnu/kmUjDuPDC2iFv3iYYeu91fsculeAFU
    XPv9Sdj+w6uSi90mM61Iq+SeIsSQTAjN+sKr7NB9BiDki9AcpQgpyY4qGNHrHBQE
    nyJHZym3NOZDNlO65g9How==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=wdc.com header.i=@wdc.com header.b=W8dxg3tg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
    dkim=pass (1024-bit rsa key sha256) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Q8aNuu/V x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-wdc-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wdc.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=wdc.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=wdc.com header.i=@wdc.com header.b=W8dxg3tg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
    dkim=pass (1024-bit rsa key sha256) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Q8aNuu/V x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-wdc-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wdc.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=wdc.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGE6Rm9B53qtSuyc/x1CrTsFpx0xbRE9J4k/15mV4RH1Ng0mv/wJAAzxVjEuNo2Q7jaeQ5uBftRysCpiYjPDpWJmxH9xRB2xVR3gRf6R/rlfnCQCys3t
    F2TYwbcadjZDkkSpBCDGw+gsAUDF7lMQ6oro2D3xafu0RYmY8Ob1SZBKg4ez6O1KO1OoCjCU86DLp6tlzb0lQF1wrYpOlkA+jwCFWO3PysNW7eENP8bylEV4
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=LkRTnUtX4-YA:10 a=91iJMktEJhYA:10
    a=U9wOTyLfYsQA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=X0ROFhD97x8A:10 a=JF9118EUAAAA:8 a=RgNJ3k4MSxo1lslWSTcA:9 a=QEXdDO2ut3YA:10
    a=xVlTc564ipvMDusKsbsT:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752777AbeDLRwD (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 13:52:03 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:3683 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752700AbeDLRv6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Apr 2018 13:51:58 -0400
X-IronPort-AV: E=Sophos;i="5.48,442,1517846400";
   d="scan'208";a="178920259"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "alan.christopher.jenkins@gmail.com"
        <alan.christopher.jenkins@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] block: do not use interruptible wait anywhere
Thread-Topic: [PATCH] block: do not use interruptible wait anywhere
Thread-Index: AQHT0nqftTrOertJVE2ZMZoV4twMtaP9aO0A
Date: Thu, 12 Apr 2018 17:51:56 +0000
Message-ID: <13e67e1243ebd96f3f56a150d47444ada47ebde0.camel@wdc.com>
References: <20180412162321.3671-1-alan.christopher.jenkins@gmail.com>
In-Reply-To: <20180412162321.3671-1-alan.christopher.jenkins@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [50.225.201.71]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0608;7:NkClhSzns1vDooxzn5WyLpyBrJrdqUDrMpK1pD1hQIsXjgtybmJMkgV8s0B0VwimTPAgZCGI2BdYj+jAYWQsQggrQu2Nr3KmsdhzycKmD4WVgg36Q17cS2NmebMT7Ys0b6IZjzVCOkw1lz9VcWCgvXgpGzIydWlwp8lowVGz7ldgF5w2XNrBq2GWrCuCdgLhmGXD20TD52r+Jn0NTNM4GIIPWz3b4OBitI6xyObhVEtOeA0DK/VuchKTKM+uIDP5;20:iRbrKyMQ2UFNCNPpKpYxeZc7cv/dq6ergartiu1KDXZfwWOpNegWOO5LDeWqhNHgdrykajUJe3ePnAtJDgAIyjrK3hx/lois1NncDYTfgvAHRf4fiKQ7oBX4E/i51XAcgyD8eXZBn62uYQZRUMM4DMcNqt9YnzRjva6vajF7gj0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0608;
x-ms-traffictypediagnostic: MWHPR04MB0608:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0608835F3C43E6CEA5E212F298BC0@MWHPR04MB0608.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR04MB0608;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0608;
x-forefront-prvs: 06400060E1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(366004)(39860400002)(376002)(396003)(199004)(189003)(377424004)(72206003)(186003)(7736002)(106356001)(478600001)(5660300001)(6506007)(59450400001)(6116002)(110136005)(76176011)(102836004)(54906003)(305945005)(3846002)(14454004)(2616005)(446003)(476003)(11346002)(316002)(486006)(2201001)(26005)(3660700001)(81166006)(81156014)(2900100001)(3280700002)(86362001)(68736007)(39060400002)(8936002)(8676002)(2906002)(97736004)(6486002)(229853002)(6512007)(105586002)(6436002)(36756003)(66066001)(118296001)(25786009)(53936002)(99286004)(5250100002)(2501003)(6246003)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0608;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 2sJFquxDbWZZzaRE8I4f/9vdkeLFinhriHoxoxRG36YOx3rx1u4kpxXBOsUZvmhnkj8FQy0sHW4ZHi19Bhro2u8xxpzj6jkM2seS8G+bPA5lbn3dXMnkwBpWz8TLjH7MvrMocqYgP9Ha642Yg4I4KsiCoRvfiokBS4HIP0IdqcodEMTTHTZku8e5pVoIN4pd
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6353BD028CE0A45935EABB75360AF0C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8e90eec0-1dcd-4040-5400-08d5a09e1544
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e90eec0-1dcd-4040-5400-08d5a09e1544
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2018 17:51:56.2838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0608
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gVGh1LCAyMDE4LTA0LTEyIGF0IDE3OjIzICswMTAwLCBBbGFuIEplbmtpbnMgd3JvdGU6DQo+
IEBAIC05NDcsMTQgKzk0NiwxMiBAQCBpbnQgYmxrX3F1ZXVlX2VudGVyKHN0cnVjdCByZXF1ZXN0
X3F1ZXVlICpxLCBibGtfbXFfcmVxX2ZsYWdzX3QgZmxhZ3MpDQo+ICAJCSAqLw0KPiAgCQlzbXBf
cm1iKCk7DQo+ICANCj4gLQkJcmV0ID0gd2FpdF9ldmVudF9pbnRlcnJ1cHRpYmxlKHEtPm1xX2Zy
ZWV6ZV93cSwNCj4gKwkJd2FpdF9ldmVudChxLT5tcV9mcmVlemVfd3EsDQo+ICAJCQkJKGF0b21p
Y19yZWFkKCZxLT5tcV9mcmVlemVfZGVwdGgpID09IDAgJiYNCj4gIAkJCQkgKHByZWVtcHQgfHwg
IWJsa19xdWV1ZV9wcmVlbXB0X29ubHkocSkpKSB8fA0KPiAgCQkJCWJsa19xdWV1ZV9keWluZyhx
KSk7DQo+ICAJCWlmIChibGtfcXVldWVfZHlpbmcocSkpDQo+ICAJCQlyZXR1cm4gLUVOT0RFVjsN
Cj4gLQkJaWYgKHJldCkNCj4gLQkJCXJldHVybiByZXQ7DQo+ICAJfQ0KPiAgfQ0KDQpIZWxsbyBB
bGFuLA0KDQpQbGVhc2UgcmVpbmRlbnQgdGhlIHdhaXRfZXZlbnQoKSBhcmd1bWVudHMgc3VjaCB0
aGF0IHRoZXNlIHJlbWFpbiBhbGlnbmVkLg0KDQpBbnl3YXk6DQoNClJldmlld2VkLWJ5OiBCYXJ0
IFZhbiBBc3NjaGUgPGJhcnQudmFuYXNzY2hlQHdkYy5jb20+DQoNCg0K
