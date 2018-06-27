Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC59C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298A121A95
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="szkgdy8o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 298A121A95
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965767AbeF0U7T (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 16:59:19 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:45016 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965335AbeF0U7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 16:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=l2GkuqEgNvIGjnj3g906AoMr4IBlb3+Zyy5DWqyyRbc=; b=szkgdy8ouwPQmr51eQRQ9XouGY
        8sQ94kI5mL4dPlAnbFRziiT8HUCvw9ocjSpHWDzAt8gzOh8uX5AN/MctbCbDs4j3erncEy7btmSon
        K8Yia50mXndZhs3whkgL+N4BtfgRX1Am4Gneibr1PjGvjnQ6xc1SmlUvQOOvdkG7xh5FtbNmp1eLV
        eg8iVcgAqZBspcNpugNV98R/A76X/3pOH566ZP0GmMVYUU1nxsVKHlMfowSSWKAc25XhnT74Cxt48
        /0lFmVcaOnacQsKELeRlrVRJuqXqm6QFt4+0zUfliflCLcnPJeSHa9a1MGtoED9HQvhTQ8F6jrOXF
        O3yuu5Yw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:39318 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fYHX2-001d6P-K8; Wed, 27 Jun 2018 20:59:17 +0000
Date:   Wed, 27 Jun 2018 13:59:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc:     Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
        "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
        Michal Simek <monstr@monstr.eu>,
        "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        Alistair Francis <alistair@alistair23.me>,
        KONRAD Frederic <frederic.konrad@adacore.com>
Subject: Re: [Qemu-devel] Linux kernel configurations for various Microblaze
 systems
Message-ID: <20180627205915.GA22693@roeck-us.net>
References: <20180627185248.GA19743@roeck-us.net>
 <96809884-2f46-ed63-48fd-9fd4c5050e20@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96809884-2f46-ed63-48fd-9fd4c5050e20@amsat.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 05:01:34PM -0300, Philippe Mathieu-Daudé wrote:
> Hi Guenter,
> 
> On 06/27/2018 03:52 PM, Guenter Roeck wrote:
> > Hi,
> > 
> > I would like to add Microblaze "petalogix-ml605" and "xlnx-zynqmp-pmu"
> > to my list of qemu boot tests of upstream and stable release kernels.
> 
> Do you mind sharing your tests on this thread?
> 
Nothing secret about it. The test results are always available at
http://kerneltests.org/. The scripts are published at
https://github.com/groeck/linux-build-test. My qemu clone (I carry a few
patches on top of upstream qemu) is at https://github.com/groeck/qemu.

> "Who is running QEMU automated tests, and when?"
> http://lists.nongnu.org/archive/html/qemu-devel/2018-04/msg04695.html
> 
> > Unfortunately I have been unable to locate working kernel configurations
> > for the those systems, nor working qemu command lines. I found a few links,
> > but they are all dead.
> 
> I got more lucky using the Xilinx downstream code from:
> https://github.com/Xilinx
> 
> In particular using their downstream DeviceTree:
> 
> https://github.com/Xilinx/device-tree-xlnx
> 
> I also used those links:
> 
> http://www.wiki.xilinx.com/MicroBlaze
> http://www.wiki.xilinx.com/Build%20kernel
> 

AFAICS they are all generic, and don't reference specific boards
(other than maybe the possibility to configure those boards). There are
comments such as "start with mmu_defconfig and modify all parameters
which are special on your board". That is great, but trying to do that
for an evaluation board that I don't own and just try to get running
under qemu is a bit difficult since I don't really know what I am doing.

The best I was able to accomplish was to boot petalogix-ml605 without crash,
but with no console output either. I could try to debug further, but I don't
really want to waste my time.

Thanks,
Guenter
