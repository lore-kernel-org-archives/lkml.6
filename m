Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EFEC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2029D2146E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uVqFn2H7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388487AbeLVREp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:04:45 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33251 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729637AbeLVREo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:04:44 -0500
Received: by mail-wm1-f66.google.com with SMTP id r24so16363731wmh.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 09:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8iEjNoTJXDO0rTFZkxKW8Avwjnii7GuykR1eFRH7jmo=;
        b=uVqFn2H7UoT8MO8rl8BP6L1evcETAoaOyBSrB8mRrwusc1YIC67we/U+P/xKh3CyM1
         RchPebYgppDDNlpt1S15PYLw/laoAt4oOxeePK252Fu1uud3EMwbuoZIH4NFvXeotgmz
         w2GrgnTJScvFF/OffKXkrE8V9LsL0U02IlI8NWBNKALZ8Cpl7Sg0ddDVwcBxfkEzwOkt
         xNx6V6slluKnTmGBgU/IUN/yvyahhLjEGSaxkj5csQJqAOi54h2jVDeszthwUhx1DUaa
         n0OlExLk5PRo3eZUcPFxxccecx1ad1NgsPfby2GB1DLkPnKUSYmNmp8lTwwhACmRJZT7
         NUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8iEjNoTJXDO0rTFZkxKW8Avwjnii7GuykR1eFRH7jmo=;
        b=OhrnHdrMnU+dcrR5qCXvASCVsLcpUk4Z2fhtniu/sWVWtiz8tfcPjlEEpyWfIBclZm
         upeFdPzpJSGzywlbwVapr4X0dtWMxCB6cU5ImRbabfkS4M5ePhzoXu54/iQ2Gwnrb5Bh
         ugYK4T4Ls8oqcHjcRELZLW7Z+4FNq3auweqm9yZz4TdWPZJWsDWd+yTkuRqOaICqAiLx
         uP2SApjwYuEwcmCVYMGZto4Ms5XGvOePjC4EMC4RGRxJa8uRwz+GPbrh8wr888Yc2qZ1
         zKQf04b9PmLBxIegINc6xHCPacUqfMIhafwudCZffwPR4138KlH/TYtAtdtw14mvS9/0
         OFoA==
X-Gm-Message-State: AA+aEWbBsRWRk9Rlnar95vD7+9wLwOzXYhzLAT3Zaql6dz54iyA0TU4K
        FotRsWSnunIn7WWzL87NoK8BgDyk
X-Google-Smtp-Source: ALg8bN5BLvP63tapfk4pIACurqdoCmnZbRJ2ylpy/Ey/+Dym6/WuQnLoQ2MNdcHiWlMmYl5pkdtYAA==
X-Received: by 2002:a1c:8acf:: with SMTP id m198mr6352209wmd.143.1545474004851;
        Sat, 22 Dec 2018 02:20:04 -0800 (PST)
Received: from [192.168.43.227] (94.197.120.105.threembb.co.uk. [94.197.120.105])
        by smtp.gmail.com with ESMTPSA id t76sm18924350wme.33.2018.12.22.02.20.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 02:20:04 -0800 (PST)
Subject: Re: [for-next][PATCH 23/24] string.h: Add strncmp_prefix() helper
 macro
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joe Perches <joe@perches.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20181221175618.968519903@goodmis.org>
 <20181221175659.208858193@goodmis.org>
 <CAHk-=wg_sR-UEC1ggmkZpypOUYanL5CMX4R7ceuaV4QMf5jBtg@mail.gmail.com>
From:   Malcolm Priestley <tvboxspy@gmail.com>
Message-ID: <e1b3abf2-e7cc-6bfe-f768-8277bb122c11@gmail.com>
Date:   Sat, 22 Dec 2018 10:20:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wg_sR-UEC1ggmkZpypOUYanL5CMX4R7ceuaV4QMf5jBtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2018 18:51, Linus Torvalds wrote:
> On Fri, Dec 21, 2018 at 9:57 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>> I figured the best thing to do is to create a helper macro and place it
>> into include/linux/string.h. And go around and fix all the open coded
>> versions of it later.
>>
>> I plan on only applying this patch and updating the tracing hooks for
>> this merge window. And perhaps use it to fix some of the bugs that were
>> found.
> 
> I like the helper function concept, but as they say about CS: "There
> is only one hard problem in computer science: naming and off-by-one
> errors".
> 
> And this one has that problem. The name makes absolutely no sense.
> 
> Calling it "strncmp_prefix()" when there is no "n" there makes no sense.
> 
> So drop the "n" from the name.
> 
Being British the 'n' implies 'and' and still being interpreted Boolean.

strncmp = string and compare

Like other of our words Fish'n'Chips, Salt'n'Shake.

I don't think these abbreviations exist in American English.
