Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1039940-1520361376-2-2912814239664613691
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520361375; b=LEkfHNXFhfrlq88kYZeLh7/WRdGOJaWJwgqCbhYcIvwPMHz
    hApudDGAQW0VJ5gMfxGVA4tUg3xs2P407sR+hon9Cbwrq7SqoVCMIcff7WOJ34Jf
    dFVjxPgIW/UL90pR5DogJL8c8C4Pr/FNvf0HgQs7nim0+aPw+y0PRkbIQIKLkGP4
    WILfR3RklsxbBX5ztuTXFJTXbB178mtmflMZPUjhipF7Ebgvhdma2IggELmf6e/v
    Lk4oOJGBRDyPz/WwMC+cudGcTNoJ73T48Dhos7zU/5XiU8lenmD2RRxqDR78VzGm
    63t+c5kxBv6+WjAexrmWRAv0Xc84SmF2l8voREg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520361375; bh=H
    BsLvfRKyKPQKfgn6iPX8PGaAj2LSTmGxzDuquqcH0g=; b=tPS3mik7xCic7SHd2
    DYDpErd19Sd+cqCUxmvFKu0RjogR8ULIeonOgf+R8fluVTDsbIdCRO+DyMbmLtxL
    4mV2OF5u2WU1aJ5PKSvyn7k0ej6tmZLzlD075AzgvWkoy9ipNFYvC115ah57RwKH
    FUmmLbI77JWVj/61nZHVUALrmouM/oootKPYiNpJCcUInq1C0rpG1WN7wsKkIMK6
    oCPWogOpYpFq9FagSGm3wlyO4W0TFkX9oAIA1vhADfyf3qz6viwF7Ax57HpQSN9K
    pRnE/OaCfb2QeIQG32Cna1mzo2EqShzEdmFK8AhNe/As2R3kzG9obfORv2zPho4R
    QWGUQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Hjj6ZxCu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Hjj6ZxCu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Dexuan Cui <decui@microsoft.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>, Stephen
 Hemminger <sthemmin@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>,
 "apw@canonical.com" <apw@canonical.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>
Subject: [PATCH v3 0/6] some fixes to the pci-hyperv driver.
Thread-Topic: [PATCH v3 0/6] some fixes to the pci-hyperv driver.
Thread-Index: AQHTtXf7PitDCSv6zUCzJu5CMiqdGg==
Date: Tue, 6 Mar 2018 18:21:45 +0000
Message-ID: <20180306182128.23281-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.15.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; KL1P15301MB0021;
 7:D/u6uOCLadU7peJVrx+M5z9Jt2a23IlI6vVuIY7NLDFYzkfp7pODGaEZv9svWAOQR0srVsUPQyysDZHM/5MpfO12OKEraRcGmTA3J3BuGa75VfYKOjf1WWTEggrLO/CqISgRdZ1NNVajAwTAzF2NLGOWhVEjM+SGCDriYVKlKgdL5DjkKuK5v6H/duEyq1/VRQ72d6D7i3Ii4UNGv/ocqqSseI4FR/oLr32XNucFc+WWC8cZVpZxaTch3vgaWgR5;
 20:REcuF8+nP50cvrAHy47ooWgJcNGESjs6Z3sQF6BIz9rxNJOBN0MEyznfq72ttMdNnEy1ZuPlCVoQPKd6Bo+J8IJdL7JeZ6o54b3tC4/dAhthPt8CwFIFirPQuFVTdRKlHesrueRSwXzFhoytUyl7MmaRd2Z8saOX/bKbfUk8UW0=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 80a49b3a-4721-4bc5-c68b-08d5838f1ebc
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:KL1P15301MB0021;
x-ms-traffictypediagnostic: KL1P15301MB0021:
x-microsoft-antispam-prvs: <KL1P15301MB0021DFA60B447413A23B2927BFD90@KL1P15301MB0021.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);
 SRVR:KL1P15301MB0021; BCL:0; PCL:0; RULEID:; SRVR:KL1P15301MB0021;
x-forefront-prvs: 06036BD506
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39860400002)(39380400002)(346002)(376002)(366004)(199004)(189003)(5660300001)(36756003)(22452003)(1511001)(10090500001)(2501003)(66066001)(316002)(7736002)(14454004)(10290500003)(2201001)(99286004)(305945005)(478600001)(25786009)(4326008)(86362001)(102836004)(106356001)(6506007)(105586002)(186003)(77096007)(26005)(3660700001)(110136005)(2900100001)(54906003)(68736007)(50226002)(97736004)(8676002)(81156014)(81166006)(8936002)(53936002)(3280700002)(6116002)(86612001)(6436002)(6512007)(2906002)(1076002)(6486002)(107886003)(3846002)(22906009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:KL1P15301MB0021;
 H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM; FPR:; SPF:None; PTR:InfoNoRecords;
 A:1; MX:1; LANG:en;
x-microsoft-antispam-message-info: Cum1XPBHU9AuToGNIht6gKNyrjsjit7SGUFMIk0O7NU7EXKw4FLxaXKBNSF+zhxTgWSV4QXqo7XNOTKKaXyHr5TPMj7ls1v9hkGoA61AYJ5QSdiB9/o9oTUKaAViR7PlWVeWYEsoucvALfAcZABmZmIkQ4c4G3+QV03nggPXXVLEcnjUEPBBHrPqSqDlsMzUi9vdwWcxryFd9XcKUObI8b5ZxEEj+hzRFcrSDrEtcD95Xq+inAMLoJRkMuN2sdX/2LyK7cxJxr+dTxDZqE35oOZWWtUfF4mWZpUhEGDM4sdlYvAbs/oBtnWTwm13LJLw9N+YQ5/y7rK+EnagiucftA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a49b3a-4721-4bc5-c68b-08d5838f1ebc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2018 18:21:45.7339 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0021
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
Cc: Haiyang Zhang <haiyangz@microsoft.com>,
 "driverdev-devel@linuxdriverproject.org"
 <driverdev-devel@linuxdriverproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Michael Kelley
 \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Changes in v2 are:

Patch 1, 6: no change since v1.
Patch 2,4,5: I added these new patches, as suggested by Michael Kelley.
Patch 3: Removed the unnecessary drain_workqueue(), as suggested by Michael Kelley.

Changes in v3 are:

Patch 5: minimized the scope of the spinlock, as suggested by Michael Kelley.

Dexuan Cui (6):
  PCI: hv: fix a comment typo in _hv_pcifront_read_config()
  PCI: hv: hv_eject_device_work(): remove the bogus test
  PCI: hv: serialize the present/eject work items
  PCI: hv: remove hbus->enum_sem
  PCI: hv: hv_pci_devices_present(): only queue a new work when
    necessary
  PCI: hv: fix 2 hang issues in hv_compose_msi_msg()

 drivers/pci/host/pci-hyperv.c | 116 ++++++++++++++++++++++++++++++++----------
 1 file changed, 90 insertions(+), 26 deletions(-)

-- 
2.7.4
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
