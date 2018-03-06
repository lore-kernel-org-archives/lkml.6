Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1039939-1520360977-2-3549837691777408324
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520360976; b=CBRJWpltVLfXEBRyUtETHdlv+6X8KsL8/JU/gtKSA3NW4gb
    mmB4YvQvyJsOZ7zf38wjfd6OTWv/d3vG8K+61FYnfwaxqjwA35ujY+5garzOBJcS
    RbkC0h2KCk3AcskuI5Vh2H1Qyo8QAh+7a4VJh3xpFQG1lYiO7XA6w4fX/B29JEt9
    0HvfTe/44e4F1UCDm9tcum/ZqMPivncLOEo1OiUH6KPgfxo9+5rM75hSjq8OQv0b
    rf1yXqN7VoFOuZvny+CNwqxcd+YtvUvGJ+dcp9bHlwJncKQpyEUX3qBgu18pHdv4
    8Di7O0E7N4t+77A9Pf3o/p2ic8ICWMOz2H8xqEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520360976; bh=TWdbCr
    GCfYPp8VJx486C+hxvUw0o5jbC9eCRTeE4LIM=; b=oZXxU5MADxaMcJsW1IoEbz
    qzH4D51DYL4FmRjU0eN81wsYIXNEmhki9Qp0e9XLpb8sPMmaeDAcSV9kKmM5s+oE
    uHZTYge8z+VzaTD4gIlLyWW8V9sySu47teRjj4kC39XzzLDcwQzhNvFFxqxJBUDT
    JX0KMsbZNagN7oXXpAx6EHlGKnA9c2vVj0W6uZCjCzJGQVKSeBhRGmjV8GYURhqg
    rTQyi8fEvfeWbd5O0ycluxs8QDoEXJcTJemB1Ias17y186JQ/PEZwjXws5C6R6up
    k2blKce1aKUFWnHeUC8+qgNSnGaUdAS/vNtmWgYy5MpyreslS1U4N5GbAVMHE4nw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Mg73Yz8/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Mg73Yz8/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753466AbeCFS3d (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 13:29:33 -0500
Received: from mail-sn1nam01on0099.outbound.protection.outlook.com ([104.47.32.99]:58880
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753454AbeCFS3c (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 6 Mar 2018 13:29:32 -0500
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: Dexuan Cui <decui@microsoft.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org"
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Jack Morgenstein <jackm@mellanox.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v3 2/6] PCI: hv: hv_eject_device_work(): remove the bogus
 test
Thread-Topic: [PATCH v3 2/6] PCI: hv: hv_eject_device_work(): remove the bogus
 test
Thread-Index: AQHTtXgAV/v0yulM9E2hP7o9JB3fsaPDhtxg
Date: Tue, 6 Mar 2018 18:29:29 +0000
Message-ID: <DM5PR2101MB10300BF86C5FA9CC94B76182DCD90@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <20180306182128.23281-1-decui@microsoft.com>
 <20180306182128.23281-3-decui@microsoft.com>
In-Reply-To: <20180306182128.23281-3-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-06T18:29:28.4924826Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1112;7:THIuL1ZRdQVtr7mwsMymFYO4qWbfWqhqoPPX7gwT1ytPB3LIGf9MMLHMdzK1Moe+iou+HXSkaSSshC/j8irCfxld7IFM3LxBgFtnZGf2IuIkYjpJLCnaDp4AmB26+PdBjdRoBSytzHQCiJ9+EMBuV9TQXmEEkNAgfOCBR/LVDLtx5ihyG12oAT4v0xfSJepx+Ci5EelewayszBmUlRnh7IKfDoua/rgtZ3LAnNciGFZ5w9uAAPc//dVEU/cWH6tq;20:2n3jYujF/xe3f6EpZNVHgtb0rt9uNyC7MYdK73e8pSY//IUtW62WZlkDMjB/9BzCHqVcc/CCNawO4eOhVmRXZIUD8Gx7QOODGtqJQ+/OmboYabRwzDR085VV4I6xSaETLzSdg1w1ZBUHmcJJ7qvTBiP4SNrpo8KXIYaCP6CQWE0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9483fa52-ad6e-4aab-1558-08d583903334
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7193020);SRVR:DM5PR2101MB1112;
x-ms-traffictypediagnostic: DM5PR2101MB1112:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1112B8B2A98337DB4741C511DCD90@DM5PR2101MB1112.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(211936372134217)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1112;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1112;
x-forefront-prvs: 06036BD506
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(366004)(39380400002)(346002)(13464003)(199004)(189003)(6506007)(110136005)(68736007)(305945005)(4326008)(105586002)(10090500001)(7736002)(2201001)(6436002)(316002)(97736004)(102836004)(72206003)(2900100001)(2501003)(86612001)(10290500003)(14454004)(478600001)(6116002)(86362001)(2950100002)(74316002)(229853002)(22452003)(81156014)(54906003)(76176011)(81166006)(2906002)(7416002)(9686003)(53936002)(99286004)(6246003)(3846002)(8936002)(66066001)(1511001)(5660300001)(7696005)(3280700002)(26005)(8990500004)(53546011)(3660700001)(8676002)(33656002)(55016002)(5250100002)(106356001)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1112;H:DM5PR2101MB1030.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: wovT4iEDqOleYTON6wom2EOWcrcdr7U4RCtRiLSlCbsMiu3j3S4CjLn9LECMdkK/QZe92qyuMsbVfjkojc5y8wM2uJVuoqE0b4Y+xls/NqlxsjXDGMUc1PDLODeIhQVIi+hpb5HW8kgk68v7K/A4o7tDckdG+JoVUp2hd2orAdoYRAmuPdgMdA3YwJZ6ko68aXnu+YmDM9LBF6A8nctTTwGOjaKmdQCDXFIzwzWfE1O43xU1KMFpdMnyD50MCOU/dfhF8J/9goLlGltv3bKBJzcWPtdYi0Rr0g4ya0MjH0jRd7sedVeDqtpj/M4tgjckBu5QBcIQ+JADosJeVa8Z2g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9483fa52-ad6e-4aab-1558-08d583903334
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2018 18:29:29.9042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1112
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> -----Original Message-----
> From: Dexuan Cui
> Sent: Tuesday, March 6, 2018 10:22 AM
> To: bhelgaas@google.com; linux-pci@vger.kernel.org; KY Srinivasan <kys@mi=
crosoft.com>;
> Stephen Hemminger <sthemmin@microsoft.com>; olaf@aepfle.de; apw@canonical=
.com;
> jasowang@redhat.com
> Cc: linux-kernel@vger.kernel.org; driverdev-devel@linuxdriverproject.org;=
 Haiyang Zhang
> <haiyangz@microsoft.com>; vkuznets@redhat.com; marcelo.cerri@canonical.co=
m; Michael
> Kelley (EOSG) <Michael.H.Kelley@microsoft.com>; Dexuan Cui <decui@microso=
ft.com>; Jack
> Morgenstein <jackm@mellanox.com>; stable@vger.kernel.org
> Subject: [PATCH v3 2/6] PCI: hv: hv_eject_device_work(): remove the bogus=
 test
>=20
> When we're in the function, hpdev->state must be hv_pcichild_ejecting:
> see hv_pci_eject_device().
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Jack Morgenstein <jackm@mellanox.com>
> Cc: stable@vger.kernel.org
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>
> ---
>  drivers/pci/host/pci-hyperv.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.=
c
> index 1233300f41c6..04edb24c92ee 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -1796,10 +1796,7 @@ static void hv_eject_device_work(struct work_struc=
t *work)
>=20
>  	hpdev =3D container_of(work, struct hv_pci_dev, wrk);
>=20
> -	if (hpdev->state !=3D hv_pcichild_ejecting) {
> -		put_pcichild(hpdev, hv_pcidev_ref_pnp);
> -		return;
> -	}
> +	WARN_ON(hpdev->state !=3D hv_pcichild_ejecting);
>=20
>  	/*
>  	 * Ejection can come before or after the PCI bus has been set up, so
> --
> 2.7.4

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
