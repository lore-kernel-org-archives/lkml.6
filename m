Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68665C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389472177E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jHHzwsNy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbfBOBXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 20:23:21 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56604 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfBOBXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 20:23:19 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1F1MO1U091281;
        Thu, 14 Feb 2019 19:22:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550193744;
        bh=XjzlX2bC7KXRONcdjanJeBenIejV+cVpZHDF5hguLkA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=jHHzwsNyfnCGiipE+rkocQNOdwFIPQSf1OW4KarIRDr/gSLEN6hGID3WthRWG9Wnd
         mdRsciEuV5HuucLR1Vxvg2I441b0NsbvBTQmQK0OQ0lYm5GE9O72PgncwdqNtUAcyT
         Snry14NMW0FEw0lOZE49XazryCPWEjdN1o68xv80=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1F1MOdc053970
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Feb 2019 19:22:24 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 14
 Feb 2019 19:22:24 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 14 Feb 2019 19:22:24 -0600
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1F1MN00002464;
        Thu, 14 Feb 2019 19:22:23 -0600
Subject: Re: [PATCH v2 01/14] dt-bindings: remoteproc: Add TI PRUSS bindings
To:     Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>
CC:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>,
        <david@lechnology.com>, <nsekhar@ti.com>, <t-kristo@ti.com>,
        <nsaulnier@ti.com>, <jreeder@ti.com>, <m-karicheri2@ti.com>,
        <woods.technical@gmail.com>, <linux-omap@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Robert Nelson <robertcnelson@gmail.com>, <dan@kulp.com>,
        Matthijs van Duin <matthijsvanduin@gmail.com>,
        Rob Herring <robh@kernel.org>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-2-git-send-email-rogerq@ti.com>
 <16001a6f-faed-ee14-5ade-79d5462f6d51@ti.com> <5C654C39.2030308@ti.com>
 <20190214155640.GD5720@atomide.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <3386fca7-73dd-db69-e179-bb90681cf28c@ti.com>
Date:   Thu, 14 Feb 2019 19:22:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214155640.GD5720@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 2/14/19 9:56 AM, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [190214 11:09]:
>> Suman is mainly concerned about the following changes in v2
>> 1) pruss node does not contain reg property representing entire ICSS.
>> 2) pruss node does not contain interrupts.
>>
>> Both of these are required if drivers/uio/uio_pruss.c or in future if
>> VFIO is to be used.
>>
>> The beagleboard community is a primary user of this driver and we need to
>> find a solution so that PRUSS is usable either via remoteproc or via UIO.
>>
>> Ideal case should allow user to use either of the drivers by just doing
>> a unbind and bind.
>>
>> I don't have a better idea than having a encapsulating node that has
>> the appropriate reg and interrupt properties.
> 
> If there are existing use cases that need to be supported
> you should list them as non-standard usage in the binding
> and not recommended for future use. Rob may have some
> comments on how to deal with this.
> 
> Then you can have device driver that needs to pass them
> parse them from the PRUSS parent node. That does not mean
> there needs to be a top level device driver for PRUSS,
> the child control module can just parse the non-standard
> bindings for compability from the parent node.

The PRUSS SoC bus driver was handling all possible architectures (OMAP,
K2 and K3) which have different clocking and reset integration, and also
catering to the UIO vs remoteproc usecases, by taking care of clocks and
resets. I am ok to replace this layer with the ti-sysc layer on OMAP
SoCs since most of the functionality added to the driver is associated
with OCP, but we would still need a PRUSS driver.

Not all sub-modules are peripherals and managed by respective peripheral
drivers, and we still need a central entity managing the sub-system wide
resources. Layering wise - it is similar if we would have done a device
for the PRUSS local interconnect, but that driver wouldn't have much to
do with interconnect functionality. K2 and K3 families uses TI-SCI and
so you don't have a similar target-module concept that allows you to
query the PRUSS parent node for PRUSS specific ranges or properties.
In anycase, I don't think these drivers should depend on a parent
interconnect driver.

regards
Suman


> 
> And naturally in addition to handling the non-standard
> binding we need to have a proper standardized binding
> too :)
> 
> Regards,
> 
> Tony
> 

