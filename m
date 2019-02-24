Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C3DC00319
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 18:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B848F206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 18:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ES47LQyF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfBXSZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 13:25:36 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36750 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfBXSZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 13:25:35 -0500
Received: by mail-wm1-f65.google.com with SMTP id j125so6068445wmj.1;
        Sun, 24 Feb 2019 10:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Is74wfUBl6pn9ZZRn/dFpKrxijO+z7ftlavk0sonjIQ=;
        b=ES47LQyF7Cdk7In15dXh8AWjTW1JVb2GNPknLfkCw9fZVxzJoWUHur+l1pan6hOQ7b
         PfdUGsLPB2s+VDvQQ285cxRphjOOLvIqK2ZCDSGW9LfZhXCH5yksi5sRvbdfPIhh4eGf
         g45LerNmjCTbA8L03+533itmFSM3of7VuoLtiEi1WJszpavJk/0FcKNzliML9TVYPTO+
         xIbTYJSzDHBM4mVeu/udaz2F9UhEV7cJOnvogUrtERItrSb5nKb+1oyWPu9ftIAScoOW
         7/uS1W8Jxf29RYtaXn1eqzZB7Ymt2PxytMf2/HWkFMZH0eP0GMgdllnLy5/yZXpM6YkR
         jSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Is74wfUBl6pn9ZZRn/dFpKrxijO+z7ftlavk0sonjIQ=;
        b=PpCa0DE2IxGgDiAgOEGWHje/P6N5lUKObuZQbZzf3AcJU0shA7ltunzqXrdMRqYqAx
         fhp4ordi7rYTM/M+fx3IJHqiu6zApYSfGWpQ5c+BsGyu3R2BQO4ZP7vJf0+WSBdMjtad
         4VoiqK0zhOp/p580tHGYUrQwgah58V3OO4W3pun1iNmgWr40+hv7kBKN4ciExl/YIr84
         JhsJgZoT5nWUKRCdq7IW/EDMxSjCZv00Xl+m1rAiurqPn9JMg6CscTuH/TUXmMGb+y/m
         pr+2vT12a8OzoP2oQqodmROKZZ7Yb78I84HtN5vdVAcaEhjDT1v2Nhc7pGzUU6Mns6wv
         TULA==
X-Gm-Message-State: AHQUAubdPnmmi49IxnUQWpvC+olWWpeziQ/VJC4CWTVk1NbDcKYRPXk+
        O1RFBDmdbRp3qav+vrO7Fv0=
X-Google-Smtp-Source: AHgI3IaUkvacqFKH/8JBRKzjfKJ4qWWY3GOEaNZRG9+ER6BeEe+re+588hfHlwhwbhaQWfSpdwwz6A==
X-Received: by 2002:a7b:c34c:: with SMTP id l12mr8096135wmj.147.1551032732546;
        Sun, 24 Feb 2019 10:25:32 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id p16sm17642556wro.25.2019.02.24.10.25.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 10:25:31 -0800 (PST)
Subject: Re: [PATCH 4.20 11/50] signal: Always notice exiting tasks
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
References: <20190213183655.747168774@linuxfoundation.org>
 <20190213183656.733725215@linuxfoundation.org>
 <95a41702-ac6a-cd58-2ca5-71d879ee923c@gmail.com>
 <20190219090714.GA27102@kroah.com>
From:   Jiri Slaby <jirislaby@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jirislaby@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <07f0b789-b88b-8afd-6a36-354b3c2fb0ba@gmail.com>
Date:   Sun, 24 Feb 2019 19:25:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190219090714.GA27102@kroah.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 02. 19, 10:07, Greg Kroah-Hartman wrote:
> On Tue, Feb 19, 2019 at 07:23:41AM +0100, Jiri Slaby wrote:
>> On 13. 02. 19, 19:38, Greg Kroah-Hartman wrote:
>>> 4.20-stable review patch.  If anyone has any objections, please let me know.
>>>
>>> ------------------
>>>
>>> From: Eric W. Biederman <ebiederm@xmission.com>
>>>
>>> commit 35634ffa1751b6efd8cf75010b509dcb0263e29b upstream.
>>>
>>> Recently syzkaller was able to create unkillablle processes by
>>> creating a timer that is delivered as a thread local signal on SIGHUP,
>>> and receiving SIGHUP SA_NODEFERER.  Ultimately causing a loop
>>> failing to deliver SIGHUP but always trying.
>>>
>>> Upon examination it turns out part of the problem is actually most of
>>> the solution.  Since 2.5 signal delivery has found all fatal signals,
>>> marked the signal group for death, and queued SIGKILL in every threads
>>> thread queue relying on signal->group_exit_code to preserve the
>>> information of which was the actual fatal signal.
>>>
>>> The conversion of all fatal signals to SIGKILL results in the
>>> synchronous signal heuristic in next_signal kicking in and preferring
>>> SIGHUP to SIGKILL.  Which is especially problematic as all
>>> fatal signals have already been transformed into SIGKILL.
>>>
>>> Instead of dequeueing signals and depending upon SIGKILL to
>>> be the first signal dequeued, first test if the signal group
>>> has already been marked for death.  This guarantees that
>>> nothing in the signal queue can prevent a process that needs
>>> to exit from exiting.
>>>
>>> Cc: stable@vger.kernel.org
>>> Tested-by: Dmitry Vyukov <dvyukov@google.com>
>>> Reported-by: Dmitry Vyukov <dvyukov@google.com>
>>> Ref: ebf5ebe31d2c ("[PATCH] signal-fixes-2.5.59-A4")
>>> History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
>>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>> This patch breaks strace self-tests in 4.20.9. In particular,
>> "threads-execve":
>> https://github.com/strace/strace/blob/master/tests/threads-execve.c
>> https://github.com/strace/strace/blob/master/tests/threads-execve.test
>>
>> The test received some fix a day ago, but it did not help in this case:
>>  https://github.com/strace/strace/commit/2a50278b9
>>
>> Only a revert of the above patch helped.
>>
>> I don't know if the strace's test is broken (which is quite usual in
>> cases like these) or the patch affects some user-visible behaviour --
>> e.g. could this be a reason for sh failures in the build farm?
>>
>> Any ideas?
> 
> Does cf43a757fd49 ("signal: Restore the stop PTRACE_EVENT_EXIT") help
> with this?  It's queued up for the next round of stable releases and is
> in Linus's tree.

Yes, confirmed.

thanks,
-- 
js
