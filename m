Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-373521-1521123698-5-1910647342743004364
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521123698; b=SWtJrWtx3A2ilrQCOszRwDby7tuG5XcYROtYbRWKEaUnO/z
    23NLscb+6yLJa6wAJ8dX3q5SVVQHdC/vrLGnPfZpQa0WkPE9ZvJbGRXLJU8fXQww
    UBBH33VtaYdxzDSnBN8hkCX0LHGEOmdrdlC1zxjUHacHwDCAnYw2rBqujC/Kicd1
    5JSp+Kepqw/UjAfUxbzvavFtcanwNUgQfsjEeDPNkUKTmoukvLYMW0VRfBlFzf0e
    WJVydBFJ1l73IroFF0ouoXGwEBOvmjuc8Lq+1c95APp/g1A7DXi4uICZyPBrofrq
    6HQlDGju9UVtcDY/DmsRt6VAHLP7sUDYFrzQX3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521123698; bh=g
    meP4G8erWCmRAvUC/+G9pbsR+L3OU/fum0DUvbYVCw=; b=mlvazLVN4GhZOkJCZ
    tFw0gXubZiqUhadHw6GptGQ9ooRvmvmECt2ukswQ+rBasWS/AjZ8PGezlm0fnBRe
    XfjI4yPzNPCCwXe06hOh/b1oxWs+7hOCqktvEXnlUWAr9icOMeCovv6CS0ij57un
    u9oHf2Ks8K8iPjxu6U8eMoqsrGve7QXTwAQ6oxumnb8+80btlrQSz9EV+MTcJKUS
    zfDHS3/VZYKzOPEH2+9TLizcxJWozBzc15n4ccb7eSr5xrWiUGyAtMaRLUlpih1u
    ltC9BnqLYTvwm2ccNPVB4hCb9SWdfIg7urQdhoCp2Tv5vegNRQxbM9QRdH1u0b4S
    BoxOQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KGtGJ1eL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KGtGJ1eL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Dexuan Cui <decui@microsoft.com>
To: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>, Stephen
 Hemminger <sthemmin@microsoft.com>
Subject: [PATCH v4 0/4] PCI: hv: Add 4 cosmetic patches
Thread-Topic: [PATCH v4 0/4] PCI: hv: Add 4 cosmetic patches
Thread-Index: AdO8O6hHGoU146NrRVilycJaPL8ugg==
Date: Thu, 15 Mar 2018 14:21:18 +0000
Message-ID: <KL1P15301MB00066C8F7CDF90BE9D2B7412BFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-15T14:21:16.1291586Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [2601:600:a27f:df20:d8b5:442c:6a7d:25c6]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; KL1P15301MB0072;
 7:yZXzgbKXB6KY/HNXuOC1psceDPJsBvlBVdUV6VCnJbmP+i23mTQjOtG1u9ueEpkAO8Oj3x6CFtyRGnIR2to0RN6UPxeEqVOVT194Uxyi5JME+zhSlKSvTWdg0nhCMiM2qGXpbracz1m5Qf1NClll0v3yio6CJtaomOIRc+AqEoqGgoRT5zPuPHVHXqrQquCw3yi8suNzG6DBK8k6+creJlNIGNj5rvAdUqbgIzicenPxQ2lTpba3c4NmWX3ul5ep;
 20:DvHUz/w18OnFH72mNpI8CPaI1EuKO/oWh2/Pu4x1rGVm5UFxeySLug30JJHX/Lo+Nj269Qgd38PKSk29UzFfF/2FvtVts9d2869p5Kv2EZtI6lpr/G2xVzrgB4IDCvcoXaq3jYRVtWcPod6pd5kiOeBLuIAr0ZtCey0AwhR16o0=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 60f0be0a-5acb-45cf-1f10-08d58a8004ff
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:KL1P15301MB0072;
x-ms-traffictypediagnostic: KL1P15301MB0072:
x-microsoft-antispam-prvs: <KL1P15301MB0072842E438431E6854020B5BFD00@KL1P15301MB0072.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(9452136761055)(278021516957215);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);
 SRVR:KL1P15301MB0072; BCL:0; PCL:0; RULEID:; SRVR:KL1P15301MB0072;
x-forefront-prvs: 0612E553B4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39860400002)(366004)(396003)(376002)(39380400002)(189003)(54534003)(199004)(14454004)(7696005)(966005)(4326008)(2900100001)(478600001)(5660300001)(68736007)(10290500003)(7416002)(3660700001)(97736004)(110136005)(7736002)(74316002)(107886003)(54906003)(86362001)(316002)(22452003)(25786009)(99286004)(2501003)(2201001)(8936002)(305945005)(6116002)(10090500001)(102836004)(33656002)(2906002)(81166006)(186003)(86612001)(77096007)(53936002)(8990500004)(6636002)(8676002)(105586002)(55016002)(1511001)(6436002)(9686003)(6306002)(106356001)(81156014)(3280700002)(59450400001)(46003)(6506007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:KL1P15301MB0072;
 H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM; FPR:; SPF:None; PTR:InfoNoRecords;
 MX:1; A:1; LANG:en;
x-microsoft-antispam-message-info: C091DLw2EYCHLdClUT28oI8zhlmwgHkwlxDjUYbAeMjigOzUi8rrk7sAl9LstFTdNyZf5YiDZIhXfbGrUEzCtb95pxn5QDDK9pEthTGmFlS0RASsFoatFslKNlt3ZpmY/OkRfQ+cw3IV9FoInHNuAxcbM4h+CrSwPmDrRxoCjot7qIRWxWSgeamhJPqPDZIvUEteto5OtTi/UnXIhtXSD275ZgHCszR3SykouWotkB8MXTwST5Tgl0WlqREedOFoMbaG9Rh2ZjTeLpouxtiijz2EopDrisPZZn3vGtzey2VD1qbTYRq+7KxMr4jys7NWZfOUUEbSEiaYBI4m+RG5xw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f0be0a-5acb-45cf-1f10-08d58a8004ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2018 14:21:18.1443 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0072
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
Cc: "olaf@aepfle.de" <olaf@aepfle.de>, Haiyang Zhang <haiyangz@microsoft.com>,
 "driverdev-devel@linuxdriverproject.org"
 <driverdev-devel@linuxdriverproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Michael Kelley
 \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
 "apw@canonical.com" <apw@canonical.com>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The 4 patches should go in v4.16.

There is no code change since v3:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1628496.html

I just split the original 6 patches to 2 series, and this is series 2.

I fixed the order of Signed-off-by/Tested-by/Cc, etc., and fixed the
other format issues in changelog (I hope I have fixed all of them).

Dexuan Cui (4):
  PCI: hv: Fix a comment typo in _hv_pcifront_read_config()
  PCI: hv: Remove the bogus test in hv_eject_device_work()
  PCI: hv: Remove hbus->enum_sem
  PCI: hv: Only queue a new work in hv_pci_devices_present() if
    necessary

 drivers/pci/host/pci-hyperv.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
