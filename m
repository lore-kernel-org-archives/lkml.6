Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2389795-1520277758-2-12764841790078566111
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
    t=1520277758; b=QEaIJR74g3VYh0d+ASUhyQuMmIcJKgKX7eNNiIIvm84UzOo
    N0uYf6EHtd7TGfXG0uwXV4uYOKwp7YEIJ4gwTcxuqJMrPqs9asOXQWM9Ucp/KpBj
    w0I5N3hsXNoJhUA2Tzys3zZW+pay3nv8SZARcA7+WfwlgBfyg1HtNGT6SnmfJvvU
    joyK1YMJh1dVfzAvyOifZLBvbAcuCKd3dBZBzyn7lkB4DqGAk2m6b0hDRssOHYGA
    2/lCqDXOguV0lCwRhOI2V54YHe5pA1tWQddH8+lG2JmyNNY5+brojCgEt9Y6KUPP
    URshNtazGz6f9WJEB0Px9udlvDP6vEHl7Sz3stA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520277758; bh=R
    MTowhQRACBHfbOdwlpKyVspVok+IVbJrwQuHcRfvbU=; b=Qqsf1RGB2ZStIuugK
    Hm/uwhiS9aZpPj+WwERbJHpzvf7XmWruXuk1q7f/RYyOAkiq5fHtApABNkeiJl4T
    UUjLiABSW4KZs44yjplxv6+GawbnbUvm/geRNPvdkRWI0PUdCXb/gB76TUXKsXr5
    aJdncdaSIXWbB89HlRBqqZqdV0Ln/8Kym3t/+IGfJ6BlT8EVx4wcfwNsuTuYIXOC
    bKEK5U+/OQ7s9Q4YBP4TDP58pvVwIKtBEznED1Z+CVv7svwlgwQ0IUjAfoBS0WtW
    vmBWSbKo1MvMREl3g8B5X4UuIyPPpyS7o0V2qJG0Pfb/0RCmPTh95wlM5hQCWH3H
    MSYsw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=i1AzemWC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=i1AzemWC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
Subject: [PATCH v2 5/6] PCI: hv: hv_pci_devices_present(): only queue a new
 work when necessary
Thread-Topic: [PATCH v2 5/6] PCI: hv: hv_pci_devices_present(): only queue a
 new work when necessary
Thread-Index: AQHTtLdILulEelG7Ik+GDDlpqOy57A==
Date: Mon, 5 Mar 2018 19:22:21 +0000
Message-ID: <20180305192134.32207-6-decui@microsoft.com>
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
 7:AFLsZq+AiL1Ca24yjT0ovpDz/cO7BIFQPO3+EYvbmtNVtAQpdZcd8kZOLK4gOh79ak2a5DcLrfsp7R7dzmAZwDq4pfXFq8W8JAU8tXm0FCnAp22OQ8JRzy0hzuPv6BNc+yzKjNq2Z1WpWpe4QPi7gwPGhnmzX0BYP3Nt7yG54sh+HGFcEX/0eSx4pVCIKQbfAum/uJfnwJDhkGBex9t8JO8w3zy2poy6q9DqwoFggX/Q88KG2uYmylbXhI+8mlvq;
 20:h1LCPwCNnEvW79cTbjHdowfEbiiavrP1MYcqPSVz53Y0CwEMvVUGSs7VTtHcRwIQR0Hq5XVNsqsCjxnxc+59WE7X1R4TN0N8AF2ekY34j1Y/aJVIVSQ1pzq9C3JPvbkQhqpsCAlOUUKjG2QMnyvAz0NWnsRiIAEze6pd4vnhkpw=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d50c2a34-c783-4c5f-2e25-08d582ce6bbd
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);
 SRVR:KL1P15301MB0039;
x-ms-traffictypediagnostic: KL1P15301MB0039:
x-microsoft-antispam-prvs: <KL1P15301MB0039AEBBE7929A08490C3CFCBFDA0@KL1P15301MB0039.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);
 SRVR:KL1P15301MB0039; BCL:0; PCL:0; RULEID:; SRVR:KL1P15301MB0039;
x-forefront-prvs: 06022AA85F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39380400002)(396003)(366004)(376002)(39860400002)(199004)(189003)(1076002)(7416002)(5660300001)(6116002)(316002)(76176011)(86362001)(106356001)(36756003)(4326008)(105586002)(2950100002)(77096007)(26005)(25786009)(3846002)(22452003)(110136005)(2201001)(59450400001)(99286004)(102836004)(6506007)(54906003)(186003)(86612001)(8936002)(66066001)(68736007)(3280700002)(81156014)(478600001)(1511001)(14454004)(8676002)(6436002)(81166006)(3660700001)(53936002)(2501003)(10290500003)(2906002)(6486002)(2900100001)(7736002)(6512007)(50226002)(305945005)(10090500001)(97736004)(22906009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:KL1P15301MB0039;
 H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM; FPR:; SPF:None; PTR:InfoNoRecords;
 A:1; MX:1; LANG:en;
x-microsoft-antispam-message-info: KQ1ql4XAY+gW4MxI/c9CQL3dv7Ys7D5qhami4a7FK+pyNkJS8Rar8vUNddQSJYFi7fID6eqeanbuxsD5x6FUUVUsq+HJwcuSyYh4Bg8wALzltYlQ4iCxtD4LTocJ4XaifKOcikOYEikizLcoZK40xRwOjOfWVmFd0btMHv8qAGhakKVgpPhd6hafFPSJU6jy3dInIZqXtCPjZcyo15xqDllAIjHctiqws07saKHvTl7mfr3QL/TT7gpRlTG1ULYuKgrH6IY/6lP0whzUPpjd85yckMZneibFM3log+Y8fdZ91v4EIVnoc3CW5XyoSuwYBwpKG/jHY1gqmNZGgVUJ8Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d50c2a34-c783-4c5f-2e25-08d582ce6bbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2018 19:22:21.8992 (UTC)
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

If there is a pending work, we just need to add the new dr into
the dr_list.

This is suggested by Michael Kelley.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Jack Morgenstein <jackm@mellanox.com>
Cc: stable@vger.kernel.org
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 3a385212f666..d3aa6736a9bb 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -1733,6 +1733,7 @@ static void hv_pci_devices_present(struct hv_pcibus_device *hbus,
 	struct hv_dr_state *dr;
 	struct hv_dr_work *dr_wrk;
 	unsigned long flags;
+	bool pending_dr;
 
 	dr_wrk = kzalloc(sizeof(*dr_wrk), GFP_NOWAIT);
 	if (!dr_wrk)
@@ -1756,11 +1757,23 @@ static void hv_pci_devices_present(struct hv_pcibus_device *hbus,
 	}
 
 	spin_lock_irqsave(&hbus->device_list_lock, flags);
+
+	/*
+	 * If pending_dr is true, we have already queued a work,
+	 * which will see the new dr. Otherwise, we need to
+	 * queue a new work.
+	 */
+	pending_dr = !list_empty(&hbus->dr_list);
 	list_add_tail(&dr->list_entry, &hbus->dr_list);
-	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
 
-	get_hvpcibus(hbus);
-	queue_work(hbus->wq, &dr_wrk->wrk);
+	if (pending_dr) {
+		kfree(dr_wrk);
+	} else {
+		get_hvpcibus(hbus);
+		queue_work(hbus->wq, &dr_wrk->wrk);
+	}
+
+	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
 }
 
 /**
-- 
2.7.4
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
