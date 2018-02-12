Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2131322-1518464858-2-10148327188727347879
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518464858; b=cRREkhtQf7RkdPF6JeSKVPH+dFT6w1gxEnMdJIGSNlXBQlK
    3RUAg2UVo6UQqNH3uVDyE1LDA0m0v+jQoqdC2Bcfdg6fNAZz53e7FEYo6FZSWd7a
    1OxLwiMpG1vqjwQ8HxWH5tPLYH/vDdJ1LtR+Xx66RxC+742f5M1zUJoNXRAu22SM
    VKqgCv8BPOnQICpvJ/m041udK84dQ2yAQP43CsfMDIhOX4rJpM/3e/HZCcX5ewD1
    mEFuHvvKMumTWA8wT12qgz4DMQbwlDbqq1PmGUTa31V2uLnqRJCE2mjj9cnUv+jo
    7YKOQLsjjUmW8VJFqHpYMNOTE3hVJN3S+htdZRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518464858; bh=uGpgTk1/zR1xKQmFRtDD2vBh2mOBJENxy6MIw7pYFVU=; b=M
    Ac7GMSj34UEbPl8FutHSm+PCOOjWEr8OJNh4T8D4/LganNoAb129exiF9hyceW8I
    b19piy5lfN+Z7oxm5Jsbi1c9BHu6aL7W43hZGfJS6lLfs9UcZkIMPl2B2bEhMcRW
    ZuQnzkHyURpGPgQr/vUDaZ/K+M3Q1cYF+rvn2msXDlKLIi5jfY5K+HVdL29onBUH
    c+dkjiXobMjGlnKj+2V9Sa0/GfToDb2H48ch1uudOoFIykfSkPPSwhj5wu2NeleD
    /bM1yUHavjP4GvDyJ85gUlhyvFw6tJLkwqMjBT/dIGFwzuxj8d7q6xcTM3F7dzgW
    es29mILjMdC4eulhmuyjA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=np8FCjzY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=np8FCjzY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbeBLTqT (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Feb 2018 14:46:19 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34443 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751034AbeBLTqS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Feb 2018 14:46:18 -0500
X-Google-Smtp-Source: AH8x225HMfxTcUwrD/EhWE6axuksswwVNuDhjJ0vlFDeQYp/dj5kbkcn2toyVo19w3NGGbndk5RQ/g==
Subject: Re: [PATCH] extcon: intel-int3496: Fix oops on probe
To: Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <CGME20180211232639epcas2p4495c006e2063cde1ce86710767cd8e97@epcas2p4.samsung.com>
 <20180211232633.13565-1-hdegoede@redhat.com> <5A80D36D.9050206@samsung.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <fefa2805-9fd6-6e4c-b12e-265a37d654cb@redhat.com>
Date: Mon, 12 Feb 2018 20:46:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5A80D36D.9050206@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 12-02-18 00:36, Chanwoo Choi wrote:
> On 2018년 02월 12일 08:26, Hans de Goede wrote:
>> Commit 41d600274fbf ("extcon: int3496: process id-pin first so that we
>> start with the right status") starts the work on the workqueue before
>> registration to make sure we've a valid cable state directly after
>> registration.
>>
>> But that commit moves the queuing of the work to before we even alloc the
>> extcon, causing a NULL pointer deref in the worker.
>>
>> This commit moves the queuing of the work to after we alloc the extcon,
>> fixing the NULL pointer deref.
>>
>> Fixes: 41d600274fbf ("extcon: int3496: process id-pin first ...")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/extcon/extcon-intel-int3496.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/extcon/extcon-intel-int3496.c b/drivers/extcon/extcon-intel-int3496.c
>> index b23ee9d993a3..673bb26a9a2a 100644
>> --- a/drivers/extcon/extcon-intel-int3496.c
>> +++ b/drivers/extcon/extcon-intel-int3496.c
>> @@ -131,15 +131,15 @@ static int int3496_probe(struct platform_device *pdev)
>>   	if (IS_ERR(data->gpio_usb_mux))
>>   		dev_info(dev, "can't request USB MUX GPIO\n");
>>   
>> +	data->edev = devm_extcon_dev_allocate(dev, int3496_cable);
>> +	if (IS_ERR(data->edev))
>> +		return -ENOMEM;
>> +
>>   	/* process id-pin first so that we start with the right status */
>>   	queue_delayed_work(system_wq, &data->work, 0);
>>   	flush_delayed_work(&data->work);
>>   
>>   	/* register extcon device */
>> -	data->edev = devm_extcon_dev_allocate(dev, int3496_cable);
>> -	if (IS_ERR(data->edev))
>> -		return -ENOMEM;
>> -
>>   	ret = devm_extcon_dev_register(dev, data->edev);
>>   	if (ret < 0) {
>>   		dev_err(dev, "can't register extcon device: %d\n", ret);
>>
> 
> Instead, You better to send v3 after merging your patch[1] and this patch.
> [1] extcon: int3496: process id-pin first so that we start with the right status

Ok, I've rebased my tree on top of 4.16-rc1 and prepared a v3. During the
rebase I noticed that a patch for the axp288-extcon driver which was supposed
to get dropped did end up in 4.16-rc1, so I will also (resend) a revert for that.

Also another extcon-axp288 driver patch seems to not have made it into 4.16-rc1,
so I will resend that too.

Regards,

Hans
