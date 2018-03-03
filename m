Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-384687-1520093420-2-7208293538630318821
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
    t=1520093419; b=I40cy2TUNeUbXuT6nwKs934/JpWcf9DPG7ceYeA7k5Pu5dU
    yNPIaEXBz95RpM432232J+CBkjZne78rIcWu3kMT0IW9woCaQPHHJPA3V90q5hkb
    NgM6qDxAgXoRXkj3QOZ7oW5Ejk6xyCO/fe8nUQMqNRbW2kD5gFyqZda9zgxpeIAY
    260ApS+OOYoTPTvAxoFciaPQNA1XoExBHSUcp/DX3DqIUFGriZdxLiwe+j02Pf8w
    RXMsKvVz4NOTJAvWTR/FRHYLx7poXAFiucicDnSRBvvMh9nu24uQQhiAbzLmfH8R
    HknYuLICp1tx4fRbfGq5816moZbe+vHbaZZETbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520093419; bh=IO4GbD
    mLvDsRM91EIhrkanqlNtm0ZdbmiQsNWLrK1dM=; b=DpNCdgbBXoktt1I0ngpTf4
    lpPwNsnSIRbfS7A0Gr6R0zdeg3gPyIZkJb/unakPhsa6ldT/60hvC6PPv+67nnDC
    aQulWGc7F91Ih7ThNwWi97DolTAe2Dfso8uuqGSBTi3E+q4tBzfq9fG94zVTdQzG
    1F7z7pkEf9GH4J+K93m5iXMIa/jDQHm/a2UeOyq7VFjWKv7YAqHhDuUm1n/LoTb1
    IdaQcHpdJw14JC4MU8ziAnSgqVcHSb2e039CKLkajQDUa7mBWOsY9Q0eaYBZnHcr
    m7IbuJSCyKzaDWBpX3sIbWrMY2fyG+qRBr0cbDjX1C3KVyH3tfxaMap3hDp3voww
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CI+qVFFC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CI+qVFFC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932121AbeCCQJu (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 11:09:50 -0500
Received: from mail-cys01nam02on0125.outbound.protection.outlook.com ([104.47.37.125]:22304
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932111AbeCCQJt (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 11:09:49 -0500
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: Dexuan Cui <decui@microsoft.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org"
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Dexuan Cui <decui@microsoft.com>,
        Jack Morgenstein <jackm@mellanox.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 2/3] PCI: hv: serialize the present/eject work items
Thread-Topic: [PATCH 2/3] PCI: hv: serialize the present/eject work items
Thread-Index: AQHTsoWGFBWjb5SxZ0KePr9iZ4nXX6O+pZGw
Date: Sat, 3 Mar 2018 16:09:46 +0000
Message-ID: <DM5PR2101MB1030BC8E7A263D65A1A64B26DCC40@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <20180303001947.20564-1-decui@microsoft.com>
 <20180303001947.20564-2-decui@microsoft.com>
In-Reply-To: <20180303001947.20564-2-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-03T16:09:44.3000079Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0886;7:jyo/tXMn/37H+yVSxt6KJaPygdXGMP7muIFM2s08+YQU0DPQWj4+ebZYA1TcSguWdby5b4vWNjXlY/PQnot4EEI5niA/0/uO/W5rcjP4eFnJZmVRxE6Jf5liUHmnfbvnPvTNpzzWL1r5Atz/udHoeZ2laZHXRKbigxnAUQSN31zkOhiWbmEpcU3KR2GR0V/VTPL9uUcb+100DINPUgVCJuvjzqRRW/Tw2A3AUjcrQVUL8FkFlM138Fa97OWuCMqG
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 40931249-6c1a-46e1-321d-08d581212ed9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:DM5PR2101MB0886;
x-ms-traffictypediagnostic: DM5PR2101MB0886:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0886C6D09FDBCDAB86E509CEDCC40@DM5PR2101MB0886.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(211936372134217)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0886;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0886;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(39860400002)(376002)(396003)(366004)(189003)(199004)(13464003)(14454004)(59450400001)(6116002)(33656002)(305945005)(6246003)(76176011)(2501003)(7416002)(7696005)(72206003)(53546011)(6506007)(102836004)(6436002)(99286004)(26005)(86612001)(9686003)(74316002)(5250100002)(55016002)(2906002)(478600001)(22452003)(53936002)(7736002)(5660300001)(3846002)(3280700002)(10290500003)(2900100001)(66066001)(86362001)(10090500001)(316002)(54906003)(110136005)(8990500004)(6636002)(106356001)(2201001)(1511001)(229853002)(68736007)(97736004)(8676002)(2950100002)(25786009)(8936002)(105586002)(4326008)(3660700001)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0886;H:DM5PR2101MB1030.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: pFdqgI7bsuZK6Xh+L3vMk/4CsDlvYJfhuMKPIigGuUFcxrh7UbS3hKeDU9TPcc/kTrqvajdOAhaTRka0Tug3/lSbXGzJ5e/FxheWUixBmuZaey98W8/Z4rmRcBegXNt7qbv/zls8mc9MF9P8mvn5a9uPsdC0CTD1bIBuBjGOd/E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40931249-6c1a-46e1-321d-08d581212ed9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 16:09:46.2058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0886
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kernel.=
org> On Behalf
> Of Dexuan Cui
> Sent: Friday, March 2, 2018 4:21 PM
> To: bhelgaas@google.com; linux-pci@vger.kernel.org; KY Srinivasan <kys@mi=
crosoft.com>;
> Stephen Hemminger <sthemmin@microsoft.com>
> Cc: linux-kernel@vger.kernel.org; driverdev-devel@linuxdriverproject.org;=
 Haiyang Zhang
> <haiyangz@microsoft.com>; olaf@aepfle.de; apw@canonical.com; jasowang@red=
hat.com;
> vkuznets@redhat.com; marcelo.cerri@canonical.com; Dexuan Cui <decui@micro=
soft.com>;
> Jack Morgenstein <jackm@mellanox.com>; stable@vger.kernel.org
> Subject: [PATCH 2/3] PCI: hv: serialize the present/eject work items
>=20
> When we hot-remove the device, we first receive a PCI_EJECT message and
> then receive a PCI_BUS_RELATIONS message with bus_rel->device_count =3D=
=3D 0.
>=20
> The first message is offloaded to hv_eject_device_work(), and the second
> is offloaded to pci_devices_present_work(). Both the paths can be running
> list_del(&hpdev->list_entry), causing general protection fault, because
> system_wq can run them concurrently.
>=20
> The patch eliminates the race condition.

With this patch, the enum_sem field in struct hv_pcibus_device
is no longer needed.  The semaphore serializes execution in
hv_pci_devices_present_work(), and that serialization is now done
with the ordered workqueue.  Also, the last paragraph of the top level
comment for hv_pci_devices_present_work() should be updated to
reflect the new ordering assumptions.

Separately, an unrelated bug:  At the top of hv_eject_device_work(),
the first test may do a put_pcichild() and return.  This exit path also
needs to do put_hvpcibus() to balance the ref counts, or do a goto
the last two lines at the bottom of the function.

>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Tested-by: Adrian Suhov <v-adsuho@microsoft.com>
> Tested-by: Chris Valean <v-chvale@microsoft.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Jack Morgenstein <jackm@mellanox.com>
> Cc: stable@vger.kernel.org
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> ---
>  drivers/pci/host/pci-hyperv.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.=
c
> index 1233300f41c6..57b1fb3ebdb9 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -461,6 +461,8 @@ struct hv_pcibus_device {
>  	struct retarget_msi_interrupt retarget_msi_interrupt_params;
>=20
>  	spinlock_t retarget_msi_interrupt_lock;
> +
> +	struct workqueue_struct *wq;
>  };
>=20
>  /*
> @@ -1770,7 +1772,7 @@ static void hv_pci_devices_present(struct hv_pcibus=
_device *hbus,
>  	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
>=20
>  	get_hvpcibus(hbus);
> -	schedule_work(&dr_wrk->wrk);
> +	queue_work(hbus->wq, &dr_wrk->wrk);

This invocation of get_hvpcibus() and queue_work() could be made
conditional on whether the preceding list_add_tail() transitioned
the list from empty to non-empty.  If the list was already non-empty,
a previously queued invocation of hv_pci_devices_present_work()
will find the new entry and process it.   But this is an
optimization in a non-perf sensitive code path, so may not be
worth it.

>  }
>=20
>  /**
> @@ -1848,7 +1850,7 @@ static void hv_pci_eject_device(struct hv_pci_dev *=
hpdev)
>  	get_pcichild(hpdev, hv_pcidev_ref_pnp);
>  	INIT_WORK(&hpdev->wrk, hv_eject_device_work);
>  	get_hvpcibus(hpdev->hbus);
> -	schedule_work(&hpdev->wrk);
> +	queue_work(hpdev->hbus->wq, &hpdev->wrk);
>  }
>=20
>  /**
> @@ -2463,11 +2465,17 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	spin_lock_init(&hbus->retarget_msi_interrupt_lock);
>  	sema_init(&hbus->enum_sem, 1);
>  	init_completion(&hbus->remove_event);
> +	hbus->wq =3D alloc_ordered_workqueue("hv_pci_%x", 0,
> +					   hbus->sysdata.domain);
> +	if (!hbus->wq) {
> +		ret =3D -ENOMEM;
> +		goto free_bus;
> +	}
>=20
>  	ret =3D vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL, 0=
,
>  			 hv_pci_onchannelcallback, hbus);
>  	if (ret)
> -		goto free_bus;
> +		goto destroy_wq;
>=20
>  	hv_set_drvdata(hdev, hbus);
>=20
> @@ -2536,6 +2544,9 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	hv_free_config_window(hbus);
>  close:
>  	vmbus_close(hdev->channel);
> +destroy_wq:
> +	drain_workqueue(hbus->wq);

The drain_workqueue() call isn't necessary.  destroy_workqueue() calls
drain_workqueue() and there better not be anything in the workqueue
anyway since all the ref counts are zero.

> +	destroy_workqueue(hbus->wq);
>  free_bus:
>  	free_page((unsigned long)hbus);
>  	return ret;
> @@ -2615,6 +2626,8 @@ static int hv_pci_remove(struct hv_device *hdev)
>  	irq_domain_free_fwnode(hbus->sysdata.fwnode);
>  	put_hvpcibus(hbus);
>  	wait_for_completion(&hbus->remove_event);
> +	drain_workqueue(hbus->wq);

Same here -- drain_workqueue() isn't needed.  The workqueue
must be empty anyway since the remove_event has completed
and the ref counts will all be zero.

> +	destroy_workqueue(hbus->wq);
>  	free_page((unsigned long)hbus);
>  	return 0;
>  }
> --
> 2.7.4
