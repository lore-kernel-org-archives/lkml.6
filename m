Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753696AbeDSWLd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 18:11:33 -0400
Received: from mail-cys01nam02on0064.outbound.protection.outlook.com ([104.47.37.64]:19630
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753657AbeDSWLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 18:11:30 -0400
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
CC: Sinan Kaya <okaya@codeaurora.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "sulrich@codeaurora.org" <sulrich@codeaurora.org>,
        "timur@codeaurora.org" <timur@codeaurora.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] IB/hfi1: Try slot reset before secondary bus reset
Thread-Topic: [PATCH 1/2] IB/hfi1: Try slot reset before secondary bus reset
Thread-Index: AQHT2CgIK7x1hOYyNUildm+N/6H94aQIpOWg
Date: Thu, 19 Apr 2018 22:11:27 +0000
Message-ID: <BN6PR12MB1809BD30AA5B890C054F9832F7B50@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1524167784-5911-1-git-send-email-okaya@codeaurora.org>
 <20180419202632.GE14063@ziepe.ca>
 <20180419214722.GO28657@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180419214722.GO28657@bhelgaas-glaptop.roam.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
x-originating-ip: [76.1.164.143]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1585;7:rX7JZ8uCbLptbWayeWGeikNGVaAm1HUrbat/o7xKYkrzH9pxHcE5PAO+KCERpu9Vdju9CKK6QU3u+UXT81KHuLLubi9L673bb+YzFCaKVUCzcnMaAPShv8dj43W3D3EDaRFQEGUzRdI5WX9o0udBjm5zsHQ+3GnmhPgVNfpZ5EIhYYIBZf4OFnCvbLhfWlCMYCqv2vqFWw+4fXKYRhzgYCQVrBGDJSVydrsHayvGEhzDQf2aix93oE7MeMh078Ny;20:QLxbyq3giIK9/flehuCf9gynzvgh1125n2ti3HwaIy6NgN2pBCaxatTShQvxHc8wL2MqLYzGzY4Qfnhd3odapwJDn7QA2QTF/BAFxYYKXEjUmo75k0O/iEvUw4ua0n5NlnVWvF3jkGInNTgEYZPBTbMButpqYOXTg5VaPT17NNbbJ1GlC2Ufp5hZD3JWygUDaNCuWkLGtb4MnUUQ5WKoBMXPz9HoJob81GLyEUUbTzQKeJfyMhyvrNKVwh7dYy4V
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1585;
x-ms-traffictypediagnostic: BN6PR12MB1585:
x-microsoft-antispam-prvs: <BN6PR12MB15850314312C9FFEC5B9099DF7B50@BN6PR12MB1585.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(258649278758335)(211936372134217)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231232)(944501327)(52105095)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR12MB1585;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1585;
x-forefront-prvs: 0647963F84
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39380400002)(39860400002)(376002)(366004)(13464003)(3846002)(110136005)(102836004)(478600001)(76176011)(26005)(11346002)(305945005)(7416002)(316002)(72206003)(2906002)(7736002)(2900100001)(86362001)(53936002)(59450400001)(7696005)(5250100002)(9686003)(25786009)(6506007)(3660700001)(6246003)(33656002)(66066001)(3280700002)(4326008)(6436002)(6116002)(186003)(446003)(229853002)(74316002)(5660300001)(8676002)(53546011)(55016002)(54906003)(81166006)(8936002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1585;H:BN6PR12MB1809.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam-message-info: FLsO8PeX2BSI0nYfcRojho6cD1ObCMoXTrjzjD5DnP261ZuHZ1CGze1SKbtHK3FTzHto1K97GYN6BsNm5mpqduJlVwuAvM3OaqdRvUWZBKVGkIi/07nghsAW9awq2KBo2mF9B53wuodaCQGrvhRF6QUa2CwNdHIh5uurrwrLVmF7hO+xiGCAGDF+LT+azN4r
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: a0a62472-34ed-47d7-1729-08d5a6427f9e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a62472-34ed-47d7-1729-08d5a6427f9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2018 22:11:28.0975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1585
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3JMBd5b001937

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Thursday, April 19, 2018 5:47 PM
> To: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Sinan Kaya <okaya@codeaurora.org>; Bjorn Helgaas
> <bhelgaas@google.com>; linux-pci@vger.kernel.org;
> sulrich@codeaurora.org; timur@codeaurora.org; linux-arm-
> msm@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Mike
> Marciniszyn <mike.marciniszyn@intel.com>; Dennis Dalessandro
> <dennis.dalessandro@intel.com>; Doug Ledford <dledford@redhat.com>;
> open list:HFI1 DRIVER <linux-rdma@vger.kernel.org>; open list <linux-
> kernel@vger.kernel.org>; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH 1/2] IB/hfi1: Try slot reset before secondary bus reset
> 
> [+cc Alex, who might know why DRM drivers have their own PCIe Gen3
> code]
> 
> On Thu, Apr 19, 2018 at 02:26:32PM -0600, Jason Gunthorpe wrote:
> > On Thu, Apr 19, 2018 at 03:56:23PM -0400, Sinan Kaya wrote:
> > > The infiniband adapter might be connected to a PCI hotplug slot.
> > > Performing secondary bus reset on a hotplug slot causes PCI link
> up/down interrupts.
> > >
> > > Hotplug driver removes the device from system when a link down
> > > interrupt is observed and performs re-enumeration when link up
> interrupt is observed.
> > >
> > > This conflicts with what this code is trying to do. Try secondary
> > > bus reset only if pci_reset_slot() fails/unsupported.
> > >
> > > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> > > drivers/infiniband/hw/hfi1/pcie.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/infiniband/hw/hfi1/pcie.c
> > > b/drivers/infiniband/hw/hfi1/pcie.c
> > > index 83d66e8..75f49e3 100644
> > > +++ b/drivers/infiniband/hw/hfi1/pcie.c
> > > @@ -908,7 +908,8 @@ static int trigger_sbr(struct hfi1_devdata *dd)
> >
> > The code above this hunk is:
> >
> > /*
> >  * Trigger a secondary bus reset (SBR) on ourselves using our parent.
> >  *
> >  * Based on pci_parent_bus_reset() which is not exported by the
> >  * kernel core.
> >  */
> > static int trigger_sbr(struct hfi1_devdata *dd) {
> >
> > [..]
> >
> > This really seems like something the PCI core should be helping with,
> > drivers shouldn't be doing stuff like this. I get the feeling this
> > should be a common need if drivers support various error recovery
> > schemes?
> >
> > Bjorn, would be appropriate to export pci_parent_bus_reset() or some
> > variation therin??
> 
> I agree it would be really nice if the PCI core could help out somehow so we
> could get some of this code out of individual drivers.
> 
> If fact, stepping back a few paces, this HFI reset path is part of a transition to
> PCIe gen3 signaling, and I'm not sure why *that* is in the driver either.
> 
> There's an ongoing discussion [1] about why this gen3 code is in the driver.
> Several DRM drivers include similar code (cik_pcie_gen3_enable(),
> si_pcie_gen3_enable()).
> 
> I *thought* the hardware was supposed to automatically negotiate to the
> highest rate supported by both sides without any help at all from software.
> But since several drivers have code to do it themselves, I wonder if I'm
> missing something, or maybe there's something the PCI core should be doing
> that it isn't, and the driver code is basically working around that PCI core
> deficiency.

My understanding was that some platfoms only bring up the link in gen 1 mode for compatibility reasons.  TBH, I'm not that familiar with how the links come up on different platforms.

Alex
