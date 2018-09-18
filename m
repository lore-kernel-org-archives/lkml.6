Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F18ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C0820C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxARl1d3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C0820C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbeISDLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:11:45 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39665 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730315AbeISDLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 23:11:45 -0400
Received: by mail-oi0-f68.google.com with SMTP id c190-v6so3202959oig.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 14:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=JkIfTB3/x6+stkJA4lJvo+peVyOjg0TtfEwW4/ru8Hk=;
        b=XxARl1d3uVRsCU8Qy7+35vgLt5b2C8ubcMT8bXTpE7zhDGbR5ZHKdqdGA8LLMV8/+B
         /PPnL49nH2gK6Y3/LRmo/6rAyGkK6J36HpO9t11UyOr5sqgHvmYRa5BQsqKo1/bSAgva
         5kwg8ShyHfLq7Mus5i1QzhjSzD+9LukrMrA3zp2Vzj4BnioxhIO7TepSMvNYGbjDGy/W
         bIIrSyHVui1EK0h6HOUM8Y2SbITxZLcsvuP3whNJMccldCtL9c+nxxyHMieiRLnxXzhn
         1TG8IN+YPPuieEbfmww/MwJ/PQFpYt9W6ojisPmm02poOcFL22iLjrvCXTY3M+QTq9X2
         t++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=JkIfTB3/x6+stkJA4lJvo+peVyOjg0TtfEwW4/ru8Hk=;
        b=jzL6zzRrUWGIkU83PClbL59I+7rjrMnIlj6kjvuWuWue17GQJIKD1g8+H4XX9o28TE
         vE25XMZ7OM6zu0XeOZY6LXIIdLCB1qk+bBtKaA11R3f0S/NDmUIOWYGZZYlL6ujMJb6a
         Q7eAgBc1hEe17ot6PjzMQ8C5zMhtlEjcrUWgU5JoZzGlUSiv6dKIZPpPr7teRdFA46vq
         KPSsTmbKkqO1vqUvIcDguETutgbA4Q5XZUbz2cI2r63kIqDuXEkDk2+2UCxaG3aF1DeB
         Sn09vEGiIt2q2DxQOy8WwZTCF5GQLdzZVRlzM4C3l0dZuhFT45ookjROn/mC4FrYesEy
         eVJQ==
X-Gm-Message-State: APzg51ASSz21LbS92L5hr01eASuxrme1xxBPzRQFXVC55BrYZuoYsx2p
        3sqxMflaUmxXA9E2wDDImQ==
X-Google-Smtp-Source: ANB0Vda89vvUinFfnjrL0N8WRhH8iAAFAuCofFmrfQri4BX66ouhEVwd2XoW4+Bp9mAYQwBur9M9Fw==
X-Received: by 2002:aca:5714:: with SMTP id l20-v6mr2886513oib.100.1537306634094;
        Tue, 18 Sep 2018 14:37:14 -0700 (PDT)
Received: from [192.168.27.3] ([47.184.170.128])
        by smtp.gmail.com with ESMTPSA id q7-v6sm6051375otg.45.2018.09.18.14.37.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 14:37:12 -0700 (PDT)
Reply-To: minyard@acm.org
Subject: Re: [PATCH v2] ipmi: looped device detection
To:     Patrick Venture <venture@google.com>,
        Corey Minyard <minyard@acm.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
References: <20180911225630.124502-1-venture@google.com>
 <585d1c3a-6121-c20d-f6d6-7567595cd1af@acm.org>
 <CAO=notzHoqsjuSdEZby0mr3KgtoxtYjdr_X0nM_2zBu0NcOOAA@mail.gmail.com>
 <CAO=notwkMAe_9=32D+ycPwiZ=c_un7sQ+Le9PW_oDiVeBp25jg@mail.gmail.com>
From:   Corey Minyard <tcminyard@gmail.com>
Message-ID: <966e9741-6a27-a511-8d39-6576d8cfc8f8@gmail.com>
Date:   Tue, 18 Sep 2018 16:37:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAO=notwkMAe_9=32D+ycPwiZ=c_un7sQ+Le9PW_oDiVeBp25jg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/18/2018 01:42 PM, Patrick Venture wrote:
> On Wed, Sep 12, 2018 at 3:54 PM Patrick Venture <venture@google.com> wrote:
>> On Wed, Sep 12, 2018 at 3:10 PM Corey Minyard <minyard@acm.org> wrote:
>>> On 09/11/2018 05:56 PM, Patrick Venture wrote:
>>>> Try to get the device ID repeatedly during initialization before giving up.
>>>> The BMC isn't always responsive, and this allows it to be slightly flaky
>>>> during early boot.
>>>>
>>>> Tested: Installed on a system with the BMC software disabled
>>>> such that it was non-responsive.  The driver correctly detected this
>>>> and gave up as expected.  Then I re-enabled the BMC software unloaded
>>>> and reloaded the driver and it was detected properly.
>>> The patch looks fine, but I wonder if this is something that is really
>>> valuable.
>>> I have wondered about this before.
>>>
>>> The question is: If the BMC is unavailable, what are the chances of it
>>> becoming
>>> available by the time you do 5 attempts?  I would guess that is a pretty
>>> small
>>> chance, which is why I haven't done this already.
> Friendly ping.  I'd like to get a sense of whether you're likely to
> accept this.  If not, it's fine, will close out patch in current
> downstream rebase.

I'm ok with doing this, but I lied about the patch being fine, there are 
some issue.
Well, I didn't lie, but I didn't look closely enough.

Can you use dev_xxx() instead of pr_xxx().  I know the driver isn't 
currently
consistent, but there are a number of patches I have pending to make it
better and it's a longer-term goal.

Can you make GET_DEVICE_ID_ATTEMPTS more specific, add IPMI_SI_ to
the beginning or something.

I am not sure that I'm ok with waiting up to 1.25 seconds in the init 
function.
As I mentioned before, a large number of systems have broken ACPI/SMBIOS
information, and for those it will add 1.25 seconds to the boot time of 
every
one of those systems.  That won't make me a popular guy :-).

This is a harder problem to figure out what to do.  To solve it properly 
would
mean having a timer or thread drive this, and unload the module later if
the process fails.

-corey

> Thanks
>
>> This patch was actually critical for us to provide a reliable IPMI
>> interface.  The version of OpenBMC or the state of the BMC at the
>> point the kernel was loading was flaky, so following the example in
>> the BIOS source, we just re-try a few times.  We also can hold boot X
>> seconds until it's responding, but, this avoided some issues inherent
>> with that.
>>
>>> You could have something that re-tested periodically, but there are so many
>>> systems with IPMI specified in ACPI or SMBIOS that is wrong, and it would
>>> try forever.  Also not really a good thing.
>> If we did a periodic check, it could check X times, but I felt going
>> for a simple solution was ideal -- and this idea was proved out on a
>> few platforms.  We have other drivers that are loaded by the kernel
>> (not at run-time) and they depend on IPMI, and without this patch they
>> would then have a non-trivial probability of failure.
>>
>>> So I've left it to reload the driver or use the hotmod interface.
>>>
>>> -corey
>>>
>>>> Signed-off-by: Patrick Venture <venture@google.com>
>>>> ---
>>>> v2:
>>>>    - removed extra variable that was set but not used.
>>>> ---
>>>>    drivers/char/ipmi/ipmi_si_intf.c | 23 ++++++++++++++++++++++-
>>>>    1 file changed, 22 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
>>>> index 90ec010bffbd..5fed96897fe8 100644
>>>> --- a/drivers/char/ipmi/ipmi_si_intf.c
>>>> +++ b/drivers/char/ipmi/ipmi_si_intf.c
>>>> @@ -1918,11 +1918,13 @@ int ipmi_si_add_smi(struct si_sm_io *io)
>>>>     * held, primarily to keep smi_num consistent, we only one to do these
>>>>     * one at a time.
>>>>     */
>>>> +#define GET_DEVICE_ID_ATTEMPTS       5
>>>>    static int try_smi_init(struct smi_info *new_smi)
>>>>    {
>>>>        int rv = 0;
>>>>        int i;
>>>>        char *init_name = NULL;
>>>> +     unsigned long sleep_rm;
>>>>
>>>>        pr_info(PFX "Trying %s-specified %s state machine at %s address 0x%lx, slave address 0x%x, irq %d\n",
>>>>                ipmi_addr_src_to_str(new_smi->io.addr_source),
>>>> @@ -2003,7 +2005,26 @@ static int try_smi_init(struct smi_info *new_smi)
>>>>         * Attempt a get device id command.  If it fails, we probably
>>>>         * don't have a BMC here.
>>>>         */
>>>> -     rv = try_get_dev_id(new_smi);
>>>> +     for (i = 0; i < GET_DEVICE_ID_ATTEMPTS; i++) {
>>>> +             pr_info(PFX "Attempting to read BMC device ID\n");
>>>> +             rv = try_get_dev_id(new_smi);
>>>> +             /* If it succeeded, stop trying */
>>>> +             if (!rv)
>>>> +                     break;
>>>> +
>>>> +             /* Sleep for ~0.25s before trying again instead of hammering
>>>> +              * the BMC.
>>>> +              */
>>>> +             sleep_rm = msleep_interruptible(250);
>>>> +             if (sleep_rm != 0) {
>>>> +                     pr_info(PFX "Find BMC interrupted\n");
>>>> +                     rv = -EINTR;
>>>> +                     goto out_err;
>>>> +             }
>>>> +     }
>>>> +
>>>> +     /* If we exited the loop above and rv is non-zero we ran out of tries.
>>>> +      */
>>>>        if (rv) {
>>>>                if (new_smi->io.addr_source)
>>>>                        dev_err(new_smi->io.dev,
>>>

