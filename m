Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8A5ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 13:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B772086B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 13:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="mcjj2GYE";
	dkim=pass (1024-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="mcjj2GYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B772086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=inbox.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbeGNNjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 09:39:39 -0400
Received: from fallback12.mail.ru ([94.100.179.29]:49190 "EHLO
        fallback12.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbeGNNjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 09:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=iCWjcoEVCVw5YLgyR4cmwvD5WonIb7//HeePkQ/cEEA=;
        b=mcjj2GYE356WtjMoyZUApJUzGyrWJo4YrtDTJ84bjhEBoPPbfu1bTmcUSdsJUegN18zgv8jOHCH11JV7W3GFIi9mP6jdU+HmkY1LX4xDF8aXX+1BWKQh70S7qYLjoPHxkWgaYKIDuHglQIrY5XirU/hmT+Nsge8S1OcibLhG/s0=;
Received: from [10.161.25.36] (port=58152 helo=smtp59.i.mail.ru)
        by fallback12.m.smailru.net with esmtp (envelope-from <kitsunyan@inbox.ru>)
        id 1feKTQ-0004O4-9j; Sat, 14 Jul 2018 16:20:32 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=iCWjcoEVCVw5YLgyR4cmwvD5WonIb7//HeePkQ/cEEA=;
        b=mcjj2GYE356WtjMoyZUApJUzGyrWJo4YrtDTJ84bjhEBoPPbfu1bTmcUSdsJUegN18zgv8jOHCH11JV7W3GFIi9mP6jdU+HmkY1LX4xDF8aXX+1BWKQh70S7qYLjoPHxkWgaYKIDuHglQIrY5XirU/hmT+Nsge8S1OcibLhG/s0=;
Received: by smtp59.i.mail.ru with esmtpa (envelope-from <kitsunyan@inbox.ru>)
        id 1feKTK-0005kb-Lj; Sat, 14 Jul 2018 16:20:27 +0300
Subject: Re: [PATCH] Input: synaptics - Lenovo ThinkPad T25 and T480 devices
 should use RMI
To:     Teika Kazura <teika@gmx.com>
Cc:     dmitry.torokhov@gmail.com, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180707051913.24035-1-kitsunyan@inbox.ru>
 <20180714.153501.1002564188152837590.teika@gmx.com>
From:   kitsunyan <kitsunyan@inbox.ru>
Message-ID: <16d5f040-cb2d-9984-53a4-5ae127bf7d6f@inbox.ru>
Date:   Sat, 14 Jul 2018 16:20:23 +0300
MIME-Version: 1.0
In-Reply-To: <20180714.153501.1002564188152837590.teika@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-7FA49CB5: 0D63561A33F958A53DA67A9F37358AF3C563B2DE63770AA9F1AB823866D87A250A6AB1C7CE11FEE3643FE6A0CAC512C7BA3038C0950A5D36B5C8C57E37DE458B4C7702A67D5C33162DBA43225CD8A89FDD013041C98CC2ABD7CFF1EB438A8D765E1C53F199C2BB95B5C8C57E37DE458B4C7702A67D5C3316FA3894348FB808DBEB6346B700B4D54FE5BFE6E7EFDEDCD789D4C264860C145E
X-Mailru-Sender: E252BC732A74C87F819B83CB9CD050395199A0467073992B2D944B18C29F43BC02C5CE79F7D8EA619C6999534B19A478CA448B6582BF645E5B2433C9C15A0C96B0C09A45F598CAFDC7092FF7CD7CF138C001A007A554749AB4A721A3011E896F
X-Mras: OK
X-7FA49CB5: 0D63561A33F958A5BB2057C3AEF2AD393F29D776BDFBA8A53FF4E19AE7770FED462275124DF8B9C99B0B8D173C204012BD9CCCA9EDD067B1EDA766A37F9254B7
X-Mailru-Sender: A5480F10D64C9005C18DAE012115204D9F376BBD2CCB156F4A2EF86AD04243837942E65D3B0E2994EB669C69D2B190863DCCF50608321A3F177374E4942518504749A2BFAF39A7AF48B387D116B59FF477DC2785AC50553367EA787935ED9F1B
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Teika. (Yes, you are right.)

I should've worried about real name earlier since I already sent the patch from pseudonym. I don't mind if the patch will be authored by maintainer, replacing my sign with "reported-by". (Hope it's possible.)

Regards,
kitsunyan

On 14/07/18 09:35, Teika Kazura wrote:
> Hi, kitsunyan. (Привет, perhaps?) Thanks for you patch, but the "signed-off" tag needs your real name. You can re-submit your patch conforming to that rule. Or if you're ok, the kernel maintainer can instead sign it off, adding "reported-by: kitsunyan <kitsunyan@inbox.ru>". (I'm not sure about the latter case. Sorry if I'm wrong.)
>
> You can find the instruction in <kernell source tree>/Documentation/process/submitting-patches.rst .
>
> Best regards / Пока, 
> Teika (Teika kazura)
>
>
> From: kitsunyan <kitsunyan@inbox.ru>
> Subject: [PATCH] Input: synaptics - Lenovo ThinkPad T25 and T480 devices should use RMI
> Date: Sat,  7 Jul 2018 08:19:12 +0300
>
>> The touchpads on both T25 and T480 are accessible over SMBUS/RMI.
>>
>> Signed-off-by: kitsunyan <kitsunyan@inbox.ru>
>> ---
>>  drivers/input/mouse/synaptics.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
>> index 55d33500d55e..be934a082424 100644
>> --- a/drivers/input/mouse/synaptics.c
>> +++ b/drivers/input/mouse/synaptics.c
>> @@ -175,7 +175,9 @@ static const char * const smbus_pnp_ids[] = {
>>  	"LEN0071", /* T480 */
>>  	"LEN0072", /* X1 Carbon Gen 5 (2017) - Elan/ALPS trackpoint */
>>  	"LEN0073", /* X1 Carbon G5 (Elantech) */
>> +	"LEN008e", /* T25 */
>>  	"LEN0092", /* X1 Carbon 6 */
>> +	"LEN0093", /* T480 */
>>  	"LEN0096", /* X280 */
>>  	"LEN0097", /* X280 -> ALPS trackpoint */
>>  	"LEN200f", /* T450s */
>> -- 
>> 2.18.0

