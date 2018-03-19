Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2220729-1521443645-2-11450557969393689587
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521443644; b=Nin5+Wb2+F54Wwv/uFJUKb0XpsJo0RtVj3OLFGhHxEJlJc5
    nS7OEfikXY0/3+meHsmQeRRThM+VGSMJ7J4c8NfvFgzRJvUVfzxFhAEYd+8NRhtl
    cGOi48nt5Rm6IVoWNdmyZvyN61NLWUIm5lZ7w5kzFoVBhTmA5yrYdUGY9BoBLQpC
    W1uOZTv5zSW0gKPshzgFUcd/Pol3/HOHL7XPtBPhplPa7tferClPfDg+rUrjCHea
    tHW31wM+T1/2OUuOqkcZ8aDOelPBVscd7H37MIEtRZ6lEuxmmwqIrASE5gWL5l2Y
    uWlb6kKuYstncC70mMUTTtCBzFGynn6gnsfSBnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521443644; bh=QPyPBJOjLQRh4+GV1uKYUs2nYla3S02/PCgfH8F0dJ0=; b=C
    zqveQ3Ww7zvwyccY/KEhX4b6mH4br9zZc3BPuxtEIJv+DKTOpUiP8BulWrBQEIfy
    3dNbNLr0VwpaLxgHzT+3Ip4dmheqLw7yaCpLTkoZTJNrseb5zeKZHiCwJ8M1cFsL
    n73TA/qgXQKW8zA3KB3vigrweb3H7gbFOPx7c5lIiOsdbDQ/FPm9QDbNo6gxGIs9
    WW2hKuTq6mh06fwoPn+xn78aBeksKJsL1C7whWlCXCk7eC2xSf6wYosaZBDEsvyO
    v/Ir/N/UXOQvjL44b2+M1yW2m+1ycSVbDx3zGekVdnSJTasqYpjtULtO0X9Vsyr1
    hTJoQv+6KbzOCRyyCtz1Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=ZqO04mgy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgddutdejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgshhpjeesthekredttdefjeenucfhrhhomheprfgvthgvrhcufghjfhgrlhhushhiuceophgvthgvrhdruhhjfhgrlhhushhisehtihdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhgtihdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdduheejrddujedtrddujedtrdejheenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeehheeifeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=ZqO04mgy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgddutdejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgshhpjeesthekredttdefjeenucfhrhhomheprfgvthgvrhcufghjfhgrlhhushhiuceophgvthgvrhdruhhjfhgrlhhushhisehtihdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhgtihdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdduheejrddujedtrddujedtrdejheenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeehheeifeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932073AbeCSHOB (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 03:14:01 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:22264 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755164AbeCSHOA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 03:14:00 -0400
Subject: Re: [PATCH 4.14 064/109] dmaengine: bcm2835-dma: Use
 vchan_terminate_vdesc() instead of desc_free
To: Vinod Koul <vinod.koul@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Eric Anholt <eric@anholt.net>,
        Sasha Levin <alexander.levin@microsoft.com>
References: <20180316152329.844663293@linuxfoundation.org>
 <20180316152333.462064800@linuxfoundation.org>
 <20180316184640.rxw6kwvqghsmdgcc@xps> <20180317143253.GI15443@localhost>
 <20180318102417.GA30164@kroah.com> <20180318104451.GA19721@kroah.com>
 <20180319030840.GJ15443@localhost>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <e83c7924-7e52-eeab-adf2-ba2af159cfac@ti.com>
Date: Mon, 19 Mar 2018 09:14:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180319030840.GJ15443@localhost>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 2018-03-19 05:08, Vinod Koul wrote:
> On Sun, Mar 18, 2018 at 11:44:51AM +0100, Greg Kroah-Hartman wrote:
>> On Sun, Mar 18, 2018 at 11:24:17AM +0100, Greg Kroah-Hartman wrote:
>>>>> This patch is causing a build error on arm and arm64 per i.e.
>>>>> https://kernelci.org/build/id/5aac017e59b5141cb1b3a4d5/
>>>>>
>>>>> Builds are also failing for arm/arm64 on 4.15 and this patch seems to be a
>>>>> problem there as well, but I have not verified it yet.
>>>>
>>>> I think we are missing commit 1c7f072d94e8. Pls cherrypick that as well
>>>>
>>>> commit 1c7f072d94e8b697fd9b70cdb268622a18faf522
>>>> Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>>> Date:   Tue Nov 14 16:32:04 2017 +0200
>>>>
>>>>     dmaengine: virt-dma: Support for race free transfer termination
>>>>
>>>> This adds vchan_terminate_vdesc API..
>>>
>>> Thanks, that helped.  I've now added this and send out a -rc2 for this
>>> kernel.
>>
>> Oops, no, that broke the build for all arches :(
>>
>> Let me just go drop this patch, and the two dmaengine patches that
>> relied on this one.  If you think these should be applied to the stable
>> trees, can you send me a series of working patches?
> 
> Okay let me grab your tree and cherry-pick all that is required and send
> you. Stay tuned...

I think these are the patches that need to be picked for this to work/compile:

2c6929d2ea70 dmaengine: s3c24xx-dma: Use vchan_terminate_vdesc() instead of desc_free
3ee7e42f3c9b dmaengine: k3dma: Use vchan_terminate_vdesc() instead of desc_free
397c59bce6cb dmaengine: img-mdc-dma: Use vchan_terminate_vdesc() instead of desc_free
47d71bc75d07 dmaengine: amba-pl08x: Use vchan_terminate_vdesc() instead of desc_free
f0dd52c85d61 dmaengine: dma-jz4780: Use vchan_terminate_vdesc() instead of desc_free
de92436ac40f dmaengine: bcm2835-dma: Use vchan_terminate_vdesc() instead of desc_free
174334bcd9f8 dmaengine: edma: Use vchan_terminate_vdesc() instead of desc_free
b1faf0f564ff dmaengine: omap-dma: Use vchan_terminate_vdesc() instead of desc_free
1c7f072d94e8 dmaengine: virt-dma: Support for race free transfer termination
6af149d2b142 dmaengine: virt-dma: Add helper to free/reuse a descriptor

Most probably we missed the 6af149d2b142 and that caused the build failures.


- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
