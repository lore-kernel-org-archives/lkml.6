Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4455DC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D6F21731
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D6F21731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732796AbeHNS1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 14:27:33 -0400
Received: from mail.windriver.com ([147.11.1.11]:47758 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbeHNS1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 14:27:33 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w7EFdejL025029
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 14 Aug 2018 08:39:40 -0700 (PDT)
Received: from [128.224.162.216] (128.224.162.216) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.399.0; Tue, 14 Aug
 2018 08:39:39 -0700
Subject: Re: [PATCH v2 2/2] kgdboc: Change printk to the right fashion
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        Joe Perches <golf@perches.com>
CC:     <jason.wessel@windriver.com>, <gregkh@linuxfoundation.org>,
        <jslaby@suse.com>, <kgdb-bugreport@lists.sourceforge.net>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1534250761-824-1-git-send-email-zhe.he@windriver.com>
 <1534250761-824-2-git-send-email-zhe.he@windriver.com>
 <20180814133536.bfpygzwnmlqfsee5@holly.lan>
 <1678613360b7aebbf1ab42dd89139cb666ee8cd9.camel@perches.com>
 <20180814144132.mpqzz3sxdbfzn7fe@holly.lan>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <e7e52f01-0ea6-094f-d9e9-cd2115311962@windriver.com>
Date:   Tue, 14 Aug 2018 23:39:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180814144132.mpqzz3sxdbfzn7fe@holly.lan>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [128.224.162.216]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年08月14日 22:41, Daniel Thompson wrote:
> On Tue, Aug 14, 2018 at 07:04:11AM -0700, Joe Perches wrote:
>> On Tue, 2018-08-14 at 14:35 +0100, Daniel Thompson wrote:
>>> On Tue, Aug 14, 2018 at 08:46:01PM +0800, zhe.he@windriver.com wrote:
>>>> From: He Zhe <zhe.he@windriver.com>
>>>>
>>>> pr_* is preferred according to scripts/checkpatch.pl.
>> []
>>>> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
>> []
>>>> @@ -136,7 +136,7 @@ static int kgdboc_option_setup(char *opt)
>>>>  	}
>>>>  
>>>>  	if (strlen(opt) >= MAX_CONFIG_LEN) {
>>>> -		printk(KERN_ERR "kgdboc: config string too long\n");
>>>> +		pr_err("kgdboc: config string too long\n");
>>> Looks like you should remove the tags from pr_err and use pr_fmt(fmt) to
>>> put tags on the messages:
>>>
>>> #define pr_fmt(fmt) "kgdboc: " fmt
>> True and it's probably better to use:
>>
>> #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> Good point! Thanks.

Daniel, Joe, thanks for your good suggestions. v3 is sent.

Zhe

>
>
> Daniel.
>

