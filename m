Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2635071-1523457071-3-11339581534293080241
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523457071; b=TgPcXbGV3d0yI1jOlNrDrt8WvR5doAXbIRCC4DahHzX48GT0tJ
    /e7DRrx1WsdXpbqU3AgoMeFa1nvvl+sxTvVxfqwywBpaHHNW50bNDRpVrEk9Jh8E
    P1tJAfndiflal45W9jWa1O6RHYD4b8ke8Ms1IoD2qtG6spiZWjNaK1myGjEzxQyj
    9HqqKuBBksNKZct5EziztPq1hQFeqhlrka+Ji7ufi4E5A/6mD0ynUqkRmSbw0Pp5
    jENErKlM+APVGDUdjuX6Oq2kX3qfShGDJnqcaF9N7zgVUG9u0rTDA9JvhvKDE5eC
    0qNMFBKpbFMGi/71YZ0/JMXt3tsAbOu5LYmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=fm2; t=
    1523457071; bh=/9VVE1JKgruX+wg/HT7aXV103TWFOrDuhZUWNIteg04=; b=B
    qbFMtankUi3UyotYWrVH+KEMx0R76K9BPy1yowvNEpKXPzAqxHX+2M+LPsveluu3
    Ce2UDgw+yxnawc+aedgIdAujYrpzADCUeNfETP36UF2Aeo0gcH1BwrrISIIGgcjm
    6sSpM6KC4cigK5mIZnmZU2a+g4cg62S4gSwx7F/GcNKJoDY/1PFO2Pihs+ZcgBYj
    ZEKFKNUWgcr0TzjQ1nhub8YembiCoU1AeZFoR3ivRjI0Fsg7JUfF0cKTMdNZZFLp
    TNu+Oi+Sl7TKjfuY2pD3FyK4YhI81XTPDouAzzFh5u8CqGXbQMjczdZvk8LqzNJS
    SyJUjXSVrmSR+bMX5s8Aw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HP5qP8ih x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Co5f+U3k;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HP5qP8ih x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Co5f+U3k;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAYKjSSeiRBLNVsi2ejKQGS1N8hjQoZVkz5OhmR3sP+ZEX10Sqr5laoVtChIuozqaH/9Qij0/iJ130Y69zeu305foXou0by7oE3UTRKEInmSgXJLu8/k
    fddywLWtKMyT5WolsmviqB9TLGW9ChQ4QPKEU3tFavp4/tE74I46YOUqcrm0zCLPft6d7dWpPEgzqJlfwrUWjLr4Udmo6XS7b5NQhss1OA7lCnKQYp+ucQ85
    dXGZtFKPGAWZpgTE0UY/5g==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=tmjX-nCzVX8A:10 a=xqWC_Br6kY4A:10 a=4_-BN3WEXhEA:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8
    a=BfFouFL-rJSI4YtKBT0A:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4/wJuFxx1jWjFGRRKcf2Laq7Vg2H7DYpfuCx4GV718IsX6tfjyYwV4Hl/xeVruIpocJZ1lakQ==
Subject: Re: [PATCH 1/2] staging: irda: Replace mdelay with usleep_range in
 stir421x_fw_upload
To: David Miller <davem@davemloft.net>
References: <ecf21a6e-0e99-55dc-54be-3bd633bedbc5@gmail.com>
 <20180411081724.GA4155@kroah.com>
 <865ad04e-ccbc-6144-c6ea-fc39790f861f@gmail.com>
 <20180411.102603.1023000970717039691.davem@davemloft.net>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <7254a94f-2c39-13b9-a97d-43e9d33f6101@gmail.com>
Date: Wed, 11 Apr 2018 22:30:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180411.102603.1023000970717039691.davem@davemloft.net>
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
Cc: devel@driverdev.osuosl.org, samuel@sortiz.org, gregkh@linuxfoundation.org,
 johan@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 arvind.yadav.cs@gmail.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 2018/4/11 22:26, David Miller wrote:
> From: Jia-Ju Bai <baijiaju1990@gmail.com>
> Date: Wed, 11 Apr 2018 16:20:22 +0800
>
>> Okay, I now know why many of my patches were not replied.
> Many of your patches are not responded to because you handle patch
> feedback poorly sometimes.

Okay, thanks for pointing it out.
I will handle patch feedback much more carefully.

> Also, all of your networking submissions have been dropped because
> the net-next tree is closed.
>

Okay, I will choose the proper tree to submit.


Best wishes,
Jia-Ju Bai
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
