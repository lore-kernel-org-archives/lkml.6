Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BA2C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5543620C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHybyV6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5543620C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbeISE4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 00:56:20 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45246 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbeISE4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 00:56:19 -0400
Received: by mail-ed1-f67.google.com with SMTP id p52-v6so3306039eda.12;
        Tue, 18 Sep 2018 16:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GFBzJWopmouz4YCld8fse0HXuKJLSnlp+Sq9rjSPumE=;
        b=eHybyV6bTt1mJxBey31h2mhoSrlE/hz3sdfdNBzdxzrmUm3u917uxt8nkkwEB6Su2U
         jNG1NWsICIZHdaG4rjzYQMUCovGNjAZeo/yKzZ9U/9pxK1E8BgiesYTI9ttClkUwc9t8
         RxOI+HUz2slxa1NfmNIIevtQKp7N/O28LQ6fp+v0BdfSKlnROotboAzMQo/LTN3uP9J0
         XUbvxc5LLx+agU8Zql3lofk9rOICBk6pmJmiT/gAc/84+vh1VqK2rgSxIx1aljeozSH8
         xO0FDWQrwCovop8kj0uCGs5EjLSQF6kZ1CqEOnGAyNoFjgdKez93viZfBkY/8LXXXaGJ
         2Djg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GFBzJWopmouz4YCld8fse0HXuKJLSnlp+Sq9rjSPumE=;
        b=aIdAgePENBzwtQRRFONdsuU+oIcJvS+mvcI+k6Ek56BzHQImarUIKF3RhTIPjl2fNP
         IJMLy4cc3j5Fyg6S/Seja5MfWoYtgKl4Ix2sXWYliyDUttF7Ye5ytXzUc6v2u5oS3sHv
         uR7AzA5PL9R1zKHtR3M71dRaPe3WvsZ4UwofTiVE7dXuYjFHXP4yaa3EGPdbfCWQpKMF
         l7vK0C5Yz7h8TvMWXW3q9PGvtLd7liHG2ceGieoQ5W84ultKRFvLsOpYyFWT8sJh/AH5
         m1Pd0I3Y7eR/PZmaDzeCweoG3U+sqk4My56Ig8IgEPG4sjZGW9hhCIPSmf2ecSuL7Cle
         bUvg==
X-Gm-Message-State: APzg51CWyxksd6k+mcF+Orz0zNRDNrYVf7+NiePZu1G1/mj+j1levxGZ
        PZrxRGO3aqnOVjNS8zOTr18=
X-Google-Smtp-Source: ANB0VdaM2QNlr24LRyGzaVoaA0Gv0Qn/cYo0xYMGyauWMNpQzhmWxfp2POE9DKzE5G2CyEERHZQMJg==
X-Received: by 2002:a50:ade6:: with SMTP id b35-v6mr31849159edd.168.1537312883375;
        Tue, 18 Sep 2018 16:21:23 -0700 (PDT)
Received: from [10.67.50.87] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id w20-v6sm1631837edc.12.2018.09.18.16.21.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 16:21:22 -0700 (PDT)
Subject: Re: [PATCH] net: apm: xgene: force XGene enet driver to re-balance
 IRQ usage
To:     ahs3@redhat.com, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        David Miller <davem@davemloft.net>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "isubramanian@apm.com" <isubramanian@apm.com>,
        "kchudgar@apm.com" <kchudgar@apm.com>,
        "qnguyen@apm.com" <qnguyen@apm.com>
References: <20180917233533.28626-1-ahs3@redhat.com>
 <20180917.193531.1424852853827678152.davem@davemloft.net>
 <a5adee73-dde7-d00f-e7ef-1f81dc7c813a@amd.com>
 <4929e93d-508a-4670-9450-66e4fc85be7e@redhat.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <cdb8a00c-a3bf-72e0-38b2-3c4b2427270a@gmail.com>
Date:   Tue, 18 Sep 2018 16:21:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4929e93d-508a-4670-9450-66e4fc85be7e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/18/2018 04:15 PM, Al Stone wrote:
> On 09/18/2018 05:09 PM, Lendacky, Thomas wrote:
>>
>>
>> On 09/17/2018 09:35 PM, David Miller wrote:
>>> From: Al Stone <ahs3@redhat.com>
>>> Date: Mon, 17 Sep 2018 17:35:33 -0600
>>>
>>>> @@ -866,8 +866,11 @@ static int xgene_enet_napi(struct napi_struct *napi, const int budget)
>>>>  	processed = xgene_enet_process_ring(ring, budget);
>>>>  
>>>>  	if (processed != budget) {
>>>> +		struct irq_desc *desc = irq_to_desc(ring->irq);
>>>> +
>>>>  		napi_complete_done(napi, processed);
>>
>> The problem could be that the driver isn't checking the
>> napi_complete_done() return code.  It was changed to return a bool and
>> the check should be more like:
>>
>>   if ((processed != budget) && napi_complete_done(napi, processed)) {
>>
>> If it returns false, then the driver will get called for polling again
>> after having issued enable_irq() and it well then issue the enable_irq()
>> a second (or more) time without having the matching diable_irq().
>>
>> Thanks,
>> Tom
> 
> Aha, that might be.  My apologies -- I play in ACPI but seldom in the network
> drivers, so was not fully aware of that change.  I can give that a try.
> 
> Thanks for the pointer.

FWIW this is being discussed in this thread as well:

https://www.spinics.net/lists/netdev/msg523760.html

there should be an update to drivers that have a ndo_poll_controller()
and don't check napi_complete_done(), though I am not clear who is doing
that yet.
-- 
Florian
