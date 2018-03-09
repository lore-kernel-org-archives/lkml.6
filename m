Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1242004-1520624326-2-4192043705823629863
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520624325; b=oqba3VSjK02GK9cRqutPHA4xozjV9mrgBCUowW1UoVLLzav
    Ws/MGsF8CEe+6DyHHvQouJywRCoirIQVe2u0EQhDQqaMwxZ4xF41dJof47XHTmjI
    GBfe/u1TPz2zlIxDR3E+yHV5y+ezmPfUtpM3zo0XtGpHYPnAMK6FJxq6bDwEKLaV
    K6epul/i2kVyB55jjaH0ir0PrdiqkuuGkEGoQAKGWck2UZij2TCMS9Ko934FMzRq
    +RdHvG+yPfqNJ7obCT0uWcMVdJ7twHC5sxkinSP0Cqekut9gSDT7uYxnQQD5XGvR
    ZEBqFfb95Fi+I+FvcXKDn/KJR1i14t8G8cT+ysg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520624325; bh=g
    uQilRPCjftW3XyWL9WJ90H5WUbtUPjqDIpxYmMmV+k=; b=R4YBn4I3nonWcvbyM
    2bRaz6hRrioJgsmLyWs+1czXVmC6ttniSDP2iPUUnpPy2wWuv176KWWibYZfTxZp
    YtWLm8JbapCPJJ/13erzKBHqcKNRM9QqCj85ZK43T66BhoiI+CT7TDOFBZFleD7/
    DCz72nu75NF4MJKdkuRSf9yjbaHCoC94z2/qyJCALHkFpdmseY70TW0mTMDLv0+N
    5jSEi6kv5dzL0g7s9Ur6TiFAD2wAJx38eaGF+zA6VbP+nmY6v1mCyf6of9ZdcJ+P
    D0Uo0Y02SdAVGxu1+epICnbUzHeOv+leHlWQ/VqjCwDba21sHdlmO+x2wBLkXlfS
    tmOow==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HQEbm6dA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HQEbm6dA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
Subject: RE: [PATCH v3 6/6] PCI: hv: fix 2 hang issues in hv_compose_msi_msg()
Thread-Topic: [PATCH v3 6/6] PCI: hv: fix 2 hang issues in hv_compose_msi_msg()
Thread-Index: AQHTtXgE9Y8Q5y/qWkesxFgPUzhEwqPIUVAA
Date: Fri, 9 Mar 2018 19:38:10 +0000
Message-ID: <BL0PR2101MB11087BE0B3B91040BE99EF5ACADE0@BL0PR2101MB1108.namprd21.prod.outlook.com>
References: <20180306182128.23281-1-decui@microsoft.com>
 <20180306182128.23281-7-decui@microsoft.com>
In-Reply-To: <20180306182128.23281-7-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-09T19:38:09.3494967Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [69.130.166.81]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BL0PR2101MB1107;
 7:aC22TbmsBEumpJs2+oOv49/Ne17Hld28OWgGi7itQ1NHgQ6gmjw7/SXzzF5YWynGDZ6sKw01WL+q0k1nncCMGGNLndMNPcvt1J2BVonS4YMtajdPq/5DzcRdXy7PHIK7SzQisWdu1as7++JA738f7uHEYF2AqK5fFkxZy6bpfcR+mFypuRKGNLPkvXXxf5UM2j7elELDnqXhxOYg1yZgmj5XAb7BX00dvv5teqVzicpAQl4vHwWjdp1S3ifvT3JF;
 20:75AD4Lw7rp/VIivV9SKKPt2nEF1OmeeAzqHhTRyq9KLs0NNhfqaDBwoAqwZECnMLKbnNo5SQaU62xVW5NCkGd6XTumBsQA/UVf8F/3VhubisqvQeF+XqMGNk+MJKmxT+GnyZxYLsOshTlzG5JJ9iE+jkDE0Skwvv1uOrO2p2swc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2a9f518b-49e1-4b6b-09f1-08d585f556d2
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7193020);
 SRVR:BL0PR2101MB1107;
x-ms-traffictypediagnostic: BL0PR2101MB1107:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com;
x-microsoft-antispam-prvs: <BL0PR2101MB11070383DAA5B3C2AB74725FCADE0@BL0PR2101MB1107.namprd21.prod.outlook.com>
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
x-microsoft-antispam-message-info: yTLoHPtIUiN23EQIEXbZ5fLQe3f4KoQMPw/I9yzx9bf5hcTUPX997TaF3bJcwSQlkaet8ffCoMTbfEOkIImj2c7NIB7Wfi2p1eK+FsvUJbuRVn0v6AKRfJHHPQElUFP7c6cw1FoMHU05M0Sk6nHfIt2y9QR+Xft8KXSqliwMJz3du/uiwj2FHnBFIeEQLRudu+nf0SJtKh/jXokqjXyB9NQBnbuiActuOE2GJ1esNswpepCZK0WralTbRyDc4RlrEnRRaKzFrXVX9GJS5Uc+K3lqy9frCUzDIOjox2ZeCDPxIlvG4Mv2Fc4Ox5QvbapTs9CFBMTW/LB7hWTSnw0NYw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a9f518b-49e1-4b6b-09f1-08d585f556d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2018 19:38:10.4274 (UTC)
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
> <Michael.H.Kelley@microsoft.com>; Dexuan Cui <decui@microsoft.com>;
> stable@vger.kernel.org; Jack Morgenstein <jackm@mellanox.com>
> Subject: [PATCH v3 6/6] PCI: hv: fix 2 hang issues in hv_compose_msi_msg()
> 
> 1. With the patch "x86/vector/msi: Switch to global reservation mode"
> (4900be8360), the recent v4.15 and newer kernels always hang for 1-vCPU
> Hyper-V VM with SR-IOV. This is because when we reach
> hv_compose_msi_msg() by request_irq()  -> request_threaded_irq() ->
> __setup_irq()->irq_startup()  -> __irq_startup() -> irq_domain_activate_irq() -
> > ... ->
> msi_domain_activate() -> ... -> hv_compose_msi_msg(), local irq is disabled in
> __setup_irq().
> 
> Fix this by polling the channel.
> 
> 2. If the host is ejecting the VF device before we reach hv_compose_msi_msg(),
> in a UP VM, we can hang in hv_compose_msi_msg() forever, because at this
> time the host doesn't respond to the CREATE_INTERRUPT request. This issue
> also happens to old kernels like v4.14, v4.13, etc.
> 
> Fix this by polling the channel for the PCI_EJECT message and
> hpdev->state, and by checking the PCI vendor ID.
> 
> Note: actually the above issues also happen to a SMP VM, if "hbus->hdev-
> >channel->target_cpu == smp_processor_id()" is true.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Tested-by: Adrian Suhov <v-adsuho@microsoft.com>
> Tested-by: Chris Valean <v-chvale@microsoft.com>
> Cc: stable@vger.kernel.org
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Jack Morgenstein <jackm@mellanox.com>
> ---

Acked-by: Haiyang Zhang <haiyangz@microsoft.com>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
