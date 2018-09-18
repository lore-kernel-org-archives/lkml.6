Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DATE_IN_PAST_06_12,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D82AC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37BF020C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjSh2GtI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37BF020C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbeIRWCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:02:00 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39404 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbeIRWCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:02:00 -0400
Received: by mail-ot1-f66.google.com with SMTP id c12-v6so2613700otl.6;
        Tue, 18 Sep 2018 09:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sycfl4Qu134g5AA/VseYN5xXSyE8MlcSoCyRotftmfk=;
        b=cjSh2GtIZhrAs8RUyYDHgPCzn2PM6dRXrStr06QdSF65ylP1eLKDnSj7b9RwAu2rTc
         vcXjyBbqs04S+nimk4riEib5xQ3cE/nVRvLErTUKLk5ENAyNqqa+zShG6r+EvE8mIE+r
         r51bojoFgsyBz3qC0+bajqiHjF0cTJMMmXenuI8O/A0QbPmL6AdE1y2HcGR4uT7Zf4g2
         6GOFunS3k3X7eWCyoV8lUnkbZNdUaScVVzHsQKmSzTzn3MQXrScAAAXLM13NkJe8m5mv
         RU6BTJG/BTBxLXMylDAQ9ZL1Yzu9fgnk+5tAB5YoQXzTdPVJwk0t6mhUaqjH9tbKIFNe
         lnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sycfl4Qu134g5AA/VseYN5xXSyE8MlcSoCyRotftmfk=;
        b=hXPSsKCe6429ub5KLo63RT/EiQIQmllfosi8IRJqt5lJiQr5HN6xur365StjHehp90
         5ZLf4T8fuVNiVYAswrVXEQCfeI72tqkm726Mad++N/hyLwV01LWDeyIwK9l9HlXJDJjt
         ZNTlfjSwvMqpQ0+0xHyMKjgrVGNaH4fFSMBJ6ifLClDVXj/snf89VBEg4hnc+0Olvivp
         rIS/etClhvDwRydLZgMU1kSXKDE/7aHKKg/3Xe3S2L7kH1ArY0oK4ocW4qB94ukygs1D
         0bTM6/DdxFWtPJ07AZ3atWRfaFD4HRYN1i1oZNeZYcZ7sJpJ6TzbAvvCJRF2/MblIbQu
         9q5Q==
X-Gm-Message-State: APzg51CO2ZTw+NEsWPEP3qo5s7Nc0VyzrFv1Z8uWdgTPg1oapKCslbCX
        bcWohZIumAMak4OgOiAsXR+fbv/m
X-Google-Smtp-Source: ANB0VdaFt8cjsOFNDFkHmKrOwUGgE1hRwSLjlPPXMLqyOi4z1PtQEkxR/qN2g2JhPkTuBa/1aSodGQ==
X-Received: by 2002:a9d:1422:: with SMTP id h31-v6mr16037767oth.41.1537288119163;
        Tue, 18 Sep 2018 09:28:39 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id t141-v6sm9768252oif.18.2018.09.18.09.28.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 09:28:38 -0700 (PDT)
Subject: Re: [PATCH 00/22] KEYS: Support TPM-wrapped key and crypto ops
To:     David Woodhouse <dwmw2@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     jmorris@namei.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <fdee179b-cfdf-7a2b-3193-e114f0084ecb@gmail.com>
 <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
 <1537253993.20009.62.camel@infradead.org>
 <14067.1537285833@warthog.procyon.org.uk>
 <745318a0-51bd-be8f-2251-44701ad75830@gmail.com>
 <0d51fca9a29458a40121df0c5380af91e3429c08.camel@infradead.org>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <2c5a34af-c2ae-b98c-e5d3-d89462ad3a20@gmail.com>
Date:   Tue, 18 Sep 2018 00:41:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <0d51fca9a29458a40121df0c5380af91e3429c08.camel@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 09/18/2018 11:17 AM, David Woodhouse wrote:
> On Tue, 2018-09-18 at 00:24 -0500, Denis Kenzior wrote:
>> Hi David,
>>
>> On 09/18/2018 10:50 AM, David Howells wrote:
>>> Denis Kenzior <denkenz@gmail.com> wrote:
>>>
>>>>      openssl asn1parse -inform pem -in /tmp/privkey.2048.tpm -noout \
>>>>                        -out /tmp/privkey.2048.der
>>>
>>> You can use "... -out - | ..." instead.
>>
>> Aha! okay, that is even more elegant.  Your openssl-fu is better than
>> mine :)
> 
> 'grep -v ^----- | base64 -d' also works most of the time :)
> 
> You are passing the raw DER to the kernel in both cases, right? And the
> kernel just happens to know that if it receives a bare OCTET-STRING
> it's supposed to treat it as a TPMv1.2 key?
> 

Short answer: right.

Long answer: The kernel runs all the registered parsers until all fail 
or one of them recognizes the format.  All the currently supported 
asymmetric key formats are DER based, e.g. PKCS8, PKCS7, TPM-1.2, etc. 
All these have a very specific DER structure with the TPM-1.2 being the 
simplest format.

Regards,
-Denis
