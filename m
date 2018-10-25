Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2097C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90BDE2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnMzCL4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90BDE2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeJZDYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:24:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33737 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbeJZDYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:24:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id a15-v6so811463pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 11:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CCcfAAa60Lij0HK6kPABjhvOUAflfQrx47AmMuzdjxc=;
        b=DnMzCL4SagvhfHVpD6SVmVjYcNLZ6QkDQyYr+ObYRkjw6dIA+Sfz97ooB4tK++pm0q
         Cz300rYEF5ObHh0aOon5W9GtWrRYgP21FbDYPbrxiXRM41dNcU6CwcYJwpmuCaQY22uV
         rNd60PV3AFFZtZben3V9DTwX9XhyqkUXFL98PQ51YdW9J+QmSMGyTkxKjKKe8hbPPTZE
         LlTWQ261r1lFPeWM+/L6P/roQgyluNmWbjAspkfqmpUsqYoonsVd+fxp4EV7qyzbSp88
         00tPsDHtLnisi0qulBXwhP8wXNshFUfSUOEzLqQEUfkqZPC5pS0zbCLb/D+u1mVxmeZO
         ToYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CCcfAAa60Lij0HK6kPABjhvOUAflfQrx47AmMuzdjxc=;
        b=Qo4WnDDxIQLp48x5r1YetIsAzv0ciFLVlHZhVzwnO3CZgg6yWE9ALGyqGpCGol9uF9
         e4EaUQvZ9+a6aLyZFaoZAH9w6fQBkP16KZ+9++ac9Q/eHE42EPTipyl9gEKSAYRjzcvS
         4rgbmXxK3kRoBktuLu2spXv81p1IgE/rkuuousoG5t+xpc7p1GumQNLfSHfhUx/oGPgh
         +WYV42yWC4T9fhVgztu4rTEF8S+LwkJNcoRubrsYg/mDi3lrips6FBvE64NpzTYdsbkY
         LPtE6AHEyLek874DpcL8lyr4TAeFdeGOOM6ZTzhHDKXIWjkQlg+M5ctwmho8P/fMjEsT
         09qg==
X-Gm-Message-State: AGRZ1gKR/sSnJJkKC1X8GLXMJrJL6yxQA0qW/WA1FLqUdoBI9stjrc1y
        /+RlnkGWPHaWZenhYo5CG3apN8cb
X-Google-Smtp-Source: AJdET5em0MawkWpHIAv1bP1zN9uxEXNXQ/8p3oOhzjGia4h2/ON+EQz+KlbhpwoZ5XV4kcdyVVFxYw==
X-Received: by 2002:aa7:8195:: with SMTP id g21-v6mr359628pfi.71.1540493447088;
        Thu, 25 Oct 2018 11:50:47 -0700 (PDT)
Received: from [10.67.49.121] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id m5-v6sm6674289pfc.188.2018.10.25.11.50.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 11:50:46 -0700 (PDT)
Subject: Re: [PATCH] ARM: mm: Facilitate debugging CONFIG_KUSER_HELPERS
 disabled
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-arm-kernel@lists.infradead.org, andrew@lunn.ch,
        Russell King <linux@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20181025180957.7900-1-f.fainelli@gmail.com>
 <87tvl9nas6.fsf@xmission.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <a48601e2-dde2-47b8-b591-ffccdc9f1bf8@gmail.com>
Date:   Thu, 25 Oct 2018 11:50:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <87tvl9nas6.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/18 11:25 AM, Eric W. Biederman wrote:
> Florian Fainelli <f.fainelli@gmail.com> writes:
> 
>> Some software such as perf makes unconditional use of the special
>> [vectors] page which is only provided when CONFIG_KUSER_HELPERS is
>> enabled in the kernel.
>>
>> Facilitate the debugging of such situations by printing a debug message
>> to the kernel log showing the task name and the faulting address.
> 
> Can't someone trigger this segv deliberately and spam the kerne log?
> Doesn't this need something like printk_ratelimit or something to ensure
> this message only gets printed once?

Yes, good point, thanks.
-- 
Florian
