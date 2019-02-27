Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BA2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43EA5217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="MKxvdodi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbfB0Rz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:55:58 -0500
Received: from esa5.dell-outbound.iphmx.com ([68.232.153.95]:60919 "EHLO
        esa5.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725854AbfB0Rz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:55:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1551290142; x=1582826142;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=AYl8k7hNrO3eLym5L2t3acYGCEZtKpLdZqWwfRx5f3M=;
  b=MKxvdodiopNyeEqNZWzBE9AfAkljFk365CJ1JOtGT9q5jPsbMtL6EK1s
   SRvI3msS3aLIR9nNQG23KwJDEG/R8ynKexrkYXedwYJDeBm9EFRgcyBll
   oehFVmyZnhvBDYXCmaG2zJ1WXStO56AfoXZ8Oal42bQYw2kBYGYWpylsa
   c=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2E8AADzzXZchyWd50NeBhoBAQEBAQI?=
 =?us-ascii?q?BAQEBBwIBAQEBgWWBVYEFEUw3JwqMd4sqgVJ8lziBZwsBARgLC4Q+hBAiOBI?=
 =?us-ascii?q?BAwEBAgEBAgEBAhABAQEKCwkIKSMMgjoiHE1rAQEBAQEBIwINYwEBAQMBAQE?=
 =?us-ascii?q?QKDQLEAIBCBgeECcBLwIEAQ0FCBMHgn4BgWoID59VPQJtgQGJBwEBAYIeiiy?=
 =?us-ascii?q?MSIEOgQiBEYIUSQcugx4BBIErARIBBwoOB4VaAol7DiQMgVmXWAcCh0KBGoV?=
 =?us-ascii?q?bhCshgXNYkFGHb4JuhVaMQQIEAgQFAhSBXoEHcXBQgmwJgh8OCYhfhT9AATG?=
 =?us-ascii?q?Pew0XB4EBgR8BAQ?=
X-IPAS-Result: =?us-ascii?q?A2E8AADzzXZchyWd50NeBhoBAQEBAQIBAQEBBwIBAQEBg?=
 =?us-ascii?q?WWBVYEFEUw3JwqMd4sqgVJ8lziBZwsBARgLC4Q+hBAiOBIBAwEBAgEBAgEBA?=
 =?us-ascii?q?hABAQEKCwkIKSMMgjoiHE1rAQEBAQEBIwINYwEBAQMBAQEQKDQLEAIBCBgeE?=
 =?us-ascii?q?CcBLwIEAQ0FCBMHgn4BgWoID59VPQJtgQGJBwEBAYIeiiyMSIEOgQiBEYIUS?=
 =?us-ascii?q?Qcugx4BBIErARIBBwoOB4VaAol7DiQMgVmXWAcCh0KBGoVbhCshgXNYkFGHb?=
 =?us-ascii?q?4JuhVaMQQIEAgQFAhSBXoEHcXBQgmwJgh8OCYhfhT9AATGPew0XB4EBgR8BA?=
 =?us-ascii?q?Q?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
  by esa5.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Feb 2019 11:55:42 -0600
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1RHr0iw038120
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 12:55:56 -0500
Received: from esa2.dell-outbound2.iphmx.com (esa2.dell-outbound2.iphmx.com [68.232.153.202])
        by mx0b-00154901.pphosted.com with ESMTP id 2qwy16r4c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 12:55:55 -0500
From:   <Austin.Bolen@dell.com>
Received: from ausc60ps301.us.dell.com ([143.166.148.206])
  by esa2.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Feb 2019 23:55:46 +0600
X-LoopCount0: from 10.166.135.144
X-IronPort-AV: E=Sophos;i="5.58,420,1544508000"; 
   d="scan'208";a="1262811980"
To:     <Alex_Gagniuc@Dellteam.com>, <torvalds@linux-foundation.org>
CC:     <axboe@fb.com>, <sagi@grimberg.me>, <linux-kernel@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <keith.busch@intel.com>,
        <mr.nuke.me@gmail.com>, <hch@lst.de>, <jonathan.derrick@intel.com>
Subject: Re: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
Thread-Topic: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
Thread-Index: AQHUyksezlXXaxBLsUa+kQskBqUhAw==
Date:   Wed, 27 Feb 2019 17:55:51 +0000
Message-ID: <f6704855445b44639f023a48f3003309@AUSX13MPC131.AMER.DELL.COM>
References: <20190222010502.2434-1-jonathan.derrick@intel.com>
 <CAHk-=wjmjHyovjtzaq=HSegEpiO2SXWaYfJ6qsJrZhXg_YSx5g@mail.gmail.com>
 <2b7d8f45d11c47e69f56ad1bc3324dd1@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wg_e5M0b5aJJf8V_UYaqX12YYA9MEg=gHNp6ALE5fK23w@mail.gmail.com>
 <cbe2ed1562a64609be6538f5816ec1b6@ausx13mps321.AMER.DELL.COM>
 <20190225155501.GI10237@localhost.localdomain>
 <b35ebf928ed743cca6649a191c76957b@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wgRdATtsBzo-LDkWn_sW-PJvq95SahZcsTxxDMPzLWxKA@mail.gmail.com>
 <940d608e1a044a54abcb9d65923951f3@ausx13mps317.AMER.DELL.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902270122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/2019 10:42 AM, Gagniuc, Alexandru - Dell Team wrote:=0A=
> =0A=
> [EXTERNAL EMAIL]=0A=
> =0A=
> On 2/26/19 7:02 PM, Linus Torvalds wrote:=0A=
>> On Tue, Feb 26, 2019 at 2:37 PM <Alex_Gagniuc@dellteam.com> wrote:=0A=
>>>=0A=
>>> Then nobody gets the (error) message. You can go a bit further and try=
=0A=
>>> 'pcie_ports=3Dnative". Again, nobody gets the memo. ):=0A=
>>=0A=
>> So? The error was bogus to begin with. Why would we care?=0A=
> =0A=
> Of course nobody cares about that. We care about actual errors that we=0A=
> now know we won't be notified of. Imagine if we didn't get the memo that=
=0A=
> a piece of data is corrupt, and imagine the reaction of RAS folk.=0A=
> =0A=
> And I know the counter to that is a panic() is much more likely to cause=
=0A=
> data corruption, and we're trading one piece of crap for an even=0A=
> stinkier one. Whatever we end up doing, we have to do better than=0A=
> silence errors and pretend nothing happened.=0A=
> =0A=
> =0A=
>> Yes, yes, PCI bridges have the ability to return errors in accesses to=
=0A=
>> non-existent devices. But that was always bogus, and is never useful.=0A=
>> The whole "you get an interrupt or NMI on a bad access" is simply a=0A=
>> horribly broken model. It's not useful.=0A=
>>=0A=
>> We already have long depended on hotplug drivers noticing the "oh, I'm=
=0A=
>> getting all-ff returns, the device may be gone". It's usually trivial,=
=0A=
>> and works a whole lot better.=0A=
> =0A=
> And that's been working great, hasn't it? I think you're thinking=0A=
> strictly about hotplug. There are other situations where things are all=
=0A=
> F'd, but the hardware isn't sending all F's. (example: ECRC errors)=0A=
> =0A=
> =0A=
>> It's not an error. Trying to force it to be an NMI or SCI or machine=0A=
>> check is bogus. It causes horrendous pain, because asynchronous=0A=
>> reporting doesn't work reliably anyway, and *synchronous* reporting is=
=0A=
>> impossible to sanely handle without crazy problems.=0A=
>>=0A=
>> So the only sane model for hotplug devices is "IO still works, and=0A=
>> returns all ones". Maybe with an async one-time and *recoverable*=0A=
>> machine check or other reporting the access after the fact.=0A=
> =0A=
> Exactly!!! A notification (not calling it an 'error') that something=0A=
> unusual has happened is good. Treating these things like errors is so=0A=
> obvious, even a caveman wouldn't do it.=0A=
> In a world with FFS, we don't always get to have that model. Oh, FFS!=0A=
> =0A=
> =0A=
>> Anything else is simply broken. It would be broken even if firmware=0A=
>> wasn't involved, but obviously firmware people tend to often make a=0A=
>> bad situation even worse.=0A=
> =0A=
> Linus, be nice to firmware people. I've met a few, and I can vouch that=
=0A=
> they're very kind and nice. They're also very scared, especially when OS=
=0A=
> people want to ask them a few questions.=0A=
> =0A=
> I think FFS should get out of the way when OS advertises it's capable of=
=0A=
> handling XYZ. There are some good arguments why this hasn't happened,=0A=
> but I won't get into details. I do think it's unlikely that machines=0A=
> will be moving back to an OS-controlled model.=0A=
> =0A=
> And Linus, keep in mind, when these machines were developed, OSes=0A=
> couldn't handle recovery properly. None of this was ever an issue. It's=
=0A=
> our fault that we've changed the OS after the machines are on the market.=
=0A=
=0A=
Just to add some background on these particular systems... at the time =0A=
they were designed none of the Linux distros we use supported the PCI =0A=
Error Recovery Services or maybe they did and we simply didn't know =0A=
about it.  We found out rather by accident after the systems were =0A=
shipped that Linux had this ability.  It was a pleasant surprise as =0A=
we've been asking OSVs to try to recover from PCI/PCIe errors for years. =
=0A=
  Linux is the first (and still only) OS we use that can has a PCIe =0A=
error recovery model so kudos on that!=0A=
=0A=
100% agree that crashing the system on PCIe errors like this is terrible =
=0A=
and we want to get to a recovery model.  It was too late for the =0A=
generation of systems being discussed as it is a big paradigm shift and =0A=
lots of changes/validation that folks are not comfortable doing on =0A=
shipping products.  But it's coming in future products.=0A=
=0A=
We also noticed that there was no mechanism in the recovery models for =0A=
system firmware and OS to interact and come to know if recovery services =
=0A=
are available and no way for OS to inform platform if error recovery was =
=0A=
successful or not and no way to establish control of Downstream Port =0A=
Containment.  This model - which PCI-SIG is calling Containment Error =0A=
Recovery - has been added in the relevant PCI-SIG documents and ACPI =0A=
spec and I believe Intel will start pushing patches soon.  Hopefully =0A=
this will provide the industry standard solution needed to get to a full =
=0A=
error recovery model for PCIe-related errors.=0A=
=0A=
There are other hardware additions in PCIe that could help with =0A=
synchronizing errors such as the RP PIO synchronous exception handling =0A=
added to PCIe as part of eDPC.  Hardware is sparse but shipping AMD =0A=
Naples products already support this new hardware.  I expect more =0A=
hardware to support as the industry shifts to Downstream Port =0A=
Containment/Containment Error Recovery model.=0A=
=0A=
For these issues on existing platforms, I'm not sure what could be done. =
=0A=
  Continuing to crash may be necessary until the CER solution is in place.=
=0A=
=0A=
BTW, this patch in particular is complaining about an error for a =0A=
removed device.  The Dell servers referenced in this chain will check if =
=0A=
the device is removed and if so it will suppress the error so I don't =0A=
think they are susceptible to this particular issue and I agree it is =0A=
broken if they do.  If that is the case we can and will fix it in firmware.=
=0A=
=0A=
> =0A=
> Alex=0A=
> =0A=
> _______________________________________________=0A=
> Linux-nvme mailing list=0A=
> Linux-nvme@lists.infradead.org=0A=
> http://lists.infradead.org/mailman/listinfo/linux-nvme=0A=
> =0A=
=0A=
