Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB37EC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B49120868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ohznU5El"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B49120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbeJLUCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 16:02:12 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:44217 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbeJLUCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 16:02:11 -0400
Received: by mail-io1-f42.google.com with SMTP id x26-v6so9065466iog.11;
        Fri, 12 Oct 2018 05:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x4X39BeHTmskD+Gyf1Bj7680OjQKEVSVl8c2DfHIMuc=;
        b=ohznU5El1+5Ct2oI+6XOnqQkkQCLuvBmXFf0MM/ZEkO055bM4rqdjt0f3V7AdZ/FE1
         wvv+eQ9qWJGcNTrkL45ZNBYmq5u7MxLTEleRE7O4fhjCPLPf4yBUTagf4S7UnZ8iMAum
         14+K4kHuePAtwfXB8pytcWbBb29kKysw3cUN+1EjOQfpVh7TdJF85x+c69PUb4cxq0hx
         tALfOA7Qut/V7YZ8u2RBFEtCx/y01d01tNh5tLRLqMYC3V8f/r3G5aHjoCEoPjcQcXSF
         zRC3/Oo4cH17aqwS7HmV9dPBhWmNpOXjfssgIUkugRCptmTpZ9GuPfcIIsq1W8fG1c3w
         8H8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x4X39BeHTmskD+Gyf1Bj7680OjQKEVSVl8c2DfHIMuc=;
        b=sKb4e6hjB9jjPjCCn+Mxcx4MrVgrBudbHtVQNTVx2LkPDbNcBof9sFYeysm9uXzd9L
         BEs1iGngURljvc88ZvxGiSKKkhCO3zJ7K9w2br5TVUe8qEqOM/ZCdFgQBDqb52Gg3pAK
         yiCxY6it4eY6YzGxBis4QcLyKlpR9alg3+uBhXEUaIXK8WxOzLkR4MBZo0vZq8GQ8G2U
         TUhih4rTLwWyxurB8KJ+n0KpBAXsUUbeUh0VNgzhJVf3ttQcT6tPCKYsgM4MMCARacfK
         1hKMuETfatuflhjP8ajFMQn8PCKOkcnbt0fnsnr44tO61IKoYkKCq0h6CkTyPjbKRTn/
         1pvw==
X-Gm-Message-State: ABuFfohSQ4A7ER/zhEBjM6XRZo5tdJ/jzJdVquXfAwyh0l9CTd15xeX7
        f9Zd62SPcDtLr6a2II0c7BOZdFOHxPk=
X-Google-Smtp-Source: ACcGV60Y5kOGGumyMqch0MfPUq8yEvNolHvi5Yx5dyv7s152FRsUNewfDfUMIjPinmf1yQsxQURRAQ==
X-Received: by 2002:a6b:b249:: with SMTP id b70-v6mr4118048iof.252.1539347395638;
        Fri, 12 Oct 2018 05:29:55 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id v13-v6sm232934iom.54.2018.10.12.05.29.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 05:29:54 -0700 (PDT)
From:   Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] KEYS: trusted: fix -Wvarags warning
To:     ndesaulniers@google.com, jejb@linux.vnet.ibm.com,
        dhowells@redhat.com
Cc:     natechancellor@gmail.com, ebiggers@google.com,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1539274203.2623.56.camel@linux.vnet.ibm.com>
 <20181011203126.15338-1-ndesaulniers@google.com>
Message-ID: <f83893d2-ed9b-613f-2768-1a975d28fe8b@gmail.com>
Date:   Fri, 12 Oct 2018 07:29:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181011203126.15338-1-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

> @@ -123,7 +123,7 @@ static int TSS_rawhmac(unsigned char *digest, const unsigned char *key,
>    */
>   static int TSS_authhmac(unsigned char *digest, const unsigned char *key,
>   			unsigned int keylen, unsigned char *h1,
> -			unsigned char *h2, unsigned char h3, ...)
> +			unsigned char h2, unsigned char *h3, ...)
>   {
>   	unsigned char paramdigest[SHA1_DIGEST_SIZE];
>   	struct sdesc *sdesc;

So my concern here is that this actually breaks the natural argument 
order compared to what the specification uses.  This in turn requires 
one to perform some mental gymnastics and I'm not sure that this is such 
a good idea.  Refer to 
https://trustedcomputinggroup.org/wp-content/uploads/TPM-Main-Part-3-Commands_v1.2_rev116_01032011.pdf 
for details.

Note that H3 is really the 'continueAuthSession' variable which is a 
bool.  In the above specification BOOL has a size of 1, and TSS_authhmac 
already assigns a h3 to 'c' which is used for the actual hashing.

So can't we simply use 'bool' or uint32 as the type for h3 instead of 
re-ordering everything?

Regards,
-Denis
