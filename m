Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13299ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A095F2148C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A095F2148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbeIXNYR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 09:24:17 -0400
Received: from smtp.qindel.com ([89.140.90.34]:51358 "EHLO thor.qindel.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727159AbeIXNYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 09:24:16 -0400
X-Greylist: delayed 351 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Sep 2018 09:24:16 EDT
Received: from localhost (localhost [127.0.0.1])
        by thor.qindel.com (Postfix) with ESMTP id 6A33A60251;
        Mon, 24 Sep 2018 09:17:42 +0200 (CEST)
Received: from thor.qindel.com ([127.0.0.1])
        by localhost (thor.qindel.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id LoWae0bt2FBP; Mon, 24 Sep 2018 09:17:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by thor.qindel.com (Postfix) with ESMTP id 23A3360252;
        Mon, 24 Sep 2018 09:17:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at thor.qindel.com
Received: from thor.qindel.com ([127.0.0.1])
        by localhost (thor.qindel.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id V9HSIEDKz0JV; Mon, 24 Sep 2018 09:17:41 +0200 (CEST)
Received: from [172.26.9.84] (unknown [172.26.9.84])
        by thor.qindel.com (Postfix) with ESMTPSA id 67E0F60251;
        Mon, 24 Sep 2018 09:17:33 +0200 (CEST)
Subject: Re: [PATH 0/4] usbip: make vhci_hcd.* objects independent of
 vhci_hcd.0
To:     =?UTF-8?Q?Salvador_Fandi=c3=b1o?= <salvador@qindel.com>,
        Shuah Khan <shuahkh@osg.samsung.com>, shuah@kernel.org,
        Salvador Fandino <salva@qindel.com>, linux-usb@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valentina.manea.m@gmail.com,
        linux-kernel@vger.kernel.org
Newsgroups: gmane.linux.kernel,gmane.linux.usb.general
References: <20180130083630.26501-1-salva@qindel.com>
 <391a54d5-73ac-3bd5-49ca-114639ea69fd@kernel.org>
 <60da1c91-d6bf-1922-44c5-3b8010129cc4@qindel.com>
 <6f8af831-e7f8-787b-b1f9-465062aa7e8c@osg.samsung.com>
 <6395451b-d31c-0196-1f7a-39286972ea3f@qindel.com>
 <a939c16a-b503-2f5a-041b-0d6a34c44425@osg.samsung.com>
 <276685f9-e73d-26ae-b006-329a17bedd3a@qindel.com>
From:   Salvador Fandino <sfandino@gmail.com>
Message-ID: <0f28251a-3c59-ad63-379a-85b251365844@gmail.com>
Date:   Mon, 24 Sep 2018 09:17:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <276685f9-e73d-26ae-b006-329a17bedd3a@qindel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping!

In March, I submitted a patch-set to get USBIP to play nicely inside 
containers, but the discussion died after a couple of mails, I got 
abducted into some unrelated project and mostly forgot about it...

But now, I have some time available to put into this and would like to 
push it further.

So, can we pick the discussion up again?

Regards



On 03/08/2018 01:45 PM, Salvador Fandiño wrote:
> On 03/06/2018 09:58 PM, Shuah Khan wrote:
>> On 03/06/2018 01:35 AM, Salvador Fandiño wrote:
>>>
>>> On 03/06/2018 01:03 AM, Shuah Khan wrote:
>>>> On 03/05/2018 02:00 AM, Salvador Fandiño wrote:
>>>>> On 02/21/2018 01:35 AM, Shuah Khan wrote:
>>>>>> Hi Salvador,
>>>>>>
>>>>>> On 01/30/2018 01:36 AM, Salvador Fandino wrote:
>>>>>>> Let me start by explaining the problem that have motivated me to 
>>>>>>> write
>>>>>>> this patches:
>>>>>>>
>>>>>>> I work on the QVD, a virtual desktop platform for Linux. This 
>>>>>>> software
>>>>>>> runs Linux desktops (i.e. XFCE, KDE) and their applications 
>>>>>>> inside LXC
>>>>>>> containers, and makes then available through the network to remote
>>>>>>> users.
>>>>>>>
>>>>>>> Supporting USB devices is a common feature customers have been
>>>>>>> requesting us for a long time (in order to use, for instance, remote
>>>>>>> signature pads, bar-code scanners, fingerprint readers, etc.). 
>>>>>>> So, we
>>>>>>> have been working on that feature using the USB/IP layer on the
>>>>>>> kernel.
>>>>>>>
>>>>>>> Connecting and disconnecting devices and transferring data works
>>>>>>> seamless for the devices listed above. But we also want to make the
>>>>>>> usbip operations private to the container where they are run.  For
>>>>>>> instance, it is unacceptable for our product, that one user could 
>>>>>>> list
>>>>>>> the devices connected by other users or access them.
>>>>>>>
>>>>>>> We can control how can access every device using cgroups once those
>>>>>>> are attached, but the usbip layer is not providing any mechanism for
>>>>>>> controlling who can attach, detach or list the devices.
>>>> In this use-case:
>>>>
>>>> - does a container act as usbip client and attach devices from their
>>>>     host?
>>>> - do containers attach remote devices from other systems?
>>> In my particular case devices are imported from remote machines. But 
>>> well, the thing is that I don't care where the connections come from, 
>>> they could even be devices emulated in user space.
>>>
>>>> Is the core of the problem really that any remote system can import 
>>>> without
>>>> a provision for being able to restrict export to a set of remote 
>>>> machines?
>>>> If so, this is a generic problem even without containers and I would 
>>>> like
>>>> to solve this with a generic solution that works in all cases, not 
>>>> just for
>>>> containers.
>>> No, that is a different issue. You are talking about controlling 
>>> which devices can be connected, from which hosts, etc. That is an 
>>> interesting problem but not the one I am trying to tackle here.
>>>
>> Not entirely. These problems are linked if you use usbip driver and usbip
>> tools. USBIp driver is intended to be used in conjunction with the usbip
>> tools.
> 
> I will come back to that later.
> 
> 
> 
>>> I don't mind which every user does inside its container as far as it 
>>> does not interfere which other users. In practice that means:
>>>
>>> 1- Not being able to attach/detach devices in other container
>> How do container attach/detach in other containers in your setup?
> 
> (let's for a moment forget I am using my own user-space USBIP layer, 
> because it doesn't do anything different than the USBIP tools other than 
> not using TCP sockets as the transport layer)
> 
> The sysfs is bind-mounted inside the container. I have also enabled 
> access to USBIP devices through the cgroups device hierarchy.
> 
> In that scenario, I can just use the "usbip" tool to attach remote USBIP 
> devices.
> 
> Limiting what devices can be attached or detached inside the "usbip" 
> tool is not enough because, in general, the container's root can install 
> any software he likes inside the container including for instance, a 
> mangled "usbip" tool with any don't-touch-others-usbip-devices policy we 
> could implement there disabled.
> 
> 
>>> 2- Not being able to list devices attached in other containers
>> How do container list devices in other containers in your setup?
> 
> Which the current implementation, running "usbip port" inside the 
> container shows all the devices attached from the host or from any 
> container.
> 
> The information is available from the "status*" entries in vhci_hcd.0, 
> so, again, even if some 
> see-only-the-usbip-devices-attached-from-this-container policy where 
> enforced by the usbip tool, the container's root would still be able to 
> read the status files directly and see all the devices connected host-wise.
> 
> In the end, that means that any enforcement of container-to-container or 
> container-to-host USBIP access restriction must be made at the kernel 
> level and that's just what my proposed patch allows to do: It makes the 
> vhci_hcd devices fully independent. Every one having its own attach, 
> detach and status objects. In that way, every container can be limited 
> to accessing just one of them (well, or some subset) by selectively 
> hidden vhci_hcd.* entries on the container sysfs when it is started. 
> Then, from inside the container it is impossible to attach/detach 
> devices in other containers vhci_hcd or to list them.
> 
> Coming back to where you said "Not entirely. These problems are linked 
> if you use usbip driver and usbip tools. USBIp driver is intended to be 
> used in conjunction with the usbip tools."
> 
> Well, as I have already explained, the usbip user space tools can not be 
> used to limit access from the container to the host or to other 
> containers because the container's root may mangle it in order to 
> override any protection. So, I don't see how using or not using the 
> usbip has any importance here.
> 
> 
> 
>>
>>> 3- Not being able to access devices attached in other containers.
>>>
>>> Point 3 is already enforceable using the devices hierarchy in 
>>> cgroups. For points 1 and 2, my proposition is making every vhci_hcd 
>>> device have its own fully independent sysfs directory (instead of all 
>>> of them going through vhci_hcd.0) so that they can be selectively 
>>> exposed with rw permissions inside the containers.
>>>
>>>
>>>
>>>> The approach in this patch series appears to solve the problem just for
>>>> containers.
>>>>
>>>>>> Did you explore a solution to add a mechanism for access control to
>>>>>> usbip?
>>>>> Could you elaborate on that?
>>>>>
>>>>> For "usbip", do you mean the user space tools?
>>>>> If that is the case, I don't think it would be enough.
>>>>> My aim is to limit vhci usage from containers and I have no control 
>>>>> about what runs inside the containers. So, a mangled usbip tool-set 
>>>>> could > > be used by a malicious user to circumvent any access 
>>>>> control set there.>
>>>> I mean the driver. There might be changes necessary in the user-space
>>>> as well depending on how the access controls are implemented. I am not
>>>> proposing implementing access controls in the user-space.
>>>>
>>>>
>>>>> IMO, there is no other choice but to control access to VHCI at the 
>>>>> kernel level.
>>>>>
>>>> Probably. Please give as many details as possible on your environment
>>>> for me to make a call on if this problem can be solved in a different
>>>> way.
>>> In our particular real life application, we are targeting the kernel 
>>> interface directly, we don't use the usbip tools at all. It is that 
>>> way because we have our own* transport layer, authentication and 
>>> authorization mechanisms. And once all the handshaking is done we end 
>>> with a socket we can directly pass to the kernel in order to get it 
>>> attached to a vhci_hcd port.
>> How do you do that? Can you elaborate on how do you pass the socket to 
>> the USBIP
>> host?
> My userspace application creates a socketpair and passes one side to the 
> kernel writing to the "attach" file. It does exactly the same the usbip 
> tool does, the only difference is that instead of a TCP socket it uses a 
> UNIX one.
> 
> 
>>   The way you are using is unsupported and just not the way it is 
>> designed
>> to be used.
> 
> Yea, that's the magic of Open Source. You intended your application to 
> be used some way, somebody comes with a slightly different use case and 
> submits a patch so that his use case is also supported...
> 
> In any case, the discussion here should not be affected by if I am using 
> the standard user space tools or some custom ones. It is only related to 
> how to effectively allow compartmentalization of the USBIP devices in a 
> secure manner.
> 
> 
>>
>> We don't like having an extra application listening on some TCP port 
>> which can be accessed by third parties on the client side either.
>> USBIP is a server/client protocol is intended to work that way. You 
>> can specify
>> a port to use.
>>
>>> The imported USB devices used are mostly devices which do not require 
>>> kernel modules and that are accessed though libusb by the 
>>> applications (i.e., id card readers, barcode scanners, signing pads, 
>>> etc.).
>> This is just not they was USBIP driver in the kernel is intended to be 
>> used.
>> I am beginning to think that USBIP isn't the right solution for your 
>> application.
>> You are talking about not using the protocol the way it is designed 
>> and finding
>> custom ways to use it.
>>
>> I am all for making the USBIP more secure for container environment by 
>> adding
>> features to restrict:
>>
>> - Remote machines that can import (attach) - this can be per device.
>> - Make sure detach is done only by the remote that imported the device
>> - Restrict listing of imported devices to the remote that imported them
>> - Enhance current version match to a stricter version match and add 
>> checksum
>>    match between kernel and user-space.
>>
>> Let me know if you would like to explore the above options that are 
>> generic as
>> opposed to custom solution based on a setup that doesn't use the USBIP 
>> driver
>> the way it is designed to work.
>>
>> thanks,
>> -- Shuah
>>
>>
>>
> 
> 
> 


