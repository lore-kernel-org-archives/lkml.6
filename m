Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D05C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D547620846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D547620846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754201AbeFTNnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:43:13 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36886 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753541AbeFTNnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:43:12 -0400
Received: by mail-wm0-f68.google.com with SMTP id r125-v6so7033997wmg.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 06:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LEKv8yFdgt/NYDMDzIkFCRpcCWpFiKQLLU1MoyEipwY=;
        b=LW6kh/FWQqvL6J33ooPV6FRK3Gxy8CN8zIKWfQKT6n7mBy1JxkB0MIt3RD5Ha8XGLv
         4/GoR44T31RY1UgW7KZ5+cN7eZ87X9GUy0NH9pMCbtksYhzqec5kiZf8FIJgT5nalWYh
         CAil55k9ixklkqWj0h5qZ4aYrr+EpFxdyZj08BnTuJP3nOezISIgQs+TUWrTM3JY7F2b
         ogTZRx39bDuF2deoox1ABgSF/SoGr99o6SSODWr6zoj0b2jjCwjCdBiMvMmRwITL6uIY
         OyLH9Nh1vQVO9jUax0r0oyZDUBC0lkyfEuBDDI6jqXPo/65ilcYZCmm0qm1fM0yhj0uM
         MauA==
X-Gm-Message-State: APt69E0nI80+4Q07e1j8r24bCvtj4cGBjLkvqlZl4ebVloYNFGqPW3Cy
        yt2JjRKuZj7kwwc9O26kve9fh5ZNi/s=
X-Google-Smtp-Source: ADUXVKIBtEGrLhYeRRr9HoIf8fbahPqs0wsNrTk5arjHBh8aAKBZaMp24+P8lZTFp6zRsTVMqL8TZQ==
X-Received: by 2002:aa7:d58d:: with SMTP id r13-v6mr18282957edq.176.1529502190673;
        Wed, 20 Jun 2018 06:43:10 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id k29-v6sm1199062ede.96.2018.06.20.06.43.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 06:43:09 -0700 (PDT)
Subject: Re: [PATCH] printk: Make CONSOLE_LOGLEVEL_QUIET configurable
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
References: <20180619115726.3098-1-hdegoede@redhat.com>
 <20180620110335.sjzmtra2z3chvon2@pathway.suse.cz>
 <20180620112436.GF444@jagdpanzerIV>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ad4ecac7-e57b-b058-7179-54c5dd949745@redhat.com>
Date:   Wed, 20 Jun 2018 15:43:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180620112436.GF444@jagdpanzerIV>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20-06-18 13:24, Sergey Senozhatsky wrote:
> On (06/20/18 13:03), Petr Mladek wrote:
>>> This commit makes CONSOLE_LOGLEVEL_QUIET configurable.
>>>
>>> This for example will allow distros which want quiet to really mean quiet
>>> to set CONSOLE_LOGLEVEL_QUIET so that only messages with a higher severity
>>> then KERN_ERR (CRIT, ALERT, EMERG) get printed, avoiding an endless game
>>> of whack-a-mole silencing harmless error messages.
>>
>> I find it a bit confusing that "quiet" would mean something different
>> on different systems.
> 
> Good that you brought this up. I had similar feelings but then the
> patch looked rather simple and I kinda agreed with it. If we can come
> up with alternative solution (you mentioned some) then it would be
> great.

I guess with my downstream hat on that we could live with silent,
but I would much prefer changing quiet, also so that we can lower
the firehose of mostly false-positive bugs coming in because of this.
Here is a short list from quick search which in no way is complete
(tip of the iceberg really):

   1413342 - Linux 4.9.3: ACPI Error: [_OSI] Namespace lookup failure, AE_NOT_FOU
   1415853 - ACPI Error: Namespace lookup failure, AE_NOT_FOUND (20160831/psargs-
   1514937 - ACPI Error: AE_NOT_FOUND
   1527870 - ACPI Error: [\_SB_.PCI0.SAT1] Namespace lookup failure, AE_NOT_FOUND
   1552580 - ACPI Error: Method parse/execution failed
   1553320 - Kernel errors at bootup -- system runs okay
   1556967 - ACPI Error: [SMIC] Namespace lookup failure, AE_ALREADY_EXISTS
   1582825 - ACPI Error: Method parse/execution failed
   https://bugzilla.kernel.org/show_bug.cgi?id=109511
   https://bugzilla.kernel.org/show_bug.cgi?id=194687

If we change quiet to filter these out, all of these will go away, if
we add a new silent option then only fresh installs will get the
new silent option and the benefit will be much reduced.

Besides that we would also need to make e.g. arch/x86/boot/edd.c
check for both quiet and silent and of course init/main.c and probably
others too, so form a code complexity pov the Kconfig way seems better too.

Regards,

Hans
