Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2389795-1520277751-2-10409268337404546278
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520277750; b=Qzni+9dWsvWQ9BkrK8Hh1f1+qXtG4OrQv5KfBBKr5FrM6we
    2Q847+0xk3JdMcgFvQu24KAO/3K7w+od8dNpAno+CicQ92JhgyWSnwQmv7NNOowD
    iyS3zKRT7uH2Qhmten1OVZ+Jn3zfa0rR7SyA2FIlF16WeW7dx24kX2eUPTxQ5Itk
    UhG9X/y/nSlK3Cs2DbDBpb18cQtIM57WRjtN0ElWgfvKA0q3WyuWevjhQ26YrBdx
    o/KVddvXEJQKImMJlWB3f0BhQ9Xe+8q4rjP+GU8l7my6Y96vSUzCWZ4myocQiMGa
    1wP6gcNPrXf+pxT5ZN45aQ6YjH+iaVIGufXJufw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520277750; bh=g
    UfeKaX2nH2RJKZtgJlT3GYRHs3Gy/4UclcFtXsrDL8=; b=KBanU4fWQwbEcd/0Q
    zintEeg/btopkPcZLuJKDAorUgj3mr1VLYBWK3AMeEcdMPDgqWZ9FY7YO77xRR1u
    Du2bLBkDqEW/u7JhESD+8ZLCKuPlrOZgcy+FjD6qFWNhmDqPExnDn2BzwAi6s24k
    2buy99uX/QAQNS4C22VkPjs5DXRfYhAGXCUG/29Y5E1OsnBvnn4lFlSqAweuKJrW
    YS7TZibQIkUbaDEEjCjEpkuQ5r2RW1OmZgVznBw9Seuowb1HcCAp0yiiz59p9vx4
    lH71dlwnVqs3iKqWBNJoLkybrhvOj1JbhcWDuMXYb7HstQ0vTwxWdxbLGcT7Q+6K
    EfNUw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ITzLkvEj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ITzLkvEj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Dexuan Cui <decui@microsoft.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>, Stephen
 Hemminger <sthemmin@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>,
 "apw@canonical.com" <apw@canonical.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>
Subject: [PATCH v2 2/6] PCI: hv: hv_eject_device_work(): remove the bogus test
Thread-Topic: [PATCH v2 2/6] PCI: hv: hv_eject_device_work(): remove the bogus
 test
Thread-Index: AQHTtLdEG5adpemEOka8xO9TE6oauw==
Date: Mon, 5 Mar 2018 19:22:15 +0000
Message-ID: <20180305192134.32207-3-decui@microsoft.com>
References: <20180305192134.32207-1-decui@microsoft.com>
In-Reply-To: <20180305192134.32207-1-decui@microsoft.com>
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
 7:ZHIuEH/jCC21s57m9kxGiw1qOSKoNf+armBta/Ct79BLVMYz5rscO6lSfYFoMz9VhfZzVS7oiI3GblSal65dgx/THmAQ3XHUyKJ39AssnxleNwPQHSSVxUHmiaZ5H94vq7v7bCpcCaQ8XiRkB1rQ48WvgTsb/WBXLtTmfDeJ3ug3nNcBLPrPN+nOT4hp0ZyGEhCWGjY8cHe+N1yC9yfXs1uk2aHpDtenRepSo8L62/VpplldHW78/iGK6GZ//rr1;
 20:/OyH0CyQlkL5fwjqocmYKsZ03PhEyl3FJWlmmnWIc/Pob/4XuWmaxFamG77+ncX2PP9mu49YD20crN7Y1yYdUnRrbFO0LgQlRaqO8n8uVx+nIql3a4yurQUeFRcBaAW1cF3odYIs3IQHoc5i2rQkyrC/i8hGKLRR6xAXb8DWpag=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 62b96d2b-80c0-4a63-7e18-08d582ce67ab
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);
 SRVR:KL1P15301MB0039;
x-ms-traffictypediagnostic: KL1P15301MB0039:
x-microsoft-antispam-prvs: <KL1P15301MB0039E7DBEF1DF1CE2CD9EF8DBFDA0@KL1P15301MB0039.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);
 SRVR:KL1P15301MB0039; BCL:0; PCL:0; RULEID:; SRVR:KL1P15301MB0039;
x-forefront-prvs: 06022AA85F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39380400002)(396003)(366004)(376002)(39860400002)(199004)(189003)(1076002)(7416002)(5660300001)(6116002)(316002)(76176011)(86362001)(106356001)(36756003)(4326008)(105586002)(2950100002)(77096007)(26005)(25786009)(3846002)(22452003)(110136005)(2201001)(99286004)(102836004)(6506007)(54906003)(186003)(86612001)(8936002)(66066001)(68736007)(3280700002)(81156014)(478600001)(1511001)(14454004)(8676002)(6436002)(81166006)(3660700001)(53936002)(2501003)(10290500003)(2906002)(6486002)(2900100001)(7736002)(6512007)(50226002)(305945005)(10090500001)(97736004)(22906009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:KL1P15301MB0039;
 H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM; FPR:; SPF:None; PTR:InfoNoRecords;
 A:1; MX:1; LANG:en;
x-microsoft-antispam-message-info: NujxJ5Lmd8iw7dRzjKAsU/19Jw9MpiETkNgeSKd1e4mvtx6FHb0vF8dV4tRxXsO0yO8CMHMtdlum7HiXeOsYjvGEm+C7Xr9/I8QxixHmqnsiXXlNJdomccWNvB5FAzKw5FEG3gHDhOnTGFXV6eDRkxqbDQN0VzMdt2oQeAPntb+Rmub9t3ZUs232lRSaf7NEK+2x7MiMrbXT4KrK8YZP1XtA2DCCXNM/6Q+23hEnZkQcE/7NX82GCwUjBvYdLVOk6aT7t8sIxfKjoZyTazTW8HIqPddpOpjW+80lydykaLbtpDwbYmW/CpHzRBzKvYT+EyHPB/9fhEKBg1vTvGt87A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b96d2b-80c0-4a63-7e18-08d582ce67ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2018 19:22:15.1074 (UTC)
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Jack Morgenstein <jackm@mellanox.com>, "Michael Kelley
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

When we're in the function, hpdev->state must be hv_pcichild_ejecting:
see hv_pci_eject_device().

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Jack Morgenstein <jackm@mellanox.com>
Cc: stable@vger.kernel.org
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 1233300f41c6..04edb24c92ee 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -1796,10 +1796,7 @@ static void hv_eject_device_work(struct work_struct *work)
 
 	hpdev = container_of(work, struct hv_pci_dev, wrk);
 
-	if (hpdev->state != hv_pcichild_ejecting) {
-		put_pcichild(hpdev, hv_pcidev_ref_pnp);
-		return;
-	}
+	WARN_ON(hpdev->state != hv_pcichild_ejecting);
 
 	/*
 	 * Ejection can come before or after the PCI bus has been set up, so
-- 
2.7.4
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
