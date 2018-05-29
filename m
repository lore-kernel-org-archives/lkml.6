Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966609AbeE2T63 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 15:58:29 -0400
Received: from mail-sg2apc01on0110.outbound.protection.outlook.com ([104.47.125.110]:12992
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966485AbeE2T60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 15:58:26 -0400
From: Dexuan Cui <decui@microsoft.com>
To: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
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
Thread-Index: AdPy2mt/5cq5najeS4qpn1DMFXGqNwEAQofQACceUGA=
Date: Tue, 29 May 2018 19:58:09 +0000
Message-ID: <KL1P15301MB0006B36AD458D43907DF82B0BF6D0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <KL1P15301MB0006DF4209AEE3809ABD303FBF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <SN6PR2101MB112020C6F949F7C72F52D6BEDC6D0@SN6PR2101MB1120.namprd21.prod.outlook.com>
In-Reply-To: <SN6PR2101MB112020C6F949F7C72F52D6BEDC6D0@SN6PR2101MB1120.namprd21.prod.outlook.com>
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
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [2001:4898:80e8:8:18b6:9e1a:2c45:fdd5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KL1P15301MB0007;7:Fqvt5qntnWdDrO6dQn3UnpTyQPsX6XdVYVPVrqpB89vd2vB2NrAHr/iXc7130u0wafXpmf4i2O5jo4wTIl+u4ma7TPz3VHn6f6RdJelZjoArV0TuCHPGrzxV3sAr01oicOK5uKZUJRVfYPOFDBkCZ7U4R+jB/RPN0NMj/Ybxt7vpjNDpXXnNmKcrVNMpz5UeGQ6vs/0xnWcJJi3XJ7VzHNGrwmwN4TDnOig1P36K8N+ziJIhJeKdnMaEJKaoXvck;20:rhU0kqv26QhwLafC9YcIj2GwUONpGJPUFdfDRL+umtfgj85btt73g4VikkK8x9CLt7mm9aFBsNYKpiCmLLFZFDuRSXgFBXBJyMJnqh4OfXiIOobUORRhEvv+dZyh+Ag8DeWZSEd2P3xlQOrI9vYu/UOcl3/WtAvWsZeCAvY9vuE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7193020);SRVR:KL1P15301MB0007;
x-ms-traffictypediagnostic: KL1P15301MB0007:
x-microsoft-antispam-prvs: <KL1P15301MB0007FD40B809B34FB16461AFBF6D0@KL1P15301MB0007.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:KL1P15301MB0007;BCL:0;PCL:0;RULEID:;SRVR:KL1P15301MB0007;
x-forefront-prvs: 0687389FB0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(39860400002)(396003)(376002)(189003)(199004)(8936002)(74316002)(11346002)(22452003)(76176011)(316002)(55016002)(86612001)(59450400001)(1511001)(33656002)(81156014)(81166006)(110136005)(54906003)(486006)(7696005)(46003)(229853002)(6116002)(4326008)(7416002)(9686003)(305945005)(86362001)(476003)(446003)(6436002)(53936002)(5660300001)(6246003)(7736002)(14454004)(3660700001)(3280700002)(77096007)(2900100001)(8990500004)(97736004)(68736007)(102836004)(10090500001)(10290500003)(2906002)(99286004)(6506007)(25786009)(105586002)(106356001)(8676002)(478600001)(491001);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0007;H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 2wSzT8i5EwE63CFf85Gp7To7P9/FPauO2tZFHRi6Q78rwQJQkTEOtArawGnmvLrJEglmEmPonyPLVdqAmwdjMcmRU17pNA3fL0ofyvWYrwektuzWN7HVTInFqMVbus9tJ0N+ip0P35joL7IwEiQ9yptxY8UY0einZI6i5hnJxsyFmQvVr6mJuKRjGS8IH5Jw
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: ccfe1008-0197-4fc1-f545-08d5c59e809d
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccfe1008-0197-4fc1-f545-08d5c59e809d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2018 19:58:09.1209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0007
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4TJx8D3020160

> From: Michael Kelley (EOSG)
> Sent: Monday, May 28, 2018 17:19
> 
> While this patch solves the immediate problem of getting hung waiting
> for a response from Hyper-V that will never come, there's another scenario
> to look at that I think introduces a race.  Suppose the guest VM issues a
> vmbus_sendpacket() request in one of the cases covered by this patch,
> and suppose that Hyper-V queues a response to the request, and then
> immediately follows with a rescind request.   Processing the response will
> get queued to a tasklet associated with the channel, while processing the
> rescind will get queued to a tasklet associated with the top-level vmbus
> connection.   From what I can see, the code doesn't impose any ordering
> on processing the two.  If the rescind is processed first, the new
> wait_for_response() function may wake up, notice the rescind flag, and
> return an error.  Its caller will return an error, and in doing so pop the
> completion packet off the stack.   When the response is processed later,
> it will try to signal completion via a completion packet that no longer
> exists, and memory corruption will likely occur.
> 
> Am I missing anything that would prevent this scenario from happening?
> It is admittedly low probability, and a solution seems non-trivial.  I haven't
> looked specifically, but a similar scenario is probably possible with the
> drivers for other VMbus devices.  We should work on a generic solution.
> 
> Michael

Thanks for spotting the race! 

IMO we can disable the per-channel tasklet to exclude the race:

--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -565,6 +565,7 @@ static int wait_for_response(struct hv_device *hdev,
 {
        while (true) {
                if (hdev->channel->rescind) {
+                       tasklet_disable(&hdev->channel->callback_event);
                        dev_warn_once(&hdev->device, "The device is gone.\n");
                        return -ENODEV;
                }

This way, when we exit the loop, we're sure hv_pci_onchannelcallback() can not 
run anymore. What do you think of this?


It looks the list of the other vmbus devices that can be hot-removed is:

the hv_utils devices
hv_sock devices
storvsc device
netvsc device

As I checked, the first 3 types of devices don't have this "send a request to the
host and wait for the response forever" pattern. NetVSC should be fixed as it has
the same pattern.

-- Dexuan
