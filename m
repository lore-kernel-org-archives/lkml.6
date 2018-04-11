Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1888220-1523434856-2-12476853039981143822
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523434856; b=ccAmppWIKhgAMEr1YSTkbR6/gywLGIlNdljXCvhsfOg0uhloSS
    30KFK5H5S4xeZkzDd9r6AJLrCF8NAdOO+/SCN4Vo4X/aASDSj7cP9+OApk/wFgfK
    8bF4hNgrmJO6TfbrM+YIg3Cd3kQKwbfR4fBGjjJlamE+0x0OojTH2PGPMxI4zjuc
    FYzPwpkgr/yDpj3gJ144n2vHIWxI0qGKhtV1BmN4fcpUdKFOjGD6tDQVu+UYws7S
    F5oWejg65Du8d8bBgPLUNUej6AuVEaUGbPT3RqscUNJl6bFlujNtXpKae5dyjhjn
    Fa+E+kJnCwUpvccdKOsMPlsG02teHPlCO4pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=fm2; t=
    1523434856; bh=nOsn7bF7VWWvKaUZpp5agF/LV0Pe/pWL0dqMRTT+td0=; b=P
    kraRU3FygZSU8uuj+0FCOSCF2lvHj9bhJlDGdI7Invi6VvYLSuTLIvKvRWXjumyL
    vIFgLuFj8KCHtOYMIStSD0BBTzBRLvDVtoREgP8jxpN9zCQ10GYUmp2Xv5w9ELTU
    ea3nyPd1wPrwotoTGRz7msF4jtUpxsupmcn4QoZ0iny48R5eTRhkiSHZLxM2dfAF
    nkDtQHiVfyuF2cr6nma6ymQimlxPCuRCVtetN7cz41JfHMkSZV+JsyXzHLtcW/S5
    mOfgPyinX2KQO13qpz7mv/th6Zf4uBiFAh3Sybt40tu2AJQfrYKNZB8v1Xcht42u
    u23Z/7wFqf4xGrxvxYEYQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=FGeb7JSV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FYx8tpI9;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=FGeb7JSV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FYx8tpI9;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGcprexzKsnRPSAcaRUSlTEPyA+Z9WUHS3NRn7pIay+0iAudUKDDMtM8pETo6x5bxAyfO3rN55w7lefqRASznUFU8lmMQGxkMMfQ709qKCLRtjA0PY23
    caGpU7GJrHkm9LW2FjvMco/7qe8KwyR8KzLiepkWFK1YLD4tEkSlEw8rUeSARmY7r0BdIELOudrRTbF1c16DpGm+GSymd674MInauiyLtnEWMGhIufdXhbJV
    EbQoDiJvmIZqQEr4IRWTNQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=tmjX-nCzVX8A:10 a=xqWC_Br6kY4A:10 a=4_-BN3WEXhEA:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8
    a=c6UUJL75T4R0Co66NJEA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4/eCqgKAUHzSvkCB+fkJT6kYCq/VrNFJ7wN264J9pUUUoiry0bxO+wieVO6V9hdoERcUo5R7w==
Subject: Re: [PATCH 1/2] staging: irda: Replace mdelay with usleep_range in
 stir421x_fw_upload
To: Greg KH <gregkh@linuxfoundation.org>
References: <1523410174-1553-1-git-send-email-baijiaju1990@gmail.com>
 <20180411064135.GA28354@kroah.com>
 <d65d1116-7ffd-e289-5379-cc052782700d@gmail.com>
 <20180411080311.GB2137@kroah.com>
 <ecf21a6e-0e99-55dc-54be-3bd633bedbc5@gmail.com>
 <20180411081724.GA4155@kroah.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <865ad04e-ccbc-6144-c6ea-fc39790f861f@gmail.com>
Date: Wed, 11 Apr 2018 16:20:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180411081724.GA4155@kroah.com>
Content-Language: en-US
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
Cc: devel@driverdev.osuosl.org, samuel@sortiz.org, netdev@vger.kernel.org,
 johan@kernel.org, linux-kernel@vger.kernel.org, arvind.yadav.cs@gmail.com,
 davem@davemloft.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 2018/4/11 16:17, Greg KH wrote:
> On Wed, Apr 11, 2018 at 04:11:00PM +0800, Jia-Ju Bai wrote:
>>
>> On 2018/4/11 16:03, Greg KH wrote:
>>> On Wed, Apr 11, 2018 at 03:17:10PM +0800, Jia-Ju Bai wrote:
>>>> On 2018/4/11 14:41, Greg KH wrote:
>>>>> On Wed, Apr 11, 2018 at 09:29:34AM +0800, Jia-Ju Bai wrote:
>>>>>> stir421x_fw_upload() is never called in atomic context.
>>>>>>
>>>>>> The call chain ending up at stir421x_fw_upload() is:
>>>>>> [1] stir421x_fw_upload() <- stir421x_patch_device() <- irda_usb_probe()
>>>>>>
>>>>>> irda_usb_probe() is set as ".probe" in struct usb_driver.
>>>>>> This function is not called in atomic context.
>>>>>>
>>>>>> Despite never getting called from atomic context, stir421x_fw_upload()
>>>>>> calls mdelay() to busily wait.
>>>>>> This is not necessary and can be replaced with usleep_range() to
>>>>>> avoid busy waiting.
>>>>>>
>>>>>> This is found by a static analysis tool named DCNS written by myself.
>>>>>> And I also manually check it.
>>>>>>
>>>>>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>>>>>> ---
>>>>>>     drivers/staging/irda/drivers/irda-usb.c | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>> Please, at the very least, work off of Linus's tree.  There is no
>>>>> drivers/staging/irda/ anymore :)
>>>>>
>>>> Okay, sorry.
>>>> Could you please recommend me a right tree or its git address?
>>> Have you looked in the MAINTAINERS file?  Worst case, always use
>>> linux-next.
>>>
>>> greg k-h
>> Oh, sorry, I did notice the git tree in the MAINTAINERS file.
>> I always used linux-stable.
> linux-stable is almost never the tree to use as it is almost always
> 12000 patches behind what is in Linus's tree and about 20000 changes
> behind linux-next.
>

Okay, I now know why many of my patches were not replied.
I should choose correct tree in the MAINTAINERS file.
Thanks :)


Best wishes,
Jia-Ju Bai
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
