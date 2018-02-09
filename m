Return-Path: <tcminyard@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518183290; cv=none;
        d=google.com; s=arc-20160816;
        b=coS9prBmL1HwYLOPA1SYW/WIV+0efzEslu5ZlkzKwRiHIhVOQTouc6aV54+fqgZqqb
         HgyHR2Zwg9Zj9Gu9UVfkwid9GW+DIW30A/yV3CmsiaiRAXLRYh+D8PstyTzH75cMIVX3
         wHvuHPmwtXVIF+/TCVnINL6x+gG/ix618+hFy3WFwu/QVp+3qP34G6klI6tOpm6qi9bw
         WmiYks6Qhf0HNv5nYv5pXUj2LpTips18m6bJyBI59sw+sA8A1G2jcS8/PxchxJZoewsV
         LZVli3j8q9SUbDwAGPE+4y+PzcL7yM0Z2muMMbvHtsUiBkzQxOl41AOA7xvIczsXXwi2
         Iz8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:reply-to
         :sender:dkim-signature:arc-authentication-results;
        bh=xKTkczV0I6NwI8lELfKzDDKxo7C/AUr9jc2la7iWMn0=;
        b=BpGNn/z69bAS0uY1aejqF2eyyJy2jms/qpYAcPtdjHhu4fUlqO9eXvM1/PJJ7ND1ml
         Ihgz4dQJ3XV39dqygElYRsguGBSBTJcwtLXNB4Fil8z1z0Y/vCDyHQd+shkPAkB3D+W+
         cvy35Xt9nCH1C12xvFbRyNWURufaz0bRSWa7gx+ftwuFeCh8ctq44GWu/MME9DYMnzHn
         YwpERFYJHXag8iBrdrMY3hmTgGHhS7aLoPstecrecJYPn1UHrg1R3AHVU9yBRWfQ687h
         RyPJFPYrsfWaSy1THaR84uHBptwWtm1hAXTW25cp7vzMYTe3UdZ2ZmEEh+zb0MqYCuDH
         8Z5w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rX/m7trQ;
       spf=pass (google.com: domain of tcminyard@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=tcminyard@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rX/m7trQ;
       spf=pass (google.com: domain of tcminyard@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=tcminyard@gmail.com
X-Google-Smtp-Source: AH8x225N3mi/RkiCDnPQZ/2RE+PNXYl81ZMbOuIfCtckwfBsA8LK22EDXhbVm2+sT7BoYZUkZpEmyg==
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
Subject: Re: ipmi_si fails to get BMC ID
To: Chris Chiu <chiu@endlessm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org,
 openipmi-developer@lists.sourceforge.net,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 Linux Upstreaming Team <linux@endlessm.com>
References: <CAB4CAwfino0JaeeZV1byp3aoaRrOGL1=BYgkruvxYMr6=c=5PQ@mail.gmail.com>
 <3b812894-46a0-3c87-1b9f-468fc63ea5bd@acm.org>
 <CAB4CAwdTa=A78hr4ZrHNpCwJBo3-kmdK8nq1ZS_k0VanPm0dMw@mail.gmail.com>
From: Corey Minyard <minyard@acm.org>
Message-ID: <afea7262-4b56-55be-803c-8f89d3b3b567@acm.org>
Date: Fri, 9 Feb 2018 07:34:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAB4CAwdTa=A78hr4ZrHNpCwJBo3-kmdK8nq1ZS_k0VanPm0dMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591800098576670064?=
X-GMAIL-MSGID: =?utf-8?q?1591930562432922973?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/08/2018 09:09 PM, Chris Chiu wrote:
> On Thu, Feb 8, 2018 at 11:53 PM, Corey Minyard <minyard@acm.org> wrote:
>> On 02/07/2018 09:01 PM, Chris Chiu wrote:
>>> Hi,
>>>       We are working with a new desktop Acer Veriton Z4640G and get
>>> stumbled on failing to enter S3 suspend with kernel version 4.14 even
>>> the latest 4.15+. Here's the kernel log
>>> https://gist.github.com/mschiu77/76888f1fd4eb56aa8959d76759a912bb.
>>
>> This is a little strange, nobody had reported this before.  Can you
>> reproduce this
>> at will, or was it a one-time thing?
> It can be reproduced on each reboot.
>> Does the IPMI driver always take this long to issue that error, even if you
>> are not
>> entering sleep state?
>>
> Yep, it will always print "ipmi_si 0000:02:00.3: There appears to be
> no BMC at this
> location" few minutes after boot.
>
>> And it started with 4.14, and didn't occur before then, right?
>>
> I haven't try pre-4.14 kernel. Will do that and update here.

Ah.  It's probably still worth trying, but I doubt it will make any 
difference.

Are you sure there is actually an IPMI BMC installed in this system?  It 
might
be a plug-in card that is not installed, but the interface still appears 
on the
PCI bus.  So there is enough hardware to go part-way through the motions
of being an IPMI interface, but not enough to actually work.

If there is a BMC there, do you know the register layout?  The IPMI spec has
an algorithm to go through to discover some of the parameters, and the
driver follows it, but IMHO it's not really very good.  I'll need to 
know the
size of the registers, and the spacing between the registers.

-corey

>> There's a bug in the PCI utils database, I submitted a report a while ago.
>> This is
>> a KCS, not a SMIC interface.
>>
>> It looks like the driver is trying to detect that there is a device out
>> there and
>> there is something that kind of works, but doesn't work completely. The
>> interface
>> specific code was all split out into separate files in 4.14.  It is possible
>> the
>> detection code got messed up in the process.  Nothing jumps out looking at
>> the code differences, and I know it works on some PCI machines.
>>
>> Assuming this is reproducible, can you send the the output of a pre-4.14
>> kernel?  If that doesn't make it obvious I may have to have access to the
>> machine itself.
>>
>> -corey
>>
>>
> It's an All-in-One machine so I think it would be difficult for
> shipment. I'll see what
> I can do. Thanks for help.
>
> Chris
>
>>>       As you see, it is due to "ipmi_probe+0x430/0x430 [ipmi_si]". After
>>> the message "ipmi_si 0000:02:00.3: There appears to be no BMC at this
>>> location" shows up, then it can really go to suspend w/o problem.
>>> Although it took around 3 mins. The IPMI device is probed from PCI and
>>> here's the output of lspci
>>> https://gist.github.com/mschiu77/33f0372be41670d8a69c97e64f833087. The
>>> IPMI device is "02:00.3 IPMI SMIC interface [0c07]". We get stuck here
>>> because we don't really know why it took so long in try_get_dev_id() /
>>> ipmi_si_intf.c. Any suggestion about this to help us moving forward?
>>> Thanks
>>>
>>>
>>> Chris
>>
>>
