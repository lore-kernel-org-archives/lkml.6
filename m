Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2286252-1521050916-2-5093635241813024090
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521050916; b=ri8Zjsgsr8qzGW9bOLC/ZdBboi9Hl+bkStR47Ra4sqHce80
    NWDTprJxNZmqcK40bmyyatPsrM4q8Y16z0ipRcmZnLpuWVcofg6maDZnRQBtNP4L
    Uep5qmimo/MTKf9w72JYH9pWvv7d0+gbBbr9DAGGsunnHxqAzQ4WrEG9X4oVZRFn
    mavycBGkU1jkAJ25vZ+FYXp7VruyvpL9urXH00x2I1wjkBJE5cFYxCFM11lr72FB
    jJaoNWiE0Jtk6EH3B8Jrve+OPzQS5EXz9dOzPJiTOrvNibaaKPm1cftJNipvsK/Q
    WkBJ0YFhYy05Gi2IeTBWLCGNOfo66pUs11dHluQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:content-id:mime-version:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:content-type:content-transfer-encoding
    :sender; s=arctest; t=1521050916; bh=ch6a9Rk+Za0BR8xyXyvhSE6FHXY
    Grv8C6zM7aO/he58=; b=wRErU5xMvJSfI9s0F7Ms9vki9EQbi8oR+4UKjocY2LK
    fIHXRRmWVgXvUYYmmlFQ6vAT+0wv3TdcFRZyJ894qZahEczHcVJ1EE2rTiA701Bm
    DyDnHJgqk/6rBNwgSmwcCJuTHp0hXEtA61/BLOm4w+iYHS1OFe4jDiTaIDgb/R04
    3LVEFBveqDtr/W8B7Im2AkIsui6lGZru9NF4T6VdUHaNaZXGEss8Rldf94pFecvS
    6BNMCbelAiEqlE8NgmH7axKMfXmwyLyhh4Fvn5YRKq5Hpl96RFHWGHyH4mW7Xv/H
    l0QnEivV2rC7hfZYUvG6vq6OgU3swHuRZZdTMWYDgdA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aTNLyXqR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aTNLyXqR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Michael Kelley (EOSG)"
 <Michael.H.Kelley@microsoft.com>
Subject: [PATCH v2]PCI: hv: fix PCI-BUS domainID corruption
Thread-Topic: [PATCH v2]PCI: hv: fix PCI-BUS domainID corruption
Thread-Index: AQHTu78ZG8K5ecbT80ie9TifFjyK46PPkgsA
Date: Wed, 14 Mar 2018 18:08:24 +0000
Message-ID: <3110FB76-7E16-4240-A5C0-135DD0E6EEE6@microsoft.com>
References: <048A5571-8706-496C-99FB-35A0CF506A8B@microsoft.com>
In-Reply-To: <048A5571-8706-496C-99FB-35A0CF506A8B@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:5::292]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR21MB0841;
 7:7u89hOOu2AH5IiXFkuJHUBaso7X8EUz+FPzoCP4G4JKL31DRMVSmiDNBrWnijHOKCAPi3rbAzZMeFdk/L+egftMBuvlWhUWKbOM2T4rrNgWtT8A86vaDYURbTX4jYYqCWTCZxCIYQSm2Pejux9aLEsz5s6nS4RHVNCa/XdTj/3qOW6aIXWs7IWvD9ppGz9yRLDBZnj5/J75QL2mEgkZcOeGc0mzBtmqB2LayejufWKSG/gviwn9fc/i0Y9wXh3Zd;
 20:orpXCMkLB+zpsmFwXer3rKoGeRm01Lce7CdwdU9/3IsZgxzJB6SZ/Ofr92OwkE/xMkYzt8cgsgMVys/iVhCOZDt/AybT0MfTgdm0hXqiIEpPT+hsYC3bBkB6xrN0q778cBLjzx9ZgrT3p9WZ3REf5JyloV/vTm9GxxeeR9vDrxc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 21fda876-1aac-4b3a-ebee-08d589d69490
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:DM5PR21MB0841;
x-ms-traffictypediagnostic: DM5PR21MB0841:
x-microsoft-antispam-prvs: <DM5PR21MB0841FAEE65181E60FDF5BECAF6D10@DM5PR21MB0841.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501262)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);
 SRVR:DM5PR21MB0841; BCL:0; PCL:0; RULEID:; SRVR:DM5PR21MB0841;
x-forefront-prvs: 0611A21987
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39860400002)(366004)(39380400002)(376002)(396003)(40224003)(189003)(199004)(97736004)(1511001)(36756003)(68736007)(5250100002)(6486002)(6512007)(10290500003)(6436002)(105586002)(2900100001)(53936002)(6116002)(316002)(3280700002)(478600001)(14454004)(54906003)(110136005)(99286004)(81166006)(6636002)(82746002)(8676002)(81156014)(2950100002)(8936002)(83716003)(2906002)(86362001)(59450400001)(4326008)(22452003)(102836004)(6346003)(106356001)(76176011)(5660300001)(305945005)(7736002)(3660700001)(10090500001)(72206003)(186003)(33656002)(25786009)(6506007)(86612001)(46003)(22906009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR21MB0841;
 H:DM5PR21MB0826.namprd21.prod.outlook.com; FPR:; SPF:None; PTR:InfoNoRecords;
 MX:1; A:1; LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sridhar.Pitchai@microsoft.com;
x-microsoft-antispam-message-info: jHAl3VsKyTqevwmqDy0fVPB4XyQeXVPy8haXGLvjULo560PQ6uSguN+scgm1E8ykdreAucAo5lu7B514Zc35vZaWeLF7LQk1evn1s7aPgm5Z1mNhLrf/HK089Q1S0iW8ey3tMRRkfhmEvRnzChYVsl/PWW80/KRwkA18xbbwgDf/3d9wewyKYFgOXJEh0zu9DmfEHD9zvryAQTVV236LHc8gEgEUm7BCM2xGRMENUxDQw5ztUYd7Vi3QLjxZQGhftHofhkdkwSpOw3qX5xF7/8yOF/4ycr9toXsCulR1HiZOn/TGt3WCHV+I5P4NwZhSzRH5637u/WObM8SRssyUxA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <419B85035A0A0C4BB8F91504C0275802@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21fda876-1aac-4b3a-ebee-08d589d69490
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2018 18:08:24.9919 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0841
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
Cc: Stephen Hemminger <sthemmin@microsoft.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jake Oshins <jakeo@microsoft.com>, Bjorn Helgaas <bhelgaas@google.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

    Whenever PCI bus is added, HyperV guarantees the BUS id is unique. Even with
    that when a first device is added to the bus, it overrides bus domain ID with
    the device serial number. Sometime this can result in BUS ID not being unique.
    In this case, when PCI_BUS and a device added to the bus, even before the PCI
    BUS is added to kernel, the first device tends to overwrite the domain ID with
    0. Since there exists a PCI bus with domain ID 0 already the PCI bus addition
    fails. This patch make sure when a device is added to a bus, it never updated
    the bus domain ID. Since we have the transparent SRIOV mode now, the short VF
    device name is no longer needed.
    
    Fixes: 4a9b0933bdfc("PCI:hv:Use device serial number as PCI domain")
    Cc: stable@vger.kernel.org
    Signed-off-by: Sridhar Pitchai <srpitcha@microsoft.com>
    ---
    
    Changes in v2:
    * fix the commit comments.
    ---
     drivers/pci/host/pci-hyperv.c | 11 -----------
     1 file changed, 11 deletions(-)
    
    diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
    index 2faf38e..ac67e56 100644
    --- a/drivers/pci/host/pci-hyperv.c
    +++ b/drivers/pci/host/pci-hyperv.c
    @@ -1518,17 +1518,6 @@ static struct hv_pci_dev *new_pcichild_device(struct hv_pcibus_device *hbus,
     	get_pcichild(hpdev, hv_pcidev_ref_childlist);
     	spin_lock_irqsave(&hbus->device_list_lock, flags);
     
    -	/*
    -	 * When a device is being added to the bus, we set the PCI domain
    -	 * number to be the device serial number, which is non-zero and
    -	 * unique on the same VM.  The serial numbers start with 1, and
    -	 * increase by 1 for each device.  So device names including this
    -	 * can have shorter names than based on the bus instance UUID.
    -	 * Only the first device serial number is used for domain, so the
    -	 * domain number will not change after the first device is added.
    -	 */
    -	if (list_empty(&hbus->children))
    -		hbus->sysdata.domain = desc->ser;
     	list_add_tail(&hpdev->list_entry, &hbus->children);
     	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
     	return hpdev;
    -- 
    2.7.4
    
    
    

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
