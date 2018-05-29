Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935141AbeE2ATV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 20:19:21 -0400
Received: from mail-bl2nam02on0134.outbound.protection.outlook.com ([104.47.38.134]:57208
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932727AbeE2ATT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 20:19:19 -0400
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
Thread-Index: AdPy2mt/5cq5najeS4qpn1DMFXGqNwEAQofQ
Date: Tue, 29 May 2018 00:19:16 +0000
Message-ID: <SN6PR2101MB112020C6F949F7C72F52D6BEDC6D0@SN6PR2101MB1120.namprd21.prod.outlook.com>
References: <KL1P15301MB0006DF4209AEE3809ABD303FBF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <KL1P15301MB0006DF4209AEE3809ABD303FBF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
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
x-microsoft-exchange-diagnostics: 1;SN6PR2101MB1007;7:YT4fGATgf/NP5gsJ2opv47ZqO93ybzOtyKO0UDy6WqOgC4lun3GzOhf4mzxpyA2HQyXcu5fzI6lbNhiT7BH+9iDHnp+1ryKdiUZTDwUYNNuzx1az/pr02XQ8fCBOZUBkt5woFLmfmwAfRsvD6Ymm+TWyZSdu4bhzvMl7WNxXu1pbK1sU/0d++JuT0CMA7NJwhTsX5lm1XEtwBZsGd27m/QXNvsqT3J7ZaFSuxTmKA4YjmU8nx4SiNyo2Rzq4j5jy;20:iYMcb7wQYiLy0TYKsqeHwgH1pNey1a5W7a0kPLKrWAf/caDfYRHGQTmUuZRs8HljsBeP5fwk5KNPxXNNKxpOO6ts4rfSL0ouo7DSodmWyqXvP0IN+DjWJxwVnJj9sTdmXfOYzABSe0SkPVzp4slUBIZDU0gB+8ojM4XMqhLR4fU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7193020);SRVR:SN6PR2101MB1007;
x-ms-traffictypediagnostic: SN6PR2101MB1007:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-prvs: <SN6PR2101MB10079045DFC6EEC1143D4D01DC6D0@SN6PR2101MB1007.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(244540007438412)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:SN6PR2101MB1007;BCL:0;PCL:0;RULEID:;SRVR:SN6PR2101MB1007;
x-forefront-prvs: 0687389FB0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(346002)(396003)(39380400002)(189003)(199004)(86362001)(7736002)(97736004)(305945005)(25786009)(54906003)(316002)(22452003)(110136005)(3280700002)(8936002)(486006)(1511001)(3660700001)(72206003)(9686003)(5660300001)(102836004)(2900100001)(26005)(14454004)(6436002)(2906002)(55016002)(106356001)(7416002)(105586002)(8990500004)(6506007)(446003)(6246003)(478600001)(229853002)(86612001)(53936002)(5250100002)(3846002)(11346002)(10090500001)(76176011)(10290500003)(6116002)(7696005)(59450400001)(74316002)(4326008)(81156014)(476003)(99286004)(66066001)(8676002)(81166006)(68736007)(33656002)(491001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1007;H:SN6PR2101MB1120.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 6jaDa3teLLO6yFYKFPorqXHwXTymrlAZSziZdgmitqtA7+aebZyB0D46Zlj0Zg1t3HkK+upYGBGqWETrts51KMJaAZqqfU4ZqtF/vFVwXuY+jpz1j93xxfrqCeWZjxkQM2KdCyA4shFqPmLWBFd8RUrDpxooHpZ53cVX5oOGrP6gC3QXb6QuUNuKcpoHdpPd
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 0a947828-e300-421b-795b-08d5c4f9d088
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a947828-e300-421b-795b-08d5c4f9d088
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2018 00:19:16.6205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1007
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4T0JfCB008661

> 
> Before the guest finishes the device initialization, the device can be
> removed anytime by the host, and after that the host won't respond to
> the guest's request, so the guest should be prepared to handle this
> case.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> ---
>  drivers/pci/host/pci-hyperv.c | 46 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 34 insertions(+), 12 deletions(-)
> 

While this patch solves the immediate problem of getting hung waiting
for a response from Hyper-V that will never come, there's another scenario
to look at that I think introduces a race.  Suppose the guest VM issues a
vmbus_sendpacket() request in one of the cases covered by this patch,
and suppose that Hyper-V queues a response to the request, and then
immediately follows with a rescind request.   Processing the response will
get queued to a tasklet associated with the channel, while processing the
rescind will get queued to a tasklet associated with the top-level vmbus
connection.   From what I can see, the code doesn't impose any ordering
on processing the two.  If the rescind is processed first, the new
wait_for_response() function may wake up, notice the rescind flag, and
return an error.  Its caller will return an error, and in doing so pop the
completion packet off the stack.   When the response is processed later,
it will try to signal completion via a completion packet that no longer
exists, and memory corruption will likely occur.

Am I missing anything that would prevent this scenario from happening?
It is admittedly low probability, and a solution seems non-trivial.  I haven't
looked specifically, but a similar scenario is probably possible with the
drivers for other VMbus devices.  We should work on a generic solution.

Michael
