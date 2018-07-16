Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C625ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 22:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D14208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 22:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="s0Y3PRpF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D14208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbeGPW6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 18:58:05 -0400
Received: from esa6.dell-outbound.iphmx.com ([68.232.149.229]:44127 "EHLO
        esa6.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728784AbeGPW6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 18:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1531780117; x=1563316117;
  h=cc:from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=rT7nytSvjmYmLSVlXY+N9hT6kBXrezsdaQx4MP+Yq0c=;
  b=s0Y3PRpFMWBiyjSJEEO5NzjT6/u7L0yMrkNB0ihUjRN8SkKYmMuVaQG9
   ezJCkW0Z/1OSiMM4joUHso7NNzXBaJ2+FLbAfdqjhLWi1ZXXpdeXyBdaa
   HfCYHDHQYTQqQ0KcFDcix3BYRWm3a4sncFCPSXZDMvuBzxWatonf33QpG
   g=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GfAQCsGk1bh2Ka6ERSChsBAQEBAwEBA?=
 =?us-ascii?q?QkBAQGFKygKmDOCDIg5jQAUgWYLhGyCZCE2FgECAQECAQECAQECEAEBAQoLCQg?=
 =?us-ascii?q?pIwyCNSKCYQEBAQECAScTNQoFCwIBCBgeECE2AgQBEggTgwWBaAMNCKd1EYIcM?=
 =?us-ascii?q?4cSDYMliQKCFoMkfoJWgXoUF4VWAodEii2HQCsJBYhpgy2DBIFLhn6FJIsIhwy?=
 =?us-ascii?q?BSASCAHCDOYIlDgmHToZJbwGMfIEaAQE?=
X-IPAS-Result: =?us-ascii?q?A2GfAQCsGk1bh2Ka6ERSChsBAQEBAwEBAQkBAQGFKygKmDO?=
 =?us-ascii?q?CDIg5jQAUgWYLhGyCZCE2FgECAQECAQECAQECEAEBAQoLCQgpIwyCNSKCYQEBA?=
 =?us-ascii?q?QECAScTNQoFCwIBCBgeECE2AgQBEggTgwWBaAMNCKd1EYIcM4cSDYMliQKCFoM?=
 =?us-ascii?q?kfoJWgXoUF4VWAodEii2HQCsJBYhpgy2DBIFLhn6FJIsIhwyBSASCAHCDOYIlD?=
 =?us-ascii?q?gmHToZJbwGMfIEaAQE?=
Received: from esa4.dell-outbound2.iphmx.com ([68.232.154.98])
  by esa6.dell-outbound.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 17:28:37 -0500
Cc:     <bhelgaas@google.com>, <Austin.Bolen@dell.com>,
        <Shyam.Iyer@dell.com>, <keith.busch@intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jeffrey.t.kirsher@intel.com>, <ariel.elior@cavium.com>,
        <michael.chan@broadcom.com>, <ganeshgr@chelsio.com>,
        <tariqt@mellanox.com>, <jakub.kicinski@netronome.com>,
        <talgi@mellanox.com>, <airlied@gmail.com>,
        <alexander.deucher@amd.com>
Received: from ausxipps306.us.dell.com ([143.166.148.156])
  by esa4.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2018 04:28:36 +0600
X-LoopCount0: from 10.166.134.88
X-IronPort-AV: E=Sophos;i="5.51,363,1526360400"; 
   d="scan'208";a="227126093"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <helgaas@kernel.org>, <mr.nuke.me@gmail.com>
Subject: Re: [PATCH v3] PCI: Check for PCIe downtraining conditions
Thread-Topic: [PATCH v3] PCI: Check for PCIe downtraining conditions
Thread-Index: AQHUHUpo2APjB2UGd0Cvq5PehAw5hA==
Date:   Mon, 16 Jul 2018 22:28:35 +0000
Message-ID: <97a70a71e1034bafbcabc6c4e23577c0@ausx13mps321.AMER.DELL.COM>
References: <20180604155523.14906-1-mr.nuke.me@gmail.com>
 <20180716211706.GB12391@bhelgaas-glaptop.roam.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/2018 4:17 PM, Bjorn Helgaas wrote:=0A=
> [+cc maintainers of drivers that already use pcie_print_link_status()=0A=
> and GPU folks]=0A=
=0A=
Thanks for finding them!=0A=
=0A=
[snip]=0A=
>> identifying this from userspace is neither intuitive, nor straigh=0A=
>> forward.=0A=
> =0A=
> s/straigh/straight/=0A=
> In this context, I think "straightforward" should be closed up=0A=
> (without the space).=0A=
=0A=
That's a straightforward edit. Thanks for the feedback!=0A=
=0A=
>> The easiest way to detect this is with pcie_print_link_status(),=0A=
>> since the bottleneck is usually the link that is downtrained. It's not=
=0A=
>> a perfect solution, but it works extremely well in most cases.=0A=
> =0A=
> This is an interesting idea.  I have two concerns:=0A=
> =0A=
> Some drivers already do this on their own, and we probably don't want=0A=
> duplicate output for those devices.  In most cases (ixgbe and mlx* are=0A=
> exceptions), the drivers do this unconditionally so we *could* remove=0A=
> it from the driver if we add it to the core.  The dmesg order would=0A=
> change, and the message wouldn't be associated with the driver as it=0A=
> now is.=0A=
=0A=
Oh, there are only 8 users of that. Even I could patch up the drivers to =
=0A=
remove the call, assuming we reach agreement about this change.=0A=
=0A=
> Also, I think some of the GPU devices might come up at a lower speed,=0A=
> then download firmware, then reset the device so it comes up at a=0A=
> higher speed.  I think this patch will make us complain about about=0A=
> the low initial speed, which might confuse users.=0A=
=0A=
I spoke to one of the PCIe spec writers. It's allowable for a device to =0A=
downtrain speed or width. It would also be extremely dumb to downtrain =0A=
with the intent to re-train at a higher speed later, but it's possible =0A=
devices do dumb stuff like that. That's why it's an informational =0A=
message, instead of a warning.=0A=
=0A=
Another case: Some devices (lower-end GPUs) use silicon (and marketing) =0A=
that advertises x16, but they're only routed for x8. I'm okay with =0A=
seeing an informational message in this case. In fact, I didn't know =0A=
that my Quadro card for three years is only wired for x8 until I was =0A=
testing this patch.=0A=
=0A=
> So I'm not sure whether it's better to do this in the core for all=0A=
> devices, or if we should just add it to the high-performance drivers=0A=
> that really care.=0A=
=0A=
You're thinking "do I really need that bandwidth" because I'm using a =0A=
function called "_bandwidth_". The point of the change is very far from =0A=
that: it is to help in system troubleshooting by detecting downtraining =0A=
conditions.=0A=
=0A=
>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>=0A=
[snip]=0A=
>> +	/* Look from the device up to avoid downstream ports with no devices. =
*/=0A=
>> +	if ((pci_pcie_type(dev) !=3D PCI_EXP_TYPE_ENDPOINT) &&=0A=
>> +	    (pci_pcie_type(dev) !=3D PCI_EXP_TYPE_LEG_END) &&=0A=
>> +	    (pci_pcie_type(dev) !=3D PCI_EXP_TYPE_UPSTREAM))=0A=
>> +		return;=0A=
> =0A=
> Do we care about Upstream Ports here?  =0A=
=0A=
YES! Switches. e.g. an x16 switch with 4x downstream ports could =0A=
downtrain at 8x and 4x, and we'd never catch it.=0A=
=0A=
> I suspect that ultimately we=0A=
> only care about the bandwidth to Endpoints, and if an Endpoint is=0A=
> constrained by a slow link farther up the tree,=0A=
> pcie_print_link_status() is supposed to identify that slow link.=0A=
=0A=
See above.=0A=
=0A=
> I would find this test easier to read as=0A=
> =0A=
>    if (!(type =3D=3D PCI_EXP_TYPE_ENDPOINT || type =3D=3D PCI_EXP_TYPE_LE=
G_END))=0A=
>      return;=0A=
> =0A=
> But maybe I'm the only one that finds the conjunction of inequalities=0A=
> hard to read.  No big deal either way.=0A=
> =0A=
>> +	/* Multi-function PCIe share the same link/status. */=0A=
>> +	if ((PCI_FUNC(dev->devfn) !=3D 0) || dev->is_virtfn)=0A=
>> +		return;=0A=
>> +=0A=
>> +	pcie_print_link_status(dev);=0A=
>> +}=0A=
>> +=0A=
>>   static void pci_init_capabilities(struct pci_dev *dev)=0A=
>>   {=0A=
>>   	/* Enhanced Allocation */=0A=
>> @@ -2181,6 +2200,9 @@ static void pci_init_capabilities(struct pci_dev *=
dev)=0A=
>>   	/* Advanced Error Reporting */=0A=
>>   	pci_aer_init(dev);=0A=
>>   =0A=
>> +	/* Check link and detect downtrain errors */=0A=
>> +	pcie_check_upstream_link(dev);=0A=
>> +=0A=
>>   	if (pci_probe_reset_function(dev) =3D=3D 0)=0A=
>>   		dev->reset_fn =3D 1;=0A=
>>   }=0A=
>> -- =0A=
>> 2.14.4=0A=
>>=0A=
> =0A=
=0A=
