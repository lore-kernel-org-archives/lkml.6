Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755769AbeEaQky (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 12:40:54 -0400
Received: from mail-co1nam03on0112.outbound.protection.outlook.com ([104.47.40.112]:35900
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755677AbeEaQkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 12:40:51 -0400
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: Dexuan Cui <decui@microsoft.com>,
        "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'driverdev-devel@linuxdriverproject.org'"
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "'vkuznets@redhat.com'" <vkuznets@redhat.com>,
        "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>
Subject: RE: [PATCH] PCI: hv: Do not wait forever on a device that has
 disappeared
Thread-Topic: [PATCH] PCI: hv: Do not wait forever on a device that has
 disappeared
Thread-Index: AdPy2mt/5cq5najeS4qpn1DMFXGqNwEAQofQACceUGAAYA3z0A==
Date: Thu, 31 May 2018 16:40:48 +0000
Message-ID: <SN6PR2101MB1120FF4297B3C7ED5E3AE032DC630@SN6PR2101MB1120.namprd21.prod.outlook.com>
References: <KL1P15301MB0006DF4209AEE3809ABD303FBF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <SN6PR2101MB112020C6F949F7C72F52D6BEDC6D0@SN6PR2101MB1120.namprd21.prod.outlook.com>
 <KL1P15301MB0006B36AD458D43907DF82B0BF6D0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <KL1P15301MB0006B36AD458D43907DF82B0BF6D0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-05-23T21:11:58.7383302Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR2101MB1119;7:MSjieb7xESczReGeHIe51Df5af98Pa6baMT7JngjpuJuMPDqpSTJO36UirEa0Z0KhW3RvO85WA6mrtubnXoZi/638WgDg+9EYRzV4rKLwHXWpVVPSSjgXV07HsLniiCgvWipm5w6apsoKVlTEmyQfBUa9gF+MKJg2QmhAo6Bck0ElFaDytCJdQK0IcmO7v9BRfsoa67cxoZN7MJto4pyEMXo3W6zqql5c0rXjtQfOgqYOhszKjQ4WF6/VIMXB02k;20:lDFRg5bVltZk8/nRpaT4B7s4I+pT4DOuMfNu9LoRjLslbMi1P+JGx1Shgfga/A583wWOqsePMotkW2AypfPN/Bx21sdH0t2FOED8Zg3tyPk3dPgCdZEN6GgiCOhrFEsP3EwVkC1VOncAhnzxVIcrcwRNwf39jcCkn88CJc0jdoo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7193020);SRVR:SN6PR2101MB1119;
x-ms-traffictypediagnostic: SN6PR2101MB1119:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-prvs: <SN6PR2101MB111938CBAD5A8A3679AC5951DC630@SN6PR2101MB1119.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(2018427008)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN6PR2101MB1119;BCL:0;PCL:0;RULEID:;SRVR:SN6PR2101MB1119;
x-forefront-prvs: 06891E23FB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39380400002)(366004)(376002)(39860400002)(189003)(199004)(229853002)(6436002)(9686003)(2900100001)(486006)(14454004)(6246003)(5250100002)(55016002)(4326008)(53936002)(25786009)(86612001)(6116002)(22452003)(3846002)(1511001)(66066001)(86362001)(10290500003)(72206003)(54906003)(316002)(110136005)(105586002)(106356001)(68736007)(476003)(99286004)(26005)(305945005)(74316002)(7416002)(53546011)(76176011)(97736004)(7696005)(11346002)(446003)(6506007)(59450400001)(3280700002)(478600001)(7736002)(3660700001)(33656002)(8990500004)(10090500001)(102836004)(5660300001)(81156014)(81166006)(8936002)(2906002)(8676002)(491001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1119;H:SN6PR2101MB1120.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: W9fJIdKZZ9WlHMmzHbJDMhkULuVDGCejtRjbL4bW2OD2ziKIo2epfvaAhPIUB+39z8LfXMcj5Z7QQfCVdCn5gCWEaM+fOtk/VHeKVgjY+56b4Dgy3aQtCxy4QS5E71V+q2YpODdl4uQRJ0BO6YesIeSkAISOh3Sr0OtfVKI3iNGe3flyGFMALyhO7W3304cq
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: b25e0be2-cc3d-4580-59e2-08d5c7154393
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b25e0be2-cc3d-4580-59e2-08d5c7154393
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2018 16:40:48.2162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1119
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4VGfB8s023964

> From: Dexuan Cui
> Sent: Tuesday, May 29, 2018 12:58 PM
> Subject: RE: [PATCH] PCI: hv: Do not wait forever on a device that has disappeared
> 
> > From: Michael Kelley (EOSG)
> > Sent: Monday, May 28, 2018 17:19
> >
> > While this patch solves the immediate problem of getting hung waiting
> > for a response from Hyper-V that will never come, there's another scenario
> > to look at that I think introduces a race.  Suppose the guest VM issues a
> > vmbus_sendpacket() request in one of the cases covered by this patch,
> > and suppose that Hyper-V queues a response to the request, and then
> > immediately follows with a rescind request.   Processing the response will
> > get queued to a tasklet associated with the channel, while processing the
> > rescind will get queued to a tasklet associated with the top-level vmbus
> > connection.   From what I can see, the code doesn't impose any ordering
> > on processing the two.  If the rescind is processed first, the new
> > wait_for_response() function may wake up, notice the rescind flag, and
> > return an error.  Its caller will return an error, and in doing so pop the
> > completion packet off the stack.   When the response is processed later,
> > it will try to signal completion via a completion packet that no longer
> > exists, and memory corruption will likely occur.
> >
> > Am I missing anything that would prevent this scenario from happening?
> > It is admittedly low probability, and a solution seems non-trivial.  I haven't
> > looked specifically, but a similar scenario is probably possible with the
> > drivers for other VMbus devices.  We should work on a generic solution.
> >
> > Michael
> 
> Thanks for spotting the race!
> 
> IMO we can disable the per-channel tasklet to exclude the race:
> 
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -565,6 +565,7 @@ static int wait_for_response(struct hv_device *hdev,
>  {
>         while (true) {
>                 if (hdev->channel->rescind) {
> +                       tasklet_disable(&hdev->channel->callback_event);
>                         dev_warn_once(&hdev->device, "The device is gone.\n");
>                         return -ENODEV;
>                 }
> 
> This way, when we exit the loop, we're sure hv_pci_onchannelcallback() can not
> run anymore. What do you think of this?

I've stared at this and the tasklet code over a couple of days now.  Adding the
call to tasklet_disable() solves the immediate problem of preventing 
hv_pci_onchannelcallback() from calling complete() against a completion packet
that has been popped off the stack.  But in doing so, it simply pushes the core
problem further down the road and leaves it unresolved.

tasklet_disable() does not prevent the tasklet from being scheduled.  So if there
is a response from Hyper-V to the original message, the tasklet still gets
scheduled.  Because it is disabled, it will sit in the tasklet queue and be skipped
over each time the queue is processed.  Later,  when the channel is eventually
deleted in free_channel(), tasklet_kill() is called.  Unfortunately, tasklet_kill()
will get stuck in an infinite loop, waiting for the tasklet to run.   There aren't
any tasklet interfaces to dequeue an already scheduled tasklet.

Please double-check my reasoning.  To solve this problem, I think the VMbus
driver code will need some additional synchronization between rescind
notifications and a response, which may or may not have been sent, and
which could be processed after the rescind.  I haven't yet thought about
what this synchronization might need to look like.

Michael

> 
> 
> It looks the list of the other vmbus devices that can be hot-removed is:
> 
> the hv_utils devices
> hv_sock devices
> storvsc device
> netvsc device
> 
> As I checked, the first 3 types of devices don't have this "send a request to the
> host and wait for the response forever" pattern. NetVSC should be fixed as it has
> the same pattern.
> 
> -- Dexuan
