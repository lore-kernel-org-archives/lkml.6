Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9E04EC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4939C208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUGqdP3K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4939C208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755242AbeFNTSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 15:18:13 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39638 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754660AbeFNTSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 15:18:12 -0400
Received: by mail-wr0-f196.google.com with SMTP id w7-v6so7557522wrn.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 12:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MMfzyv6kIa8+EnPkMdevMcMc8RGrWwnKcKCDoVXOij8=;
        b=iUGqdP3K8c+0Nla5RGwhHLoghZXDXsmDdHY1xxlKOLfCDkQ1ZGAGJSruInUsQVw3S2
         tfQtEiT1EGnIsffg7RlbswZNeKBXuq/+pAGkpR20geBOC9XJA4IH9ADgaSbzRJ6hbT7C
         qY3sqolFnQ4ANzJvkiXWwxsVUL9Lm9ja3s9WC8CV5W+bSK13Aye0Y0v3oR3/Xv6DE/Sp
         65ycVZLXJzXBgFpkM9D2Sihv7HfQEkjgAtENUvSQ5borkF+OnXHcgFcwtaCNyMBfMK9m
         NLyTvoHIuNOkAbetgYI1h08wR7s5UTyIBJhZfSjHEB2Dcq1I6CmR6OXDdzQdmzB/0oe4
         Sdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MMfzyv6kIa8+EnPkMdevMcMc8RGrWwnKcKCDoVXOij8=;
        b=VRAexo8bKfX0tRtyUn5a06bAompe+FxW0ZcdWOISJGIO1r6P7OZEchLBAHKK6ulJ/k
         4SVxyU4XsbQbgxapO5TVHjZRJgIAvG4rhz5gC+gk8bFxxiVUS6Tx+5Nqn8IDe+cVkuxQ
         JyOyMQqQNkFLFD15ADVEunudFqq8eQ6iIRLv5rWZ5sULUk8tLozYQ5u8xXWuApqWCy3F
         iHFd0fG5x5D8cYvVZRfAViqEHIaaIKEIT5+kl4OvtobLznJpwm8LW+z0GGvEXX3VmwQQ
         ImsMuwrG3/UnXyJ9p56RVVESI6RFbjVKcBaS3JnuBzohas4zgox/JWqv9QSm3uYr+mPf
         ufHw==
X-Gm-Message-State: APt69E3OsIIle2giytLbu+79ikKGj5rkpgtrDAsB3GZzV5bR8vkec27r
        hbYZN3jN5r8bRSVrtuXqZvWI3tdGBCGjT+G4+bA=
X-Google-Smtp-Source: ADUXVKIJ+Z2dH7WepF+k+uiM+agvFMKXla997+QY8E91/jSAE/8eUANPi020ETZqbifSldmh9Xk+HajJkcNAtDccp3o=
X-Received: by 2002:adf:e687:: with SMTP id r7-v6mr3336652wrm.14.1529003891453;
 Thu, 14 Jun 2018 12:18:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:4004:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 12:18:10
 -0700 (PDT)
In-Reply-To: <s5ha7rx2vya.wl-tiwai@suse.de>
References: <20180612143201.29988-1-jorge.sanjuan@codethink.co.uk>
 <20180614140558.28277-1-jorge.sanjuan@codethink.co.uk> <s5ha7rx2vya.wl-tiwai@suse.de>
From:   Ruslan Bilovol <ruslan.bilovol@gmail.com>
Date:   Thu, 14 Jun 2018 22:18:10 +0300
Message-ID: <CAB=otbRkXJwMUXebJuLtVaZkUG-RY=O65rRNT9oL+u2_cipgXQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] ALSA: usb-audio: Insertion Control for BADD Adaptors.
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 7:07 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Thu, 14 Jun 2018 16:05:54 +0200,
> Jorge Sanjuan wrote:
>>
>> Thanks for review!
>>
>> Here is what's new in this V2:
>>  - Split the patchset into a more sensible series.
>>
>> This patchset adds support for the Insertion Control for BADD devices
>> (subset of UAC3).
>>
>> This control is only pressent in the HEADSET ADAPTER BADD profile. The USB
>> interrupt pipe shall be present for this profile so the status pipe
>> creation should also happen for BADD devices.
>>
>> Also, the bi-directional type codes have been defined so they can be used
>> as inferred values for the Input and Output terminals for this adapter
>> profile.
>>
>> Based on tag: next-20180612
>>
>> Jorge Sanjuan (4):
>>   ALSA: usb-audio: Add bi-directional terminal types.
>>   ALSA: usb-audio: Change in connectors control creation interface
>>   ALSA: usb-audio: UAC3. Add insertion control for BADD.
>>   ALSA: usb-audio: Always create the interrupt pipe for the mixer
>
> Thanks, this looks nicer, each of changes is smaller and clearer.
> Although it's a bit too late for the merge window, this is a change
> that is fairly safe for the existing UAC1/UAC2, I merged it now.
>

It's too late probably, but I just finished reviewing these patches
and don't have any objections.

Thanks,
Ruslan
