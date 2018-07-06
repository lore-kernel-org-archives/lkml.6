Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253C8C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE32216F9
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="P7l5/mQ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE32216F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934451AbeGFSZI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:25:08 -0400
Received: from vern.gendns.com ([206.190.152.46]:51381 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934063AbeGFSZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RMtQTwh//6DcfnrYxmwbuxVtwtOZnRoec+DcqOqEI0o=; b=P7l5/mQ8u95z0x71lE86gWskVN
        8nW1KPhNVs1ZoS3WAf97e3SdRBsoOLk41U5mSlSO0EakEODjCLyelsuAua9EGRyjMalMzvgfx7XRW
        puMKvUxoMlS1tU+QY4Otv5WKUEwdMvR0F1YsgSHBALi39gMWY2Yej49FJAPirlYoYaOediPQ6jPkv
        bXFl7ecH+etN+Ppgjg0CZbsLVfklMvmIWT4k5P+5O5bbtEf1xy3VJtf8MtX0Jvno/Sar7YSCH3cjh
        Pzc9lejHqoViMQdZ/nVcMOcJ0P6V/UQnzO0fasMVPHirPK9QcdtK16DxE2unzEOWY/mzwF37z/hVz
        F6VZsvKQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:37158 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fbVPj-00BV1v-Ti; Fri, 06 Jul 2018 14:25:04 -0400
Subject: Re: [v7,03/10] docs: Add Generic Counter interface documentation
To:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>
References: <7606bdc53c26c332b2bbff0f865380fb0e874b56.1529607879.git.vilhelm.gray@gmail.com>
 <b7c690eb-274e-3377-cf8a-2f9ab836677e@lechnology.com>
 <20180703141620.GB14958@sophia>
 <CACRpkdbq1ued8gA-zcJYtK2jYJyMbuSkvinCvuoz_VGU=i+1nQ@mail.gmail.com>
 <20180706181537.00006916@huawei.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <9e610ccd-bf2c-f20e-c562-b316e880a5d4@lechnology.com>
Date:   Fri, 6 Jul 2018 13:25:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180706181537.00006916@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2018 12:15 PM, Jonathan Cameron wrote:
> On Wed, 4 Jul 2018 19:23:26 +0200
> Linus Walleij <linus.walleij@linaro.org> wrote:
> 
>> On Tue, Jul 3, 2018 at 4:16 PM William Breathitt Gray
>> <vilhelm.gray@gmail.com> wrote:
>>> On Mon, Jul 02, 2018 at 02:37:53PM -0500, David Lechner wrote:
>>>> On 06/21/2018 04:07 PM, William Breathitt Gray wrote:
>>>>> +Userspace Interface
>>>>> +===================
>>>>> +
>>>>> +Several sysfs attributes are generated by the Generic Counter interface,
>>>>> +and reside under the /sys/bus/counter/devices/counterX directory, where
>>>>> +counterX refers to the respective counter device. Please see
>>>>> +Documentation/ABI/testing/sys-bus-counter-generic-sysfs for detailed
>>>>> +information on each Generic Counter interface sysfs attribute.
>>>>> +
>>>>> +Through these sysfs attributes, programs and scripts may interact with
>>>>> +the Generic Counter paradigm Counts, Signals, and Synapses of respective
>>>>> +counter devices.
>>>>> +
>>>>
>>>> Have you considered a character device in addition to the sysfs interface?
>>>>
>>>> I basically have many of the same concerns that resulted in a char dev for
>>>> gpio[1].
>>>>
>>>> - With sysfs, you *can* technically poll for events, but then you have to
>>>>    seek and read or re-open the file.
> 
> For this to be relevant we need some type of self clocking sampling of a counter,
> so far this hasn't really been true for William's devices - they tend to have
> internal monitoring and you just 'ask' them when you want to know the rotation.
> Sure if we have 'events' such as soft limit switches in the hardware, then
> we'd want some sort of event chrdev (personally I think these should be separate
> from the main data flow - but that's a detail).
> 
>>>> - File permissions are annoying if you want a non root user to be able to
>>>>    use the device.
> 
> They aren't a whole lot different for a chrdev.  In both cases you can allow
> a non root user write access if you want to.
> 
>>>> - A single program can't claim exclusive access to a device.
> 
> Agreed.  Though that only matters for control, why do you care if someone
> else can read.  In IIO we get around this by 'generally' blocking settings
> changes that will a process that is sampling data via the chrdev.
> It's not a hard and fast rule though.  I really don't like configuration
> via chrdevs as for complex devices you end up with a non self describing
> interface with a lot of complexity.
> 
> The exceptions are things like the media controller frameworks, but they
> are very very heavyweight for an simple devices like counters.
> 
>>>> - There is no automatic cleanup if a userspace program accessing the device
>>>>     crashes.
> 
> For these devices, the question is what sort of cleanup makes sense?
> 
> Often they are freerunning so the most you could do is power down if you knew
> no one cared, but for an encoder you may well want to continue tracking even
> if no one is looking right now.
> 
> I can think of reasons you 'might' want to tidy up, but we'd need real
> driver code to show the necessity of this one.
> 
>>>>
>>>> [1]: https://www.elinux.org/images/7/74/Elce2017_new_GPIO_interface.pdf
>>>
>>> Those look like good technical reasons for implementing a character
>>> device for the Generic Counter interface. I chose to implement the sysfs
>>> interface because I was using the IIO code as a reference, but I
>>> personally don't have much opposition to a character device in addition.
>>
>> IIO is also using a character device for outputting events and sensor
>> data. In IIO sysfs is only used for configuring what events and
>> data should come out of the character device.
> 
> Yes, with the addition that we typically provide data readback as well.
> For some simple devices which are slow and are actually polled to get
> a reading, there is not a lot of point in implementing the chrdev route
> so in IIO it is optional.
>>
>>> I'd like to get Jonathan's opinion on this as well if possible -- I
>>> vaguely recall us considering this option briefly last year when the
>>> Generic Counter interface was still in its beginnings. I've CC'd Linus
>>> Walleij as well for input as the GPIO maintainer.
> 
> I'm not against it, but I do want to see use cases that are not
> satisfied by sysfs first.
> 
> So far we've no seen them but sounds like you might have one David!
> 

Basically, we are implementing a counter in the PRU on TI Sitara, so
we can make it do just about whatever we want. Although, I'm trying to
keep it similar to the eQEP.

