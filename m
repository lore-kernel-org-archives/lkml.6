Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A622C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E50B217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="W48+NnZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbfB0Qme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:42:34 -0500
Received: from esa2.dell-outbound.iphmx.com ([68.232.149.220]:2833 "EHLO
        esa2.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725854AbfB0Qma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:42:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1551285750; x=1582821750;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=mMnWLk945TabVOHQyF0Zv0LecvoHpi1uk0+Ug/NdkVY=;
  b=W48+NnZWquFKP/NcBR3CEoD3IZj2zXj0vnJ09Yog1tIKAN7T3jJcLz7r
   lb6NcGBpA5neUopv4blI73Qdq/VBvaKydU2n2XvO0ZUTAkEx10MzC2lIe
   fNVlVEO4jOnR8MzGABYiNqZNZlaK5n3e7VjoFaQpY2jSsiq2bsWo99Fdy
   E=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GhAADIvHZchyWd50NeBhsBAQEBAwE?=
 =?us-ascii?q?BAQcDAQEBgWWCWl03JwqMd4x8mhsLAQEshECEECI4EgEDAQECAQECAQECEAE?=
 =?us-ascii?q?BAQoLCQgpL4I6IoJvAQEBAwESKD8FCwIBCBgeEFcCBA4FCBqCfoFrCJ9IPQJ?=
 =?us-ascii?q?tgQGJBwEBAYIeiiyMSIIWgyVJBy6Ecw4HhVoCiXsOggmXWAkFkl0hkxyHb5U?=
 =?us-ascii?q?FAgQCBAUCFIFegXhwgzyCNo4nQTGBKI9/AYEeAQE?=
X-IPAS-Result: =?us-ascii?q?A2GhAADIvHZchyWd50NeBhsBAQEBAwEBAQcDAQEBgWWCW?=
 =?us-ascii?q?l03JwqMd4x8mhsLAQEshECEECI4EgEDAQECAQECAQECEAEBAQoLCQgpL4I6I?=
 =?us-ascii?q?oJvAQEBAwESKD8FCwIBCBgeEFcCBA4FCBqCfoFrCJ9IPQJtgQGJBwEBAYIei?=
 =?us-ascii?q?iyMSIIWgyVJBy6Ecw4HhVoCiXsOggmXWAkFkl0hkxyHb5UFAgQCBAUCFIFeg?=
 =?us-ascii?q?XhwgzyCNo4nQTGBKI9/AYEeAQE?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
  by esa2.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Feb 2019 10:42:14 -0600
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1RGcEpH113796
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 11:42:14 -0500
Received: from esa2.dell-outbound2.iphmx.com (esa2.dell-outbound2.iphmx.com [68.232.153.202])
        by mx0a-00154901.pphosted.com with ESMTP id 2qu1pj02w0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 11:42:14 -0500
Received: from ausxippc101.us.dell.com ([143.166.85.207])
  by esa2.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Feb 2019 22:41:59 +0600
X-LoopCount0: from 10.166.135.141
X-IronPort-AV: E=Sophos;i="5.58,420,1544508000"; 
   d="scan'208";a="1202685558"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <torvalds@linux-foundation.org>
CC:     <keith.busch@intel.com>, <axboe@fb.com>, <sagi@grimberg.me>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <mr.nuke.me@gmail.com>, <hch@lst.de>, <jonathan.derrick@intel.com>
Subject: Re: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
Thread-Topic: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
Thread-Index: AQHUyksMhaVeVw7H30qZ9nZ8VEPxSQ==
Date:   Wed, 27 Feb 2019 16:42:05 +0000
Message-ID: <940d608e1a044a54abcb9d65923951f3@ausx13mps317.AMER.DELL.COM>
References: <20190222010502.2434-1-jonathan.derrick@intel.com>
 <CAHk-=wjmjHyovjtzaq=HSegEpiO2SXWaYfJ6qsJrZhXg_YSx5g@mail.gmail.com>
 <2b7d8f45d11c47e69f56ad1bc3324dd1@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wg_e5M0b5aJJf8V_UYaqX12YYA9MEg=gHNp6ALE5fK23w@mail.gmail.com>
 <cbe2ed1562a64609be6538f5816ec1b6@ausx13mps321.AMER.DELL.COM>
 <20190225155501.GI10237@localhost.localdomain>
 <b35ebf928ed743cca6649a191c76957b@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wgRdATtsBzo-LDkWn_sW-PJvq95SahZcsTxxDMPzLWxKA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.11.234]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=668 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902270113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/19 7:02 PM, Linus Torvalds wrote:=0A=
> On Tue, Feb 26, 2019 at 2:37 PM <Alex_Gagniuc@dellteam.com> wrote:=0A=
>>=0A=
>> Then nobody gets the (error) message. You can go a bit further and try=
=0A=
>> 'pcie_ports=3Dnative". Again, nobody gets the memo. ):=0A=
> =0A=
> So? The error was bogus to begin with. Why would we care?=0A=
=0A=
Of course nobody cares about that. We care about actual errors that we =0A=
now know we won't be notified of. Imagine if we didn't get the memo that =
=0A=
a piece of data is corrupt, and imagine the reaction of RAS folk.=0A=
=0A=
And I know the counter to that is a panic() is much more likely to cause =
=0A=
data corruption, and we're trading one piece of crap for an even =0A=
stinkier one. Whatever we end up doing, we have to do better than =0A=
silence errors and pretend nothing happened.=0A=
=0A=
=0A=
> Yes, yes, PCI bridges have the ability to return errors in accesses to=0A=
> non-existent devices. But that was always bogus, and is never useful.=0A=
> The whole "you get an interrupt or NMI on a bad access" is simply a=0A=
> horribly broken model. It's not useful.=0A=
> =0A=
> We already have long depended on hotplug drivers noticing the "oh, I'm=0A=
> getting all-ff returns, the device may be gone". It's usually trivial,=0A=
> and works a whole lot better.=0A=
=0A=
And that's been working great, hasn't it? I think you're thinking =0A=
strictly about hotplug. There are other situations where things are all =0A=
F'd, but the hardware isn't sending all F's. (example: ECRC errors)=0A=
=0A=
=0A=
> It's not an error. Trying to force it to be an NMI or SCI or machine=0A=
> check is bogus. It causes horrendous pain, because asynchronous=0A=
> reporting doesn't work reliably anyway, and *synchronous* reporting is=0A=
> impossible to sanely handle without crazy problems.=0A=
> =0A=
> So the only sane model for hotplug devices is "IO still works, and=0A=
> returns all ones". Maybe with an async one-time and *recoverable*=0A=
> machine check or other reporting the access after the fact.=0A=
=0A=
Exactly!!! A notification (not calling it an 'error') that something =0A=
unusual has happened is good. Treating these things like errors is so =0A=
obvious, even a caveman wouldn't do it.=0A=
In a world with FFS, we don't always get to have that model. Oh, FFS!=0A=
=0A=
=0A=
> Anything else is simply broken. It would be broken even if firmware=0A=
> wasn't involved, but obviously firmware people tend to often make a=0A=
> bad situation even worse.=0A=
=0A=
Linus, be nice to firmware people. I've met a few, and I can vouch that =0A=
they're very kind and nice. They're also very scared, especially when OS =
=0A=
people want to ask them a few questions.=0A=
=0A=
I think FFS should get out of the way when OS advertises it's capable of =
=0A=
handling XYZ. There are some good arguments why this hasn't happened, =0A=
but I won't get into details. I do think it's unlikely that machines =0A=
will be moving back to an OS-controlled model.=0A=
=0A=
And Linus, keep in mind, when these machines were developed, OSes =0A=
couldn't handle recovery properly. None of this was ever an issue. It's =0A=
our fault that we've changed the OS after the machines are on the market.=
=0A=
=0A=
Alex=0A=
