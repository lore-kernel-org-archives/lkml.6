Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA95C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A30269D6
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="elMnYwpg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A30269D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934736AbeFZLbX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 07:31:23 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:41123 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934597AbeFZLbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 07:31:20 -0400
Received: by mail-vk0-f67.google.com with SMTP id j11-v6so4507615vke.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 04:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EpCY7o91CIWQoAQ4iqPLPVYvthNz4Xg9v7H35qFspcI=;
        b=elMnYwpguh+LN8drN8QZmvEEa7BE1s0lrAviS/VTm6HvLbNQVzWwlXZVt36gY2iQEe
         I6VrM6LDGxcYfP+EoSUScuG7thdyd4+5yerJnOLGKKL/wlfrmUbFR+LgUOyy9/VaRk+d
         7XI8dkXOneBYdqOuoYTFTkeyoJsl/7GbMLhhbqV0Y7GhIIkBfsK3GGMhkWJaTPZfvrSP
         BVSTM6Dzv+DwZzRFGYsRQV60HiAkdoJADF7QlFXkcpF83wfKpkp4awiMexEpkq7D+GZB
         /eS4l3AfPEepq5uMmi6+bQ1RthBC/wQpXQvPXjFGVjP/vSL+xFuJlq3XNxDimSzsKGW8
         luwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EpCY7o91CIWQoAQ4iqPLPVYvthNz4Xg9v7H35qFspcI=;
        b=GdPFR3iiDHrH10BiOWyezbm80p19lYL3ejcYh9f7dKICq/jE9uNeCL6G4kgBfCpDzu
         vEcxm4so4cu3n4w+EkuUtRJxOuvkooCZ++ZK2zlaxVr1A63NbCulAW6uzeK12rQJksDd
         mjfEgDNC7o5sWIxqKfLBSbrjk0X0pc7+5FvzSaPtQY9qOj2JjxcKxITO030g+yXf/0Gs
         gHaReKRIfndlhIy3mn9WHY+APrJCbsrn+IndzdZzpoW4nhv/gR3a31Z1RYMvYrqo9eku
         n3nlKEASJie0XdHPOxoBXB66WE2XEXu12sq7cHkVh283q9V2AcNJQFC7o9xNwXoPEt9f
         5cLA==
X-Gm-Message-State: APt69E0TFsfigFf0pN8YBnkl6IAXHYFUlaJWQzRdIOLP4P4cEs1eA2xz
        7Tzz/xCViFXm6F2H0p4yAFyYzE8SQCFkP6cVp2PR7loN
X-Google-Smtp-Source: AAOMgpe/TdJH2ViPgfLkV9GGFwy75b2GXY+KP0iP0jbFQJpI7R1cpUTO+KXqWphP4o74s22LLi3Pozs1OCYZlV/LzeA=
X-Received: by 2002:a1f:c204:: with SMTP id s4-v6mr643132vkf.86.1530012679061;
 Tue, 26 Jun 2018 04:31:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:981b:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 04:31:18
 -0700 (PDT)
In-Reply-To: <ed909bcb-8e91-7e6d-521e-b5f36db61efa@lightnvm.io>
References: <1529399189-3239-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <a2bb1959-5244-f8af-b747-6d87e8d456a4@lightnvm.io> <1612C143-24C3-4B6F-B745-945EAF684DFC@cnexlabs.com>
 <ed909bcb-8e91-7e6d-521e-b5f36db61efa@lightnvm.io>
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date:   Tue, 26 Jun 2018 14:31:18 +0300
Message-ID: <CANr-nt3Qzp-brMa16NAVa=E6eRCfpNyV44cmRoaxYUV0J7zStA@mail.gmail.com>
Subject: Re: [PATCH] lightnvm: pblk: assume that chunks are closed on 1.2 devices
To:     =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
Cc:     Javier Gonzalez <javier@cnexlabs.com>, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 1:38 PM, Matias Bj=C3=B8rling <mb@lightnvm.io> wrot=
e:
> On 06/26/2018 11:37 AM, Javier Gonzalez wrote:
>>
>>
>>
>>> On 26 Jun 2018, at 10.41, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>>>
>>> On 06/19/2018 11:06 AM, Hans Holmberg wrote:
>>>>
>>>> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>>>> We can't know if a block is closed or not on 1.2 devices, so assume
>>>> closed state to make sure that blocks are erased before writing.
>>>> Fixes: 32ef9412c114 ("lightnvm: pblk: implement get log report chunk")
>>>> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
>>>> ---
>>>> This patch applies on:
>>>> ssh://github.com/OpenChannelSSD/linux branch for-4.19/core
>>>>   drivers/lightnvm/pblk-init.c | 5 +++--
>>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init=
.c
>>>> index aa24264..3b8aa4a 100644
>>>> --- a/drivers/lightnvm/pblk-init.c
>>>> +++ b/drivers/lightnvm/pblk-init.c
>>>> @@ -717,10 +717,11 @@ static int pblk_setup_line_meta_12(struct pblk
>>>> *pblk, struct pblk_line *line,
>>>>                 /*
>>>>                  * In 1.2 spec. chunk state is not persisted by the
>>>> device. Thus
>>>> -                * some of the values are reset each time pblk is
>>>> instantiated.
>>>> +                * some of the values are reset each time pblk is
>>>> instantiated,
>>>> +                * so we have to assume that the block is closed.
>>>>                  */
>>>>                 if (lun_bb_meta[line->id] =3D=3D NVM_BLK_T_FREE)
>>>> -                       chunk->state =3D  NVM_CHK_ST_FREE;
>>>> +                       chunk->state =3D  NVM_CHK_ST_CLOSED;
>>>>                 else
>>>>                         chunk->state =3D NVM_CHK_ST_OFFLINE;
>>>>
>>>
>>> pblk should scan (or the lightnvm subsystem) the blocks for their
>>> state, such that it doesn't have to reinitialize a full drive if it is
>>> already in a closed state. If marking closed, it does a full erase
>>> cycle on initialization, which should be avoided since it is a limited
>>> resource.
>>
>>
>> In 1.2 there is no such state unfortunately. However, pblk will never
>> attempt to reinitialize the whole drive - metadata for closed blocks
>> will be recovered and only those going to GC will be erased before
>> usage. In fact, a full close drive is the state pblk expects.
>>
>> This patch only affects "unknown blocks", thus the only case in which
>> pblk would attempt to double erase is when blocks have been pre-erased
>> (e.g., factory or through liblightnvm). After an erase round though,
>> pblk will only erase pre-usage. One thing we could do is attempting to
>> read the first page of these unknown blocks and mark them as free if
>> "empty page" is returned. Is this what you mean?
>
>
> Yes, that is what I mean.
>
> Note that this can be
>>
>> costly on large drives; this is the reason we returned to the pre-2.0
>> behaviour with this patch. We are implementing a log that, among other
>> things, keeps the state so that pblk can have an accurate state for the
>> cases this can be a problem.
>
>
> Yep, it will take some time. Good to hear with the log.

Until we have a log in place, this patch unbreaks 1.2 support and has
no negative impact on performance (as compared to pre 2.0 support), so
please consider it for the next window.
The current state is that if a pblk instance is created on a 1.2 disk
with written blocks, writes will fail.

 / Hans
