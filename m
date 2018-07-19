Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52ABC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8228B20661
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+0WfAj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8228B20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731866AbeGSQac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:30:32 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33863 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731570AbeGSQac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:30:32 -0400
Received: by mail-oi0-f65.google.com with SMTP id 13-v6so15860103ois.1;
        Thu, 19 Jul 2018 08:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OvumWTtxn2XMugUW0CE141REBO4t5geQsXiJFiPMp0o=;
        b=V+0WfAj5dz08QbvjiwUQVqCGpF5eFS7s4k1qI+v1om5DfV/daqyh16dPGkv6Zt8Ut8
         RLoSskvMU+yzDeOgAZoi/9Ns8sOJIoFgAq3kUugv6WzLQ3wh6w6BPw8h/xEWz6buF/WC
         /bMsoGKPhTrIamxhM5nrW6+c/hgIjwIorp0oPAJCd9Szf2VoGjqfs/dgSYki1FCxe0dG
         v/25D9Logm9Lx7o/h1yFLouzrClhPDIoP296j7k/QMh0iP9PiTh/fm72SbDhXmRFQ4XL
         5O37fZ32IaQPfllIozaAb8vvtNGLO5forz2CRQItfKPdBdDwi0+uH7Vt2gT3aD+I/3Mu
         IK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OvumWTtxn2XMugUW0CE141REBO4t5geQsXiJFiPMp0o=;
        b=QRJAQHHy8rUSR50hmcEtHrH3I/BZhYh/DSeVqxM9Hees+UmIrLg/7YU1EzEprsY3GJ
         /zMfzBkx0OZMwYKcJ9CiDPi1OitISuXbTKhLnmltAnB3+dMuAEm8jD+W9Kt6kEkfa3E7
         +v970lRqv9DANBrnb76hunU+/ukrflthgeBlhV8vjBLtemEtflB7o3zEz1ReKIqPQJXK
         iaU+8BTL9ZThkqAgRT63vHFkG+M+crS8dJVTyJFakzoPZzZy04zoDz5kbgHMBJVAwQm0
         LZFx5Wxmto9PM4vgXm8bQgtU+KVEvv83gqBA2QmhRyIIXQVAyGmmYc+Y2XTzIWTsEXvT
         qTBA==
X-Gm-Message-State: AOUpUlHo5yElPvtemUyN/0XoBXZ/qhhGZcBmkwpkB7oHTJYUpBsab5U4
        pCxmsIF7qRlu2D8TyuZEnWM=
X-Google-Smtp-Source: AAOMgpeHFGSckz3hV7u2MiSy0uby0Gzd5AElDOIh7XiSLfhgNIazujO88aVtqKkeTnoC9tR1VoLcww==
X-Received: by 2002:aca:3357:: with SMTP id z84-v6mr12191882oiz.49.1532015205677;
        Thu, 19 Jul 2018 08:46:45 -0700 (PDT)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id w204-v6sm11866974oif.2.2018.07.19.08.46.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 08:46:44 -0700 (PDT)
From:   "Alex G." <mr.nuke.me@gmail.com>
Subject: Re: [PATCH v3] PCI: Check for PCIe downtraining conditions
To:     Bjorn Helgaas <helgaas@kernel.org>, Alex_Gagniuc@Dellteam.com
Cc:     bhelgaas@google.com, Austin.Bolen@dell.com, Shyam.Iyer@dell.com,
        keith.busch@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, jeffrey.t.kirsher@intel.com,
        ariel.elior@cavium.com, michael.chan@broadcom.com,
        ganeshgr@chelsio.com, tariqt@mellanox.com,
        jakub.kicinski@netronome.com, talgi@mellanox.com,
        airlied@gmail.com, alexander.deucher@amd.com,
        Mike Marciniszyn <mike.marciniszyn@intel.com>
References: <20180604155523.14906-1-mr.nuke.me@gmail.com>
 <20180716211706.GB12391@bhelgaas-glaptop.roam.corp.google.com>
 <97a70a71e1034bafbcabc6c4e23577c0@ausx13mps321.AMER.DELL.COM>
 <20180718215359.GG128988@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <8baf16fb-7e7c-ec59-19ef-a709e164dc94@gmail.com>
Date:   Thu, 19 Jul 2018 10:46:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180718215359.GG128988@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/18/2018 04:53 PM, Bjorn Helgaas wrote:
> [+cc Mike (hfi1)]
> 
> On Mon, Jul 16, 2018 at 10:28:35PM +0000, Alex_Gagniuc@Dellteam.com wrote:
>> On 7/16/2018 4:17 PM, Bjorn Helgaas wrote:
>>>> ...
>>>> The easiest way to detect this is with pcie_print_link_status(),
>>>> since the bottleneck is usually the link that is downtrained. It's not
>>>> a perfect solution, but it works extremely well in most cases.
>>>
>>> This is an interesting idea.  I have two concerns:
>>>
>>> Some drivers already do this on their own, and we probably don't want
>>> duplicate output for those devices.  In most cases (ixgbe and mlx* are
>>> exceptions), the drivers do this unconditionally so we *could* remove
>>> it from the driver if we add it to the core.  The dmesg order would
>>> change, and the message wouldn't be associated with the driver as it
>>> now is.
>>
>> Oh, there are only 8 users of that. Even I could patch up the drivers to
>> remove the call, assuming we reach agreement about this change.
>>
>>> Also, I think some of the GPU devices might come up at a lower speed,
>>> then download firmware, then reset the device so it comes up at a
>>> higher speed.  I think this patch will make us complain about about
>>> the low initial speed, which might confuse users.
>>
>> I spoke to one of the PCIe spec writers. It's allowable for a device to
>> downtrain speed or width. It would also be extremely dumb to downtrain
>> with the intent to re-train at a higher speed later, but it's possible
>> devices do dumb stuff like that. That's why it's an informational
>> message, instead of a warning.
> 
> FWIW, here's some of the discussion related to hfi1 from [1]:
> 
>    > Btw, why is the driver configuring the PCIe link speed?  Isn't
>    > this something we should be handling in the PCI core?
> 
>    The device comes out of reset at the 5GT/s speed. The driver
>    downloads device firmware, programs PCIe registers, and co-ordinates
>    the transition to 8GT/s.
> 
>    This recipe is device specific and is therefore implemented in the
>    hfi1 driver built on top of PCI core functions and macros.
> 
> Also several DRM drivers seem to do this (see ),
> si_pcie_gen3_enable()); from [2]:
> 
>    My understanding was that some platfoms only bring up the link in gen 1
>    mode for compatibility reasons.
> 
> [1] https://lkml.kernel.org/r/32E1700B9017364D9B60AED9960492BC627FF54C@fmsmsx120.amr.corp.intel.com
> [2] https://lkml.kernel.org/r/BN6PR12MB1809BD30AA5B890C054F9832F7B50@BN6PR12MB1809.namprd12.prod.outlook.com

Downtraining a link "for compatibility reasons" is one of those dumb 
things that devices do. I'm SURPRISED AMD HW does it, although it is 
perfectly permissible by PCIe spec.

>> Another case: Some devices (lower-end GPUs) use silicon (and marketing)
>> that advertises x16, but they're only routed for x8. I'm okay with
>> seeing an informational message in this case. In fact, I didn't know
>> that my Quadro card for three years is only wired for x8 until I was
>> testing this patch.
> 
> Yeah, it's probably OK.  I don't want bug reports from people who
> think something's broken when it's really just a hardware limitation
> of their system.  But hopefully the message is not alarming.

It looks fairly innocent:

[    0.749415] pci 0000:18:00.0: 4.000 Gb/s available PCIe bandwidth, 
limited by 5 GT/s x1 link at 0000:17:03.0 (capable of 15.752 Gb/s with 8 
GT/s x2 link)

>>> So I'm not sure whether it's better to do this in the core for all
>>> devices, or if we should just add it to the high-performance drivers
>>> that really care.
>>
>> You're thinking "do I really need that bandwidth" because I'm using a
>> function called "_bandwidth_". The point of the change is very far from
>> that: it is to help in system troubleshooting by detecting downtraining
>> conditions.
> 
> I'm not sure what you think I'm thinking :)  My question is whether
> it's worthwhile to print this extra information for *every* PCIe
> device, given that your use case is the tiny percentage of broken
> systems.

I think this information is a lot more useful than a bunch of other info 
that's printed. Is "type 00 class 0x088000" more valuable? What about 
"reg 0x20: [mem 0x9d950000-0x9d95ffff 64bit pref]", which is also 
available under /proc/iomem for those curious?

> If we only printed the info in the "bw_avail < bw_cap" case, i.e.,
> when the device is capable of more than it's getting, that would make
> a lot of sense to me.  The normal case line is more questionable.  I
> think the reason that's there is because the network drivers are very
> performance sensitive and like to see that info all the time.

I agree that can be an acceptable compromise.

> Maybe we need something like this:
> 
>    pcie_print_link_status(struct pci_dev *dev, int verbose)
>    {
>      ...
>      if (bw_avail >= bw_cap) {
>        if (verbose)
>          pci_info(dev, "... available PCIe bandwidth ...");
>      } else
>        pci_info(dev, "... available PCIe bandwidth, limited by ...");
>    }
> 
> So the core could print only the potential problems with:
> 
>    pcie_print_link_status(dev, 0);
> 
> and drivers that really care even if there's no problem could do:
> 
>    pcie_print_link_status(dev, 1);

Sounds good. I'll try to push out updated PATCH early next week.

>>>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>> [snip]
>>>> +	/* Look from the device up to avoid downstream ports with no devices. */
>>>> +	if ((pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT) &&
>>>> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_LEG_END) &&
>>>> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM))
>>>> +		return;
>>>
>>> Do we care about Upstream Ports here?
>>
>> YES! Switches. e.g. an x16 switch with 4x downstream ports could
>> downtrain at 8x and 4x, and we'd never catch it.
> 
> OK, I think I see your point: if the upstream port *could* do 16x but
> only trains to 4x, and two endpoints below it are both capable of 4x,
> the endpoints *think* they're happy but in fact they have to share 4x
> when they could use more.
> 
> Bjorn
> 
