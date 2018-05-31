Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750777AbeEaVBw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 17:01:52 -0400
Received: from mail-sg2apc01on0091.outbound.protection.outlook.com ([104.47.125.91]:55520
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750711AbeEaVBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 17:01:49 -0400
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
Thread-Index: AdPy2mt/5cq5najeS4qpn1DMFXGqNwEAQofQACceUGAAYA3z0AACpCMg
Date: Thu, 31 May 2018 21:01:34 +0000
Message-ID: <KL1P15301MB0006F8A3E876E7BEB5973B94BF630@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <KL1P15301MB0006DF4209AEE3809ABD303FBF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <SN6PR2101MB112020C6F949F7C72F52D6BEDC6D0@SN6PR2101MB1120.namprd21.prod.outlook.com>
 <KL1P15301MB0006B36AD458D43907DF82B0BF6D0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <SN6PR2101MB1120FF4297B3C7ED5E3AE032DC630@SN6PR2101MB1120.namprd21.prod.outlook.com>
In-Reply-To: <SN6PR2101MB1120FF4297B3C7ED5E3AE032DC630@SN6PR2101MB1120.namprd21.prod.outlook.com>
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
x-originating-ip: [2001:4898:80e8:9:ade3:b67c:bf27:1ca9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KL1P15301MB0056;7:XiAbMa4jdGDbM/MZG7vf6+lI+EM4RqX96KJWFrLYzm+D73Xhkq3gSBMbMk86UVl8/ZNuZC9i2k0Ue+efnSjG8CJ7I3L/sZeHQhLCn3M1pZIGIbUBDcdAvkmdbVhm0F42+6PiaPiLY5wh1J+iL8js/Wg3y1dSym5hMRJa240gqhkTvBO3T6wkNQtY5g+7/NMSH62b31HBjlcvgO4SZcY/MWwKY/nvzG8mhc5TEa0jlGqXkhAeXLdgbbWtnI+RiSoM;20:xV2F2iFoRa1f/hXQ888K14PHr+b9tm3f7hQuVbQGEPIX0NNuQXeW51Ap6HskC0Yx3N5zgdTWqjb0fmr8xogJjNZB6gyqw6ci35S2rTm9qkw79L/MLFtmFBB7W5eft5yB+wUL1YusreCSpCTpDU/vY8fnPWEnkXIIUjiZkrQ6440=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7193020);SRVR:KL1P15301MB0056;
x-ms-traffictypediagnostic: KL1P15301MB0056:
x-microsoft-antispam-prvs: <KL1P15301MB00560B660CCD14075E94CF92BF630@KL1P15301MB0056.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:KL1P15301MB0056;BCL:0;PCL:0;RULEID:;SRVR:KL1P15301MB0056;
x-forefront-prvs: 06891E23FB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(366004)(39860400002)(39380400002)(199004)(189003)(6506007)(59450400001)(6116002)(3660700001)(77096007)(102836004)(8936002)(7416002)(99286004)(2900100001)(68736007)(5660300001)(3280700002)(25786009)(7736002)(486006)(86362001)(2906002)(476003)(86612001)(6246003)(74316002)(305945005)(11346002)(446003)(81156014)(478600001)(46003)(10290500003)(33656002)(6436002)(9686003)(105586002)(110136005)(4326008)(229853002)(54906003)(97736004)(10090500001)(7696005)(53936002)(93886005)(8990500004)(8676002)(1511001)(81166006)(76176011)(14454004)(55016002)(316002)(22452003)(106356001)(491001);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0056;H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: jiNZlu7kVBgNyjpAhP1K+a8yWWlVeFtYYY5VFx0XUoTCdfeCOp3SW/KeHa6tj3H5uss0Vg4EX5X5ckF4SkSrC9REMuPOtNP0L1j2AJGN4qwkfDgR+d1AxoSKHp0Yj6uzkuDEDhAQMW1Y0VwHUOpujG95ii2B3723zTf/0dwZy9eJrtCrwArhkZpKM6yiktZ/
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 996f49b4-b671-4746-7436-08d5c739b175
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 996f49b4-b671-4746-7436-08d5c739b175
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2018 21:01:34.2177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0056
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4VL1xl9009883

> From: Michael Kelley (EOSG)
> Sent: Thursday, May 31, 2018 09:41
> >
> > IMO we can disable the per-channel tasklet to exclude the race:
> > This way, when we exit the loop, we're sure hv_pci_onchannelcallback() can
> > not run anymore. What do you think of this?
> 
> I've stared at this and the tasklet code over a couple of days now.  Adding the
> call to tasklet_disable() solves the immediate problem of preventing
> hv_pci_onchannelcallback() from calling complete() against a completion
> packet
> that has been popped off the stack.  But in doing so, it simply pushes the core
> problem further down the road and leaves it unresolved.
> 
> tasklet_disable() does not prevent the tasklet from being scheduled.  So if
> there
> is a response from Hyper-V to the original message, the tasklet still gets
> scheduled.  Because it is disabled, it will sit in the tasklet queue and be
> skipped
> over each time the queue is processed.  Later,  when the channel is
> eventually
> deleted in free_channel(), tasklet_kill() is called.  Unfortunately, tasklet_kill()
> will get stuck in an infinite loop, waiting for the tasklet to run.   There aren't
> any tasklet interfaces to dequeue an already scheduled tasklet.

I think you're correct.
 
> Please double-check my reasoning.  To solve this problem, I think the VMbus
> driver code will need some additional synchronization between rescind
> notifications and a response, which may or may not have been sent, and
> which could be processed after the rescind.  I haven't yet thought about
> what this synchronization might need to look like.
> 
> Michael

Yes, it looks the VMBus driver needs to provide an API to cope with this.
I'll try to further investigate the issue.

-- Dexuan
