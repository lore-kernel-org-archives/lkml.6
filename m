Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DATE_IN_PAST_06_12,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A0BC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1FF221508
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCbVkwVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1FF221508
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbeIRVop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:44:45 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34812 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbeIRVop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:44:45 -0400
Received: by mail-ot1-f66.google.com with SMTP id i12-v6so2584038otl.1;
        Tue, 18 Sep 2018 09:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pdO51CM3uK5HARSymvMdaAqJUvwelGp9NLvyYpb9JlQ=;
        b=jCbVkwVJ2KTx6EfT4YHQSaZ8ZpO0JAh8IUxOA5/i7D8IhGXWtR2D8wwaHOjBSAUwN6
         +Bk4oQBRGLuDAwadgw0VWxB5nUahd2olRJ1S3KhimeC9F8hoqzgSy74WJQx8gAzIumct
         4z88vtgwLB24Urlf720xjKCjrZRMVTJFbs3A4jHjCmoBiaYdv0oUzIg3zfSQD2zENZaJ
         u+1sgGf7rNzVMHK8YlKWyTAUioSj79a4Sexd7s4sUjMTVb7fOIN4RRQChJnh2WqHA2wr
         P8uXHjo8XsyBFzJywKVT/XQLPx2o10VwtXJfS1M3JDWff+1VJWigAYOX5aNsrO2ecBLe
         740A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pdO51CM3uK5HARSymvMdaAqJUvwelGp9NLvyYpb9JlQ=;
        b=jjpj6W6yNvu1TKQEEo+PPwpCDSpKo7uHDlmnZSIHmD1odUpW4PA6W20vDcP8irVtHV
         hwOkvbEVrGI71gdttyPx5o5XmeVhFjBevLvQT2Y32rjBoMEcbB4qG2paAyPZ90SMlIBX
         MlXCRCNhc/Q0WFkl2du3JB+1HYzhZRwnaNuGU1J3VbrPGdKvvbH+mavc5cHrWEdQZv6U
         5Hhs8mY13/x4E3t5T5SGGM5MU0DTIBywta5vmFVaQkT8sF07JzFqEr1+clPDwriTJb2x
         7sH1L4pEZ5U+HEy2NpQEG8QquEDw+G8KExwlY5OdXlVIx1c4E4M/Tt+n6sREK5fKmnzI
         WOBA==
X-Gm-Message-State: APzg51BB86nlGA9jeItomIuC0EWEmt8ebgPK0yCT8NhEq2mVIkrPYdwH
        /8ruLqCvvXiQCcLX1jXmef05b1f8
X-Google-Smtp-Source: ANB0VdaMs7Lxa+Y6lXfWCR4E835Yu0iuTi5xh8VfXWPi6CU+0d1pxl/3JVtWot205c8U7k6V3pQjjw==
X-Received: by 2002:a9d:2359:: with SMTP id k25-v6mr16629086otd.161.1537287089896;
        Tue, 18 Sep 2018 09:11:29 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id u68-v6sm6117545otb.81.2018.09.18.09.11.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 09:11:29 -0700 (PDT)
Subject: Re: [PATCH 00/22] KEYS: Support TPM-wrapped key and crypto ops
To:     David Howells <dhowells@redhat.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, jmorris@namei.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <fdee179b-cfdf-7a2b-3193-e114f0084ecb@gmail.com>
 <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
 <1537253993.20009.62.camel@infradead.org>
 <14067.1537285833@warthog.procyon.org.uk>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <745318a0-51bd-be8f-2251-44701ad75830@gmail.com>
Date:   Tue, 18 Sep 2018 00:24:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <14067.1537285833@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 09/18/2018 10:50 AM, David Howells wrote:
> Denis Kenzior <denkenz@gmail.com> wrote:
> 
>>    openssl asn1parse -inform pem -in /tmp/privkey.2048.tpm -noout \
>> 			-out /tmp/privkey.2048.der
> 
> You can use "... -out - | ..." instead.

Aha! okay, that is even more elegant.  Your openssl-fu is better than 
mine :)

Regards,
-Denis

