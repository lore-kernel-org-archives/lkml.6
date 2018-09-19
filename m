Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4A3C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C96208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLui58VS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C96208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732036AbeITB7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 21:59:45 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:44620 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbeITB7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 21:59:45 -0400
Received: by mail-oi0-f67.google.com with SMTP id l82-v6so6268159oih.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 13:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:reply-to:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fV6561O3DtW7nxG4TFCBt7jutJfcpda+O8gbOaAePWY=;
        b=ZLui58VSqdH8XQxRk/3z4lAd+xviwU5c/VIwZ4R4oGvYsH3pQyBoAEDUeLtBITQ/TN
         98ZAiFc7LTuU5dFcogCLWvLvo4G8HgRCV8qTSk7UYHHJZx0v2V+IA9RJiOpbngxZJdQo
         16ELtQsTyn43MoC5bNrc6Y7unRUa98jrFNckg+b7cZvU7CEp/pJ5Q53FKSxO9tEihktN
         QkJZk0+P4QMS9nY96G/K5IxuVq3RW0HOBRcu7fpLbS8W5B5Y0CafEuhID/6YYXAWpU22
         xwd7b7sCpvBL75C0cD3h1W7RUpEg1IqJ2pKf30UvL4mxfw9NSbTx0Hxq2cFT6RYss87p
         9qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=fV6561O3DtW7nxG4TFCBt7jutJfcpda+O8gbOaAePWY=;
        b=uAZZ2j0/rOyY+TcV75GMrdAGy8sSIrDLEU7ITwfShO/7hjIr+7uY6leoQ+1rNltOAU
         JpBk5c5nBTpZ8TxSBifOWYlvT3OKUZVXOBHxDEejpic9Y9Q6kTl3mZyHpuw+rjapRQad
         cNjVWPMm4nXCHC/1cweX/HVO1EzyOt8627dAMFM7BosXK2jDIjj10OPmKD3EeCECu3Kz
         fZuv5WdtYXONhdvHWVlZW1VF8ag1JKPHrlEQkUIs3zCzTl1GnAyUc1TdEmHMV06HFcLc
         ynGpBfGzcpFWPlcjNEBPKYVv64A8X3FgThHcfjAj2aRZqBRnVV3aTXFEizSTmzVN6RdK
         fKTQ==
X-Gm-Message-State: APzg51BWDErx8cAp9QwJCC9KwySkbBgiJrUKTwyfGmLqKtQFDr01Ybj1
        IriaFVbnD7NgO5MlJ2qTlw==
X-Google-Smtp-Source: ANB0VdYPxQ0tFmzBrr3ZH8hM5IJMGetphcQJ4d8HfKUNeit1hwyYvc8o/OMVjXEEZKboyaz/YqACYw==
X-Received: by 2002:aca:7513:: with SMTP id q19-v6mr2865097oic.13.1537388410876;
        Wed, 19 Sep 2018 13:20:10 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.128])
        by smtp.gmail.com with ESMTPSA id r10-v6sm10819156oif.37.2018.09.19.13.20.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 13:20:09 -0700 (PDT)
Received: from [192.168.27.3] (t430m.minyard.net [192.168.27.3])
        by serve.minyard.net (Postfix) with ESMTPSA id 9CA288E6;
        Wed, 19 Sep 2018 15:20:08 -0500 (CDT)
Reply-To: minyard@acm.org
Subject: Re: [PATCH v2] ipmi: looped device detection
To:     Patrick Venture <venture@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
References: <20180911225630.124502-1-venture@google.com>
 <585d1c3a-6121-c20d-f6d6-7567595cd1af@acm.org>
 <CAO=notzHoqsjuSdEZby0mr3KgtoxtYjdr_X0nM_2zBu0NcOOAA@mail.gmail.com>
 <CAO=notwkMAe_9=32D+ycPwiZ=c_un7sQ+Le9PW_oDiVeBp25jg@mail.gmail.com>
 <966e9741-6a27-a511-8d39-6576d8cfc8f8@gmail.com>
 <CAO=notzJxVuf+jfLaSde1iMRBE2=qwWGSCj+JzJociYK6yGTdQ@mail.gmail.com>
From:   Corey Minyard <minyard@acm.org>
Message-ID: <25f12226-b974-9373-cb9b-b04f2a6dfcdf@acm.org>
Date:   Wed, 19 Sep 2018 15:20:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAO=notzJxVuf+jfLaSde1iMRBE2=qwWGSCj+JzJociYK6yGTdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/19/2018 02:56 PM, Patrick Venture wrote:
> On Tue, Sep 18, 2018 at 2:37 PM Corey Minyard <tcminyard@gmail.com> wrote:
>> On 09/18/2018 01:42 PM, Patrick Venture wrote:
>>> On Wed, Sep 12, 2018 at 3:54 PM Patrick Venture <venture@google.com> wrote:
>>>> On Wed, Sep 12, 2018 at 3:10 PM Corey Minyard <minyard@acm.org> wrote:
>>>>> On 09/11/2018 05:56 PM, Patrick Venture wrote:
>>>>>> Try to get the device ID repeatedly during initialization before giving up.
>>>>>> The BMC isn't always responsive, and this allows it to be slightly flaky
>>>>>> during early boot.
>>>>>>
>>>>>> Tested: Installed on a system with the BMC software disabled
>>>>>> such that it was non-responsive.  The driver correctly detected this
>>>>>> and gave up as expected.  Then I re-enabled the BMC software unloaded
>>>>>> and reloaded the driver and it was detected properly.
>>>>> The patch looks fine, but I wonder if this is something that is really
>>>>> valuable.
>>>>> I have wondered about this before.
>>>>>
>>>>> The question is: If the BMC is unavailable, what are the chances of it
>>>>> becoming
>>>>> available by the time you do 5 attempts?  I would guess that is a pretty
>>>>> small
>>>>> chance, which is why I haven't done this already.
>>> Friendly ping.  I'd like to get a sense of whether you're likely to
>>> accept this.  If not, it's fine, will close out patch in current
>>> downstream rebase.
>> I'm ok with doing this, but I lied about the patch being fine, there are
>> some issue.
>> Well, I didn't lie, but I didn't look closely enough.
>>
>> Can you use dev_xxx() instead of pr_xxx().  I know the driver isn't
>> currently
>> consistent, but there are a number of patches I have pending to make it
>> better and it's a longer-term goal.
> Ack.
>
>> Can you make GET_DEVICE_ID_ATTEMPTS more specific, add IPMI_SI_ to
>> the beginning or something.
> Ack.
>
>> I am not sure that I'm ok with waiting up to 1.25 seconds in the init
>> function.
>> As I mentioned before, a large number of systems have broken ACPI/SMBIOS
>> information, and for those it will add 1.25 seconds to the boot time of
>> every
>> one of those systems.  That won't make me a popular guy :-).
> Yeah, that's problematic for the systems that'll never get a valid
> response.  I don't think it makes sense to gate the feature with a
> configuration option, do you?

Yeah, a config option wouldn't really help.  You could do a module parm, 
but that's
really not very easy to use.

Pushing the detection off to a thread would solve that problem, but it 
creates its
own problems.  The driver may be in the process of detecting something, but
it may not be ready when the module load or kernel boot finishes.

I don't think this has been an issue in the past because generally the 
BMC is
integral to the boot of most systems.  So it's always operational by the 
time
the OS comes up.

So I'm not sure what to do.

-corey

>> This is a harder problem to figure out what to do.  To solve it properly
>> would
>> mean having a timer or thread drive this, and unload the module later if
>> the process fails.
>>
>> -corey
>>
>>> Thanks
>>>
>>>> This patch was actually critical for us to provide a reliable IPMI
>>>> interface.  The version of OpenBMC or the state of the BMC at the
>>>> point the kernel was loading was flaky, so following the example in
>>>> the BIOS source, we just re-try a few times.  We also can hold boot X
>>>> seconds until it's responding, but, this avoided some issues inherent
>>>> with that.
>>>>
>>>>> You could have something that re-tested periodically, but there are so many
>>>>> systems with IPMI specified in ACPI or SMBIOS that is wrong, and it would
>>>>> try forever.  Also not really a good thing.
>>>> If we did a periodic check, it could check X times, but I felt going
>>>> for a simple solution was ideal -- and this idea was proved out on a
>>>> few platforms.  We have other drivers that are loaded by the kernel
>>>> (not at run-time) and they depend on IPMI, and without this patch they
>>>> would then have a non-trivial probability of failure.
>>>>
>>>>> So I've left it to reload the driver or use the hotmod interface.
>>>>>
>>>>> -corey
>>>>>
>>>>>> Signed-off-by: Patrick Venture <venture@google.com>
>>>>>> ---
>>>>>> v2:
>>>>>>     - removed extra variable that was set but not used.
>>>>>> ---
>>>>>>     drivers/char/ipmi/ipmi_si_intf.c | 23 ++++++++++++++++++++++-
>>>>>>     1 file changed, 22 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
>>>>>> index 90ec010bffbd..5fed96897fe8 100644
>>>>>> --- a/drivers/char/ipmi/ipmi_si_intf.c
>>>>>> +++ b/drivers/char/ipmi/ipmi_si_intf.c
>>>>>> @@ -1918,11 +1918,13 @@ int ipmi_si_add_smi(struct si_sm_io *io)
>>>>>>      * held, primarily to keep smi_num consistent, we only one to do these
>>>>>>      * one at a time.
>>>>>>      */
>>>>>> +#define GET_DEVICE_ID_ATTEMPTS       5
>>>>>>     static int try_smi_init(struct smi_info *new_smi)
>>>>>>     {
>>>>>>         int rv = 0;
>>>>>>         int i;
>>>>>>         char *init_name = NULL;
>>>>>> +     unsigned long sleep_rm;
>>>>>>
>>>>>>         pr_info(PFX "Trying %s-specified %s state machine at %s address 0x%lx, slave address 0x%x, irq %d\n",
>>>>>>                 ipmi_addr_src_to_str(new_smi->io.addr_source),
>>>>>> @@ -2003,7 +2005,26 @@ static int try_smi_init(struct smi_info *new_smi)
>>>>>>          * Attempt a get device id command.  If it fails, we probably
>>>>>>          * don't have a BMC here.
>>>>>>          */
>>>>>> -     rv = try_get_dev_id(new_smi);
>>>>>> +     for (i = 0; i < GET_DEVICE_ID_ATTEMPTS; i++) {
>>>>>> +             pr_info(PFX "Attempting to read BMC device ID\n");
>>>>>> +             rv = try_get_dev_id(new_smi);
>>>>>> +             /* If it succeeded, stop trying */
>>>>>> +             if (!rv)
>>>>>> +                     break;
>>>>>> +
>>>>>> +             /* Sleep for ~0.25s before trying again instead of hammering
>>>>>> +              * the BMC.
>>>>>> +              */
>>>>>> +             sleep_rm = msleep_interruptible(250);
>>>>>> +             if (sleep_rm != 0) {
>>>>>> +                     pr_info(PFX "Find BMC interrupted\n");
>>>>>> +                     rv = -EINTR;
>>>>>> +                     goto out_err;
>>>>>> +             }
>>>>>> +     }
>>>>>> +
>>>>>> +     /* If we exited the loop above and rv is non-zero we ran out of tries.
>>>>>> +      */
>>>>>>         if (rv) {
>>>>>>                 if (new_smi->io.addr_source)
>>>>>>                         dev_err(new_smi->io.dev,


