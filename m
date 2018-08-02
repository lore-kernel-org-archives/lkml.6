Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC694C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 907552159F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Wzeqpi1S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 907552159F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732379AbeHBXvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:51:07 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:57718 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731311AbeHBXvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:51:07 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 2B64624E114E;
        Thu,  2 Aug 2018 14:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1533247083; bh=i/0Z9PWppazdGH0LswE3E+xcVjn8uhGDoGX3irYTElE=;
        h=From:To:CC:Subject:Date:References:From;
        b=Wzeqpi1S1mpVBITkQYrFGfq/sQVj71EolBcL4dE3hweBFKLDLF9mGXqq86P0oFsNf
         enge7YPAr2C5zOH83YvCBrqlDMokzGQjokXH/oFpN0SaDW4DLa+UAaXJrZstTK5pZM
         rdqdLqmJZJJj7WrprO9143/WqPv3nC4GlOIDlOui0ieWIkqTvp/bgprM+YPybF+aq6
         5CkMQUKDt9B+qjwUS9NBJpUxN+ssFiS3XsENxXeUX7zXNCrd5+X2qovgOA2rpv1q1N
         xO82dQXRDWtNXYHF/v84n1ZMV0XSSzdzPhsJLjYUTRdBqqmUDzrlxPY6VtWGmz20Ff
         J5Eaymz4/M3lg==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 14AC35AC7;
        Thu,  2 Aug 2018 14:58:03 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 us01wehtc1.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Thu, 2
 Aug 2018 14:58:02 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] ARC: AXS10x/HSDK: Allow U-Boot to pass MAC-address to
 the kernel
Thread-Topic: [PATCH] ARC: AXS10x/HSDK: Allow U-Boot to pass MAC-address to
 the kernel
Thread-Index: AQHUKkpVkbG0NJVU9ECvTFZ36touEQ==
Date:   Thu, 2 Aug 2018 21:58:02 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B089D74@us01wembx1.internal.synopsys.com>
References: <20180802101937.6202-1-abrodkin@synopsys.com>
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

On 08/02/2018 03:19 AM, Alexey Brodkin wrote:=0A=
> Otherwise kernel uses random MAC which is not very conveniet.=0A=
=0A=
Curious what exactly is the issue - why does the user care what MAC is assi=
gned ?=0A=
=0A=
> With that change in place use might set desired MAC in U-Boot=0A=
> with "setenv ethaddr 11:22:33:44:55:66", save environment and=0A=
> then from boot to boot the same MAC will be used by the kernel.=0A=
>=0A=
=0A=
And what if one is running without uboot - it will resort to all zeros vs. =
random=0A=
yet working MAC ?=0A=
=0A=
=0A=
