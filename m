Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0221C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80782241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUBsExjJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A80782241E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbeKMCJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:09:40 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37848 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbeKMCJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:09:40 -0500
Received: by mail-oi1-f196.google.com with SMTP id w66-v6so7613359oiw.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 08:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:reply-to:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WCxdd0//IIzUxm+lNrxUD5GYI7ABQ6z+wT+ygV3jmFQ=;
        b=SUBsExjJjdpDAR1Iy+5c4raa8Vi3vz9pVDrZuFx39Et8oZ6cqMz5F25gAeehCSOvLj
         3qpDDvLsDOFkvckIsDJ7iI/5MtdHgIq9Vxhqh8KRVzULOPXy1N8mViqk0F8HScHtQ6CQ
         HGHDgPjq93TmkKaHtWrc3ltTHaLQHZ4pRbVCRfJkNWbEAmTSSSU9L8sAI2rPjHP/8S+H
         JQQhgYv+M9nPQH0y1CImI5UKivbgOZS8lx7ymfo7AXZmiLn+fT9qQEgIfMZVYWmS+NCm
         sa6JEgB+WzuQ6F0ID+4hCzNSMGfWb1d59/b/coE+QaJSQA3sVgCdpX8b/jQ2vDKpVJ/L
         QK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=WCxdd0//IIzUxm+lNrxUD5GYI7ABQ6z+wT+ygV3jmFQ=;
        b=UE9esHk2corRoWWYlSq8Om5QQK7jORw1kGerd1b42YiK1NslYx5ryTQG5yK5804sD/
         /lo+yFTEc7S0mBOlBfy6E4U0NZOurVMKA8VrUeZjm2aTicyK9YbpC5T4bbxd/krGR8NO
         ToxIuGXQTS30pXG1YDTg/HHV5pDU1C4JKdXyzPgWZEfnIGy9akcZJ3ECofu3lmPvNBem
         6V/9OCPNghI6lS3iW9QI/gY3cSD1nWTKopWj7N5nWjjGGd+m1ZJpTxskZbzDuCR5y/QH
         epjxRfyTwE3KaYxqYgkxHs0svoTc7de6Y70LQNug+CPL/uiuDBj2zlD1YhNU+qANe9Cs
         Dovw==
X-Gm-Message-State: AGRZ1gJNFeRroHu6XOhXEsrZMLVX2R5YjdpAJyiy+OWrACVOU+pcsVhc
        Iduq5hNgnX3NH5chm6MtXA==
X-Google-Smtp-Source: AJdET5dBBZluLDSJbLWmwGkpQwh3JKTX41hFPa50VEERqGk8U2eWDI9fScI+BNRHl4ONzZ1QF646Ug==
X-Received: by 2002:aca:b183:: with SMTP id a125-v6mr928806oif.44.1542039344038;
        Mon, 12 Nov 2018 08:15:44 -0800 (PST)
Received: from serve.minyard.net ([47.184.128.64])
        by smtp.gmail.com with ESMTPSA id 43sm8299603otz.66.2018.11.12.08.15.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 08:15:43 -0800 (PST)
Received: from [192.168.27.3] (t430m.minyard.net [192.168.27.3])
        by serve.minyard.net (Postfix) with ESMTPSA id BFB09941;
        Mon, 12 Nov 2018 10:15:41 -0600 (CST)
Reply-To: minyard@acm.org
Subject: Re: [PATCH tip/core/rcu 10/41] drivers/ipmi: Replace
 synchronize_sched() with synchronize_rcu()
To:     paulmck@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net
References: <20181111194104.GA4787@linux.ibm.com>
 <20181111194410.6368-10-paulmck@linux.ibm.com>
 <16c19493-44b0-18e3-d3cb-4d6c2f9f9f53@acm.org>
 <20181112160425.GJ4170@linux.ibm.com>
From:   Corey Minyard <minyard@acm.org>
Message-ID: <465ebdbb-188c-c4b8-935b-58205b9f98e5@acm.org>
Date:   Mon, 12 Nov 2018 10:15:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181112160425.GJ4170@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/18 10:04 AM, Paul E. McKenney wrote:
> On Mon, Nov 12, 2018 at 09:38:55AM -0600, Corey Minyard wrote:
>> On 11/11/18 1:43 PM, Paul E. McKenney wrote:
>>> Now that synchronize_rcu() waits for preempt-disable regions of code
>>> as well as RCU read-side critical sections, synchronize_sched() can be
>>> replaced by synchronize_rcu().  This commit therefore makes this change.
>> Assuming the above is true, this looks fine to me.
>>
>> Acked-by: Corey MInyard <cminyard@mvista.com>


Dang, that's

Acked-by: Corey Minyard <cminyard@mvista.com>


> Thank you!
>
>> Or I can take it in my tree, either way.
> I will carry it unless/until I send it upstream (this coming merge
> window) or I see it already upstream.
>
> So your choice.  ;-)


Ok, if you don't mind, you can carry it.

Thanks,

-corey


> 							Thanx, Paul
>
>> -corey
>>
>>
>>> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
>>> Cc: Corey Minyard <minyard@acm.org>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: <openipmi-developer@lists.sourceforge.net>
>>> ---
>>>   drivers/char/ipmi/ipmi_si_intf.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
>>> index 677618e6f1f7..dc8603d34320 100644
>>> --- a/drivers/char/ipmi/ipmi_si_intf.c
>>> +++ b/drivers/char/ipmi/ipmi_si_intf.c
>>> @@ -2187,7 +2187,7 @@ static void shutdown_smi(void *send_info)
>>>   	 * handlers might have been running before we freed the
>>>   	 * interrupt.
>>>   	 */
>>> -	synchronize_sched();
>>> +	synchronize_rcu();
>>>   	/*
>>>   	 * Timeouts are stopped, now make sure the interrupts are off
>>

