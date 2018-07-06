Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2592C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A808F22B46
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A808F22B46
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933452AbeGFXfd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 19:35:33 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:46174 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932774AbeGFXfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 19:35:32 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w66NZR3H075801;
        Sat, 7 Jul 2018 08:35:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Sat, 07 Jul 2018 08:35:27 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w66NZRQe075798
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 7 Jul 2018 08:35:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] uts: Don't randomize "struct uts_namespace".
To:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1530871650-3582-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CA+55aFzK5z4VQEMQAOqVHXpm+o_gd_eg5Vecck07E=WmoO6BFA@mail.gmail.com>
 <CAGXu5jKrM_3ymnmcJ+AE1A3uVPDJykRj0z5B8sDoxM6zUnX-Rg@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <945be212-8e82-9dd8-930f-4e5c11dcae77@i-love.sakura.ne.jp>
Date:   Sat, 7 Jul 2018 08:35:28 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKrM_3ymnmcJ+AE1A3uVPDJykRj0z5B8sDoxM6zUnX-Rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm waiting for response from makedumpfile developers.

But makedumpfile is a tool for saving kernel crash dump.
If makedumpfile cannot work, we cannot use kernel crash dump.

On 2018/07/07 8:19, Kees Cook wrote:
> On Fri, Jul 6, 2018 at 9:11 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> On Fri, Jul 6, 2018 at 3:07 AM Tetsuo Handa
>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>>
>>> I noticed that makedumpfile utility is failing to check kernel version, for
>>> it depends on offset of "struct uts_namespace"->name being sizeof(int).
>>
>> For something like this, we fix makedumpfile instead. This is not a
>> "user program" using system calls etc, this is something that delves
>> into the kernel dump and tries to make sense of it.
>>
>> Where is the makedumpfile source code? What is it trying to do, and why?
>>
>> One option is to just say "hey, you can't make much sense of a
>> randomized kernel dump anyway, so don't even try".
> 
> I would second this -- trying to deal with a randomized layout kernel
> dump is going to be much worse than just looking at uts_namespace. :)
> 
> -Kees
> 

