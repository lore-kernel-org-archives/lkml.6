Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D66C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B0220877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mM9iXKzq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B0220877
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbeIZD36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:29:58 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50598 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbeIZD35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 23:29:57 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8PLKD4U091818;
        Tue, 25 Sep 2018 16:20:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537910413;
        bh=sFeFqN0sQZ6KOPZJQezA1h9xQWS8JFPtaEjTw/+3TU8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mM9iXKzqvnRKq/iwAokpUcgL7QREVWGUrTq1tKsBLj/LvzFwUojUdLdkb4tgtlRka
         jCfIqQPMJjmlKHQXARgJMqMT8qZjEaWeVSDYTS6D7/5l9eoooeUNq0lKqoDa+R7dJW
         T7eUg1ehEd5KID6kPf8Gt2jWd9xmZBX7M/kYTu/Y=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8PLKD80011506;
        Tue, 25 Sep 2018 16:20:13 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 25
 Sep 2018 16:20:13 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 25 Sep 2018 16:20:13 -0500
Received: from [172.22.166.242] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8PLKD05013891;
        Tue, 25 Sep 2018 16:20:13 -0500
Subject: Re: [PATCH v7 3/6] dt-bindings: leds: Add bindings for lm3697 driver
To:     Rob Herring <robh@kernel.org>, Pavel Machek <pavel@ucw.cz>
CC:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
References: <20180911170825.17789-1-dmurphy@ti.com>
 <20180911170825.17789-4-dmurphy@ti.com> <20180924161844.GA29028@bogus>
 <20180924180219.GA24418@amd>
 <CAL_JsqLsKtzvnkfwy4H7QQyRqwEEmSp_qi_28=QoLJqs0w2NNw@mail.gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <b1990cde-9b12-58e0-7181-5085234c0a8a@ti.com>
Date:   Tue, 25 Sep 2018 16:19:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLsKtzvnkfwy4H7QQyRqwEEmSp_qi_28=QoLJqs0w2NNw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob/Pavel/Jacek

On 09/25/2018 02:39 PM, Rob Herring wrote:
> On Mon, Sep 24, 2018 at 1:02 PM Pavel Machek <pavel@ucw.cz> wrote:
>>
>> Hi!
>>
>>>> Add the device tree bindings for the lm3697
>>>> LED driver for backlighting and display.
>>>>
>>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>
>>>>  .../devicetree/bindings/leds/leds-lm3697.txt  | 86 +++++++++++++++++++
>>>>  1 file changed, 86 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.txt
>>>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>
>> We already have binding for lm3697 in
>> Documentation/devicetree/bindings/mfd/ti-lmu.txt . Is it good idea to
>> have second one?
> 
> Of course not. Now that you mention it, I do remember seeing some
> discussion on this.
> 
> Rob
> 

I will be posting a RFC tomorrow with all the changes that shows 3 devices
attached to the common code along with extending out the features on the LED
drivers themselves.

Its not complete or tested code but it should give a basis for discussion.  This way I
can do some other code while this is being discussed.

Dan

-- 
------------------
Dan Murphy
