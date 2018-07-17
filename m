Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E182ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 01:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FED4208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 01:24:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FED4208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731096AbeGQByh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 21:54:37 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:10031 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729913AbeGQByg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 21:54:36 -0400
Received: from [192.168.90.200] (10.18.20.235) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Tue, 17 Jul
 2018 09:23:50 +0800
Subject: Re: [PATCH 3/3] clk: meson-g12a: Add EE Clock controller driver
To:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
References: <1531134767-29927-1-git-send-email-jian.hu@amlogic.com>
 <1531134767-29927-4-git-send-email-jian.hu@amlogic.com>
 <CAFBinCBB9N_p6S_-dfiV=zDCf-RYnA3C-ir6oNLC7JAfdOqqiw@mail.gmail.com>
 <ec49c089-bccf-9aac-5d0f-43bc27770ad9@amlogic.com>
 <1531216472.2708.71.camel@baylibre.com> <7hfu0jmhbe.fsf@baylibre.com>
CC:     <yixun.lan@amlogic.com>, <qianggui.song@amlogic.com>,
        Rob Herring <robh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <mturquette@baylibre.com>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <bo.yang@amlogic.com>,
        <sboyd@kernel.org>, <jian.hu@amlogic.com>,
        <xingyu.chen@amlogic.com>, <qiufang.dai@amlogic.com>,
        <linux-amlogic@lists.infradead.org>, <sunny.luo@amlogic.com>,
        <carlo@caione.org>, <linux-arm-kernel@lists.infradead.org>
From:   Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <7e1cce0b-fc86-b900-2019-a85c5e5ba2ae@amlogic.com>
Date:   Tue, 17 Jul 2018 09:24:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <7hfu0jmhbe.fsf@baylibre.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.20.235]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Kevin

just want to clarify..

On 07/16/18 21:38, Kevin Hilman wrote:
> Jerome Brunet <jbrunet@baylibre.com> writes:
> 
>> On Tue, 2018-07-10 at 09:21 +0800, Yixun Lan wrote:
>>>
>>> On 07/10/18 05:53, Martin Blumenstingl wrote:
>>>> On Mon, Jul 9, 2018 at 1:14 PM Jian Hu <jian.hu@amlogic.com> wrote:
> 
> [...]
> 
>>>>> +
>>>>> +static const struct of_device_id clkc_match_table[] = {
>>>>> +       { .compatible = "amlogic,g12a-clkc" },
>>>>
>>>> I wonder if that should be "amlogic,meson-g12a-clkc" (I know that AXG
>>>> and GXBB/GXL/GXM omit the "meson-" prefix, but I am not sure if that's
>>>> correct - I'll CC Rob Herring on the dt-bindings patch)
>>>>
>>>
>>> we're fine with either way, since the g12a is recently new added SoC.
>>>
>>> but I guess those old compatibles which already exist won't be changed,
>>> as it will break the DT
>>
>> Yes, I doubt we are going to change the compatibles. With or without the meson
>> prefix, I suppose it going to stay that way.
> 
> Correct, we will not change existing compatibles.  Adding new ones for
> clarity is fine though.
> 
fine

>> It is worth thinking about it for new drivers though.
>> We already have the "amlogic,", so do we really to prefix even more with "meson-
>> "
>>
>> Also, if we were really strict about that scheme, should meson8b compatible be
>>
>> "amlogic,meson-meson8b-foo-bar" ... the SoC is meson8b, not just 8b after all ?
>>
>> For the particular case of the clock controller, I don't care very much, as long
>> as the compatible is coherent with documentation.
>>
>> I might have a preference for the current compatible ... just for consistency
>> with the other clock controllers.
> 
> In hindsight, I think using the "meson" prefix was a mistake.  It's
> redunant, IMO, but it's how we've been doing things for all the drivers,
> except for drivers/clk, which, honestly, I hadn't even noticed until
> now.
> 
> As Jerome said, I think consistency is an important goal, so leaving off
> the "meson-" for drivers/clk is fine with me.
> 
ok

> Also for consistency, for the rest of the drivers, keeping "meson-" is
> probably the right thing to do.
> 
ok, for the above, you are talking about the already exist compatible
names? or the patches we will push in the future?

> However, patches would be welcome to add compatibles without the "meson"
> for the rest of the drivers & documentation as well, but please do not
> remove any compatibles.
> 
I assume you are talking about the patches in the future we will push?
to drop the "meson".

I'm confused here, as the above two paragraphs conflict with each other

> Kevin
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> 
> .
> 

