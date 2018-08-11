Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839DBC46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 04:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CAA62084C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 04:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fy3X6h52"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CAA62084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbeHKGmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 02:42:52 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37450 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbeHKGmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 02:42:51 -0400
Received: by mail-pl0-f66.google.com with SMTP id d5-v6so4809915pll.4;
        Fri, 10 Aug 2018 21:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gh+wWwkv/kRkVjUWYe0v6f4wp36nB59d6Dd6MqPCPqI=;
        b=Fy3X6h52nTQdyrqS+m74le4jvIWwOBLc/ckl5kGCD3AWZhqByyIqv2pXznM2j+6/cW
         OVesYxGsHUeDi2wcIYj2o41BUaTiZQqgYQ9A4bQXarDlXmo6BmzYK4kVmtS/6ANZu3Mi
         RYHpC49PtQA0uXCwkq9pXm1z6Mwb0eS+Jh10zb1OJsc6qJzAVHGNlCbpKtN8YW+OISIb
         qVU1NqB+ybwxiqnzVsnu3j+4FNCY0sutUx2I3jJdxoOFhFJ0I0QAkHz56sZEnh7McC3M
         6QSMaEy/MNmnJYqXFUoK0Qh1GameIK7AdlWNqN8nYv5WECsNsYpQ3yx9DLK23EkNIDz0
         R/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=gh+wWwkv/kRkVjUWYe0v6f4wp36nB59d6Dd6MqPCPqI=;
        b=evIEMVAAL5LoRFq1n8ovbMa/RQDQD0bFaplgjfHh8j2x3BA3wzBrOaa5nvWVHqOB6j
         742MKMY5gHCCdsqMq4hTOmxH+XzHKU/Ol971/lHbmzq6IR/p29e19ZLhE03dqH+eua7+
         WsH8Cjpe+OLqPuFFchPHAXjZlHFMhBD3qgRr6g3PmF1/3dWl0zddvCZ/n9/klv4stCYP
         QtlWnFD5PPSqpCDYsg7eJrOQMacb+TSSMobQGYZ79AZ0SiYlsXm35mcZKxvKifP5MY8j
         8W1pTVRQSnzfCEbKtsh2zFr1+SDFcLle9niS6JOMNrigjIDXJJvTM0qmF4ngMcIY6EOR
         cotA==
X-Gm-Message-State: AOUpUlGOnMJnXKZPpuHUsSGcpsegN7k7pz8GMBEna1vQ+Cj3xb2eL0LG
        YKoG2Vj4BQy6j6kVnhwFxEI=
X-Google-Smtp-Source: AA+uWPzXtk98kIzltr2VtqbJHdANy0fZyIa2YTc/dn8JC2LdnZYpx9I+UZywiBDa9Am/vIyYn4u94g==
X-Received: by 2002:a17:902:904c:: with SMTP id w12-v6mr8541747plz.95.1533960607436;
        Fri, 10 Aug 2018 21:10:07 -0700 (PDT)
Received: from cloudburst.twiddle.net (97-113-8-179.tukw.qwest.net. [97.113.8.179])
        by smtp.googlemail.com with ESMTPSA id r23-v6sm22345799pfj.5.2018.08.10.21.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 21:10:06 -0700 (PDT)
Subject: Re: [PATCH 3/6] alpha: Unify the not-implemented system call entry
 name
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Firoz Khan <firoz.khan@linaro.org>, linux-alpha@vger.kernel.org,
        ink@jurassic.park.msu.ru, mattst88@gmail.com,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com
References: <1531736638-15294-1-git-send-email-firoz.khan@linaro.org>
 <1531736638-15294-4-git-send-email-firoz.khan@linaro.org>
 <20180811000455.GC6515@ZenIV.linux.org.uk>
 <98937991-cefa-b7f3-11c3-12727b3159b1@twiddle.net>
 <20180811024553.GF6515@ZenIV.linux.org.uk>
From:   Richard Henderson <rth@twiddle.net>
Openpgp: preference=signencrypt
Autocrypt: addr=rth@twiddle.net; prefer-encrypt=mutual; keydata=
 xsBNBFGuLC8BCADcAoWcnW9lTsDMzbO3MBU+KbiGaj5JPatEUscRDkQYM2fyNjJp2tIWDK5a
 n4yngeXB3eX61WbYR3QraRK8mlYLGxyAdHMEQfPipbqf3TmN043fssT2bc82ApJcs1zvLYgI
 rhMht7Dck7A0wNC1jo+ZjVVFig5gDTN7gOzaAdBtV8tVNUddwkLzzaGpfihhSD6U46NdqKOG
 Wlnn6TrkMy0QGdQ5NaXHkRlUjnnUTSW/nKfoxD+EI+A9V4sYOd8mc/TL4aJh/i/AiU57eLbo
 n17uQI6/VTWDUWl8USiz4x9c8vmqlywLx00tAFxxoRWqk4KVJlj+Sh0up/D/sJ+vPpgBABEB
 AAHNI1JpY2hhcmQgSGVuZGVyc29uIDxydGhAdHdpZGRsZS5uZXQ+wsCBBBMBAgArAhsDBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUJC7UHogUCWaDNVgIZAQAKCRCtEnDMTdAnm9N5CADO
 cB8F/SudJ72IupxQf40hbJdBK176+gb3sHMsixyLtrU59lee+lIM1OZmlNjsnCYmiSnbA5ks
 Q7p0HfO7DgdmfLzcK6xsHZukqSZy5LByw348Y913ZyjOrJZFdPP7kDg1MnqRqH4+3ZdzxV4y
 eYBWFU9GYMIF06JbUubossOOO4ArNVZbnIPu8Vn2tDZVVqsCBqkoCSBMj519xrvyOu5z4mHS
 LkCglXmVDOXMbqLuNAC3rfNXSnyM4hYkLUyfALJlAAy1Ro+jUqYhu7XUFV/MiwRuFMh5GbtY
 Urkx7tqsWQXLT3GeDk/LqvpWJQwk4cHHckYjRih+70CHIenm81PVzsBNBFGuLC8BCACyEx3x
 94HIkTX0CHu2sA0w75+h9wuoA8ggJ7+S4ri0y2YsijWad5TTt6z6MMiqxk9kSA5bppaj4HXh
 86hBF/dWCtMpNr3Rb8FNOKyeA/qkYHVD6HiAiw9c6D8Dr9hWmOk3/HSmGrNURxeUFOckDXsv
 I+yGGKBNshj59j7QZr7ZiuIi2rWlBL8dFN/OWa/o3x7HKsE4k6K8ngwvCKP/QbDLwLLBOWH+
 VEUtpyeyxTr3OJ47ECTxdYvXoAV2iJaKr+6doVQiiR5eVFiMYrUPUECJeolOCwqc/JlWE18L
 +PCAFaW1H+/mpPVfSpN4wnkJ5cQiQVB41IaCM4p20iRzx7ZJABEBAAHCwGUEGAECAA8CGwwF
 AlmgzYEFCQu1CEoACgkQrRJwzE3QJ5s7rggAwABzDAGrZ6uWsMxg5PeiiAYPy6LBnCBJSpB5
 Tfy5jH8QTmLfXW+u4Ib4sWXG7PYNR7sIrtqUHjRqXLVXrSnBX9ASGcYw/Xil45khW6LsRpO1
 prHv9gkwQfa6fTiWXVfSfm2Nant6u02q+MaYtQpCVTiz/9ki4FfftUwUHFLU0MhIQogjd11y
 /E08RJsqBwaHQdt14PwU1HphDOzSkhOXRXQLSd3ysyeGUXvL+gqQoXl5XYdvk8IId4PoJRo4
 jcyJ4VbnldvXh5gdGhFA/f9JgkLk9tPW+C3wNtNWyRUq8azR9hF2fg2HJUf4IXQlIu8OOgh1
 VcROBqvtH3ecaIL9iw==
Message-ID: <d223ad23-04ae-408f-2a73-d5fa641ad725@twiddle.net>
Date:   Fri, 10 Aug 2018 21:10:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180811024553.GF6515@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/2018 07:45 PM, Al Viro wrote:
> BTW, seeing that it's your code - why was unop used in
> alpha_ni_syscall?  I don't remember the rules re pipeline
> stalls; is it that some earlier variants prefer unop to
> nop in such places?  It's not that microoptimizing that
> one makes any difference, but just out of curiosity -
> would something like
> 	lda     $0, -ENOSYS
> 	stq     $sp, 0($sp)	/* sp != 0 */
> 	ret
> do just as well there?

Oh that.  Well, unop is a "load" and pairs with everything
on all cpus, where nop is an integer and doesn't always
pair.  So I got into the habit of using unop for everything.

The extra nop was so that lda + unop // stq + ret paired up
in in two cycles as opposed to lda /stall/ stq // ret in
three cycles on ev4+ev5.  ev6 didn't care.  FWIW.


r~

