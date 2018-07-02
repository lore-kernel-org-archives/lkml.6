Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7585C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F9E82420B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tfUqwo1q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F9E82420B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752326AbeGBOwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:52:49 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:46629 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752212AbeGBOwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:52:45 -0400
Received: by mail-oi0-f66.google.com with SMTP id y207-v6so16861928oie.13;
        Mon, 02 Jul 2018 07:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I13/BlNC/o+VsqHPJZp8KfQ1jbCdy+NFhBXhITiy+4s=;
        b=tfUqwo1qz16H2s3BMkhe15WP2foPdR7F5YKBX57J2SPDlhvqKTKsj1g7sXnQ8hGDRz
         8QK0XvulUl9ghRcqdvQFEiMYxC87vCPM033IJMpMFahH14+Ph9LAxcAmkapRcB7L7ec3
         HzMnN5cZQEMiQ/S4vefNkEoKEj6pgKo5UjUaM2LJWSdUtkzWHYpam8PzUGyszPNpaYB1
         5x1u/qv39BqpQhcwjXolQQoIILQ4x3lwId5bjJ4R3j0QoJkQ6fPVqB5Sh3MIx3j5OS/B
         hs7bdnDvjO25CUcofFZgCLvWYHczVqvua9coGPgVF8t5eS4SLa0EhjiMxtWMi9J5VClM
         kW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I13/BlNC/o+VsqHPJZp8KfQ1jbCdy+NFhBXhITiy+4s=;
        b=mXEOqK8bpiuhB22/vR9v/P4DZAHVx1piqUi1xnMbjQ5D/HvNTNqOqWcZ52WgWvaMkr
         d+8YwyE8rDBk75SdRaDBgCpDLeAj395UR1gvp2QKLHR5uJCWhdd4raY9AMbog9DVWX+/
         sg3eBN9Vbgh5B7EUH5KfIeDISQ6YmPryRYDOb4w2V1EFrzUGuP0WzbrBOZv5LWBWqR1j
         jZtXNdFZZRDClyg9RnFbXwwP5+8YyOdYuRNWIg/M9GpnNbiE+YSY7bkOYKwPV3HO9Fxb
         CVukOSlzaF3Wsr6qFl5ZFw1wKG+ZioMgQuVFWYecuiUeQ73BV0ZzLg75mSXPcvZzjJqQ
         m+lA==
X-Gm-Message-State: APt69E0TISwYkfME9ACxVhbZcU0ojClLHMpmnq/X60Mkn6iEifJqq8VC
        pwRYSQofgQZFHtqqH1t76fI=
X-Google-Smtp-Source: AAOMgpfkZrry28JBqlwk2nhcabpiu2cldQkA0ekLiJXPf67mG2r3EDm4WdhjIT4HutDTYynBWjZnGw==
X-Received: by 2002:aca:b1c1:: with SMTP id a184-v6mr4390412oif.182.1530543163399;
        Mon, 02 Jul 2018 07:52:43 -0700 (PDT)
Received: from nuclearis2_1.gtech (c-98-201-114-184.hsd1.tx.comcast.net. [98.201.114.184])
        by smtp.gmail.com with ESMTPSA id h124-v6sm343230oif.15.2018.07.02.07.52.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 07:52:42 -0700 (PDT)
Subject: Re: [PATCH v2] PCI/AER: Fix aerdrv loading with "pcie_ports=native"
 parameter
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, keith.busch@intel.com,
        alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, Frederick Lawler <fred@fredlawl.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
References: <20180619195835.5423-1-mr.nuke.me@gmail.com>
 <20180630213140.GG9547@bhelgaas-glaptop.roam.corp.google.com>
 <fdc547c3-e4f7-4967-7216-9379e6d28139@gmail.com>
 <20180702131645.GA15983@bhelgaas-glaptop.roam.corp.google.com>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <225720dd-d1d7-ab4a-6103-ff32b88cc9c2@gmail.com>
Date:   Mon, 2 Jul 2018 09:52:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180702131645.GA15983@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/02/2018 08:16 AM, Bjorn Helgaas wrote:
> On Sat, Jun 30, 2018 at 11:39:00PM -0500, Alex G wrote:
>> On 06/30/2018 04:31 PM, Bjorn Helgaas wrote:
>>> [+cc Borislav, linux-acpi, since this involves APEI/HEST]
>>
>> Borislav is not the relevant maintainer here, since we're not contingent on
>> APEI handling. I think Keith has a lot more experience with this part of the
>> kernel.
> 
> Thanks for adding Keith.
> 
>>> On Tue, Jun 19, 2018 at 02:58:20PM -0500, Alexandru Gagniuc wrote:
>>>> According to the documentation, "pcie_ports=native", linux should use
>>>> native AER and DPC services. While that is true for the _OSC method
>>>> parsing, this is not the only place that is checked. Should the HEST
>>>> table list PCIe ports as firmware-first, linux will not use native
>>>> services.
>>>
>>> Nothing in ACPI-land looks at pcie_ports_native.  How should ACPI
>>> things work in the "pcie_ports=native" case?  I guess we still have to
>>> expect to receive error records from the firmware, because it may
>>> certainly send us non-PCI errors (machine checks, etc) and maybe even
>>> some PCI errors (even if the Linux AER driver claims AER interrupts,
>>> we don't know what notification mechanisms the firmware may be using).
>>
>> I think ACPI land shouldn't care about this. We care about it from the PCIe
>> stand point at the interface with ACPI. FW might see a delta in the sense
>> that we request control of some features via _OSC, which we otherwise would
>> not do without pcie_ports=native.
>>
>>> I guess best-case, we'll get ACPI error records for all non-PCI
>>> things, and the Linux AER driver will see all the AER errors.
>>
>> It might affect FW's ability to catch errors, but that's dependent on the
>> root port implementation.
>>
>>> Worst-case, I don't really know what to expect.  Duplicate reporting
>>> of AER errors via firmware and Linux AER driver?  Some kind of
>>> confusion about who acknowledges and clears them?
>>
>> Once user enters pcie_ports=native, all bets are off: you broke the contract
>> you have with the FW -- whether or not you have this patch.
>>
>>> Out of curiosity, what is your use case for "pcie_ports=native"?
>>> Presumably there's something that works better when using it, and
>>> things work even *better* with this patch?
>>
>> Corectness. It bothers me that actual behavior does not match the
>> documentation:
>>
>>  native  Use native PCIe services associated with PCIe ports
>>                         unconditionally.
>>
>>
>>> I know people do use it, because I often see it mentioned in forums
>>> and bug reports, but I really don't expect it to work very well
>>> because we're ignoring the usage model the firmware is designed
>>> around.  My unproven suspicion is that most uses are in the black
>>> magic category of "there's a bug here, and we don't know how to fix
>>> it, but pcie_ports=native makes it work better".
>>
>> There exist cases that firmware didn't consider. I would not call them
>> "firmware bugs", but there are cases where the user understands the platform
>> better than firmware.
>> Example: on certain PCIe switches, a hardware PCIe error may bring the
>> switch downstream ports into a state where they stop notifying hotplug
>> events. Depending on the platform, firmware may or may not fix this
>> condition, but "pcie_ports=native" enables DPC. DPC contains the error
>> without the switch downstream port entering the weird error state in the
>> first place.
>>
>> All bets are off at this point.
> 
> If a user needs "pcie_ports=native", I claim that's a user experience
> problem, and the underlying cause is a hardware, firmware, or OS
> defect.
> 
> I have no doubt the situation you describe is real, but this doesn't
> make any progress toward resolving the user experience problem.  In
> fact, it propagates the folklore that using "pcie_ports=native" is an
> appropriate final solution.  It's fine as a temporary workaround while
> we figure out a better solution, but we need some mechanism for
> analyzing the problem and eventually removing the need to use
> "pcie_ports=native".

Speaking of user experience, I'd argue that it's a horrible experience
for the kernel to _not_ do what it is asked.

I'm going to go fix the little comment about the patch. I had the same
dilemma when I wrote it, but didn't find it too noteworthy. It makes
more sense now that you mentioned it.

Alex

> I have a minor comment on the patch, but I think it makes sense.  This
> might be a good time to resurrect Prarit's "taint-on-pci-parameters"
> patch.  If somebody uses "pcie_ports=native", I think it makes sense
> to taint the kernel both because (1) we broke the contract with the
> firmware and we don't really know what to expect, and (2) it's an
> opportunity to encourage the user to raise a bug report.
> 
> Bjorn
> 
