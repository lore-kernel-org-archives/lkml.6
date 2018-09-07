Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0A2C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB092075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=obeliks.de header.i=@obeliks.de header.b="cE+DtvO2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB092075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nospam.obeliks.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbeIGXu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 19:50:56 -0400
Received: from scopuli.esotechnik.de ([79.143.188.15]:56368 "EHLO
        mail.esotechnik.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeIGXu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 19:50:56 -0400
Received: by mail.esotechnik.net (Postfix) with ESMTPSA id 4B20AAE0B80;
        Fri,  7 Sep 2018 21:08:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=obeliks.de; s=jul2017;
        t=1536347315; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6lYFa4N5C0k1wO6SvIBdnBOHFiTQ1r0+eU5R9FcHBiA=;
        b=cE+DtvO2Umqay0t5vUHViTV8JfaF2Z7IXzjc/eBVqN+AFQih/guQt6BEmJ5/p+drxasrGT
        R9oCPlVWnZfXU+JD9m5IOcy0Ih3DsIZ1LvCnYM6VAYAo7rlssi9ChAIYpemJ4l+FTyJ1Yu
        B5tqmYNtoc7gLNl2dFLJHLMWXaILINlD0jOOp1DG33wex+ii/x/kVGwKARpdqfcXXhJt0x
        L0M2qjH/uV490tVx3HaSlgraFs4IEIz3PiKR6oEpuUDT0oalfjhyhJoCtgr/crgT8R4v3S
        A0hPGcwqvK/1JS3J5ASvT4c/I6+Y4fjTwKJAzd31mklCPDXbQugU9C4wyGXV5w==
Subject: Re: [PATCH v2 0/3] mtd concat device driver
To:     Bernhard Frauendienst <kernel@nospam.obeliks.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20180907173515.19990-1-kernel@nospam.obeliks.de>
 <20180907173515.19990-2-kernel@nospam.obeliks.de>
 <7ea0a54e-fc10-8e21-aa2f-864c40297369@nospam.obeliks.de>
From:   Bernhard Frauendienst <kernel@nospam.obeliks.de>
Message-ID: <828f1767-a937-b081-fe9a-447f5b9f0a3b@nospam.obeliks.de>
Date:   Fri, 7 Sep 2018 21:08:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7ea0a54e-fc10-8e21-aa2f-864c40297369@nospam.obeliks.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

it looks like I didn't even manage to correctly CC the device tree
maintainers and list, which was the main reason for sending out this
second roll. This is getting embarrassing, but I guess I will simply
prepare a 3rd roll and try even harder to send it to the right people
this time (without relying on any script magic).

Of course I'm happy to include any suggestions you have in the meantime.

Sorry for the disturbance!

Best regards,
Bernhard

Am 07.09.2018 um 20:12 schrieb Bernhard Frauendienst:
> Apologies, again, I seem not to be able to handle git-send-mail  > correctly, the cover letter got lost in operation (using 
get_maintainers > on a cover letter is not a good idea). Here it is 
again: > > > Hi everybody, > > when porting my router board from a 
mach-file based OpenWRT target to a > device-tree based target, I found 
that there is no generic way to create > a mtd_concat device from within 
the dts. The following patches attempt > to provide that possibility. > 
 > This is a second roll of that patch series, the first one can be seen 
at > [1]. Apologies for not including the correct recipients in the 
first > roll. > > In this first discussion, concerns were raised that a 
driver for a > "virtual" device like this might have no place in the 
device tree > system. However, I would argue that this very similar to 
specifying the > partitions of a mtd device, which can also done in the 
device tree. In > fact, I believe this is the only way to be able to 
specify the > partitions of such a concat device in the dts file (but 
I'm happy to be > corrected if I'm mistaken). > I have made the example 
in the dt-binding documentation a little bit > more expressive in this 
detail. > > In this second roll I have also addressed all issues that 
reviewers have > brought up so far, hopefully to their satisfaction. > > 
Best Regards > Bernhard > > [1] 
http://lists.infradead.org/pipermail/linux-mtd/2018-September/083832.html 
 > > > Bernhard Frauendienst (3): > mtd: core: add 
get_mtd_device_by_node > dt-bindings: add bindings for mtd-concat 
devices > mtd: mtdconcat: add dt driver for concat devices > > 
.../devicetree/bindings/mtd/mtd-concat.txt | 36 +++++ > 
drivers/mtd/Kconfig | 2 + > drivers/mtd/Makefile | 3 + > 
drivers/mtd/composite/Kconfig | 12 ++ > drivers/mtd/composite/Makefile | 
7 + > drivers/mtd/composite/virt_concat.c | 128 ++++++++++++++++++ > 
drivers/mtd/mtdcore.c | 38 ++++++ > include/linux/mtd/mtd.h | 2 + > 8 
files changed, 228 insertions(+) > create mode 100644 
Documentation/devicetree/bindings/mtd/mtd-concat.txt > create mode 
100644 drivers/mtd/composite/Kconfig > create mode 100644 
drivers/mtd/composite/Makefile > create mode 100644 
drivers/mtd/composite/virt_concat.c >

