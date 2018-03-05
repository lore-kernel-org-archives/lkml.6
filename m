Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2846501-1520293662-2-1133268481450631302
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520293661; b=gXXXo0pMcalwPTR01EeFohxgAeu0Qq3X9ZqZsSD+UKn9BB+
    VhYtzXeo22KzLenkazBOuyt0YBD6cudQaKFhMwFqlrObf+jdPAbNEdgEd8Fzkt8/
    vXjbJ/bBEturMateIuj2tjikdI1RiPGN1nG8Lwv3A5PssJajCJ8nAok1jlJbx4rP
    gBCSbwS/2iHF0lIPR2qUxk5MI/tpz0n3irDa6nzXUvX0qEZZiekPUlUZZoV8B4sW
    1SUkjy2V2F022RuqJ/aeQm1SJzdxLh4GJmDVsPVeVzYRGkQQdekBOl7FzMKkOnie
    mynzVn7HnCDf/AtB0JURI0B3hEE6rovUX0PK0lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520293661; bh=htnWv4
    MMuVPAm7xQDjwokdtyv/lPgBRDL8HWtKuFZzU=; b=IacMJ6dQ5l/WlYVvzkJWml
    +H7MJXlStc5Cb45HgPaqbQIOSLeRWS4PF7tYOtzz+BHCqYmw2RANZYoWyQhe/T38
    27jfvO0jOFXm2YZ5Ui7Hb/KcK8DsjekqMNLEyf9KmxJuIB5hYMg06ZVCynqx2GoX
    cERzjUDs8qymx3XW4AukyT2otkGvsUuFzqonlRCtrVu1/j9ivhX2Y3rLOgQ8b5XQ
    rvFp/24Uq6gsqK8rzHyAYdfu3c78qNmj/VzF8h17ebQKmerhOekT3msyK2rhGag3
    hU1ZTkUKS1k878kp4YuA7HY7kEOxxkpxkH732piMabV19F34tlXz1omK5FPOi83g
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AIezBMSo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AIezBMSo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932739AbeCEXrh (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 18:47:37 -0500
Received: from mail-bn3nam01on0132.outbound.protection.outlook.com ([104.47.33.132]:35493
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932084AbeCEXrf (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 5 Mar 2018 18:47:35 -0500
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
Subject: RE: [PATCH v2 5/6] PCI: hv: hv_pci_devices_present(): only queue a
 new work when necessary
Thread-Topic: [PATCH v2 5/6] PCI: hv: hv_pci_devices_present(): only queue a
 new work when necessary
Thread-Index: AQHTtLdRBbXIsdHoGkiHVEmx+LHB+qPCTKDQ
Date: Mon, 5 Mar 2018 23:47:32 +0000
Message-ID: <DM5PR2101MB10300B0494E43D69A20C86B3DCDA0@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <20180305192134.32207-1-decui@microsoft.com>
 <20180305192134.32207-6-decui@microsoft.com>
In-Reply-To: <20180305192134.32207-6-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-05T23:47:30.5230940Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;7:Vz/dR6cUXXkAI92/l9bWvpKIiZPe7Nw+AIeV47FM9LHB1isMaqqY+6e8xwO0yvWxSxTFufgOi4eq2J0X8un799X+xo5+/6plPqlD9ZVBKvWqz/YgXsv0EWmqWzgu0uCwcItX6I9WFQzTmUKkmyqwavMtfIqkbJGXj7dvWIoT7unAe+6fFANttx6V3AeCUHpjW2KAXTM4XrF0KV+mBGbK6OmdZ99eGuQ/0bMDHy7rELADxZjbW9SXqCj9zX35s3yH;20:UX3DUrBsE4cAVlSAshAQtRH1rn0ydl9qi7nOygwvdrYwRKUiPR9U0651xzHeFBhNxs8dEFdaTldNIX/LFUvpXXY08FFRpq/Bf7CZMR6InatCAQuFcmDl6bur4NgW1VAJlpYHjiajX9+87pLRpJ29ga5iEoPnNt3xRv9dEfzhSAw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bd9aeebc-65e9-4d4c-def9-08d582f376a9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0871C94DEC019AF49A14271BDCDA0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(211936372134217)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 06022AA85F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(376002)(346002)(366004)(39860400002)(199004)(189003)(13464003)(8936002)(8676002)(81166006)(1511001)(66066001)(81156014)(14454004)(7416002)(10090500001)(105586002)(8990500004)(305945005)(7736002)(478600001)(2900100001)(10290500003)(74316002)(86612001)(72206003)(2501003)(68736007)(25786009)(4326008)(102836004)(33656002)(53546011)(26005)(97736004)(5250100002)(6506007)(99286004)(7696005)(6116002)(76176011)(3846002)(316002)(22452003)(110136005)(59450400001)(3660700001)(54906003)(6436002)(5660300001)(86362001)(2201001)(2906002)(9686003)(3280700002)(229853002)(55016002)(106356001)(6246003)(53936002)(2950100002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1030.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: gRhN/JdKeHN12WPMuj0sLeerqZERJyKJjTGqX0k9X/e6mSFzbxcLAyXev8MAcJiPJFzhOl8NUerHJuIm55KqkoChvF1kZKd0uNNoDFkRm9C7lksk/RXWL8gmP0aHQbTdSq5HK3oxD6g9bJz9OmTnpzdjSPOXkKx9WBvaxbI1fondilZ7mJS5BWsHVc+5fw2HJdfW4kLZiLYHINT0sZsjwOUh9zXegGpICTCkwgkD0ZvxG/XxI4am8eahkZWKPPD0lbi4RobZABKyI6Q3O60AJcCzNJdS4zdXeMhubm6/6KESmHp3v9e8w6n5OVh8xr8z/O2FUkp1Kv54s4gdbiQPOg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9aeebc-65e9-4d4c-def9-08d582f376a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2018 23:47:32.0459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> -----Original Message-----
> From: Dexuan Cui
> Sent: Monday, March 5, 2018 11:22 AM
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
> Subject: [PATCH v2 5/6] PCI: hv: hv_pci_devices_present(): only queue a n=
ew work when
> necessary
>=20
> If there is a pending work, we just need to add the new dr into
> the dr_list.
>=20
> This is suggested by Michael Kelley.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Jack Morgenstein <jackm@mellanox.com>
> Cc: stable@vger.kernel.org
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>
> ---
>  drivers/pci/host/pci-hyperv.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.=
c
> index 3a385212f666..d3aa6736a9bb 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -1733,6 +1733,7 @@ static void hv_pci_devices_present(struct hv_pcibus=
_device *hbus,
>  	struct hv_dr_state *dr;
>  	struct hv_dr_work *dr_wrk;
>  	unsigned long flags;
> +	bool pending_dr;
>=20
>  	dr_wrk =3D kzalloc(sizeof(*dr_wrk), GFP_NOWAIT);
>  	if (!dr_wrk)
> @@ -1756,11 +1757,23 @@ static void hv_pci_devices_present(struct hv_pcib=
us_device
> *hbus,
>  	}
>=20
>  	spin_lock_irqsave(&hbus->device_list_lock, flags);
> +
> +	/*
> +	 * If pending_dr is true, we have already queued a work,
> +	 * which will see the new dr. Otherwise, we need to
> +	 * queue a new work.
> +	 */
> +	pending_dr =3D !list_empty(&hbus->dr_list);
>  	list_add_tail(&dr->list_entry, &hbus->dr_list);
> -	spin_unlock_irqrestore(&hbus->device_list_lock, flags);

A minor point:  The spin_unlock_irqrestore() call can
stay here.   Once we have the list status in a local variable
and the new entry is added to the list, nothing bad can
happen if we drop the spin lock.   At worst, and very unlikely,
we'll queue work when some other thread has already queued
work to process the list entry, but that's no big deal.   I'd argue
for keeping the code covered by a spin lock as small as possible.

Michael

>=20
> -	get_hvpcibus(hbus);
> -	queue_work(hbus->wq, &dr_wrk->wrk);
> +	if (pending_dr) {
> +		kfree(dr_wrk);
> +	} else {
> +		get_hvpcibus(hbus);
> +		queue_work(hbus->wq, &dr_wrk->wrk);
> +	}
> +
> +	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
>  }
>=20
>  /**
> --
> 2.7.4
