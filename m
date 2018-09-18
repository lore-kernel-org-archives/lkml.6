Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783F8C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CC021471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOoimuZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06CC021471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbeIRUk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:40:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45321 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729618AbeIRUk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:40:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id 20-v6so2479947wrb.12;
        Tue, 18 Sep 2018 08:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9bG/SpXvx9wkojMsLQtvP/VSO5oqBDXfqfliofzy+qw=;
        b=gOoimuZWcF5EVO+1oXXkfWfbJcQANkgG6SSTa8OYIiJWmg8X4May1jQe6OG/DuUD4g
         wVP4RxBFCD2Fv7uHikmlqhGDbn+yyBZgCU2euxWZx0DBZEamQ9bdfQEjogxgYVY3nWih
         jyPuMFXmTWRWmm4YFiwBIIgtOCMpy4rbuMalhAwh/Q7dQhK6YFxeVha/8MwrQpoG8bWK
         o70LPXlcYRAwzbUDBmP88gfhFlQ7IOadQlk2rbgyI8LwblDOCqyw2WDyUB4bxNiCrDED
         uHNxhZYfCAI+8KrJPop/zJpXpsI6fdY4zsk7vOMZAcxN97tSPoV/g70ITdxGwX3T/M28
         XJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9bG/SpXvx9wkojMsLQtvP/VSO5oqBDXfqfliofzy+qw=;
        b=iI5ABgB7hRLZK90eKxnU0CCeFUSFQB5DOUd63jwDNOs84gXtmMBYKQL8nXTtAtGFOe
         WzegBvcg5lm+RTuHPgXqgT/mFGpu09Cedcw4Oj3GNbymtYaVCe4oMH8+7rrNu6KGHNdi
         mzD6c6H69/Mg8x09MnHE6vM4ZOZ4/azAJ7nJVbU03lWeJsgM2dkuh0aJ5n5ZB/JOdtd3
         m/ZgohoAVosox0348HLqNue+CurPyOTRwWII0J4DaiFrjfPEaK8TCEh8l+g2inpHc+KI
         /I6Ao46HK8cNyiwEdoajz9B2DMENi1yTO2k2ETT0XdA7YM8VxIiXAuIkG26tRw4N2Bly
         yrFg==
X-Gm-Message-State: APzg51ABghzE+kZcpwOMN9mbiJMpgbNnqFxsmRuXjlCQBTFLC1fqlkJT
        0+3Eboa2Zcs80twRNTl2ybs=
X-Google-Smtp-Source: ANB0VdapnnQxbH/QBcsIM1xgUnlHzi/YTHYp+XjG0PGMD4D79LT/LOi5L59SEmpuZG9UyhUwAzU8Vw==
X-Received: by 2002:adf:fb81:: with SMTP id a1-v6mr24983803wrr.219.1537283247146;
        Tue, 18 Sep 2018 08:07:27 -0700 (PDT)
Received: from [192.168.10.165] (94-36-187-248.adsl-ull.clienti.tiscali.it. [94.36.187.248])
        by smtp.googlemail.com with ESMTPSA id h206-v6sm2696583wmf.25.2018.09.18.08.07.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 08:07:26 -0700 (PDT)
Subject: Re: [RFC PATCH 04/10 v2 ] x86/fpu: eager switch PKRU state
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>
References: <20180912133353.20595-1-bigeasy@linutronix.de>
 <20180912133353.20595-5-bigeasy@linutronix.de>
 <8e5b64e4-b3e6-f884-beb6-b7b69ab2d8c1@redhat.com>
 <20180914203501.qibhpmueosvkr74w@linutronix.de>
 <a239e97a-d1a1-388e-5db9-10758c33d702@redhat.com>
 <20180918142701.atfb4ul45k7tl6ew@linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
Message-ID: <7e9a13f3-93f5-fe4a-20d2-f4f9407bd43b@redhat.com>
Date:   Tue, 18 Sep 2018 17:07:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180918142701.atfb4ul45k7tl6ew@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/2018 16:27, Sebastian Andrzej Siewior wrote:
>> Likewise, move this to fpu__clear and outside "if
>> (static_cpu_has(X86_FEATURE_FPU))"?
> okay. But if there is no FPU we did not save/restore the pkru value. Is
> this supposed to be an improvement?

Honestly it just seemed "more correct", but now that I think about it,
kernel threads should run with PKRU=0.  maybe there's a preexisting bug
that your patch has the occasion to fix.

Paolo

>> Also, a __read_pkru() seems to be missing in switch_fpu_prepare.
> But the value is stored during write_pkru(). So the copy that is saved
> should be identical to the value that would be read, correct?
> 

