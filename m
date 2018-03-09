Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1266598-1520624323-2-688637137059468097
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES endanl, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520624323; b=viAV0xn+PQbO3mL0xeR/qTp9qRuasNW8xhNyqUJU6EyfPIT
    cAohbmf9QZdXySeu9ugGtmxu6K8U49oDnMqASm3lGmSRMsppLIOn1W5x2an6X9UM
    ZVtvZijhD+XPSC7mPxrOFLGO2zPmj4RGp2SXYsLLpPg2bMDQh/6HgvUHywcoVSUG
    Jbu1TaJj0yccDYxlfqRKlDYHd6x6rUBD/MFzcAn3p0U4f0ZcyPBP9kh5o9jThHB8
    WkuYSE+l+pkFp+qnk1ZU62/Y0SWFk0cjpYYaebaLwyYt+oFqxVJRSNIWnxDDNnNq
    JHiolB5qQWNFs1r2klbEaKZ95aaloTOt0AQKgIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520624323; bh=K
    KR5iv/gz/4/qUoaVdyeZ6d3Tkn6NIGmf/2hdy+M2ss=; b=MrrnAe4hFDpBzgxfw
    xlI0gAuwAVjfGZB8bGU7VzcPvtIN7u4eIjnFOVPkqjGHfzoiJDttltYB3EsyXG7r
    M9cB2PP53mwSZjpI67mjnQNuD50wNt1obBoiAy5Lj8KPXq7njphDYuPTnsiaiV4+
    HfZxirJn3ZQS6M1DR9mB05KMa4R8cx6UgxyW5Evsjdr4gktBQg7IfroHJAtLpwPy
    tBe61hKPs+E5IzO4TUz9Y60HehZI1KLdu/RsvmBRjBIvMs++72rcAHyhDG9lna5D
    lWQLpEujV88LrgY4xTYncu5quoNL9rG5psCcyeWVEXVcHKbV0EuASdccgxr/SVcu
    1cG8Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=W6jJXtn6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=W6jJXtn6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Dexuan Cui <decui@microsoft.com>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>, Stephen
 Hemminger <sthemmin@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>,
 "apw@canonical.com" <apw@canonical.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>
Subject: RE: [PATCH v3 5/6] PCI: hv: hv_pci_devices_present(): only queue a
 new work when necessary
Thread-Topic: [PATCH v3 5/6] PCI: hv: hv_pci_devices_present(): only queue a
 new work when necessary
Thread-Index: AQHTtXgDjLgA2j8iukulpyHD75YrKqPIUT2w
Date: Fri, 9 Mar 2018 19:37:54 +0000
Message-ID: <BL0PR2101MB11083951371835374EFB4966CADE0@BL0PR2101MB1108.namprd21.prod.outlook.com>
References: <20180306182128.23281-1-decui@microsoft.com>
 <20180306182128.23281-6-decui@microsoft.com>
In-Reply-To: <20180306182128.23281-6-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-09T19:37:53.1639282Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [69.130.166.81]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BL0PR2101MB1107;
 7:zk/MnwF/e8FzfhRllbXpdltldqNgBWodLxC6LW/uTxBtErHVx/6Sh//iN5K5VZ6k3oW+Wy9mJnOI/Oh4MFdi0yEAQhynwdmXxdiRa2D7kPZ/7i2r+zm8/1kqpqEoGxMH5jZGJaaGL6NNiY/oTVBu3kLpalTtCI7owzWqHObwd541NBgLaQ5ZpAmJjogqhQRn67c4OM38vZnfeq0KJKhl0F25hvahk5Zia6Cdc9+QbS2ZIEVA/moK5SRitBJaYrTa;
 20:4zb5wu5M7oC3lqBXItV7W7pUupWSKs+OT1vVc3L3yhITj/GZD7TFI0V315kySOF4GSgsNyzgp1oPVcXG5lhRvad0h2dEum3TZmc7g+SZXLzrZwpHNIgaiFIUHB1jXA/uGd8YSn7OPzLjlWQ13FFZ2jEMDVkZwBjVpomSMVAxZ1w=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8286b16d-c0ef-4f16-4bd7-08d585f5565e
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7193020);
 SRVR:BL0PR2101MB1107;
x-ms-traffictypediagnostic: BL0PR2101MB1107:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com;
x-microsoft-antispam-prvs: <BL0PR2101MB1107C8DF0DF75F7422DDA139CADE0@BL0PR2101MB1107.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(211936372134217)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231220)(944501255)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);
 SRVR:BL0PR2101MB1107; BCL:0; PCL:0; RULEID:; SRVR:BL0PR2101MB1107;
x-forefront-prvs: 0606BBEB39
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(39380400002)(346002)(376002)(39860400002)(189003)(199004)(13464003)(66066001)(59450400001)(53546011)(26005)(478600001)(6506007)(97736004)(10290500003)(86612001)(2950100002)(76176011)(2201001)(4326008)(86362001)(6246003)(102836004)(1511001)(54906003)(8936002)(6666003)(110136005)(8676002)(316002)(81166006)(81156014)(74316002)(106356001)(33656002)(7736002)(305945005)(2906002)(25786009)(7696005)(5250100002)(2900100001)(3846002)(2501003)(99286004)(6116002)(8990500004)(3660700001)(10090500001)(6436002)(229853002)(53936002)(105586002)(55016002)(7416002)(9686003)(5660300001)(68736007)(22452003)(3280700002)(14454004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BL0PR2101MB1107;
 H:BL0PR2101MB1108.namprd21.prod.outlook.com; FPR:; SPF:None; PTR:InfoNoRecords;
 MX:1; A:1; LANG:en;
x-microsoft-antispam-message-info: UhAVcpDRI2m/X9w/2NjsWCGdyq86SnFBlkVSxs91ZY1pmChErRe7tO6u20C2f95/+af+DlG6XQESrY+r3r9nhTnBgsItlciff8nTm2T2hDbP3MC68MvMs8DudWr3Wde6YZ5hoDBFkI14OwC+53sy7JMtkSAPNW6tDazxuaxEndfI38ZA52dHp+cRiFzK/i5Pe8xIF6HUJfknoOZ18rbrzF3AcooHNcza6tGIFKtMuPduCkOq0texo+a71d6h60goDolwK7qzNYKyVNe6GsYFpHW96wlKHgREYziI9WJ7+B6tST/zQjJkmnSVTLHItdg6s8RvjMxJfWGIbyBF/LU3FA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8286b16d-c0ef-4f16-4bd7-08d585f5565e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2018 19:37:54.2130 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1107
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
Cc: "driverdev-devel@linuxdriverproject.org"
 <driverdev-devel@linuxdriverproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Jack Morgenstein <jackm@mellanox.com>,
 "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: Dexuan Cui
> Sent: Tuesday, March 6, 2018 1:22 PM
> To: bhelgaas@google.com; linux-pci@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> olaf@aepfle.de; apw@canonical.com; jasowang@redhat.com
> Cc: linux-kernel@vger.kernel.org; driverdev-devel@linuxdriverproject.org;
> Haiyang Zhang <haiyangz@microsoft.com>; vkuznets@redhat.com;
> marcelo.cerri@canonical.com; Michael Kelley (EOSG)
> <Michael.H.Kelley@microsoft.com>; Dexuan Cui <decui@microsoft.com>; Jack
> Morgenstein <jackm@mellanox.com>; stable@vger.kernel.org
> Subject: [PATCH v3 5/6] PCI: hv: hv_pci_devices_present(): only queue a new
> work when necessary
> 
> If there is a pending work, we just need to add the new dr into the dr_list.
> 
> This is suggested by Michael Kelley.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Jack Morgenstein <jackm@mellanox.com>
> Cc: stable@vger.kernel.org
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>
> ---

Acked-by: Haiyang Zhang <haiyangz@microsoft.com>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
