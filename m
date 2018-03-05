Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2389728-1520277747-1-17529083084645073530
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
    t=1520277746; b=FJbB3EOrqWtn43mHWVZPbaKjaahsekU/Vb6hdc13bXnLsgt
    xe7ck9l9vEmgGCVLkGtnPMkVqWqgKFqarLPV2sa8s/NrQKZQep2UDBchgcJfsfU1
    X6+aPl7x5GMZDDBgO/TnRE0pxNf/gNFGcbmS1CtI23lN7Teth1Ebq+QjXrQrK59b
    wvEvZj6jt/xTnqYmbDY0Wk7hlem3oC4Pw5cIFv0QcHoA5J3uYryWIu3xUA22XlC+
    YWqsuaD04XOPLoNAdv3NTwsERYqj++TsDmz+kK60Aj42eKvDinGo0IfNCSFYhLNM
    o0JirzfqOGwYxgyfS1CyjLoiUndVXCbpQxBI9pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520277746; bh=T
    O3lOx/kEnx+1AfbQmxCsLmSFK7fqN6w5ZMjoLFuwe0=; b=TChzaM6ni2WIhHK3x
    n10v3VEOQTqhiGpUs2z3WloWMGopOM+il0oW6iJsX044S6zgyucdC1/Jp2/nvJgE
    ipNQcU4paKEprre5JMTyOyFrafr7NoqpLtxtDULAEy3KplwiQ/K7MR/4MgvsKrF1
    NPfGjjqWqDwM8Z1kyhJF1UnVpvTV3I1VOGFpb5IN259cfJta9QS06hLeYU7iMtXK
    BCBfqnE2rJMK1Bvzfd3h4GR/LnC5oNgOYVKen8BHvADIQ7Q6wFxn0SBI9gpEhUW+
    ZjD7ltHLvmZRoKTtkGhT9P5E+qQJhNsyXQO2+AWGZf4jUyXvW5ifQ1hVI2U0RWIX
    1P7uw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EAgmAC/i x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EAgmAC/i x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
Subject: [PATCH v2 0/6] some fixes to the pci-hyperv driver.
Thread-Topic: [PATCH v2 0/6] some fixes to the pci-hyperv driver.
Thread-Index: AQHTtLdCf0q5hC207kCF43lyuu+XxA==
Date: Mon, 5 Mar 2018 19:22:11 +0000
Message-ID: <20180305192134.32207-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.15.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; KL1P15301MB0039;
 7:IZCxGpuMeFzKClMbtOSuvaK2iizh/A2p9FDW/fGK+0L8z4COa8cT9sTyvUzqQa3y4xdGdtgX5rH6iDDg/0T4NTk9bvFKxqygKsQxX06tR3I5ZY8jDSFqJimEwWqBvrx0sQtH85eXUDtlAKRYCY3Dpc7ouzfJ1oUOJsU5In1TchWzaoTLh7DUXZdRb3BsF8/3SMTW5tnfCCNbpgcpmE51ftfDPWJ4PC602iYc/n+SUHYDDsfZ9Shf2kO/cjjKHbKD;
 20:mTD3+oIfodMrF3QmXv21RlPlz4u+OfVAKBKtjq7i9DWf9WSTkBrG7AbdsNtVmt/ixkBlzwGESd8XuJLoqQhW5ocXgOs0ocfWuKaXvwCsbL3xgtMJkjeob+XjLedN7O49a95bbJhKcmFgzNNZMFThlecSUuxmKPiXFvb+woG6FxI=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 205c0a17-24a9-4416-8664-08d582ce656a
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);
 SRVR:KL1P15301MB0039;
x-ms-traffictypediagnostic: KL1P15301MB0039:
x-microsoft-antispam-prvs: <KL1P15301MB003971FAA5EED82F354AA663BFDA0@KL1P15301MB0039.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);
 SRVR:KL1P15301MB0039; BCL:0; PCL:0; RULEID:; SRVR:KL1P15301MB0039;
x-forefront-prvs: 06022AA85F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39380400002)(396003)(366004)(376002)(39860400002)(199004)(189003)(1076002)(5660300001)(6116002)(316002)(86362001)(106356001)(36756003)(4326008)(105586002)(77096007)(26005)(25786009)(3846002)(22452003)(110136005)(2201001)(99286004)(102836004)(6506007)(54906003)(186003)(86612001)(8936002)(66066001)(68736007)(3280700002)(81156014)(478600001)(1511001)(14454004)(8676002)(6436002)(81166006)(3660700001)(107886003)(53936002)(2501003)(10290500003)(2906002)(6486002)(2900100001)(7736002)(6512007)(50226002)(305945005)(10090500001)(97736004)(22906009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:KL1P15301MB0039;
 H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM; FPR:; SPF:None; PTR:InfoNoRecords;
 A:1; MX:1; LANG:en;
x-microsoft-antispam-message-info: glEL3CLtvit+ARrm8jrTulTf2XsQPW/M+Cmu7hytZkyziH3I1ULTFrAtln8QMABQMQyJdCz3H4WgvMumc9HXeEilwQGON96mMjnWp551/sOPGNh1UJoKwVIWsGm7ehxkzmt98083ZJ6q4PAmLx6vVsyLZl6iyESSI5Mkfin/rFQbs5hipHG59mTZHKtWKgO5t/WzT74EGF9mRTDthOvE0lZaNr7pxRvHaFDs37/12UCz7oeXo/fPeQKdFMlG1pI7oniSYddI1LxNtGq/eCA0TRVwTiUFgwM3wf+YRBosibMOTxEXVRWeFjSk+cQEUfFJnITeN8ar5BlPMuWXJic5jw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 205c0a17-24a9-4416-8664-08d582ce656a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2018 19:22:11.2871 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0039
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

Changes since v1 are:

Patch 1, 6: no change since v1.

Patch 2,4,5: I added these new patches, as suggested by Michael Kelley.

Patch 3: Removed the unnecessary drain_workqueue(), as suggested by Michael Kelley.


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
