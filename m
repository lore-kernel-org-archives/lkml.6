Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-568472-1520226721-2-4957031823332237922
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
    t=1520226720; b=ryhRcITveXvk31YLfOykLTkTSLlQgPQusDmpIkK08zNt29x
    Zby77DhUoyVgcTszenYLz5tWCsqLG/Shu+3c0dpr05C9zZ+bfKP2N91L7VCiZamP
    Y3wCkeAsjhsf09kL7HAKsNyt//x2a4FPPxOMBbKoJ2KBHmqK5SjVkFnUXYOTMrDx
    9EedLcxfVP7TK/W99nqpcdXZIi/nV2O2aQnmhm3pVADVckwdDonf9izisonjpYxk
    KKS0ZQwdoQKsI+fv4muo9gkpwQv42RCXJo0aWtLZivgsjCw8sE9Z1pN5fTrqyMq0
    UT5sEUEexuBbaHMclvG9+zxiGnDlDGt5JPtDC4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520226720; bh=3mqrcV
    ScJ+qpQidv5BGYQdVqpXVWSHv2kLDojoCpRGU=; b=ReEz5lDzkaP9ZLl+EBgivo
    CO3jX6yMOXTLKDKIo2IGtJ2Ao43ACIhXneya9bmF6KtHggrgPXSnMFemphh6Kx3H
    imiKLrGfg6hl/WuOT3gtkJcPJRu4Cw27IdJfhUtsz0vlAuPlxjMbGsDTfPKnL8T8
    cehSVvw+FGijh5Ywra4/ZywiIlYyOZjAnnqi0E7rUkfkma9++3BSElf6GHtUK98X
    XMJNYsFVMO4bCHZ63ehvZP8WouE0+v4EvjQzG64E99QGoTCZX7kyfMnGXATVTK9E
    w4ZnLC+1U8gUfQj+2RL2fW16Gz+2ll5bhxe7DfPkHmd7qsYXGwYtgd3hqTWWCh2w
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MjTDpPWV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MjTDpPWV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932563AbeCEFLz (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 00:11:55 -0500
Received: from mail-pu1apc01on0122.outbound.protection.outlook.com ([104.47.126.122]:13753
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751144AbeCEFLv (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 5 Mar 2018 00:11:51 -0500
From: Dexuan Cui <decui@microsoft.com>
To: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
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
        Jack Morgenstein <jackm@mellanox.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 2/3] PCI: hv: serialize the present/eject work items
Thread-Topic: [PATCH 2/3] PCI: hv: serialize the present/eject work items
Thread-Index: AQHTsoV58ygEHWMoYEeyKVqO+bn/hqO+rw0AgAIpgWA=
Date: Mon, 5 Mar 2018 05:11:35 +0000
Message-ID: <KL1P15301MB0006F7C015D8D113FC2ACD1DBFDA0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <20180303001947.20564-1-decui@microsoft.com>
 <20180303001947.20564-2-decui@microsoft.com>
 <DM5PR2101MB1030BC8E7A263D65A1A64B26DCC40@DM5PR2101MB1030.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR2101MB1030BC8E7A263D65A1A64B26DCC40@DM5PR2101MB1030.namprd21.prod.outlook.com>
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
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [73.225.236.69]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KL1P15301MB0022;7:4Y79d+TkLeEbyMAsqtm1ZHuvr/I9tx0Q+PeQXe+1vG88k5QUC8/AzNJuhkpw4Ueqb+0yvuvJ/4fPgmxgLaZy1DlQYH67W2OAT8uknk3Lfs2as8h517gWBKfltpPlVvFPHSqGhENXWEtbUYlOmMlJKqdFWAVXBzuv+rqSmKs2V/14OWu2L60jPCb91qwzpw4FMWT8BrNm+z8KOEW59vrZnUObS7HcvY9WAlH1aghJLUjromdMSKwk4TTBap4LZDiX
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d89c48e0-563b-4a83-43fd-08d582579184
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:KL1P15301MB0022;
x-ms-traffictypediagnostic: KL1P15301MB0022:
x-microsoft-antispam-prvs: <KL1P15301MB0022C9383DC7BD0A13D24F7CBFDA0@KL1P15301MB0022.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:KL1P15301MB0022;BCL:0;PCL:0;RULEID:;SRVR:KL1P15301MB0022;
x-forefront-prvs: 06022AA85F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(39380400002)(346002)(39860400002)(189003)(199004)(110136005)(81156014)(6636002)(2900100001)(7696005)(76176011)(5660300001)(53936002)(105586002)(10090500001)(9686003)(6246003)(68736007)(8936002)(25786009)(81166006)(54906003)(8676002)(4326008)(316002)(97736004)(2950100002)(55016002)(99286004)(229853002)(33656002)(3660700001)(22452003)(478600001)(2501003)(86362001)(106356001)(305945005)(6506007)(7416002)(8990500004)(3280700002)(66066001)(102836004)(1511001)(74316002)(26005)(77096007)(2201001)(14454004)(6116002)(2906002)(59450400001)(86612001)(10290500003)(3846002)(6436002)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0022;H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: VaXCzZxN3fp/hKs95AeFqc5jreNri1p+HI2V3sstwkeR4/faAAxUt3QV+6n9gOwey1gw8KFDYauoZd5KCuo4umfuBWR9JOsGYjvm90Xe0YykQMRj3LA+IpdSyKNYwwo/LhC9cWGsqcL1RIDavh3wTeuGJHngs9L8V3l/+wUyBJbC8Dr6twEcavkwTG9GXvNN/oIpMdFVDDbbBQQbla3YteSoIH7PY3aypK9Dj2rcWiWoO5bBg8iI69PXSHMUZy7029GqqUBdBfxjb0wjedQmv6CqaNd9iLeshWhZcH7dcApenCeSfsxoFMu1SWYzXbFZqmPR7XfoOvBYSiJrb3KlrA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d89c48e0-563b-4a83-43fd-08d582579184
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2018 05:11:35.3089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0022
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> From: Michael Kelley (EOSG)
> Sent: Saturday, March 3, 2018 08:10
> > From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> owner@vger.kernel.org> On Behalf Of Dexuan Cui
> > Sent: Friday, March 2, 2018 4:21 PM
> > When we hot-remove the device, we first receive a PCI_EJECT message and
> > then receive a PCI_BUS_RELATIONS message with bus_rel->device_count =3D=
=3D
> 0.
> >
> > The first message is offloaded to hv_eject_device_work(), and the secon=
d
> > is offloaded to pci_devices_present_work(). Both the paths can be runni=
ng
> > list_del(&hpdev->list_entry), causing general protection fault, because
> > system_wq can run them concurrently.
> >
> > The patch eliminates the race condition.
>=20
> With this patch, the enum_sem field in struct hv_pcibus_device
> is no longer needed.  The semaphore serializes execution in
> hv_pci_devices_present_work(), and that serialization is now done
> with the ordered workqueue.  Also, the last paragraph of the top level
> comment for hv_pci_devices_present_work() should be updated to
> reflect the new ordering assumptions.

Thanks! I'll make an extra patch for this.

> Separately, an unrelated bug:  At the top of hv_eject_device_work(),
> the first test may do a put_pcichild() and return.  This exit path also
> needs to do put_hvpcibus() to balance the ref counts, or do a goto
> the last two lines at the bottom of the function.

When we're in hv_eject_device_work(), IMO hpdev->state must be=20
hv_pcichild_ejecting, so I'm going to make a patch like this:

@@ -1867,10 +1867,7 @@ static void hv_eject_device_work(struct work_struct =
*work)

        hpdev =3D container_of(work, struct hv_pci_dev, wrk);

-       if (hpdev->state !=3D hv_pcichild_ejecting) {
-               put_pcichild(hpdev, hv_pcidev_ref_pnp);
-               return;
-       }
+       WARN_ON(hpdev->state !=3D hv_pcichild_ejecting);

        /*
         * Ejection can come before or after the PCI bus has been set up, s=
o
=20
> > @@ -1770,7 +1772,7 @@ static void hv_pci_devices_present(struct
> hv_pcibus_device *hbus,
> >  	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
> >
> >  	get_hvpcibus(hbus);
> > -	schedule_work(&dr_wrk->wrk);
> > +	queue_work(hbus->wq, &dr_wrk->wrk);
>=20
> This invocation of get_hvpcibus() and queue_work() could be made
> conditional on whether the preceding list_add_tail() transitioned
> the list from empty to non-empty.  If the list was already non-empty,
> a previously queued invocation of hv_pci_devices_present_work()
> will find the new entry and process it.   But this is an
> optimization in a non-perf sensitive code path, so may not be
> worth it.

Exactly. I'll add the the optimization.

> > @@ -1848,7 +1850,7 @@ static void hv_pci_eject_device(struct hv_pci_dev
> *hpdev)
> >  	get_pcichild(hpdev, hv_pcidev_ref_pnp);
> >  	INIT_WORK(&hpdev->wrk, hv_eject_device_work);
> >  	get_hvpcibus(hpdev->hbus);
> > -	schedule_work(&hpdev->wrk);
> > +	queue_work(hpdev->hbus->wq, &hpdev->wrk);
> >  }
> >
> >  /**
> > @@ -2463,11 +2465,17 @@ static int hv_pci_probe(struct hv_device *hdev,
> >  	spin_lock_init(&hbus->retarget_msi_interrupt_lock);
> >  	sema_init(&hbus->enum_sem, 1);
> >  	init_completion(&hbus->remove_event);
> > +	hbus->wq =3D alloc_ordered_workqueue("hv_pci_%x", 0,
> > +					   hbus->sysdata.domain);
> > +	if (!hbus->wq) {
> > +		ret =3D -ENOMEM;
> > +		goto free_bus;
> > +	}
> >
> >  	ret =3D vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL,=
 0,
> >  			 hv_pci_onchannelcallback, hbus);
> >  	if (ret)
> > -		goto free_bus;
> > +		goto destroy_wq;
> >
> >  	hv_set_drvdata(hdev, hbus);
> >
> > @@ -2536,6 +2544,9 @@ static int hv_pci_probe(struct hv_device *hdev,
> >  	hv_free_config_window(hbus);
> >  close:
> >  	vmbus_close(hdev->channel);
> > +destroy_wq:
> > +	drain_workqueue(hbus->wq);
>=20
> The drain_workqueue() call isn't necessary.  destroy_workqueue() calls
> drain_workqueue() and there better not be anything in the workqueue
> anyway since all the ref counts are zero.

OK. Will remove it.

> > +	destroy_workqueue(hbus->wq);
> >  free_bus:
> >  	free_page((unsigned long)hbus);
> >  	return ret;
> > @@ -2615,6 +2626,8 @@ static int hv_pci_remove(struct hv_device *hdev)
> >  	irq_domain_free_fwnode(hbus->sysdata.fwnode);
> >  	put_hvpcibus(hbus);
> >  	wait_for_completion(&hbus->remove_event);
> > +	drain_workqueue(hbus->wq);
>=20
> Same here -- drain_workqueue() isn't needed.  The workqueue
> must be empty anyway since the remove_event has completed
> and the ref counts will all be zero.

Will remove it.

> > +	destroy_workqueue(hbus->wq);

I'm going to post a v2 patchset tomorrow.

Thanks,
-- Dexuan
