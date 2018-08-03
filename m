Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94501C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C8721759
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="ZYUYpHnF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C8721759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbeHCO1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:27:08 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33691 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728622AbeHCO1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:27:08 -0400
Received: by mail-lf1-f66.google.com with SMTP id u14-v6so3961248lfu.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 05:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qP12nqMXPjQLfry6LAlbmsqgbwnorXyycLWxKwQHPMc=;
        b=ZYUYpHnFbVsOtaSVSvp+NKmjndje/NtMcdCd9VbOV7efJFwWKD8VQn/eARp6BMnb4+
         7dDdXGTqbAVHhuE33DjlSIk93tE2nr9NcmWv+re0TmbDudoNOirJpbFp0c8aRfDoVHPs
         nN0GB+qApsFYSCe7jMF41e2lCJ6Kf1oXWFY0hkNE3eTuNiF+wDNBII+nd37qYf6ui6Qu
         qqOcUtbGgALjzdB34Gj3LLdRvdPTsYwUCui7hOX2iKfqeWGpYQak1Gd/3DRu37j+zWmN
         c7BR9WLd3MnrVb6OkrHWbxhZ4lEn1oBOkSe/CemWcmf9eYZGPQ6Aw5OleQjF/6PF0j95
         xfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qP12nqMXPjQLfry6LAlbmsqgbwnorXyycLWxKwQHPMc=;
        b=BWPAW/JYJdlnTpwYn8PWojZKzCA/kcapaKza/o3Fx/VtvVUKM05vzOy0TNPJz9X+f1
         D3TkbAwDAtUEbtBoMa7s4sNi8l6cQaZl1GO+GyHGdm4b58tmrTtAnjGRJU+TR1CKuX9i
         c6DSd1PUu5ZWLRGhKtLv3ev7/WPZOQh05KKxniItBAl8UJ/nyix+8sei9yLxwqntFZrh
         6n6XD0sUxEIqkpt6cr3Vv4Cwmvl3bjTOpuvsPVTlOJKvhDibJcYYBSxSbl6v2gqdCjWG
         d8ddzZGw0e6Yw0cVqgQMXZsB/+RLZ8kN/o9j+0ALOoDLKQao9bFAX0KPLuV0smKhQBcM
         Pcqg==
X-Gm-Message-State: AOUpUlGmzkYJxDH7HTjRfwuxOV9Ti3XtlKRD0h2/xXVOa9lc8cm3UnmR
        2bHX+5jZgpfXS3w0BXg0khWUN6Rnn07/+A==
X-Google-Smtp-Source: AAOMgpfrXfGyC9uWltMwHCDt/gBl5YXogfeZ+7I87toZjCaRite07dTlj4n6x/rprETH2vUdQwoy7Q==
X-Received: by 2002:a19:14dc:: with SMTP id 89-v6mr4440779lfu.45.1533299458183;
        Fri, 03 Aug 2018 05:30:58 -0700 (PDT)
Received: from [192.168.0.10] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id o4-v6sm874093ljc.67.2018.08.03.05.30.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 05:30:57 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: recover chunk state on 1.2 devices
To:     javier@cnexlabs.com
Cc:     hans.holmberg@cnexlabs.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1530177121-24908-1-git-send-email-javier@cnexlabs.com>
 <1530177121-24908-2-git-send-email-javier@cnexlabs.com>
 <e42e5ab4-48c7-e822-618d-dc28c25262ed@lightnvm.io>
 <43D7E3C4-765F-46AB-9B84-27E37FCAE016@cnexlabs.com>
 <19b2f125-d373-cf2b-43c7-140b3872cd64@lightnvm.io>
 <D6AFE2C1-D273-4945-9A12-D4A0A57FD108@cnexlabs.com>
 <8c2fc1ff-e2ea-499e-3699-39622d00be9e@lightnvm.io>
 <88659F4F-8105-41CA-B0B8-849E707F18CD@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <423c5d4b-6d9a-d233-d3da-f2cb8b10f880@lightnvm.io>
Date:   Fri, 3 Aug 2018 14:30:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <88659F4F-8105-41CA-B0B8-849E707F18CD@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2018 02:02 PM, Javier Gonzalez wrote:
>> On 3 Aug 2018, at 13.57, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 07/24/2018 09:54 AM, Javier Gonzalez wrote:
>>>> On 29 Jun 2018, at 13.28, Matias Bjørling <mb@lightnvm.io> wrote:
>>>>
>>>> On 06/29/2018 01:22 PM, Javier Gonzalez wrote:
>>>>>> On 29 Jun 2018, at 13.14, Matias Bjørling <mb@lightnvm.io> wrote:
>>>>>>
>>>>>> On 06/28/2018 11:12 AM, Javier González wrote:
>>>>>>> The Open-Channel 1.2 spec does not define a mechanism for the host to
>>>>>>> recover the block (chunk) state. As a consequence, a newly format device
>>>>>>> will need to reconstruct the state. Currently, pblk assumes that blocks
>>>>>>> are not erased, which might cause double-erases in case that the device
>>>>>>> does not protect itself against them (which is not specified in the spec
>>>>>>> either).
>>>>>>
>>>>>> It should not be specified in the spec. It is up to the device to handle
>>>>>> double erases and not do it.
>>>>>>
>>>>>>> This patch, reconstructs the state based on read errors. If the first
>>>>>>> sector of a block returns and empty page (NVM_RSP_ERR_EMPTYPAGE), then
>>>>>>> the block s marked free, i.e., erased and ready to be used
>>>>>>> (NVM_CHK_ST_FREE). Otherwise, the block is marked as closed
>>>>>>> (NVM_CHK_ST_CLOSED). Note that even if a block is open and not fully
>>>>>>> written, it has to be erased in order to be used again.
>>>>>>
>>>>>> Should we extend it to do the scan, and update the write pointer as
>>>>>> well? I think this kind of feature already is baked into pblk?
>>>>> This is already in place: we scan until empty page and take it from
>>>>> there. This patch is only for the case in which we start a pblk instance
>>>>> form scratch. On a device already owned by pblk, we would not have the
>>>>> problem we are trying to solve here because we know the state.
>>>>
>>>> Agree. What I meant was that when we anyway are recovering the state,
>>>> we could just as well update ->wp and set to NVM_CHK_ST_OPEN and so
>>>> forth for the initialization phase.
>>> In 1.2 the use of chunk metadata is purely fictional. We respect the
>>> chunk state machine as we transition lines, but all the write pointers
>>> are ignored. Instead, we use the line bitmap to point to the next
>>> writable entry. This is BTW the same way we it in open lines on 2.0 too.
>>
>> Now I understand where you are coming from. I had the understanding
>> that we where using the write pointer now that we moved to 2.0,
>> looking through the code, that wasn't the case. :) Which means that
>> pblk doesn't work with a devices that implements 2.0. Yikes... I knew
>> I had forgot a detail when support was added into pblk.
>>
> 
> I think you misunderstood; pblk does support 2.0 devices. What happens
> is that we transform the per chunk WP in 2.0 into the line bitmap to
> simplify the lookup. The point being that we do not need to create a
> fictional chunk for 1.2 devices since we do the translation to the
> bitmap directly. Does this make sense?

The chunk->wp isn't used anywhere. So it can't take wp into account. It 
uses the EMPTYPAGE marker from 1.2 instead. See pblk-core and 
pblk-recovery.

> 
>> There are no empty sector marker in the 2.0 spec, since it uses the
>> write pointer to know where it is in the chunk. So there is a bit of
>> work to do there.
>>
> 
> Yes. And for 2.0 devices we go and look at the WP, but for 1.2 devices we
> need to scan.
> 
>> Since this properly is a bit more work to do, I'll look into it after FMS.
>>
> 
> Look the comments above. All we need for 2.0 support is in place. We can
> talk about it f2f.
> 
>> I'm also moving the explicit coding of 1.2/2.0 chunk / bad block
>> fixing into core, so pblk can be simplfied, and doesn't have to think
>> to manage each version separately.
>>
> 
> Good. I have a patch I was expecting to send after FMS for moving chunk
> / bad block out of pblk for the same reason. If you're doing the same
> thing I can stop looking into it...

I am, will post when done.

> 
>>
>>> Chunk metadata is only used to setup the bitmaps on init/recovery. From
>>> here on, we use the bitmap to find the next writable sector, without
>>> worrying about the specific per-chunk write pointer. Thus, updating
>>> chunk metadata here has no effect.
>>> Does this make sense to you?
>>> Javier

