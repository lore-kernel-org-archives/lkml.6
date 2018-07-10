Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22505C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D49208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="M1WaHjLJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D49208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732673AbeGJTOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 15:14:47 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36998 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732502AbeGJTOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 15:14:47 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6AJE0Nq080691;
        Tue, 10 Jul 2018 14:14:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531250040;
        bh=SldqOA8lT+zRIGArWhumukQTJWXMCoY3ACqrkm6R+T8=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=M1WaHjLJK22aFHuZQ1LK13VHCZH0F8WLRvXvWlJHxbLaLFVOxNdBw4mxT29A3nRHI
         qQ/VkHOMuXXL8WIynVxbKkuwmRWQeBBqnqMfz1YXLF6RoBrWm3EM7HSPW9c1PLzARr
         XpS5BVXV4f4zrD2KzqRT5imtoNnrsfVTGHdKdHJM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6AJE0SG011710;
        Tue, 10 Jul 2018 14:14:00 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 10
 Jul 2018 14:14:00 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 10 Jul 2018 14:14:00 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6AJDusE025610;
        Tue, 10 Jul 2018 14:13:57 -0500
Subject: Re: [PATCH v2] driver core: Partially revert "driver core: correct
 device's shutdown order"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <8816662.k3KXbdkA2e@aspire.rjw.lan> <2927655.Y1qg3UnIrE@aspire.rjw.lan>
 <5284251.Resgjlja2Q@aspire.rjw.lan> <20180710125956.GA25343@kroah.com>
 <CAJZ5v0iV0ZaCbhoVOrGx08f6Y7Ei2q+qazxEMQRYD4LAq9LUbA@mail.gmail.com>
 <20180710154715.GA20793@kroah.com>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pingfan Liu <kernelfans@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Linux PM <linux-pm@vger.kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <a35d5f42-a89e-9614-e621-a3274475ef55@ti.com>
Date:   Wed, 11 Jul 2018 00:43:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180710154715.GA20793@kroah.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 10 July 2018 09:17 PM, Greg Kroah-Hartman wrote:
> On Tue, Jul 10, 2018 at 05:40:21PM +0200, Rafael J. Wysocki wrote:
>> On Tue, Jul 10, 2018 at 2:59 PM, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>>> On Tue, Jul 10, 2018 at 02:51:33PM +0200, Rafael J. Wysocki wrote:
>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>
>>>> Commit 52cdbdd49853 (driver core: correct device's shutdown order)
>>>> introduced a regression by breaking device shutdown on some systems.
>>>>
>>>> Namely, the devices_kset_move_last() call in really_probe() added by
>>>> that commit is a mistake as it may cause parents to follow children
>>>> in the devices_kset list which then causes shutdown to fail.  For
>>>> example, if a device has children before really_probe() is called
>>>> for it (which is not uncommon), that call will cause it to be
>>>> reordered after the children in the devices_kset list and the
>>>> ordering of that list will not reflect the correct device shutdown
>>>> order any more.
>>>>
>>>> Also it causes the devices_kset list to be constantly reordered
>>>> until all drivers have been probed which is totally pointless
>>>> overhead in the majority of cases and it only covered an issue
>>>> with system shutdown, while system-wide suspend/resume potentially
>>>> had the same issue on the affected platforms (which was not covered).
>>>>
>>>> Moreover, the shutdown issue originally addressed by the change in
>>>> really_probe() made by commit 52cdbdd49853 is not present in 4.18-rc
>>>> any more, since dra7 started to use the sdhci-omap driver which
>>>> doesn't disable any regulators during shutdown, so the really_probe()
>>>> part of commit 52cdbdd49853 can be safely reverted.  [The original
>>>> issue was related to the omap_hsmmc driver used by dra7 previously.]
>>>>
>>>> For the above reasons, revert the really_probe() modifications made
>>>> by commit 52cdbdd49853.
>>>>
>>>> The other code changes made by commit 52cdbdd49853 are useful and
>>>> they need not be reverted.
>>>>
>>>> Fixes: 52cdbdd49853 (driver core: correct device's shutdown order)
>>>> Link: https://lore.kernel.org/lkml/CAFgQCTt7VfqM=UyCnvNFxrSw8Z6cUtAi3HUwR4_xPAc03SgHjQ@mail.gmail.com/
>>>> Reported-by: Pingfan Liu <kernelfans@gmail.com>
>>>> Tested-by: Pingfan Liu <kernelfans@gmail.com>
>>>> Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>> ---
>>>>
>>>> -> v2: Added information from Kishon on the fact that it should be safe
>>>>        to revert the really_probe() modifications added by the
>>>>        problematic commit.  Also added the Reviewed-by tag from Kishon.
>>>
>>> Looks good to me, want me to queue it up in my tree, or are you going to
>>> send it on to Linus?
>>
>> Please queue it up.
>>
>>> And shouldn't this have a stable tag as well?
>>
>> That is sort of a gray area, because I think it may expose the
>> shutdown issue on dra7 in -stable, but technically it still fixes a
>> regression in the driver core.  So your call I suppose. :-)
> 
> Being bug compatible is key :)
> 
> I'll add a stable tag.

sure. If I see the issue in dra7, I'll send a stable fix in omap_hsmmmc driver.

Thanks
Kishon
