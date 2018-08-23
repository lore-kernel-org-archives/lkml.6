Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2CDC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 01:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3D0208CD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 01:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D3D0208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbeHWFBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 01:01:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48363 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbeHWFBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 01:01:17 -0400
Received: from mail-pl0-f71.google.com ([209.85.160.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1fseVe-0001mq-64
        for linux-kernel@vger.kernel.org; Thu, 23 Aug 2018 01:34:02 +0000
Received: by mail-pl0-f71.google.com with SMTP id e8-v6so1742740plt.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 18:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=V4D7UkXXWqrBPxImEp3Uu9sddqFo5Agazjl0MV7sERg=;
        b=p8UFeBCXZIKsUA06vPYiow8XlDcXMfTqKUR/QPWbfnBYLjiP/DWs13bM6/aho5oY03
         r8fynDjByMujxenG05p43xOB4wn0VuYZyCBkTUjQh5pvHwZ6UD40VFDbJPE5Ynhd5Trq
         V4a1+LmslHCLMrM2H9TN0PRGZ9zV1slQ4Ep+0Iy5pKb7aXsKD/gLjO+fHQ6G6cgb7xxd
         t8CfHeyNxwzulFi58biuovKcrvr7y5ow7csTRUnxF0O1Kgiri0KV50y+3RH320Gcz7Du
         FPC62j72vLDW2p0h3S7EkqHOGMirGrmTYBjAPV1Ysf64y/vGQH2Kr7aDNS3Pgm8Xnlpr
         ZBzA==
X-Gm-Message-State: AOUpUlHhJAM9/3vBxPZsRJ+9VElPGQp3guZA0Dhuw8CINQB/wDTB6lCD
        GLVQUvvC3HVqe0gS9knKuDV8OWfsCanjZIETNpJtvuS2n4ncKB3WUCZ2+SIEToNTzabToRfxdjD
        8SD9gkifDo+9vdmtmGsbGcmNCwSUeCEkim0X48SCdAQ==
X-Received: by 2002:a17:902:b784:: with SMTP id e4-v6mr26250414pls.204.1534988040923;
        Wed, 22 Aug 2018 18:34:00 -0700 (PDT)
X-Google-Smtp-Source: AA+uWPw8awKZNw3cgpMUSzvnAH2Ghmh6C4eCmNyRmyitgk5r3w6MrSosU0ELkbAMg4WVpLjQAA7OsA==
X-Received: by 2002:a17:902:b784:: with SMTP id e4-v6mr26250400pls.204.1534988040554;
        Wed, 22 Aug 2018 18:34:00 -0700 (PDT)
Received: from [192.168.1.206] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id l85-v6sm5072926pfk.34.2018.08.22.18.33.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 18:34:00 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] ath9k: turn on btcoex_enable as default
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <6A0F65EF-A7C4-469F-8FAF-CBE314676237@canonical.com>
Date:   Thu, 23 Aug 2018 09:33:56 +0800
Cc:     Kalle Valo <kvalo@codeaurora.org>, ath9k-devel@qca.qualcomm.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
Message-Id: <9AF82E83-2EBE-4076-BAFA-EEA44B1DB423@canonical.com>
References: <20180208052801.15670-1-kai.heng.feng@canonical.com>
 <56d650e6-d26f-087c-4e86-2e5d4e859414@nbd.name>
 <A5972CE9-8325-404A-A63D-ED29E44FB67B@canonical.com>
 <87k1vmeip8.fsf@kamboji.qca.qualcomm.com>
 <E500FA42-23F1-433F-9BFB-78A2FD1946AF@canonical.com>
 <7170e2d5-a59d-8260-fa8e-f02f583b773f@nbd.name>
 <6A0F65EF-A7C4-469F-8FAF-CBE314676237@canonical.com>
To:     Felix Fietkau <nbd@nbd.name>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 12:15, Kai Heng Feng <kai.heng.feng@canonical.com> wrote:

>
>
>> On 10 Feb 2018, at 10:05 PM, Felix Fietkau <nbd@nbd.name> wrote:
>>
>> On 2018-02-10 14:56, Kai Heng Feng wrote:
>>>> On 9 Feb 2018, at 3:16 PM, Kalle Valo <kvalo@codeaurora.org> wrote:
>>>> Sure, but we have to make sure that we don't create regressions on
>>>> existing systems. For example, did you test this with any system which
>>>> don't support btcoex? (just asking, haven't tested this myself)
>>>
>>> No not really, but I will definitely test it.
>>> The only module I have that uses ath9k is Dell’s DW1707.
>>> How do I check if it support btcoex or not?
>> I just reviewed the code again, and I am sure that we cannot merge this
>> patch. Enabling the btcoex parameter makes the driver enable a whole
>> bunch of code starting timers, listening to some GPIOs, etc.
>>
>> On non-btcoex systems, some of those GPIOs might be floating or even
>> connected to different things, which could cause a lot of undefined
>> behavior.
>>
>> This is simply too big a risk, so there absolutely needs to be a
>> whitelist for systems that need this, otherwise it has to remain
>> disabled by default.
>
> So what information can we use to whitelist btcoex chips?
> Can we get btcoex support status at ath9k probing?

Sorry for bringing this up again.

Is DMI based match an acceptable approach for ath9k?

Kai-Heng

>
> Kai-Heng
>
>> - Felix


