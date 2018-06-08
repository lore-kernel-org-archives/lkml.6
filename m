Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id XcIwOEhbGlsMaQAAmS7hNA
	; Fri, 08 Jun 2018 10:32:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CA92A607A4; Fri,  8 Jun 2018 10:32:40 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CvjFuByv"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4713460590;
	Fri,  8 Jun 2018 10:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4713460590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752667AbeFHKci (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 06:32:38 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39397 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751265AbeFHKch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 06:32:37 -0400
Received: by mail-wm0-f68.google.com with SMTP id p11-v6so2737690wmc.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 03:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dITMI4l7aJUATZu4oKRtakaJjgYR8lqhz1VJoiK+mrY=;
        b=CvjFuByve6LTNffcwGH5lgj2EP7oYKiXaqtVeW0zTnmar/Guy5MwJxvasxSxbi05Oq
         O/U7OWAJ/nk3YdCDhcu6UztNaBYyKpNem6AFwQMnwtypsrWLp/dzSr42lTfVrmy4jyOi
         WWxGGfQLgBzRUsuvypHm1l885I61Xpde6jee4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dITMI4l7aJUATZu4oKRtakaJjgYR8lqhz1VJoiK+mrY=;
        b=sqG7EaJdKxzZhW+z1eCG2WWFPUQbMU2j6Ax6lyGKsdK/EngOX9JbQdRRFao0BJDXJR
         L6iNYxwJ9s2YSINHw1q7inaGssmGWqWFxog3z68zAdb/tYZ038b4lhmLcy2uzu246IHJ
         ROnOPmOUAy83XIvwy0tO04Oi0K5xP04PFSthf7/HTIiHMUeCt+IXwPeYZLOHfm3fUE37
         uhoPAikk9LexiHsj9+OTMZvimZ17Ud/A2rDjE4mDUbraPv9vwwE2TeV5v82H9HrPdrpJ
         uqlfWYlrUnDcfDRwZRzSQcQynLVKximPD5mjJQOt2F52OJB5kWw6zKQnZX7EX4jj9qdX
         8Kqw==
X-Gm-Message-State: APt69E2Y1pqWwjnKEbWjYp7ddWN820LZP9MVqbd3oWxyKgYUpLK64Ucc
        rCl/1uOMIQGiqWzvFsBEM+Jl//rEg8s=
X-Google-Smtp-Source: ADUXVKLt27nLnzQs4oNCves68fFqxS8qrW92aWmeIhPScgpnl0xZnhJcbpKeuP1Ckf9wnfwn81Sngw==
X-Received: by 2002:a1c:4252:: with SMTP id p79-v6mr1114762wma.119.1528453955785;
        Fri, 08 Jun 2018 03:32:35 -0700 (PDT)
Received: from [192.168.1.100] (aig34-1-88-167-228-121.fbx.proxad.net. [88.167.228.121])
        by smtp.gmail.com with ESMTPSA id i76-v6sm1741406wmd.20.2018.06.08.03.32.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 03:32:34 -0700 (PDT)
Subject: Re: [PATCH RESEND] lib/test_printf.c: call wait_for_random_bytes()
 before plain %p tests
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180604113708.11554-1-thierry.escande@linaro.org>
 <20180607122434.i4x7b5ij4p6dpx7w@pathway.suse.cz>
 <d9ecdf72-7500-66d4-0360-231218cccbb4@linaro.org>
 <20180608080437.n2b5nv73d3kp6yhb@pathway.suse.cz>
 <0fa30e13-c16f-95d8-d1ef-fd45e7a99888@linaro.org>
 <CAHp75Vc5_+Kxsvgws9Oq-hOgbQ8-ocxeKa4AuhC0uJ0oKsu+BA@mail.gmail.com>
From: Thierry Escande <thierry.escande@linaro.org>
Message-ID: <a8ab166e-a2b9-b0fc-9717-ffd8fcbcd386@linaro.org>
Date: Fri, 8 Jun 2018 12:32:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vc5_+Kxsvgws9Oq-hOgbQ8-ocxeKa4AuhC0uJ0oKsu+BA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2018 11:46, Andy Shevchenko wrote:
> On Fri, Jun 8, 2018 at 12:07 PM, Thierry Escande
> <thierry.escande@linaro.org> wrote:
> 
>> But as I type I realize it's not necessary. I will simply enclose the call
>> to wait_for_random_bytes() by #if IS_MODULE() #endif so it gets called only
>> if built as a module, which is how run_kselftest.sh wants it... If
>> test_printf is compiled built-in and the crng is not yet initialized the
>> test will fail anyway so there is no need to add an extra check.
> 
> Unfortunately I can't support this as is.
> We have environments where crng will be ready minutes after the boot.
> It's unacceptable.
> 
> So, we need to have means to not delay test for so long.

I agree we can't delay test execution for too long. In my case the crng 
is ready only a few seconds after the boot. So we may just skip this 
plain 'p' printf test if crng is not ready then.

Regards,
Thierry
