Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-490216-1525254327-2-7763803522247182155
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525254327; b=ZGahSo1RqJ72EmLapvuQysriftYZcy+siB5jb1eDFXPSZx9Bje
    D9yuQkXDHkCF0YD9XTsjBukJ4wpPuFvSeciq9ufeSw/BF1M8Fd6iuvKXSFSIo0Xa
    kCEJFeWnpSABN23fydCAZ2XLhBYog+2FqXIlhRaWmQrzMW3lVDF76OeSEiiNfrWI
    jlvqWxdT4hacKXKXvSKHzHyruKXj8H1ZjlHFNt5LDDi8ca0bgZ2NLr9YeStG3WyJ
    5xectLik3CM5EEhdvSUHWb0ixIBDrWO+vr5uid3S3aduVA9EPJKvoTfqUP3P20nK
    ash+pOFNAI8m2bRgHHphCN7V3I+QXtKMfXxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=fm2; t=
    1525254327; bh=JLJeAtbC+KK7BbPcgilYVYQlQ6m3nLzRiHZQhaoF058=; b=Y
    fkgJ18O1zUxeyuMR4S7uqsJWmu8nUM3/3bHBAmH+/B3FmlNdWY8gyrHtz5YmRCZV
    t5vULmqKime8cfu4ZiapQ34N+nVH5MT25uYaNWZCLOMyFJiAcBQJ3TPyPSEmQurj
    9SJWQYOPsYGJgS26uHJOpb5ZiiJhBmX5e5CndvHZ/nqYComNk8rI8W0aVRRxE81Q
    4C91vP1l7CU3VdAYPiCuqJEUAP08LpaouqW9Bss5YurfIbk59GP/Rov0wC6wGrmB
    IfNJ7jcKBTJdO23S8dByTccmeQkvYa1DzIrQUpSSENOmKE86Gw1wRwd+RJE0Vxj1
    XBlnGg1QCRUqRbSGxQv8w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=dzcgtAJ4 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=JXDXQGy0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=dzcgtAJ4 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=JXDXQGy0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJtEIfg1ZGPUsqzsC+hE3B6CeOEzdaVEKlKVq2P8m+LSXDJxX+O5kFSQAb7osKvH76Vx7YqJN2+pDBHo2Ky8onGJa/jPzoSSHCZet52xqgvCO7ljElgp
    A2WF9DRwa4O0NwOgHLGNI60XpyEud/tHpgsbbUsvlok6iYtjC2IYg79YJdovWRCFMsOjc8LiFr1rdJ1tkZs2uMexA2p8VQdfhmOCCiR3ZEskJcGQBEFYUjz2
    zUWpjSBZZL2IDcEFenXsvg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=LxSDy4Xbj5AA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=cOHvpQB6Pd1W65NBl7wA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZodKvXiTt2sbk9Tqg+SOy5M05gdKkk/4e7qb2NRY2TzRv5wJRI0oKTq/NBqW1WfQ4Sn4Lm5Bw==
Subject: Re: [PATCH v2] staging: greybus: Use gpio_is_valid()
To: Johan Hovold <johan@kernel.org>
References: <5c8c96b1971bc09a2a2bfa62c343973ab986aec8.1524889296.git.arvind.yadav.cs@gmail.com>
 <20180502084308.GF2285@localhost>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Message-ID: <2aa263ef-1bbc-69fc-c007-303e59517081@gmail.com>
Date: Wed, 2 May 2018 15:15:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20180502084308.GF2285@localhost>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Wednesday 02 May 2018 02:13 PM, Johan Hovold wrote:
> On Sat, Apr 28, 2018 at 10:05:39AM +0530, Arvind Yadav wrote:
>> Replace the manual validity checks for the GPIO with the
>> gpio_is_valid().
>>
>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>> ---
>> chnage in v2 :
>>               Returning invalid gpio as error instead of -ENODEV.
>>
>>   drivers/staging/greybus/arche-platform.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
>> index 83254a7..c3a7da5 100644
>> --- a/drivers/staging/greybus/arche-platform.c
>> +++ b/drivers/staging/greybus/arche-platform.c
>> @@ -448,7 +448,7 @@ static int arche_platform_probe(struct platform_device *pdev)
>>   	arche_pdata->svc_reset_gpio = of_get_named_gpio(np,
>>   							"svc,reset-gpio",
>>   							0);
>> -	if (arche_pdata->svc_reset_gpio < 0) {
>> +	if (!gpio_is_valid(arche_pdata->svc_reset_gpio)) {
>>   		dev_err(dev, "failed to get reset-gpio\n");
>>   		return arche_pdata->svc_reset_gpio;
> I'm sorry, but I don't this change is desirable. of_get_named_gpio()
> returns a valid gpio number or a negative errno, so there's no need to
> use the legacy gpio_is_valid() helper here.
>
> If you grep for of_get_named_gpio() you'll find that some drivers indeed
> use that helper this way, but they are in a clear minority.
>
> And ultimately, we want to move to using gpio descriptors anyway.

We need to check gpio validity. If we are using of_get_named_gpio() or not.
of_get_name_gpio() will read a device node and fetch the value. But 
it'll not
check that gpio is valid or not valid.
>
>>   	}
>> @@ -468,7 +468,7 @@ static int arche_platform_probe(struct platform_device *pdev)
>>   	arche_pdata->svc_sysboot_gpio = of_get_named_gpio(np,
>>   							  "svc,sysboot-gpio",
>>   							  0);
>> -	if (arche_pdata->svc_sysboot_gpio < 0) {
>> +	if (!gpio_is_valid(arche_pdata->svc_sysboot_gpio)) {
>>   		dev_err(dev, "failed to get sysboot gpio\n");
>>   		return arche_pdata->svc_sysboot_gpio;
>>   	}
>> @@ -487,7 +487,7 @@ static int arche_platform_probe(struct platform_device *pdev)
>>   	arche_pdata->svc_refclk_req = of_get_named_gpio(np,
>>   							"svc,refclk-req-gpio",
>>   							0);
>> -	if (arche_pdata->svc_refclk_req < 0) {
>> +	if (!gpio_is_valid(arche_pdata->svc_refclk_req)) {
>>   		dev_err(dev, "failed to get svc clock-req gpio\n");
>>   		return arche_pdata->svc_refclk_req;
>>   	}
> But if this were to be changed, you'd need to update also the fourth
> call to of_get_named_gpio() in this function.

Sorry, I missed it. Thanks for point out. I will add check for this.

~arvind
>
> Thanks,
> Johan

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
