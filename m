Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4059601-1520325334-2-8937865604573932824
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: from='UTF-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520325334; b=gxt7QVrfQJ4c7+lUBNFbRNkSADF63fnHEIfxWKeoEkjNhRI
    clnvr2jwGxynozdv5C95rkGbID+mdqwJ8+o8eqw2EwXdTuVo1i+ULogNUpaqChwn
    cAqvgvXWg7zEbDQc5LkTE4kRWwFkweSmMpzj4CrrmhgyPbaerGlU7xdNHl40cyJo
    3crexcAs/ao4fKd/dnSV0G8SclwdT9DU4dfeS1lOVj6vMvAvFoXhu/Y+g+C8xK7s
    kkGyP5ltQCZVIcPjxus8biWD5W9D6VvpmPg4x3LJadG+W/QTfOuB8lWdxq/7sWGS
    D592wrAkfCOkRT7EULJEjiZ10RiNclyW05IGFEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520325334; bh=467vdTaXEdaBYIJ06yNw+DAA42407/3N8qgUDt6qQbk=; b=m
    VSoBG+q1ZlNEtKy3kJaaBHlPr+y1YlX1chVZK0EibFCBwyWJfIRQ5+GZQrvRgoRM
    S5ir66m4AGz+VO/vX8JEy1wYNXPzlgXjBfo4iXR3o8Tjv1s/ofCWl79x/ekcRFTF
    aG/0G9zvVUrQP37IYPcPbQ1muARgdLTceiPXqfy2EZe/Gl4uRgRHR9YuOZF6GJgJ
    ViKQfac7+mH/yfbVcMi0/TXnv+shgWnFg15oCT5yb3IedNbiSn3Oh5h1HrQIukRe
    oFy0bDXTyDRQbOtIGsbSUZF1K+QvIMdO65wBHFQzA1f5yFXl7ojkjJPnPEaIOb+Z
    PQEVfsWell1nB+luPl5Sg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=qindel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=qindel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=qindel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=qindel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753298AbeCFIfT convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Tue, 6 Mar 2018 03:35:19 -0500
Received: from smtp.qindel.com ([89.140.90.34]:44702 "EHLO thor.qindel.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753210AbeCFIfT (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 6 Mar 2018 03:35:19 -0500
Subject: Re: [PATH 0/4] usbip: make vhci_hcd.* objects independent of
 vhci_hcd.0
To: Shuah Khan <shuahkh@osg.samsung.com>, shuah@kernel.org,
        Salvador Fandino <salva@qindel.com>, linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org, valentina.manea.m@gmail.com,
        linux-kernel@vger.kernel.org
References: <20180130083630.26501-1-salva@qindel.com>
 <391a54d5-73ac-3bd5-49ca-114639ea69fd@kernel.org>
 <60da1c91-d6bf-1922-44c5-3b8010129cc4@qindel.com>
 <6f8af831-e7f8-787b-b1f9-465062aa7e8c@osg.samsung.com>
From: =?UTF-8?Q?Salvador_Fandi=c3=b1o?= <salvador@qindel.com>
Message-ID: <6395451b-d31c-0196-1f7a-39286972ea3f@qindel.com>
Date: Tue, 6 Mar 2018 09:35:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6f8af831-e7f8-787b-b1f9-465062aa7e8c@osg.samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/06/2018 01:03 AM, Shuah Khan wrote:
> On 03/05/2018 02:00 AM, Salvador Fandiño wrote:
>> On 02/21/2018 01:35 AM, Shuah Khan wrote:
>>> Hi Salvador,
>>>
>>> On 01/30/2018 01:36 AM, Salvador Fandino wrote:
>>>> Let me start by explaining the problem that have motivated me to write
>>>> this patches:
>>>>
>>>> I work on the QVD, a virtual desktop platform for Linux. This software
>>>> runs Linux desktops (i.e. XFCE, KDE) and their applications inside LXC
>>>> containers, and makes then available through the network to remote
>>>> users.
>>>>
>>>> Supporting USB devices is a common feature customers have been
>>>> requesting us for a long time (in order to use, for instance, remote
>>>> signature pads, bar-code scanners, fingerprint readers, etc.). So, we
>>>> have been working on that feature using the USB/IP layer on the
>>>> kernel.
>>>>
>>>> Connecting and disconnecting devices and transferring data works
>>>> seamless for the devices listed above. But we also want to make the
>>>> usbip operations private to the container where they are run.  For
>>>> instance, it is unacceptable for our product, that one user could list
>>>> the devices connected by other users or access them.
>>>>
>>>> We can control how can access every device using cgroups once those
>>>> are attached, but the usbip layer is not providing any mechanism for
>>>> controlling who can attach, detach or list the devices.
> In this use-case:
>
> - does a container act as usbip client and attach devices from their
>    host?
> - do containers attach remote devices from other systems?
In my particular case devices are imported from remote machines. But 
well, the thing is that I don't care where the connections come from, 
they could even be devices emulated in user space.

> Is the core of the problem really that any remote system can import without
> a provision for being able to restrict export to a set of remote machines?
> If so, this is a generic problem even without containers and I would like
> to solve this with a generic solution that works in all cases, not just for
> containers.
No, that is a different issue. You are talking about controlling which 
devices can be connected, from which hosts, etc. That is an interesting 
problem but not the one I am trying to tackle here.

I don't mind which every user does inside its container as far as it 
does not interfere which other users. In practice that means:

1- Not being able to attach/detach devices in other containers
2- Not being able to list devices attached in other containers
3- Not being able to access devices attached in other containers.

Point 3 is already enforceable using the devices hierarchy in cgroups. 
For points 1 and 2, my proposition is making every vhci_hcd device have 
its own fully independent sysfs directory (instead of all of them going 
through vhci_hcd.0) so that they can be selectively exposed with rw 
permissions inside the containers.



> The approach in this patch series appears to solve the problem just for
> containers.
>
>>> Did you explore a solution to add a mechanism for access control to
>>> usbip?
>> Could you elaborate on that?
>>
>> For "usbip", do you mean the user space tools?
>> If that is the case, I don't think it would be enough.
>> My aim is to limit vhci usage from containers and I have no control about what runs inside the containers. So, a mangled usbip tool-set could > > be used by a malicious user to circumvent any access control set there.>
> I mean the driver. There might be changes necessary in the user-space
> as well depending on how the access controls are implemented. I am not
> proposing implementing access controls in the user-space.
>
>
>> IMO, there is no other choice but to control access to VHCI at the kernel level.
>>
> Probably. Please give as many details as possible on your environment
> for me to make a call on if this problem can be solved in a different
> way.

In our particular real life application, we are targeting the kernel 
interface directly, we don't use the usbip tools at all. It is that way 
because we have our own* transport layer, authentication and 
authorization mechanisms. And once all the handshaking is done we end 
with a socket we can directly pass to the kernel in order to get it 
attached to a vhci_hcd port. We don't like having an extra application 
listening on some TCP port which can be accessed by third parties on the 
client side either.

The imported USB devices used are mostly devices which do not require 
kernel modules and that are accessed though libusb by the applications 
(i.e., id card readers, barcode scanners, signing pads, etc.).

* Just in case you want to know, USBIP data goes through a channel in a 
nx (https://github.com/ArcticaProject/nx-libs) connection running over a 
websocket over TLS. Authentication is performed by the broker (a proxy 
which knows where a user containers are running). Authorization is 
performed following policies configured by the administrator (currently 
it is just an all or nothing policy: USPIP is allowed or not) by the 
control application at container creation time.


