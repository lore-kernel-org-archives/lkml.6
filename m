Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E4A6EC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 22:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86FB0208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 22:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8kjkyoP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86FB0208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965011AbeFNWbP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 18:31:15 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:38987 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964866AbeFNWbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 18:31:14 -0400
Received: by mail-ot0-f196.google.com with SMTP id l15-v6so8947321oth.6;
        Thu, 14 Jun 2018 15:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SXyqXnVncvlJEgAh/+G6kX8SUMejuH63jYKW9bJqS6k=;
        b=d8kjkyoP0Mwy2McY3Gy5AkQSnU0UkBvW7Qx1Gu7JFMbFCOe+q4GRH1M+ZFTcQm19bn
         VRF5ixCLPNVCMQHTducyDPVbWtt2K8/GdFT+FLSTMuzTQgMf26c+7YSOGjPddmLgUSif
         4RLkC3tq+bp+MZEYBoRi7N3CjVDBmCcWollsymzil3DL0+DvQls0yMz7ptIHmvawpvwC
         lzlD+uhv4EpRcSg4rNnbaHXEwPyTWA3ICWafaTmgMBXPTo9iZ7dGUh9++/ABokclYpqO
         Q1AeZYuDTlgCRqLXGZhRlPdyWZDkYCJaoldiN7f8yV7cE+6iwwhV9+UaGd6nlCEhgaKG
         QxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SXyqXnVncvlJEgAh/+G6kX8SUMejuH63jYKW9bJqS6k=;
        b=D7s58vkDa28ae5Zk8MxGMTv6vpYwPUY1zhdeNRmODJDB5Usg8F3OezlOFlH9pXe6+v
         W5brFhYZfxabUri+u0eYPnPoprtQs3sUaDuX+9+b4h+3fb+WlUNqQhz2AKvYECHWDbO5
         pEHaKAPcCQ3LOuM6+b+7ySHPjnzh2Bt1vwkgSq0KUQM51w/8a2zP5plGNLqU8cum+KZX
         ab80CfR+zvcqKY3x/cuaOHIZTTTB+0vT9dR32uTke53tSdg7iptcEbVFyi7DUuj5X3vi
         OjrhpOZtGbqtydGOIoMJ0cyqQuH/67+oKx+uDh+tB0933bru80F1OJYiUHSN7GXxIreA
         JsDw==
X-Gm-Message-State: APt69E0+5the2/aZ3trUwQTDS/j9KGLabuFt+K7DCQayQneaJwB2HF/9
        5SteHxDYb4EsGdIYt3eX0PBb+6gA
X-Google-Smtp-Source: ADUXVKKWLmxKy3zsTI6gV/vH9lxCB9BJI20ZY6+oZ84hLCjtkNyvJ1T/vxE68utbgMIlta2j4AZLlQ==
X-Received: by 2002:a9d:4e99:: with SMTP id v25-v6mr2676006otk.328.1529015473022;
        Thu, 14 Jun 2018 15:31:13 -0700 (PDT)
Received: from [192.168.0.2] (cpe-24-27-59-32.austin.res.rr.com. [24.27.59.32])
        by smtp.gmail.com with ESMTPSA id x36-v6sm3005282ota.16.2018.06.14.15.31.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 15:31:12 -0700 (PDT)
Subject: Re: [PATCH v3] dcdbas: Add support for WSMT ACPI table
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>, Douglas_Warzecha@dell.com,
        Mario Limonciello <mario.limonciello@dell.com>,
        Jared.Dominguez@dell.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
References: <45b8bde6-aaa8-3f3f-0528-81e5e931751c@gmail.com>
 <bc6846e1-2b6d-dcc2-355c-2699aa1607a2@gmail.com>
 <CAHp75Vdmqm+r=Orxs6_dCr18y+EwEQ=s-7UgaZKHuKbtjMcOig@mail.gmail.com>
 <20180609010420.GA112645@localhost.localdomain>
 <CAHp75VcA5ZWahraDP69_hBHuqxw6cng93zAa1op5EBYfuCSPwg@mail.gmail.com>
 <b59027b3-a48e-f168-5f12-c67758c0c2c7@gmail.com>
 <CAHp75VcK78jL_7sF+ZGaPpwDED-6Xd+SdH_5WCfSBsVJW2GnDg@mail.gmail.com>
 <8307f1e0-c480-3f78-9327-e248208e5349@gmail.com>
 <CAHp75VdTGXqE__VHjRphEmpMVfxaVVik=u-_0NRhQAKeq=+ZKA@mail.gmail.com>
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
Message-ID: <b5652ed8-5fff-4f8b-ec0f-467bce853bf8@gmail.com>
Date:   Thu, 14 Jun 2018 17:31:08 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdTGXqE__VHjRphEmpMVfxaVVik=u-_0NRhQAKeq=+ZKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Antivirus: Avast (VPS 180613-2, 06/13/2018), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/2018 12:25 PM, Andy Shevchenko wrote:
> On Thu, Jun 14, 2018 at 5:22 PM, Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
>> On 6/13/2018 3:54 AM, Andy Shevchenko wrote:
> 
>>>> +                * Provide physical address of command buffer field within
>>>> +                * the struct smi_cmd... can't use virt_to_phys on smi_cmd
>>>> +                * because address may be from memremap.
>>>
>>> Wait, memremap() might return a virtual address. How we be sure that
>>> we got still physical address here?
> 
>> Before this patch, the address in smi_cmd always came from an alloc, so
>> virt_to_phys() was used to get the physical address here.  With WSMT, we
>> could be using a BIOS-provided buffer for SMI, in which case the address in
>> smi_cmd will come from memremap(), so we can't use virt_to_phys() on it.
>> So instead I changed this to use the physical address of smi_data_buf that
>> is stored in smi_data_buf_phys_addr, which will be valid regardless of how
>> the address of smi_data_buf was generated.
> 
> Yes, but what does guarantee that memremap() will return you still
> physical address?
> 

Sorry, I'm not sure I understand the question.

Up to now, this driver always just allocated a buffer from main memory that
it used to send/receive information from BIOS when it generated a SMI.  That's
what smi_cmd points to where this comment is.  And it was safe to use
virt_to_phys() on this address.

With this patch, though, the driver may now be using a buffer that isn't part
of main memory--it could now be using a buffer that BIOS provided the physical
address for, and this would not be part of main memory.  So smi_cmd may contain
a virtual address that memremap() provided.  And because memremap() is just
like ioremap(), the driver can no longer use virt_to_phys(smi_cmd) to get the
physical address of the buffer.

My comment is just pointing that out... I was trying to say, "the code can't
use virt_to_phys(smi_cmd) to get the virtual address here".

memremap() should always return a virtual address that points to the physical
address we send it (unless it fails of course).


>>>> +               return 0;
>>>> +
>>>> +       /* Scan for EPS (entry point structure) */
>>>> +       for (addr = (u8 *)__va(0xf0000);
>>>> +            addr < (u8 *)__va(0x100000 - sizeof(struct smm_eps_table));
>>>
>>>> +            addr += 1) {
>>>
>>> This wasn't commented IIRC and changed. So, why?
> 
>> I changed this is response to your earlier comment (7 june)... you had pointed
>> out that it would be better if I put an "if (eps) break;" inside the for loop
>> instead of having "&& !eps" in the condition of the for loop.  I put the note
>> "Changed loop searching 0xf0000 to be more readable" in the list of changes for
>> patch version v3 to cover this change.
> 
> Thanks, but here I meant += 1 vs += 16 step.
> 

Sorry, I thought I had answered this earlier.  The spec does not say that the EPS
table will be on a 16-byte boundary.  And I just added a printk in this driver to
see where it is on the system I had at hand, and it isn't on a 16-byte boundary:

[ 4680.192542] dcdbas - EPS table at 000000005761efb7
[ 4680.194012] dcdbas dcdbas: WSMT found, using firmware-provided SMI buffer.
[ 4680.195327] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.3)
