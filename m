Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751661AbeBWHca (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 02:32:30 -0500
Received: from mout.web.de ([212.227.17.11]:47461 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751539AbeBWHc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 02:32:28 -0500
Subject: Re: [PATCH 2/2] crypto: omap: Improve a size determination in three
 functions
To: Herbert Xu <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Joel Fernandes <joelf@ti.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <28780631-d093-a581-8690-3868f8fa327e@users.sourceforge.net>
 <0a45e47f-5ed0-5dd6-7545-adc8df2d7972@users.sourceforge.net>
 <20180222133813.GB28447@gondor.apana.org.au>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <3916c49d-f74a-97a0-9240-de9a727bece9@users.sourceforge.net>
Date: Fri, 23 Feb 2018 08:32:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180222133813.GB28447@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:fjoAZrsZnkiV9tXXJt8WmnB2mkp7YztFzE2fm80QQbCIKBQRcLM
 AoFIodNiM2e6Yt/TJO1A1wcHZS8K5wNu9rqMschtmZ2i77w69VXS3v3dY8ZeXn52egaCe0i
 bMMKRyseXzQBru0g5mreD7HIBqGOU9nLa65wNtqX7XBdyk9qJtx1bdAifviUzdouGQR5LzW
 IeGPoDOtIjekn1LVREFaQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oq09mef9qR0=:tONZhdO1AgkA8hLcSAia/5
 OwQhaho+77LFIfl85dd4ArTfNS7fsvbSIaPDfSGYDfXyYd4+h+0vM23seEQ+mrhd9DWtJo8pC
 UIxvciMJeUVEUX72wH1JdajaYjuPxzzMKWOof8vpW0TVk6wPP6WZ5M4xhyUVmNQMEMQQWBGtT
 atC+26QrabuuDMWkNoZJ4pHGi5mfQAeX+2ZZ6Hun3qHMddF4rZpAcTSv0yx3tU8IhEP/KcgX8
 K7pLbZkdFINprc271DzE1iLmlN2EnPZUOHZtNPSpFV4VoVctv+mmsCNAoSOEj0vVlHhKIoJN9
 IRdTfBHnPvqOtiCtZjrWdFpu2rN3DhmV44VqL1UVQQH2TGbzapaig2I2kV2XM2N3ErqitHz+T
 XuPBxHB1II3sJAfU3qfA0c5Yvzi3lWCaTOU0Vf0VAUFq1QThLoCKs74wO3acSFNfonKzTnYZ5
 iVffznTRr2pqr+QuWhJxZtKBCwMb6HEBFNpHQSM6mFyOJo7OB6qrTs7GldVddv6Ei35rVK9ez
 4Y/bWN6B+nVx4jdRnJzYyWrTv/HVLarXBKzOHT55JkfRPUeMZR3CQrFv5z1/x+L4QA0UG1mHN
 Ol0PSnUYytnedZzwzF6Jkh9Vh3r7d6g6n0g7zapWO7SK2u/CNkXTwragvcGRbxxxlKzheCSb5
 PRdAiaJHZpKsHcIRbZyjql1/3rd/57der/LghR0Gre5Fgyxzrg6vbiEftqlAzsRBGWTQAOsp+
 eLI62N128RniNf8RdSpGS5DyN8EWmbRJiM0OsH2VDXMTXvO03cuUkW/Ntadn6cZvE16zWg4xZ
 Ixz/V6Cc4R1HcegIkfKLll2feXZgdK5pi9DFgztpOh0df4n7/k=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> @@ -1032,14 +1032,13 @@ static int omap_aes_get_res_pdev(struct omap_aes_dev *dd,
>>  static int omap_aes_probe(struct platform_device *pdev)
>>  {
>>  	struct device *dev = &pdev->dev;
>> -	struct omap_aes_dev *dd;
>>  	struct crypto_alg *algp;
>>  	struct aead_alg *aalg;
>>  	struct resource res;
>>  	int err = -ENOMEM, i, j, irq = -1;
>>  	u32 reg;
>> +	struct omap_aes_dev *dd = devm_kzalloc(dev, sizeof(*dd), GFP_KERNEL);
>>  
>> -	dd = devm_kzalloc(dev, sizeof(struct omap_aes_dev), GFP_KERNEL);
> 
> I'm fine with sizeof(*dd)

Thanks for your feedback.


> but please don't combine the allocation with the declaration.

Why do you not like such an implementation detail?

Regards,
Markus
