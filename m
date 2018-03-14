Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2529736-1521057385-2-16230092039179568213
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
    t=1521057384; b=f1EXRDsLiO8yDBmmF82ZsCuYUOW3b0EeKM95Wz4vYCYcry8
    7JkMB1xgknJTbeK++xTygBVVz3avkO0VTvQj3BABDHQm81nC062HesAMSD2umdFB
    UeKenPxwHHwKdoFumA5bdp/fdzjNauyU5sfD31e1ZB2cekVNwVZ8cAyJuKQjrR8p
    areOSjfHGk7VRwUPAnHkEz3YUOJZQbvM+amLwjsTOLbVwcTjKBynv9KVAt5vMJUK
    M+3hDsZod1u/sB+VfKwidbK4i/UYSdfOTDy9cHlB/raugwjAeFjcVbpnMPwjL+gQ
    nagnQ1+UzwPs2KhgSJX+2LRRy3GWr6zec8vy/MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521057384; bh=D
    wuTngjv5tAghiF0Vd2KIaeFFsmui7jomBJqBiz09tA=; b=D8OjQu5BzDG04CQtM
    9KG4Yrz65DIgIUZ3doNGPHpug6LkQeklD4Nz7coDEv0ibobmp7ZIaSna/6tKxDRD
    k2ZMqofxqKsXzt1eFeLGXoyiiyhlXOWge7kNaYJqgS1bueDf8SwoN7B2BzhnXO9s
    qrOBMRyHHiDYYyxJAC4suQOQbrOlQzzY2rtxRtLGMQpM82tl298jZ7TD5eAxCs6i
    k5qC9BVyiAYlEBQj8ZGsNRtiHbS6Ax+Qhvjdc4wjM6RHuFA6kLHI2sbypHBnVraK
    qFHfT53QIAZW/J62P5QOS8K5VgVxz6AJJ62oCLyorqvYpX5WrikMxU7t2dMcEvT/
    4yDYw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=W4HWFUIp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=W4HWFUIp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>
Subject: RE: [PATCH v2]PCI: hv: fix PCI-BUS domainID corruption
Thread-Topic: [PATCH v2]PCI: hv: fix PCI-BUS domainID corruption
Thread-Index: AQHTu78ZG8K5ecbT80ie9TifFjyK46PPkgsAgACTL6A=
Date: Wed, 14 Mar 2018 19:56:13 +0000
Message-ID: <DM5PR2101MB103077541F5DDC9B1355E71FDCD10@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <048A5571-8706-496C-99FB-35A0CF506A8B@microsoft.com>
 <3110FB76-7E16-4240-A5C0-135DD0E6EEE6@microsoft.com>
In-Reply-To: <3110FB76-7E16-4240-A5C0-135DD0E6EEE6@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-14T19:56:12.3638051Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [131.107.147.162]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR2101MB0869;
 7:yRwnEs+US8GJje6a7SSO5hAF8622VHL0ZPUuk1DS6PKOFtldcDZXSSxwy4RUwAiqJS6mfeadPGl/AZu8X7VM/3/AawfHw34lty9VuPt+GwsxYpgnkXiifBhVjiIYRwIVgJppGkhuibPSRf0/u14I52g+MM+rKozWXr7L56fL+BfnniUhbZaLnBvPXDoGzKt97y6O/Gzap4EF4mMkzbdmz5xgA2e0EAf4QjU7QtsXZ9QmEoHi18W8odJj0d8MWREB;
 20:ovIVNrCCGWgQcjAz4JKEIlxAQXl2HTsWbq0l+KH23gdvIFrZcYJwKTU4YsBHHLksnaDRZYCH/cjmepRzpWhVOWDxuZuy+rK9jy5WVzk+F5LNkOxkJEXBCTQ3sqk1h45F41cET5vn3IWBvuV31IVtOGG+m/+t0xrftoSSVj32RYQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 97426a85-ed08-4ba0-c393-08d589e5a437
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7193020);
 SRVR:DM5PR2101MB0869;
x-ms-traffictypediagnostic: DM5PR2101MB0869:
x-o365eop-header: O365_EOP: Allow for Unauthenticated Relay
x-o365ent-eop-header: Message processed by -  O365_ENT: Allow from ranges
 (Engineering ONLY)
x-microsoft-antispam-prvs: <DM5PR2101MB0869B1BD593988706CAF56E6DCD10@DM5PR2101MB0869.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(9452136761055)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231221)(944501268)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011);
 SRVR:DM5PR2101MB0869; BCL:0; PCL:0; RULEID:; SRVR:DM5PR2101MB0869;
x-forefront-prvs: 0611A21987
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(346002)(39380400002)(366004)(376002)(396003)(40224003)(13464003)(189003)(199004)(478600001)(9686003)(74316002)(55016002)(66066001)(53936002)(10290500003)(14454004)(6246003)(7696005)(5250100002)(86612001)(10090500001)(1511001)(26005)(86362001)(305945005)(105586002)(6436002)(2900100001)(3280700002)(2906002)(8990500004)(54906003)(7736002)(6506007)(316002)(53546011)(110136005)(68736007)(76176011)(6116002)(8676002)(81156014)(97736004)(4326008)(3846002)(3660700001)(8936002)(33656002)(81166006)(6346003)(106356001)(72206003)(5660300001)(229853002)(102836004)(2950100002)(25786009)(99286004)(22452003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR2101MB0869;
 H:DM5PR2101MB1030.namprd21.prod.outlook.com; FPR:; SPF:None; PTR:InfoNoRecords;
 MX:1; A:1; LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-message-info: mExJ1huSUk6BHBP/8PdnuowtMMdaMTCn+WG6n7pItaWHnELIu9NEcd8T+b9f8i4Fl4t1dOlV9sb0djwmZ3QAArigwuyuPHh9geQ2rovasBdmG9OhdXClcUsggohTY0Zx4KK1nDzvOrhoY19YlcJ7abzZ/jTWEAxIoird2Qk28Hb2zekh8WVj0dlEV1dfTg57wkpEVY5vs4fUyFLjlDVaXRLJP0wJpTa6qiIrWRNM7VVFKso56r5ZgONKRctMmgES2S3Lmeq9fhm/57Xk6tVmWQ8Pws1YO04gMm6OVNGpZDe8Wtsx83tQzNWKMOMUzf8rEMuZDZ6frp34ovPXjIgBQQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97426a85-ed08-4ba0-c393-08d589e5a437
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2018 19:56:13.7266 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0869
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

> -----Original Message-----
> From: Sridhar Pitchai
> Sent: Wednesday, March 14, 2018 11:08 AM
> To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Michael Kelley (EOSG)
> <Michael.H.Kelley@microsoft.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>; Jake Oshins <jakeo@microsoft.com>; Haiyang
> Zhang <haiyangz@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>; Dexuan
> Cui <decui@microsoft.com>; KY Srinivasan <kys@microsoft.com>;
> devel@linuxdriverproject.org; linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH v2]PCI: hv: fix PCI-BUS domainID corruption
> 
>     Whenever PCI bus is added, HyperV guarantees the BUS id is unique. Even with
>     that when a first device is added to the bus, it overrides bus domain ID with
>     the device serial number. Sometime this can result in BUS ID not being unique.
>     In this case, when PCI_BUS and a device added to the bus, even before the PCI
>     BUS is added to kernel, the first device tends to overwrite the domain ID with
>     0. Since there exists a PCI bus with domain ID 0 already the PCI bus addition
>     fails. This patch make sure when a device is added to a bus, it never updated
>     the bus domain ID. Since we have the transparent SRIOV mode now, the short VF
>     device name is no longer needed.
> 
>     Fixes: 4a9b0933bdfc("PCI:hv:Use device serial number as PCI domain")
>     Cc: stable@vger.kernel.org
>     Signed-off-by: Sridhar Pitchai <srpitcha@microsoft.com>
>     ---

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
