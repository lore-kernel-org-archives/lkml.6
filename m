Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF90C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 546BD208A4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="fOv9pJpm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 546BD208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbeGaBDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 21:03:25 -0400
Received: from esa1.dell-outbound.iphmx.com ([68.232.153.90]:31435 "EHLO
        esa1.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727094AbeGaBDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 21:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1532992693; x=1564528693;
  h=cc:from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=gm7b2us34f/ReJ2Ew+hH0m6YV52j6m/0CyuEjvspdR0=;
  b=fOv9pJpmZHKOpp/POCuNzC1Iqkk2UPe3xUjMYrRwHGMBpAV5dPcK9Rky
   kgayvUX3/vijUu82+1M0OBYYLztKB2HQhvZw4G9j8S1azEtDRwy0mXei6
   U74ujw4MMFtAL5dPAw2IzWc8+9+QWINCaAsHBGzSNXvzSZNbWCrWTrcLw
   o=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FrAQAXnl9bmMqZ6ERcGwEBAQEDAQEBC?=
 =?us-ascii?q?QEBAYQigQ4oCpg2gg2IQo8JC4RsgxYhOBQBAgEBAgEBAgEBAhABAQEBAQgLCwY?=
 =?us-ascii?q?pIwyCNSKCYgECA20MEAIBCBguITYCBAESCBODBYFoAxWuIYcTDYMmiQKCF4ESg?=
 =?us-ascii?q?xKCVoIohVYCh1WFUow+KwkFjCaDBIFQjEGIDYMWhxSBWIF0cIM5gjOHV4ZJbwG?=
 =?us-ascii?q?OLIEbAQE?=
X-IPAS-Result: =?us-ascii?q?A2FrAQAXnl9bmMqZ6ERcGwEBAQEDAQEBCQEBAYQigQ4oCpg?=
 =?us-ascii?q?2gg2IQo8JC4RsgxYhOBQBAgEBAgEBAgEBAhABAQEBAQgLCwYpIwyCNSKCYgECA?=
 =?us-ascii?q?20MEAIBCBguITYCBAESCBODBYFoAxWuIYcTDYMmiQKCF4ESgxKCVoIohVYCh1W?=
 =?us-ascii?q?FUow+KwkFjCaDBIFQjEGIDYMWhxSBWIF0cIM5gjOHV4ZJbwGOLIEbAQE?=
Received: from esa2.dell-outbound2.iphmx.com ([68.232.153.202])
  by esa1.dell-outbound.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 18:18:13 -0500
Cc:     <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <keith.busch@intel.com>, <Austin.Bolen@dell.com>,
        <Shyam.Iyer@dell.com>, <jeffrey.t.kirsher@intel.com>,
        <ariel.elior@cavium.com>, <michael.chan@broadcom.com>,
        <ganeshgr@chelsio.com>, <tariqt@mellanox.com>, <airlied@gmail.com>,
        <alexander.deucher@amd.com>, <mike.marciniszyn@intel.com>,
        <linux-kernel@vger.kernel.org>
Received: from ausxippc106.us.dell.com ([143.166.85.156])
  by esa2.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2018 05:21:38 +0600
X-LoopCount0: from 10.166.134.89
X-IronPort-AV: E=Sophos;i="5.51,425,1526360400"; 
   d="scan'208";a="274668540"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <talgi@mellanox.com>, <mr.nuke.me@gmail.com>,
        <jakub.kicinski@netronome.com>
Subject: Re: [PATCH v5] PCI: Check for PCIe downtraining conditions
Thread-Topic: [PATCH v5] PCI: Check for PCIe downtraining conditions
Thread-Index: AQHUIsBJEgoOQgRprEe8nLwocH1DnQ==
Date:   Mon, 30 Jul 2018 23:26:02 +0000
Message-ID: <cc8e0ec8fd7c4222a8ef858d3682b18b@ausx13mps321.AMER.DELL.COM>
References: <20180718215359.GG128988@bhelgaas-glaptop.roam.corp.google.com>
 <20180723200339.23943-1-mr.nuke.me@gmail.com>
 <20180723140143.1a46902f@cakuba.netronome.com>
 <b9a6b3b8-56cf-8bb5-2568-071ccd8a4f28@mellanox.com>
 <20180723151439.50524a2a@cakuba.netronome.com>
 <2bb6e96c-a48d-62ea-90a3-ec978536372f@gmail.com>
 <cf663b45-a6ce-b0d7-c79a-a02940001c20@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.178.128.193]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/2018 08:40 AM, Tal Gilboa wrote:=0A=
> On 7/24/2018 2:59 AM, Alex G. wrote:=0A=
>>=0A=
>>=0A=
>> On 07/23/2018 05:14 PM, Jakub Kicinski wrote:=0A=
>>> On Tue, 24 Jul 2018 00:52:22 +0300, Tal Gilboa wrote:=0A=
>>>> On 7/24/2018 12:01 AM, Jakub Kicinski wrote:=0A=
>>>>> On Mon, 23 Jul 2018 15:03:38 -0500, Alexandru Gagniuc wrote:=0A=
>>>>>> PCIe downtraining happens when both the device and PCIe port are=0A=
>>>>>> capable of a larger bus width or higher speed than negotiated.=0A=
>>>>>> Downtraining might be indicative of other problems in the system, an=
d=0A=
>>>>>> identifying this from userspace is neither intuitive, nor=0A=
>>>>>> straightforward.=0A=
>>>>>>=0A=
>>>>>> The easiest way to detect this is with pcie_print_link_status(),=0A=
>>>>>> since the bottleneck is usually the link that is downtrained. It's n=
ot=0A=
>>>>>> a perfect solution, but it works extremely well in most cases.=0A=
>>>>>>=0A=
>>>>>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>=0A=
>>>>>> ---=0A=
>>>>>>=0A=
>>>>>> For the sake of review, I've created a __pcie_print_link_status()=0A=
>>>>>> which=0A=
>>>>>> takes a 'verbose' argument. If we agree want to go this route, and=
=0A=
>>>>>> update=0A=
>>>>>> the users of pcie_print_link_status(), I can split this up in two=0A=
>>>>>> patches.=0A=
>>>>>> I prefer just printing this information in the core functions, and=
=0A=
>>>>>> letting=0A=
>>>>>> drivers not have to worry about this. Though there seems to be=0A=
>>>>>> strong for=0A=
>>>>>> not going that route, so here it goes:=0A=
>>>>>=0A=
>>>>> FWIW the networking drivers print PCIe BW because sometimes the netwo=
rk=0A=
>>>>> bandwidth is simply over-provisioned on multi port cards, e.g. 80Gbps=
=0A=
>>>>> card on a x8 link.=0A=
>>>>>=0A=
>>>>> Sorry to bike shed, but currently the networking cards print the info=
=0A=
>>>>> during probe.=A0 Would it make sense to move your message closer to p=
robe=0A=
>>>>> time?=A0 Rather than when device is added.=A0 If driver structure is=
=0A=
>>>>> available, we could also consider adding a boolean to struct pci_driv=
er=0A=
>>>>> to indicate if driver wants the verbose message?=A0 This way we avoid=
=0A=
>>>>> duplicated prints.=0A=
>>>>>=0A=
>>>>> I have no objection to current patch, it LGTM.=A0 Just a thought.=0A=
>>>>=0A=
>>>> I don't see the reason for having two functions. What's the problem wi=
th=0A=
>>>> adding the verbose argument to the original function?=0A=
>>>=0A=
>>> IMHO it's reasonable to keep the default parameter to what 90% of users=
=0A=
>>> want by a means on a wrapper.=A0 The non-verbose output is provided by=
=0A=
>>> the core already for all devices.=0A=
>>>=0A=
>>> What do you think of my proposal above Tal?=A0 That would make the extr=
a=0A=
>>> wrapper unnecessary since the verbose parameter would be part of the=0A=
>>> driver structure, and it would avoid the duplicated output.=0A=
>>=0A=
>> I see how it might make sense to add another member to the driver=0A=
>> struct, but is it worth the extra learning curve? It seems to be=0A=
>> something with the potential to confuse new driver developers, and=0A=
>> having a very marginal benefit.=0A=
>> Although, if that's what people want...=0A=
> =0A=
> I prefer the wrapper function. Looking at struct pci_driver it would=0A=
> seem strange for it to hold a field for controlling verbosity (IMO).=0A=
> This is a very (very) specific field in a very general struct.=0A=
=0A=
If people are okay with the wrapper, then I'm not going to update the patch=
.=0A=
=0A=
Alex=0A=
