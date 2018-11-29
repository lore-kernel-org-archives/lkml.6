Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5650C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733E620868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DNHtGD0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 733E620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbeK3Gjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:39:53 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:60142 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeK3Gjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 01:39:53 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 2693210C0EAC;
        Thu, 29 Nov 2018 11:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1543520003; bh=jeqFqmvTzs2KKfAPX/gAKdDetNQbT3cutvQn8368MOA=;
        h=From:To:CC:Subject:Date:References:From;
        b=DNHtGD0uaFshfEL2/dJq2xUUVuw0d1Yp0IRAxVUzIIYXEER6AMA0uqQ+JgbkXiML+
         XuJDvk8rA/8qgTafKdB8luvID8ePN0TC3R8HHs+ewI15J3IxNbL04FZVFuKAk3PdQE
         0XbsujkiQN80UsM8F0VkRu3xRiPxgwTefOxshIAUmZXrfzS+639wkiYjpPAAjnDdLH
         6be3JtXOCX9U9t887TZXG9+DYgOXUR0U6TdqEAD0EiFvMNCsZKi7MShsw9BLLkwSaR
         7SWxpf9LotssRH2Zz16qnUo5H+ZTOQCJFfcnovJSjx+gciSlTE5YU5qPDTwSBHjTE1
         iJlhcpHN/2Plw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 159C43E01;
        Thu, 29 Nov 2018 11:33:22 -0800 (PST)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by us01wehtc1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Thu,
 29 Nov 2018 11:33:22 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] ARC: change defconfig defaults to ARCv2
Thread-Topic: [PATCH] ARC: change defconfig defaults to ARCv2
Thread-Index: AQHUhp9+KPpwRKkuK0WKMdrVDoAasQ==
Date:   Thu, 29 Nov 2018 19:33:22 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230750146419E64@US01WEMBX2.internal.synopsys.com>
References: <20181127222045.18491-1-khilman@baylibre.com>
 <C2D7FE5348E1B147BCA15975FBA230750146419633@US01WEMBX2.internal.synopsys.com>
 <7h36rjae1i.fsf@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.104]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/18 11:18 AM, Kevin Hilman wrote:=0A=
> Hi Vineet,=0A=
>=0A=
> Vineet Gupta <vineet.gupta1@synopsys.com> writes:=0A=
>=0A=
>> On 11/27/18 2:21 PM, Kevin Hilman wrote:=0A=
>>> Change the default defconfig (used with 'make defconfig') to the ARCv2=
=0A=
>>> nsim_hs_defconfig, and also switch the default Kconfig ISA selection to=
=0A=
>>> ARCv2.=0A=
>>>=0A=
>>> This allows several default defconfigs (e.g. make defconfig, make=0A=
>>> allnoconfig, make tinyconfig) to all work with ARCv2 by default.=0A=
>>>=0A=
>>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>=0A=
>> Applied to for-curr=0A=
> If it's not too late, could you tag this for stable?=0A=
>=0A=
> Even though this is not technicall a regression, Greg said (in a=0A=
> different thread) he'd be willing to accept this for stable if it fixes=
=0A=
> the builders like kernelCI.=0A=
=0A=
Sure thing. But this change actually causes regression in our in-house test=
ing for=0A=
the arc700 defconfigs which falter due to missing CONFIG_ISA_ARCOMPACT whic=
h was=0A=
the default before. Alexey found this and will post a fixup whcih I plan to=
 squash=0A=
into ur patch to keep bisectability (and allow trivial stable backports) an=
d then=0A=
regen the relevant defconfigs.=0A=
=0A=
-Vineet=0A=
