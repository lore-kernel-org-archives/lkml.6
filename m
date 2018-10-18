Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6B3C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153742145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWzWUbC9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 153742145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbeJSABB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 20:01:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45714 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbeJSABA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 20:01:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id f17-v6so2528053wrs.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 08:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nFG/b7FANiOaFo5ao/k2hSWS+TiAjlaXa3P+TVoz7TQ=;
        b=pWzWUbC9rFpuwWl6pcx85mADysq2Utfo02KVTXGp/PMX8BE9HScGa6MGlBxXO3Z38J
         BchipmZ+7Mv2at4HPMcksULE8uARoagbI7pqjiZlcCHFyh2Nvp+8WKLbWqLa6YxzEF8B
         Iqk4RBiNTqucHSIDTyZg7R2YR5Ky1EO03JMPxf3VPofj/PFmcyQDU8NUoL7AE64XTyDn
         P5b9gcPkN/rQyWkcIeWAjNuUMvdrQYysn6FcCjFmXOI+TKOcLfCrAOZkiSKoufCPKr4m
         ALVsgWDeqbzra8n0DN0ojgUsb2x6FT8OfqlFgzv2Qiqjf8Oe/GrAarGvQdWhjQvxjXA1
         sdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nFG/b7FANiOaFo5ao/k2hSWS+TiAjlaXa3P+TVoz7TQ=;
        b=MAjjigHweUHHZUl8Fo+Cbs/GafvxH5Uqb+pV/UJqcMxztQxcLVO/uEZj6G9BUy2k8g
         iEXLJ/U+W5zB0h9KyZFJEYc873xsIgh14ffjFwyNPrAfq6sFAlunyicOV0PR00yWaeu4
         BNHhoNrcO6nCv/1ZUN8EdbbFsXZ+81A/HJi5SdW5XlJud4d9u5W7uuOkhkK26b9OlAns
         17VAOF7qoqOwg3TxhZTItutGF+DtgVN6g+Wyu5NMoNGxQ3gLHpQzHEQK7WyHMmMPJNRG
         yKP31ZuuGkb1sG2b7pG/KSRThI1DzKX4YiYSv6UKPbHgRbEdDmZLYayrEOLw0hHYK2EC
         wfvw==
X-Gm-Message-State: ABuFfogL6kr8lac6nB/24Oeksj0iq7B74VCKarAYZqfVDA4F/F8rMDjk
        yXvtWidU4VtGdsYqP8nG85iTCez2yKYEmA7neMo=
X-Google-Smtp-Source: ACcGV61tvKdhEKbJCFu9md4dV6EKKBe+NL0zTJrPVJqlCL4LWchrVe+IlLpZtbSCw0LO4h+hSC/dkD/TWfsxKFvQuFk=
X-Received: by 2002:a5d:424c:: with SMTP id s12-v6mr8648088wrr.260.1539878361332;
 Thu, 18 Oct 2018 08:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20181018142133.12341-1-tiny.windzz@gmail.com>
In-Reply-To: <20181018142133.12341-1-tiny.windzz@gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Thu, 18 Oct 2018 23:58:08 +0800
Message-ID: <CAEExFWvwnzEwEiqy7PnbOLckwDcadudp9=krry8W=p4UOUovUA@mail.gmail.com>
Subject: Re: [PATCH] softirq: modify comments about PF_MEMALLOC in __do_softirq
To:     joel@joelfernandes.org, tglx@linutronix.de
Cc:     mingo@kernel.org, rostedt@goodmis.org, frederic@kernel.org,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        alexander.levin@verizon.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This place looks like a small mistake. :-)

-- Yangtao Li

>On Thu, 18 Oct 2018
>Steven Rostedt (VMware) <rostedt@goodmis.org> wrote:
>I don't know if the trivial tree is dead or not, but this would be a
>prime candidate.
>
>Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>
>-- Steve
>
>
>On Thu, 18 Oct 2018 10:21:33 -0400
>Yangtao Li <tiny.windzz@gmail.com> wrote:
>
>> ---
>>  kernel/softirq.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/softirq.c b/kernel/softirq.c
>> index 6f584861d329..6193e1d1b30d 100644
>> --- a/kernel/softirq.c
>> +++ b/kernel/softirq.c
>> @@ -257,7 +257,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
>>   int softirq_bit;
>>
>>   /*
>> - * Mask out PF_MEMALLOC s current task context is borrowed for the
>> + * Mask out PF_MEMALLOC as current task context is borrowed for the
>>   * softirq. A softirq handled such as network RX might set PF_MEMALLOC
>>   * again if the socket is related to swap
>>   */

On Thu, Oct 18, 2018 at 10:21 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> ---
>  kernel/softirq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 6f584861d329..6193e1d1b30d 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -257,7 +257,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
>         int softirq_bit;
>
>         /*
> -        * Mask out PF_MEMALLOC s current task context is borrowed for the
> +        * Mask out PF_MEMALLOC as current task context is borrowed for the
>          * softirq. A softirq handled such as network RX might set PF_MEMALLOC
>          * again if the socket is related to swap
>          */
> --
> 2.17.0
>
