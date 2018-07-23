Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F81BECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 23:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C6020854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 23:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bF1wc9uG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C6020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388207AbeGXBCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 21:02:48 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43722 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388149AbeGXBCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 21:02:48 -0400
Received: by mail-oi0-f68.google.com with SMTP id b15-v6so4352863oib.10;
        Mon, 23 Jul 2018 16:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6B0W1i/5jbXDWhxoT8qWghN0ElXeTNHHUpJgNkQcT7Y=;
        b=bF1wc9uGsNsGn7ac+4X96fB/wCwSBlXS2QqiF+yWViKV4n4Uu72mDo22vds34pR5i6
         Vqd5QPoAsx2VxQD36Q1amTztpHTiPowvOjMrsa0eoYyW/vR61Ls5qfGGlB0+TEWjAlWv
         5yz2UYOY+RUulfXoyWPkT+ZzfXKgHaitEcf+zzxGS30HvakCih9BY1eo55Lg+nUimxhF
         bKrfvRrw3dgnd7V4CSYYAYF+IVqXJOYdInu4Mrp7tQqNM2ANczfXUFONbh797tVJwfN/
         kJuMzwIawDT5gHnLR0vEZaFe8BrYcidD0wYL7M+SaNjOvNg/uuCcPgMTd7p4hnRzmYoI
         WHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6B0W1i/5jbXDWhxoT8qWghN0ElXeTNHHUpJgNkQcT7Y=;
        b=cN1G8cfqoCzMdiZ9aPLSffNfL02FsJ5ldw/jLVyTAlwZ0gB2xNYuHU1JrG8sOzXO5y
         H/9hJ512XasZhiqd9ejXpmc3qvrpuIfCsY7jvgGTT26H1U1ygViCvUyCfVjCgsaXbvg+
         rkO2smBWQZA/472Sx2MvwzBlSpbsz5JRSuXtbZPzJFvkSXmPZV++TgoRQ87FUUD7IEad
         18SUGrxpUNzzzzhfH7cD6ymm8v8uGpF+QnGu+vI4/junuzSyFuD+VbEVBwKz9xhNZLGs
         qDhzuSj04E2AtdTs5aws7e3Rwm3cd1/bagRvyh3goQvO5cBwJmWVKNvV8bSvUt7EOW3f
         Ltjg==
X-Gm-Message-State: AOUpUlFXakVIf1Mfw8N1ch8LCZdS/hS6Xlus6SRv8mRWEqeS72vjEijs
        Z94ZnVxETT8B8xxvwmpTes13ec34FCk=
X-Google-Smtp-Source: AAOMgpfUHab/dHGJE27BWkWKDxXZ/V9IVXlM4AjBmOTCsI802sNZmeNzSxPUx1D+hXEo86w0H6CI3Q==
X-Received: by 2002:aca:2c3:: with SMTP id 186-v6mr889964oic.85.1532390348766;
        Mon, 23 Jul 2018 16:59:08 -0700 (PDT)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id 1-v6sm6851127oir.19.2018.07.23.16.59.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 16:59:07 -0700 (PDT)
Subject: Re: [PATCH v5] PCI: Check for PCIe downtraining conditions
To:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Tal Gilboa <talgi@mellanox.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "alex_gagniuc@dellteam.com" <alex_gagniuc@dellteam.com>,
        "austin_bolen@dell.com" <austin_bolen@dell.com>,
        "shyam_iyer@dell.com" <shyam_iyer@dell.com>,
        "jeffrey.t.kirsher@intel.com" <jeffrey.t.kirsher@intel.com>,
        "ariel.elior@cavium.com" <ariel.elior@cavium.com>,
        "michael.chan@broadcom.com" <michael.chan@broadcom.com>,
        "ganeshgr@chelsio.com" <ganeshgr@chelsio.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "mike.marciniszyn@intel.com" <mike.marciniszyn@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180718215359.GG128988@bhelgaas-glaptop.roam.corp.google.com>
 <20180723200339.23943-1-mr.nuke.me@gmail.com>
 <20180723140143.1a46902f@cakuba.netronome.com>
 <b9a6b3b8-56cf-8bb5-2568-071ccd8a4f28@mellanox.com>
 <20180723151439.50524a2a@cakuba.netronome.com>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <2bb6e96c-a48d-62ea-90a3-ec978536372f@gmail.com>
Date:   Mon, 23 Jul 2018 18:59:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180723151439.50524a2a@cakuba.netronome.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/23/2018 05:14 PM, Jakub Kicinski wrote:
> On Tue, 24 Jul 2018 00:52:22 +0300, Tal Gilboa wrote:
>> On 7/24/2018 12:01 AM, Jakub Kicinski wrote:
>>> On Mon, 23 Jul 2018 15:03:38 -0500, Alexandru Gagniuc wrote:
>>>> PCIe downtraining happens when both the device and PCIe port are
>>>> capable of a larger bus width or higher speed than negotiated.
>>>> Downtraining might be indicative of other problems in the system, and
>>>> identifying this from userspace is neither intuitive, nor
>>>> straightforward.
>>>>
>>>> The easiest way to detect this is with pcie_print_link_status(),
>>>> since the bottleneck is usually the link that is downtrained. It's not
>>>> a perfect solution, but it works extremely well in most cases.
>>>>
>>>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>>>> ---
>>>>
>>>> For the sake of review, I've created a __pcie_print_link_status() which
>>>> takes a 'verbose' argument. If we agree want to go this route, and update
>>>> the users of pcie_print_link_status(), I can split this up in two patches.
>>>> I prefer just printing this information in the core functions, and letting
>>>> drivers not have to worry about this. Though there seems to be strong for
>>>> not going that route, so here it goes:
>>>
>>> FWIW the networking drivers print PCIe BW because sometimes the network
>>> bandwidth is simply over-provisioned on multi port cards, e.g. 80Gbps
>>> card on a x8 link.
>>>
>>> Sorry to bike shed, but currently the networking cards print the info
>>> during probe.  Would it make sense to move your message closer to probe
>>> time?  Rather than when device is added.  If driver structure is
>>> available, we could also consider adding a boolean to struct pci_driver
>>> to indicate if driver wants the verbose message?  This way we avoid
>>> duplicated prints.
>>>
>>> I have no objection to current patch, it LGTM.  Just a thought.
>>
>> I don't see the reason for having two functions. What's the problem with
>> adding the verbose argument to the original function?
> 
> IMHO it's reasonable to keep the default parameter to what 90% of users
> want by a means on a wrapper.  The non-verbose output is provided by
> the core already for all devices.
> 
> What do you think of my proposal above Tal?  That would make the extra
> wrapper unnecessary since the verbose parameter would be part of the
> driver structure, and it would avoid the duplicated output.

I see how it might make sense to add another member to the driver 
struct, but is it worth the extra learning curve? It seems to be 
something with the potential to confuse new driver developers, and 
having a very marginal benefit.
Although, if that's what people want...

Alex
