Return-Path: <stuyoder@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522799866; cv=none;
        d=google.com; s=arc-20160816;
        b=fFcYcjQKfmrLNYYVXU5XwDK0p/HvYReFRnv2Qgr/NcDYh6OiUzdhfH396KpGl3RmWK
         Y2zNE0/nGl57An6Ng8pw0r8NK9nkHohOE3Bx2uAOX4k/DQ8Lv7jbfqHdqc3THX0hQB+S
         TuIUzkYlLyPJT8HBpTcw/QbneL0pUcvURFCRRZXtTXo2irs6LxIK//MY6afJOEEg/nIO
         8AQkdfyVKjKSNGjhxtr6irOcflzfdQz34qFo9aKSI2GoPVTNS3Elsrrjs7Kj70r2ccIY
         yxrEF97M8W4vkdCZlMbzR4OcMWN5J4FxshsJc6B8YlTtmDwNLKNTALOwtWJJ1qHvgYxW
         Rmhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=HcZKPrX/cIMlRH+vCSxi4MOtfO5pO7Ui5MmDhXLmd/w=;
        b=YFCq4BusDvB87IFrmWD2PL+UEVwRJe0N/RNGJuDBYBeqZn9p6NzokZL59k/6Ek+8PA
         gYTN3hDknCrAQg5Rr61QfK6quw3z7JB9gnTrEusOPDEyB+iCzkWLVF64Y53rzJKH/Fve
         +sitFDJbCjxMtTKnMHYXNyLDMm27iNOP2psY8F0NgzchwJmpf8tKPJ9PUrE3THE1g1w8
         /v3zF4jHzNDDImuOj1QVRuT8f6I0b2xG+MtkSSkN1wJQkvHXkD0C526xqN6IzvWZvQjH
         0lChOnb13AxCwrJerDSch6VbDArFpIdHYw8oXg9xCGMfMc4nNOYWnl/2MDT+a9cJGGmH
         lX/w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=o1i2ztHf;
       spf=pass (google.com: domain of stuyoder@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=stuyoder@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=o1i2ztHf;
       spf=pass (google.com: domain of stuyoder@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=stuyoder@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48rrzmOTBgu6SimLDqmlnj7ZEiJyVV6RGdo4NEBm/2r/M/etNUWxIS710NffAU8A2VntD4Lv+3X35ooV6MXH+8=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1aQCm_r95Ka4x+j8SJLCLFvLuX3A4twK1WJcJs66YwKg@mail.gmail.com>
References: <cover.1521818402.git.ioana.ciornei@nxp.com> <d8c243a9ead2fe1375dee242aec26d1276129409.1521818402.git.ioana.ciornei@nxp.com>
 <CAK8P3a089ZiPdp1CcVct8Kac+ejkNP8TrVpWYSr_nMGo4goO1Q@mail.gmail.com>
 <HE1PR04MB32126A07A4B4CC7225E661E4E0A30@HE1PR04MB3212.eurprd04.prod.outlook.com>
 <CAK8P3a1aQCm_r95Ka4x+j8SJLCLFvLuX3A4twK1WJcJs66YwKg@mail.gmail.com>
From: Stuart Yoder <stuyoder@gmail.com>
Date: Tue, 3 Apr 2018 18:57:44 -0500
Message-ID: <CAEac7tZ4we46EEa2DuAbmMr+hW6Q4BoBKJFFf1k_k57r2oJpng@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
To: Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew@lunn.ch>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>, gregkh <gregkh@linuxfoundation.org>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ruxandra Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>, Razvan Stefanescu <razvan.stefanescu@nxp.com>,
	Roy Pledge <roy.pledge@nxp.com>, Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595743497041548891?=
X-GMAIL-MSGID: =?utf-8?q?1596771392643302687?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 10:43 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Mar 28, 2018 at 4:27 PM, Ioana Ciornei <ioana.ciornei@nxp.com> wrote:
>> Hi,
>>
>>>
>>> Hi Ioana,
>>>
>>> So this driver is a direct passthrough to your hardware for passing fixed-
>>> length command/response pairs. Have you considered using a higher-level
>>> interface instead?
>>>
>>> Can you list some of the commands that are passed here as clarification, and
>>> explain what the tradeoffs are that have led to adopting a low-level interface
>>> instead of a high-level interface?
>>>
>>> The main downside of the direct passthrough obviously is that you tie your
>>> user space to a particular hardware implementation, while a high-level
>>> abstraction could in principle work across a wider range of hardware revisions
>>> or even across multiple vendors implementing the same concept by different
>>> means.
>>
>> If by "higher-level" you mean an implementation where commands are created by the kernel at userspace's request, then I believe this approach is not really viable because of the sheer number of possible commands that would bloat the driver.
>>
>> For example, a DPNI (Data Path Network Interface) can be created using a command that has the following structure:
>>
>> struct dpni_cmd_create {
>>         uint32_t options;
>>         uint8_t num_queues;
>>         uint8_t num_tcs;
>>         uint8_t mac_filter_entries;
>>         uint8_t pad1;
>>         uint8_t vlan_filter_entries;
>>         uint8_t pad2;
>>         uint8_t qos_entries;
>>         uint8_t pad3;
>>         uint16_t fs_entries;
>> };
>>
>> In the above structure, each field has a meaning that the end-user might want to be able to change according to their particular use-case (not much is left at its default value).
>> The same level of complexity is encountered for all the commands that interact with Data Path objects such as DPBP(buffer pools), DPRC(Resource Container) etc.
>> You can find more examples of commands in restool's repo: https://github.com/qoriq-open-source/restool/tree/integration/mc_v10
>>
>> In my opinion, an in-kernel implementation that is equivalent in terms of flexibility will turn
>> into a giant ioctl parser, all while also exposing an userspace API that is not as simple/easy to use.
>
> (adding the netdev list)
>
> The command you list there seems to be networking related, so instead of
> an ioctl based interface, a high-lever interface would likely use netlink
> for consistency with other drivers. Are all commands for networking
> or are there some that are talking to the device to do something unrelated?
>
> Obviously creating a high-level interface would be a lot of work in the kernel,
> and it only pays off if there are multiple independent users, we wouldn't do
> that for just one driver.
>
> I'm still not convinced either way (high-level or low-level
> interface), but I think
> this needs to be discussed with the networking maintainers. Given the examples
> on the github page you linked to, the high-level user space commands
> based on these ioctls
>
>    ls-addni   # adds a network interface
>    ls-addmux  # adds a dpdmux
>    ls-addsw   # adds an l2switch
>    ls-listmac # lists MACs and their connections
>    ls-listni  # lists network interfaces and their connections
>
> and I see that you also support the switchdev interface in
> drivers/staging/fsl-dpaa2, which I think does some of the same
> things, presumably by implementing the switchdev API using
> fsl_mc_command low-level interfaces in the kernel.
>
> Is that a correct interpretation? If yes, could we extend switchdev
> or other networking interfaces to fill in whatever those don't handle
> yet?

The wrapper scripts you referenced are not sufficient to show the scope
of what the proposed user space interface is for.  The command list is
not just about networking related objects, as there are quite a few
other types of  objects as well:
    dprc - container object representing an fsl-mc bus instance...i.e. other
           objects are attached to this bus
    dpio - used for queuing operations towards any accelerator or network
           interface
    dpbp - buffer pool object
    dpmcp - command portal interface
    dpdmai - DMA engine
    dpseci - crypto accelerator
    dpdcei - compression/decompression accelerator
    dpni - network interface
    dprtc - real time counter
    dpaiop - heterogenous core complex for packet processing offload
    dpmac - represents an Ethernet MAC
    dpsw - network switch
    dpcon - network concentrator
    dpci - communication interface

The proposed ioctl interface is about:
   A)  creating and destroying all those object types
   B)  managing the dprc containers they live in, including moving
       objects between containers
   C)  where applicable establishing connections between different
       objects

No _operational_ aspects of these object/devices is being handled
through this interface.  The network interface should be managed
through ethtool, for example.  The proposed ioctl interface is about
bringing the devices into existence and getting them "wired" up.

Suppose you want to create and assign a network interface to a KVM
virtual machine, you would do something like the following using
a user space tool like restool:
   -create a new (empty) dprc object
   -create a new dpni and assign it to the dprc
   -create a new dpio and assign it to the dprc
   -create a new dpbp and assign it to the dprc
   -create a new dpmcp and assign it to the dprc
   -create a new dpmac and assign it to the dprc
   -connect the dpni to the dpmac

Now, at this point you have a functional set of objects that
can function as a network interface.

That dprc can now be assigned to a KVM VM using vfio and the
guest will see a dprc that it can probe and enumerate using the
fsl-mc bus infrastructure that is now upstream.

There is no existing kernel <--> user space mechanism that will
work to do all that, so something new was needed.

As far as low-level vs high-level...we did consider a higher level
interface that would expose operations on individual object such
as "create dpbp", but the user space API gets complex and
fragile for no obvious value.  Every object needs commands to
create/destroy and get attributes.  There is a sizeable dprc command
set.  Every time an object is enhanced (with a corresponding major
or minor version rev) you have to change the ioctl interface.

Having a simple command passthrough interface reduces complexity
in the kernel and provides an interface that should be very stable.

The fsl-mc bus and DPAA2 is very NXP-specific, so there doesn't
seem to be anything that can be made generic here to provide
more common benefit.

Thanks,
Stuart
