Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C25BECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E7112146E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7112146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389531AbeIUOzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 10:55:21 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35498 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbeIUOzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 10:55:21 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id W4ueZbSjZezx; Fri, 21 Sep 2018 11:07:25 +0200 (CEST)
Received: from nazgul.tnic (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 60DFE1EC0118;
        Fri, 21 Sep 2018 11:07:25 +0200 (CEST)
Date:   Fri, 21 Sep 2018 11:07:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Manish Narani <MNARANI@xilinx.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 2/7] edac: synps: Add platform specific structures for
 ddrc controller
Message-ID: <20180921090721.GB30439@nazgul.tnic>
References: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
 <1537194305-9243-3-git-send-email-manish.narani@xilinx.com>
 <20180918075522.GC22202@nazgul.tnic>
 <DM6PR02MB5227F5B1B329C903BA64A27CC11C0@DM6PR02MB5227.namprd02.prod.outlook.com>
 <20180919111553.GA9140@nazgul.tnic>
 <DM6PR02MB52279753E7FD04587393DC08C11C0@DM6PR02MB5227.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM6PR02MB52279753E7FD04587393DC08C11C0@DM6PR02MB5227.namprd02.prod.outlook.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 01:33:58PM +0000, Manish Narani wrote:
> Apart from this one, I have covered all the comments from the previous review.

Are you sure?

Let's see. I said:

| Kill all that "function pointer" fluff. Here's how I've changed it:
| 
| /**
|  * struct synps_platform_data -  synps platform data structure
|  * @edac_geterror_info: edac error info
|  * @edac_get_mtype:     get mtype
|  * @edac_get_dtype:     get dtype
|  * @edac_get_eccstate:  get ECC state
			  ^^^^^^^^^^^^^

This is supposed to denote that this function returns whether ECC
checking is enabled on the controller or not.

Your patch has:

+ * struct synps_platform_data -  synps platform data structure.
+ * @geterror_info:     Get error info.
+ * @get_mtype:         Get mtype.
+ * @get_dtype:         Get dtype.
+ * @get_eccstate:      Get eccstate.

So what is "eccstate"? Is it a struct or a variable or ...?

Do you see my point?

I know, it is a small thing but documenting our code properly is
something which people would be thanking us for. Even you will be
thanking yourself when you look at this months from now after having
forgotten it all.

Please check the rest of your additions for similar discrepancies.

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
