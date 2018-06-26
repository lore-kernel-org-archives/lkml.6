Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974A9C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFCC2154F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="K6Prq22A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DFCC2154F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935434AbeFZMNh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:13:37 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33588 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935110AbeFZMNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:13:34 -0400
Received: by mail-pl0-f65.google.com with SMTP id 6-v6so8446386plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 05:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QDBrm/nyR+1KXV+JW8VIKI+5dLKJUiPxsi5eNl8aDso=;
        b=K6Prq22A0FqkUiQLfs1p5cYdEsnd6nFkCeAXRMzdKK1vlqFnHDjvBxh7us6z1WkzD8
         dhKjeaXdPmIpMr3DybPdSywjYeoZLhYoqayqCuWvElcwdtXZ/vPa2m5jSogme6E9f2Wo
         BONDb1LftRrStrztAkW7hobNIgJlTMf2uLo2TXR9WuvgKW7l5s/DN1R6E+gsb54xV0FN
         Rp5Sz+KSDYojyBko67QgDxtp8jWt+VLd28BupCk2Oi6k6bZ4Cscbdj8NcqQ5i7pgUnSp
         TL7ldXKATKIoiNCUjftkEeU6EpbW92jdClp4RfsyluGXzy8W+gAc+qx6/9e2Us2PloMB
         wBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QDBrm/nyR+1KXV+JW8VIKI+5dLKJUiPxsi5eNl8aDso=;
        b=ZIUlvLmCQDi+fhKIvSvwIWrkhyl+zPl9LZkBJIO6H+T5vi0JwbskAL8o/EcrGCrCck
         4i0rpMf1bQgKuBhz1bYxG0SXmb71qE+2+9jjJfm9/qPIxNQObZwJMV7vJ38SB1bdpQTN
         ok0CXuEnutMsT2Iw4tDEyl67cxUqt1q2qpe8Jp5WMndjpYM8Lgg7ok0NHsqKb8qJltBC
         a7Iqj2+uj4y/Spf56HTx/CMGfNM8BQ4QFyDh0L87eWjogjT1KKEyLV83jdlXuxJHSZg4
         Jb77qFHqa/c6i8BGnmJhfQfkTl9Ls5VDGkHCvZX+Z9AIeGNsL+aSLj8lA4cFWNC+mKGW
         mBBw==
X-Gm-Message-State: APt69E1rwRtvfGEZquQG8XgGvfz9IVCUKMH9j8lrwH6Ziy3QWTlAtgBt
        uzfoLJXVUI6Bt/dcqUJrqtr45Q==
X-Google-Smtp-Source: AAOMgpeIHeXAfyR89R+2TLPI7o0EyMRzCDnMenq/xMHuF8L1qlj/XH52jPaMnpvF6jJR2k6wY77K/w==
X-Received: by 2002:a17:902:2702:: with SMTP id c2-v6mr297309plb.297.1530015214202;
        Tue, 26 Jun 2018 05:13:34 -0700 (PDT)
Received: from [10.86.48.245] (rap-us.hgst.com. [199.255.44.250])
        by smtp.googlemail.com with ESMTPSA id n26-v6sm3018715pfi.168.2018.06.26.05.13.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 05:13:33 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: assume that chunks are closed on 1.2
 devices
To:     javier@cnexlabs.com
Cc:     hans.ml.holmberg@owltronix.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, hans.holmberg@cnexlabs.com
References: <1529399189-3239-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <a2bb1959-5244-f8af-b747-6d87e8d456a4@lightnvm.io>
 <1612C143-24C3-4B6F-B745-945EAF684DFC@cnexlabs.com>
 <ed909bcb-8e91-7e6d-521e-b5f36db61efa@lightnvm.io>
 <CANr-nt3Qzp-brMa16NAVa=E6eRCfpNyV44cmRoaxYUV0J7zStA@mail.gmail.com>
 <4bcd22df-3899-fc87-d558-27754befae5e@lightnvm.io>
 <D165FE85-ED96-4E1E-85C3-D4C0C52B8E24@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <f000c5f3-27f4-489c-5e6e-99921f456954@lightnvm.io>
Date:   Tue, 26 Jun 2018 14:13:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <D165FE85-ED96-4E1E-85C3-D4C0C52B8E24@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/26/2018 01:54 PM, Javier Gonzalez wrote:
> 
>> On 26 Jun 2018, at 13.44, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>>> On 06/26/2018 01:31 PM, Hans Holmberg wrote:
>>>> On Tue, Jun 26, 2018 at 1:38 PM, Matias Bjørling <mb@lightnvm.io> wrote:
>>>>> On 06/26/2018 11:37 AM, Javier Gonzalez wrote:
>>>>>
>>>>>
>>>>>
>>>>>> On 26 Jun 2018, at 10.41, Matias Bjørling <mb@lightnvm.io> wrote:
>>>>>>
>>>>>> On 06/19/2018 11:06 AM, Hans Holmberg wrote:
>>>>>>>
>>>>>>> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>>>>>>> We can't know if a block is closed or not on 1.2 devices, so assume
>>>>>>> closed state to make sure that blocks are erased before writing.
>>>>>>> Fixes: 32ef9412c114 ("lightnvm: pblk: implement get log report chunk")
>>>>>>> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
>>>>>>> ---
>>>>>>> This patch applies on:
>>>>>>> ssh://github.com/OpenChannelSSD/linux branch for-4.19/core
>>>>>>>    drivers/lightnvm/pblk-init.c | 5 +++--
>>>>>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>>> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
>>>>>>> index aa24264..3b8aa4a 100644
>>>>>>> --- a/drivers/lightnvm/pblk-init.c
>>>>>>> +++ b/drivers/lightnvm/pblk-init.c
>>>>>>> @@ -717,10 +717,11 @@ static int pblk_setup_line_meta_12(struct pblk
>>>>>>> *pblk, struct pblk_line *line,
>>>>>>>                  /*
>>>>>>>                   * In 1.2 spec. chunk state is not persisted by the
>>>>>>> device. Thus
>>>>>>> -                * some of the values are reset each time pblk is
>>>>>>> instantiated.
>>>>>>> +                * some of the values are reset each time pblk is
>>>>>>> instantiated,
>>>>>>> +                * so we have to assume that the block is closed.
>>>>>>>                   */
>>>>>>>                  if (lun_bb_meta[line->id] == NVM_BLK_T_FREE)
>>>>>>> -                       chunk->state =  NVM_CHK_ST_FREE;
>>>>>>> +                       chunk->state =  NVM_CHK_ST_CLOSED;
>>>>>>>                  else
>>>>>>>                          chunk->state = NVM_CHK_ST_OFFLINE;
>>>>>>>
>>>>>>
>>>>>> pblk should scan (or the lightnvm subsystem) the blocks for their
>>>>>> state, such that it doesn't have to reinitialize a full drive if it is
>>>>>> already in a closed state. If marking closed, it does a full erase
>>>>>> cycle on initialization, which should be avoided since it is a limited
>>>>>> resource.
>>>>>
>>>>>
>>>>> In 1.2 there is no such state unfortunately. However, pblk will never
>>>>> attempt to reinitialize the whole drive - metadata for closed blocks
>>>>> will be recovered and only those going to GC will be erased before
>>>>> usage. In fact, a full close drive is the state pblk expects.
>>>>>
>>>>> This patch only affects "unknown blocks", thus the only case in which
>>>>> pblk would attempt to double erase is when blocks have been pre-erased
>>>>> (e.g., factory or through liblightnvm). After an erase round though,
>>>>> pblk will only erase pre-usage. One thing we could do is attempting to
>>>>> read the first page of these unknown blocks and mark them as free if
>>>>> "empty page" is returned. Is this what you mean?
>>>>
>>>>
>>>> Yes, that is what I mean.
>>>>
>>>> Note that this can be
>>>>>
>>>>> costly on large drives; this is the reason we returned to the pre-2.0
>>>>> behaviour with this patch. We are implementing a log that, among other
>>>>> things, keeps the state so that pblk can have an accurate state for the
>>>>> cases this can be a problem.
>>>>
>>>>
>>>> Yep, it will take some time. Good to hear with the log.
>>> Until we have a log in place, this patch unbreaks 1.2 support and has
>>> no negative impact on performance (as compared to pre 2.0 support), so
>>> please consider it for the next window.
>>> The current state is that if a pblk instance is created on a 1.2 disk
>>> with written blocks, writes will fail.
>>>   / Hans
>>
>> The negative impact is that all blocks are erased, even if they are in free state. This is a showstopper. We cannot throw out 1/X of the lifetime of the drive on each initialization. The 1.2 spec is made such that a scan can recover the block state accurately.
> 
> This fixes patch returns to the original behavior, so it’s not introducing a worse behavior than before 2.0. But you’re right, it is not the way it should be.
> 
> Can you consider taking this as a fix for 4.18 to avoid writes failing on 1.2 devices and I promise to send a patch this week to implement the state based on reads? This new patch would be for 4.19.
> 
> Javier
> 

Okay, sounds good to me. Thanks
