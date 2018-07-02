Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338FFC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B462536D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iY6/OL4T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B462536D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752642AbeGBOGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:06:19 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:38701 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752033AbeGBOGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:06:16 -0400
Received: by mail-vk0-f65.google.com with SMTP id b77-v6so9222240vkb.5;
        Mon, 02 Jul 2018 07:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sDbtDnmMZj9a1gM23U5obyHS4ZVaSvgFbvWLdsldDu0=;
        b=iY6/OL4Thes9lliApYX69KoVAqSDI+u4p1J8gUMu62/W7afOJGBtqftdtuFXrMNI4Q
         mUy+cgQwgINQ1lIY2VzrPJ0U5SZyr8R+q2uyhyi6nZSCCM0Gf4w7RDsN2SoM6FgP74OJ
         aHmX6vdy57D6JYm14iMFiC9PaQKviyDu6CVZMRz9LdzIL9HCR6qvY3b39GvqPp/ljKTx
         HGs87Qi+4RmW5HF6EY6YKVT9iBFN/YxQtzL9GWpma/p1XYmnza3K20KGPaiTZ6cBwZQE
         NlqsMGoiEOH+QxE/pdymdzYgelBgBHzxX7OkPbUcNl35/LVlHs/LisAyfv3c2Wx1hvyv
         gh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sDbtDnmMZj9a1gM23U5obyHS4ZVaSvgFbvWLdsldDu0=;
        b=q3eLK79rBppeZLtrJEKLin4eqD8IIOw4Bc3JdwXHCdy8NemcMdv/uq9muqKY9IT/GE
         49aPYeDTr+ZIvLOg33yY8hVdLsnAxmm9rZvqnehRMKTqwJbPZ8VGGF3agrAh8c2+jOdM
         F/ZAJJ+D7N1Cwb+fuCQ2u6xE0I/PPTtG/0NH1E4D4d9gANmt4bzF2S3AlPKLs+mU9BCF
         2/6RCGKrhLvyoQRb90I+1Dfiw3xP5O5PuH/JkrblH8nqi5iQYEOqD9voyulNNyL98yyr
         W0okx0G1qshBraNJkdaqjl286X0jZJTzU6F/36aeCDzXXqatPvob4i1nZQE5ucHVjYfF
         q/WQ==
X-Gm-Message-State: APt69E3wXHXK5fs+nInhtYAwe2Su/ZTnaAFOefu12VR/U8Pjjk+xMj6e
        bcw9srKOij6I0GoJIMfYXT5yU9bEl1GuIhj6/KI=
X-Google-Smtp-Source: AAOMgpdSlJGOAJdMBKCcGwMbLHgH3PvG2aC0m3n4HlS8ZNFtAchiX2xbN4tbx9qz8BguflHm/Ui2XnicrWQ/9DXXzH0=
X-Received: by 2002:a1f:20d4:: with SMTP id g203-v6mr13971104vkg.176.1530540375559;
 Mon, 02 Jul 2018 07:06:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 07:06:14 -0700 (PDT)
In-Reply-To: <cc4bc804434a40d9bdd2fa03bbb875aa@ausx13mpc120.AMER.DELL.COM>
References: <20180628181906.54910-1-srinivas.pandruvada@linux.intel.com>
 <74ac9bf130074e0a8f86a7904783d091@ausx13mpc120.AMER.DELL.COM>
 <95b3748fcb911c7305bd2bbcfd4e368f044f8b14.camel@linux.intel.com>
 <CAHp75VdX+i_N_GttiL3QZrpivpUeJa0ofGfeJR1FkfuiBWocqA@mail.gmail.com> <cc4bc804434a40d9bdd2fa03bbb875aa@ausx13mpc120.AMER.DELL.COM>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 2 Jul 2018 17:06:14 +0300
Message-ID: <CAHp75VerxQrPwHTU9PF_q_8xkRm7=cBTPf2tb_5xPEoBQKcL8A@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86: intel-hid: Add support for Device
 Specific Methods
To:     Mario Limonciello <Mario.Limonciello@dell.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Alex Hung <alex.hung@canonical.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 4:51 PM,  <Mario.Limonciello@dell.com> wrote:

>> > So there are some customers who will have issue with power button
>> > without this patch, so it should be also marked for stable also.
>> > Also this may be a candidate for 4.18-rcX.
>> >
>>
>> I'm not sure Greg will take this selling point for rather big patch.
>> From changelog, honestly, I don't see any regression description,
>> looks like "it wasn't working before change anyway".
>>
>
> Just for adding some context.
>
> Some platforms have moved to different interface in ASL in FW upgrade
> due to deficiencies/bugs present with old interface.  So yes it's platform FW
> change in behavior that leads to Linux kernel regression.  Windows driver has supported
> both interfaces for a long time.  Linux kernel however doesn't support this interface until now.
>
>> For now, I pushed this to my review and testing queue as is, thanks!
>
> If not stable I think it would at least be ideal to try to bring this to 4.18-rcX if possible for
> compatibility with more platforms that will come with this other interface instead.

Citing Linus:

--- 8< --- 8< ---
So please, people, the "fixes" during the rc series really should be
things that are _regressions_. If it used to work, and it no longer does,
then fixing that is a good and proper fix. Or if something oopses or has a
security implication, then the fix for that is a real fix.

But if it's something that has never worked, even if it "fixes" some
behavior, then it's new development, and that should come in during the
merge window. Just because you think it's a "fix" doesn't mean that it
really is one, at least in the "during the rc series" sense.
--- 8< --- 8< ---

So, if we can sell him that it used to work and firmware fix is a
Linux regression I'm fine.

Darren, what do you think?

-- 
With Best Regards,
Andy Shevchenko
