Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0135ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B91E214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fz1zYZw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B91E214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733192AbeITWwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:52:21 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:42607 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeITWwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:52:20 -0400
Received: by mail-oi0-f65.google.com with SMTP id v198-v6so9013384oif.9;
        Thu, 20 Sep 2018 10:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fwqKaKdgvaiU/cUk6D4Wr1DpxV9SN7fSzIsgOeo8IVI=;
        b=Fz1zYZw4B+GNp2fA72+kPwGrz9j1AtGiMBDbyizgj5wo/Zi1S4P8kDyO9LC3XrQHbA
         Ut7f7qSuBZnV4tY7d//E4mFuIt6DO9WydVYgesVjuI5FW4HGd6qx6gYZ4SlRKfxhFrHU
         4f+TVdd0GqNY1Tyd+QMtOuIUfIFgO361inRuG/IJAE8+R0C50pdtTAJDYU0oEJDlAgQ/
         uH3tV1pbwDX8byRNhh94le2CKH1WkuDnMVphd5kAP3QqPvN6dGCiqaVJ29mW9PHGs3Kd
         WWGYb3Bbr652eb3AhQVpe4HpYs7GkEf/Euad9Me2sr4QmIt/1ku2uBlKkZpYbe6bNIyI
         CrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fwqKaKdgvaiU/cUk6D4Wr1DpxV9SN7fSzIsgOeo8IVI=;
        b=FNzK66k2zE1VnZvzQyy3KlWhQMrJN/iBMKtwUd+sN7881DmZkXw38v4Rt2+uqf1WP1
         zeJ2/wkCmqnG5QbpUZ5IY9NiaZIqN5IWeiIv/l9gLiYHOvXqpwX8/elAngdhtQO2NLWy
         mGmBipD8GG6i92bR5EMRPIKAsJMdNu1tH7/kD5FpIB/LWXUynDOLXBueOTKUcIyNyI7L
         MbNVr+ww+JtHaRtSrtVo3QYgQzFds01bw0w6vSEb+804ZjXoLZrosp634Ec8fXBjz0Bd
         UEjxcdvDQ7XVXkPvN/9+tTJ/JxcU1KDfXER2EzUJfjkuoPD5SC3abh0XgIIQgZnUIiKD
         jHCw==
X-Gm-Message-State: APzg51CkbE9SwQGm7gqwpi3UsrzVvQNGkwuXAmdABMaMOySuUOaKpL9b
        x/u3UENLNmtZHV4Og5g2qVJfdBu/
X-Google-Smtp-Source: ANB0VdYedRQnnwFyj/yp8xKUTZ5dT99RUKAnyJW2r1Led74ulFsM/A4DDnlM4UBsMoe8LvBRq+Zs6Q==
X-Received: by 2002:aca:2203:: with SMTP id b3-v6mr2277627oic.366.1537463273288;
        Thu, 20 Sep 2018 10:07:53 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id q38-v6sm496231otc.46.2018.09.20.10.07.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 10:07:52 -0700 (PDT)
Subject: Re: [PATCH 00/22] KEYS: Support TPM-wrapped key and crypto ops
To:     David Woodhouse <dwmw2@infradead.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     James Morris <jmorris@namei.org>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <c33c759d-9243-8885-7c5f-667681b759c2@gmail.com>
 <14f91823-474e-1b46-d305-12229dac8967@gmail.com>
 <0d51fca9a29458a40121df0c5380af91e3429c08.camel@infradead.org>
 <fdee179b-cfdf-7a2b-3193-e114f0084ecb@gmail.com>
 <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
 <1537253993.20009.62.camel@infradead.org>
 <14067.1537285833@warthog.procyon.org.uk>
 <745318a0-51bd-be8f-2251-44701ad75830@gmail.com>
 <19247.1537288419@warthog.procyon.org.uk>
 <23698.1537289705@warthog.procyon.org.uk>
 <20622.1537291117@warthog.procyon.org.uk>
 <58F37819-78E2-45C8-8F04-4F21DDFB640E@holtmann.org>
 <219367882d33fda9705485aa4a40b2ef55f3992f.camel@infradead.org>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <c8608829-2669-077f-b7d4-5a199f4bf4c8@gmail.com>
Date:   Thu, 20 Sep 2018 12:07:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <219367882d33fda9705485aa4a40b2ef55f3992f.camel@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David,

On 09/20/2018 11:45 AM, David Woodhouse wrote:
> On Thu, 2018-09-20 at 09:26 +0200, Marcel Holtmann wrote:
>> Hi David,
>>
>>>>> Yes.  It shouldn't be much code, either.  You still have to check for X.509
>>>>> DER since the kernel currently supports that.
>>>>
>>>> For reasons of backward compatibility, correct?  The kernel also has
>>>> mscode.asn1 which we would need to support as well.  Since we can't break
>>>> compatibility then perhaps this doesn't buy us a whole lot in the end.
>>>
>>> Don't worry about mscode - that's not an asymmetric key parser.  That's only
>>> ever used directly from verify_pefile_signature().
>>>
>>> Currently, we have to retain support for DER-encoded X.509.
>>>
>>> But there's no reason we can't have a PEM parser that decodes the PEM and
>>> selects X.509, PKCS#8 or TPM based on the ascii header in that.  PKCS#8 and
>>> TPM don't need to take DER directly.
>>
>> since we have to support DER-encoded anyway, can we get the current
>> patches merged (with fixes to the commit messages for the openssl
>> examples if needed) and then work on PEM support inside the kernel.
>> For me these seems to be two independent features. And in the current
>> form the patches have been tested and used.
>>
>> Or let me ask this differently, are there any objections to merging
>> these patches with just DER support?
> 
> Let me rephrase that question slightly: Are we happy to have to make
> inferences from the ASN.1 structure, and in particular that a bare
> OCTET-STRING is a TPMv1 blob? I believe James ended up doing something
> somewhat more sensible for the TPMv2 blob so that might end up being
> OK...?
> 

I think it should be OK.  It is highly unlikely that we get another 
OCTET string type format, and even then we can actually peek inside and 
try to parse the TPM structure carried in the DER if there is indeed a 
conflict.

Also, after refreshing my memory of how PEM format is actually 
specified, I'm no longer convinced that having it in the kernel is such 
a good idea.  It would probably be made to work, but the PEM file format 
itself isn't that precise, at least compared to DER.

James, is there a document / official place with your TPMKey ASN.1 
format?  The only reference I can find is here:
https://kernel.googlesource.com/pub/scm/linux/kernel/git/jejb/openssl_tpm2_engine/+/93b2f4f3f0f2260292f54de4e6333219063c77b1/tpm2-asn.h

Regards,
-Denis
