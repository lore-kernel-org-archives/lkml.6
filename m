Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C71F16256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECEEC205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECEEC205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbeG3Rl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:41:28 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:43039 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbeG3Rl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:41:27 -0400
Received: from [148.252.241.226] (helo=[10.35.4.113])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fkAg7-00019D-FD; Mon, 30 Jul 2018 17:05:47 +0100
Subject: Re: [PATCH v2 1/4] ALSA: usb-audio: Initial Power Domain support
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20180719112215.4219-1-jorge.sanjuan@codethink.co.uk>
 <20180730092336.18741-1-jorge.sanjuan@codethink.co.uk>
 <20180730092336.18741-2-jorge.sanjuan@codethink.co.uk>
 <s5hbmaox4dh.wl-tiwai@suse.de>
From:   Jorge <jorge.sanjuan@codethink.co.uk>
Message-ID: <dcca62da-db80-5081-4552-2a010b307656@codethink.co.uk>
Date:   Mon, 30 Jul 2018 17:05:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <s5hbmaox4dh.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/07/18 14:03, Takashi Iwai wrote:
> On Mon, 30 Jul 2018 11:23:33 +0200,
> Jorge Sanjuan wrote:
>>
>> diff --git a/include/linux/usb/audio-v3.h b/include/linux/usb/audio-v3.h
>> index 334bfa6dfb47..786e5939d831 100644
>> --- a/include/linux/usb/audio-v3.h
>> +++ b/include/linux/usb/audio-v3.h
>> @@ -447,4 +447,8 @@ struct uac3_interrupt_data_msg {
>>  /* BADD sample rate is always fixed to 48kHz */
>>  #define UAC3_BADD_SAMPLING_RATE				48000
>>  
>> +/* BADD power domains recovery times */
>> +#define UAC3_BADD_PD_RECOVER_D1D0			0x0258
>> +#define UAC3_BADD_PD_RECOVER_D2D0			0x1770
> 
> Please put the unit for these values.  I guess they don't need to be
> hex?
> 

Hi!

The BADD spec defines these inferred values as hex (see section 6.2.2.13
of the spec). Should we keep them as per spec to avoid confusion? I'll
update comment there with the units (50 us increments).

Thanks for the reviews today. I'll update this series soon with the
suggested changes.

Jorge

> 
> Takashi
> 


