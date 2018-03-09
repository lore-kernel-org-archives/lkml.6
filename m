Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1242004-1520624320-2-14265381110343654487
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520624319; b=hoO+lS3mREMQN9dzP29KGQwQWO0AP3yJ8yNLAk3XilCt61h
    0DqkFd3aRVRG8gg1NPpkuVs9QrisDsmE4PhpdElLaOOlZ41fKD9Yci+w9XFuAo3l
    mTlu3yr8g8hf6Bdya0XmFyhw5Gd7Xj18FLi82m/QKIe0oXdQOly7EguPSPs8Gyvy
    ahLHaGgQJVzIiMVgPDusVpF/HsrE0QpuVs6fRGrk7LTrW5xGn9BEFUzOTDGolmgs
    CmoFYjVJYVifa1onYLASnpGL+7+0eHSB5cZ3xcGQ6Qu5FTDeMNuiv/Z6fbDtKc9g
    r9WYXm1bb93u7to05JzaukdkVA8kYl/a1jArIxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520624319; bh=s
    DEpfTCyPD4nroPGFe0lbqLpG9/JAVndkHlmNr1jlB4=; b=EsGLVZo9ysE4NkCh2
    GQoWzexdaCqytZ2vHZOKplrAJgERRGjwKmH5aV8hOJINg6erXjpodZkSfB6r+X3R
    kIyQWWMaa1KNYjfThpo+h5QeO3FsvKpdO5KMqGMQvK2/DqgfGbRzwrK5nrOhGSyN
    gS7+oWUuWUFD99rdCidaiSQjuzzSTCyPrtNtvpZtXqvB6pfOIqIpYo7Clc9Q5fi6
    RIRFuzUN2ghy2LR4Gtf2nJg5ARBg3kVQwlk9xrPO5TrARn8ynzMJPUwhfj26slZ6
    X5Fov5Pjwkj1sYHYcL+TmvUJxe7z+fP0RRRMEw50Cqv4oVg0Wo70l7tNyxAOusPl
    A8bmQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=L+rc2Oj9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=L+rc2Oj9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
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
Subject: RE: [PATCH v3 3/6] PCI: hv: serialize the present/eject work items
Thread-Topic: [PATCH v3 3/6] PCI: hv: serialize the present/eject work items
Thread-Index: AQHTtXgBpTiV2t8ytkWUZze+26AbwaPIURNA
Date: Fri, 9 Mar 2018 19:37:21 +0000
Message-ID: <BL0PR2101MB11089D6D870B1BF92093135ACADE0@BL0PR2101MB1108.namprd21.prod.outlook.com>
References: <20180306182128.23281-1-decui@microsoft.com>
 <20180306182128.23281-4-decui@microsoft.com>
In-Reply-To: <20180306182128.23281-4-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-09T19:37:20.5642665Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [69.130.166.81]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BL0PR2101MB1076;
 7:USI1vNTqIl423v37o/1MqXCFUG+Wn/VMU8uV72NSFtws3aJz1q6RVLPioqBR24e0vC+Z22vxPlkjAsWZ4JAG7VhWiFjm2g/S7lyBeX5JsEeZbDEgFTwxLedJ/yY6NxGDUVRvgzvdTRvYbPUzNC/VJopSx4sf2qtoM+kB0ZU1LEYPLt8KVvxoYMPTvfeJHnvm8hECOi3moz4Osws16CNe8NscgqgoPCV6sgWvil7D4i1844BhfxX781qZWrh8mS2P;
 20:phiXyDnr1CDrlPWAXzGlRPO70GpPyMZHYUzyEFwnTdMR7jyelKfh8ZOzMqc29wkXBxh1gn1uf5IxoG8YZIHJfWLl5uAFRK7h6k+znGpFLj7W4AiUuiYUYmtKheFqCRK3fJk4hspNJjNgPgvmV6a8O9kIuHTOCKBzaXF30JpE1Zw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 14330c6d-e80e-407d-6d58-08d585f52d6f
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7193020);
 SRVR:BL0PR2101MB1076;
x-ms-traffictypediagnostic: BL0PR2101MB1076:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com;
x-microsoft-antispam-prvs: <BL0PR2101MB1076CF376C61F933F18E994ACADE0@BL0PR2101MB1076.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(211936372134217)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231220)(944501255)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);
 SRVR:BL0PR2101MB1076; BCL:0; PCL:0; RULEID:; SRVR:BL0PR2101MB1076;
x-forefront-prvs: 0606BBEB39
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(396003)(366004)(13464003)(199004)(189003)(2501003)(86612001)(2906002)(53546011)(2950100002)(316002)(3660700001)(6436002)(6506007)(5250100002)(2900100001)(8936002)(229853002)(86362001)(4326008)(25786009)(2201001)(3280700002)(97736004)(1511001)(102836004)(6246003)(9686003)(55016002)(110136005)(26005)(74316002)(10290500003)(22452003)(478600001)(99286004)(8990500004)(3846002)(305945005)(54906003)(66066001)(53936002)(106356001)(8676002)(5660300001)(33656002)(7696005)(81156014)(105586002)(76176011)(7416002)(81166006)(14454004)(68736007)(7736002)(6116002)(10090500001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BL0PR2101MB1076;
 H:BL0PR2101MB1108.namprd21.prod.outlook.com; FPR:; SPF:None; PTR:InfoNoRecords;
 A:1; MX:1; LANG:en;
x-microsoft-antispam-message-info: sxlW5iIzqkwqyZwcEBbaZZPHh9j3Rs03tpOIM2rJPtgewF7+MVHn5YhQDU0panBMH8t5y8WpPh2INOY3TO91AfhCHoyS/lGaLRgYhxZk0F15gJ2n4tazsv7of0yX97JKV/PmXxchS36UrhayXerMHm3a7TMzMAB7ECBUKyIGiNDmJnI5fdQXg4YOHQGUfnj4yl0Gv8juRTeg/kmxE0DrWAMh02dcmIKpEKDXL5NNBHkTDL7jFD2U/LcfwYrtl5Mn1anUpazX3hD0ufyq/cbx2VRDsZhisyimzFG1MYsipe3kvXKowH/ewSY2uUq6+wfD+uwh4zgIA+myVgwauhmM8g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14330c6d-e80e-407d-6d58-08d585f52d6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2018 19:37:21.5640 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1076
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
> Subject: [PATCH v3 3/6] PCI: hv: serialize the present/eject work items
> 
> When we hot-remove the device, we first receive a PCI_EJECT message and
> then receive a PCI_BUS_RELATIONS message with bus_rel->device_count == 0.
> 
> The first message is offloaded to hv_eject_device_work(), and the second is
> offloaded to pci_devices_present_work(). Both the paths can be running
> list_del(&hpdev->list_entry), causing general protection fault, because
> system_wq can run them concurrently.
> 
> The patch eliminates the race condition.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Tested-by: Adrian Suhov <v-adsuho@microsoft.com>
> Tested-by: Chris Valean <v-chvale@microsoft.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Jack Morgenstein <jackm@mellanox.com>
> Cc: stable@vger.kernel.org
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> ---

Acked-by: Haiyang Zhang <haiyangz@microsoft.com>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
