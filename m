Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1B9C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 14:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 546E92064D
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 14:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BjpRxqub"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 546E92064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbeG1PaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 11:30:13 -0400
Received: from m12-18.163.com ([220.181.12.18]:58029 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728780AbeG1PaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 11:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=3MYvq
        sG3cWz4bbMpteDqxdJyroApbFouTWsj6nMLLqY=; b=BjpRxqubFU0t+LdoN8rAd
        TjnBWuvDWE4Kh4RLcDYLvlU6TI1LsXxW+ooh+cggWtZU8jJGs2AwdskDQ06l+sgl
        GvKnMht86FR7wiNeW7Xslm5wNiD3R6ZnKzVvtu4jYUhXf4NyJDQCRAwSRoObO5Wz
        MnnRqRhXuBOvnR5bgVbEUY=
Received: from [192.168.0.103] (unknown [223.73.7.251])
        by smtp14 (Coremail) with SMTP id EsCowABHpR2Kd1xbVv61Mw--.63351S3;
        Sat, 28 Jul 2018 22:02:52 +0800 (CST)
Subject: Re: [PATCH 1/1] lib: use sunday algorithm to do strstr() and
 strnstr()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
References: <20180722173715.25327-1-zengzhaoxiu@163.com>
 <20180722183706.GA7979@kroah.com>
 <9b18802b-a451-eb81-3317-1de406f03118@163.com>
 <6dc928cd-adbb-0304-1308-fb556d48698d@163.com>
 <CAHp75Vd2Lu110om-hPE2bx_XFa0zpNHHC4RC_uLsTBSywJO2KQ@mail.gmail.com>
From:   Zhaoxiu Zeng <zengzhaoxiu@163.com>
Message-ID: <6b33eb08-b7f8-0104-4fe0-1c0f4cd5edfc@163.com>
Date:   Sat, 28 Jul 2018 22:02:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vd2Lu110om-hPE2bx_XFa0zpNHHC4RC_uLsTBSywJO2KQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowABHpR2Kd1xbVv61Mw--.63351S3
X-Coremail-Antispam: 1Uf129KBjvJXoWrKr48Kw13Kr1DuFWxtr1DJrb_yoW8JrWxpF
        Wvva1rKF4DJay2yr1vkrn7XF4Yy3sakrykXry5Xwnaywn0qFn8Kr4xtrWj9F1kurn2kw1S
        yFWDt3yUZF1DXaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jiuc_UUUUU=
X-Originating-IP: [223.73.7.251]
X-CM-SenderInfo: p2hqw6xkdr5xrx6rljoofrz/1tbiow6RgFUMGqqqlwAAso
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018/7/27 18:39, Andy Shevchenko 写道:
> On Fri, Jul 27, 2018 at 8:48 AM, Zhaoxiu Zeng <zengzhaoxiu@163.com> wrote:
>> 在 2018/7/27 1:17, Zhaoxiu Zeng 写道:
>>> 在 2018/7/23 2:37, Greg Kroah-Hartman 写道:
>>>> On Mon, Jul 23, 2018 at 01:37:15AM +0800, Zhaoxiu Zeng wrote:
> 
>>>>> The Sunday algorithm is a variation of Boyer-Moore algorithm, it is easy and fast.
>>>>> For the Sunday algorithm, to see
>>>>>     http://www.inf.fh-flensburg.de/lang/algorithmen/pattern/sundayen.htm
>>>>
>>>> So you say, but what does this really buy us?  Why make this change?
>>>> How was it tested?  What is the downside of not taking this?
> 
>>> I use the following program to test on fc28.
>>> Compile with O2, the new version is almost 2X faster than the original.
> 
>>> The code size of the original is 0x80, the newer is 0xB0.
> 
> So, output of bloat-o-meter would be good to have in commit message.
> 
>>> The test result:
> 
> Compact performance statistics as well.
> 
>>> Thanks!
> 
>> The original strnstr might has a bug too!
>> For example, assume s1 is "123\0abc...." and s2 is "abc\0",
>> call strnstr(s1, s2, 7) will return &s1[4], but the correct result is NULL.
> 
> If there is a bug, send another patch to fix the bug first.
> 

The bug could be fixed by this patch.

