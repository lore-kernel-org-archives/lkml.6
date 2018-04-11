Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2024894-1523438194-2-3496252322472450922
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='uk', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523438193; b=UHqgVOyOxI7r3VDdZnnSGV+6iNVaoe3W2C7q4A0kPQWTBPnrzH
    Mk8GrxMT4E6FrPKbnYLzWRiJ40FhMzkfaXNTCyk/2mq1JhCyKlpds0uO6zowTyYa
    xuNcAHigVZ6lQxCFkR8Ba7XWQS6wIfw/uylGVTpb3JO6EIWpAAUbYOQaVP3p3vs3
    9ROqAf3MKwQR0P8dnKpki5r7waGlqWb51hmfw95qGCNuzCn/DztUmqABvWEjmttP
    tL2LTcaYDwALeL/soR8f3gOTi8kJl0zuAof7aMk0IeaazY3HWvgZGY+sPmdlcjOo
    oumB8qiqS8Y4QnbOaSsjtzb4KtyDZz2mMzvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=fm2; t=
    1523438193; bh=9FVc2t1+XG8zGW1U5P+f7Q7XyYQwcm8i3Jl1h1BXn1A=; b=F
    i4t2njT6f1d/qRQtwEQrjF/++QLIzHJ6Wt8cNbTA+0C/4uI7K4m3wBVC/Bjcb20i
    q9MYlH8uqpBq9i2JxYem/61RY34WQrN9qKMWNbS91DaG2fKBaSj2sxsgKubAG6ja
    KDtJCbMxpDfPi29NAoWl+35XPtP8sSWpf05oEevjeYyFklxfAmjMbYerdTzQZqLn
    RSvmF9FgXePY4l39MmCjzrwTvAj87Vhh8q/lcBEKYYKU2xcXDjimm7pzxzuxDp81
    hAOyPh5Wf/+xUaVgmyX3Jaa8U7ZF0aL4MbKAIZUTy2inRHm5OKkxKZ9pIOx6RSyo
    YAEq1SQ7i3Pcl4aARTt1Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mev.co.uk;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=mev.co.uk header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mev.co.uk;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=mev.co.uk header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfABdbSgDzb+ERxtSuWqC+aIW2RAj69pJ9WayM4/dmommIRw9SH+KLTbzhCE3o7dPNgGOlrHC6RL1QNHhbxShI4NkAFpSHe9fYDIWDybjC27LZ2LhBe2l
    SCE71mc786AojPUNkzKHtQoQq69J5MEjn3OLo5iBxAOTQwesBg4nsnC9R9Z7ZEtdFfTpOIjfwo+9nNuNi9QES+uGgEvjNGMKJ065yKBh/q5AvlVkjrHjbDA+
    yXw112U/xYvwrvXolilNRw==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=LMMEo6NmNBYA:10
    a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=v8_uC2TkAAAA:8
    a=DDOyTI_5AAAA:8 a=Mteujk6JuJGZj2b2tCYA:9 a=6DtscLQJHiNKBO5A:21
    a=h3CjRyiYmBHzpcop:21 a=CjuIK1q_8ugA:10 a=-zX3Q7Ulo5sA:10
    a=OGrQfBrq7qvr04naqs9r:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Auth-ID: siepeng@mev.co.uk
X-Sender-Id: siepeng@mev.co.uk
Subject: Re: [PATCH] staging: comedi: cb_pcidas64: fix alignment of function
 parameters
To: Julia Lawall <julia.lawall@lip6.fr>,
 Gabriel Francisco Mandaji <gfmandaji@gmail.com>
References: <20180410225007.GA5050@gfm-note>
 <alpine.DEB.2.20.1804110707130.2316@hadrien>
From: Ian Abbott <abbotti@mev.co.uk>
Message-ID: <fe7c72f2-2d51-42a7-5d2b-960174bc29a4@mev.co.uk>
Date: Wed, 11 Apr 2018 10:16:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1804110707130.2316@hadrien>
Content-Language: en-GB
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
 lkcamp@lists.libreplanetbr.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 11/04/18 06:07, Julia Lawall wrote:
> On Tue, 10 Apr 2018, Gabriel Francisco Mandaji wrote:
[snip]
>> diff --git a/drivers/staging/comedi/drivers/cb_pcidas64.c b/drivers/staging/comedi/drivers/cb_pcidas64.c
>> index fdd81c3..631a703 100644
>> --- a/drivers/staging/comedi/drivers/cb_pcidas64.c
>> +++ b/drivers/staging/comedi/drivers/cb_pcidas64.c
>> @@ -2268,14 +2268,14 @@ static inline unsigned int dma_transfer_size(struct comedi_device *dev)
>>   }
>>
>>   static u32 ai_convert_counter_6xxx(const struct comedi_device *dev,
>> -					const struct comedi_cmd *cmd)
>> +				   const struct comedi_cmd *cmd)
> 
> Someone has made the effort to put const on these parameters, but not on
> the other similar functions.  Perhaps this can be improved as well.

Perhaps, but that should be in a separate patch.

-- 
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk> )=-
-=(                          Web: http://www.mev.co.uk/  )=-
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
