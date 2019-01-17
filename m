Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B00C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42B920851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="fS48/Itd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfAQWbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:31:40 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:60022 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfAQWbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:31:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1547764296; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+QfZXXY/CGGFt7A/vIxhzgSb/TWMaE8ImGqTkc74C6o=;
        b=fS48/ItdLLXUHHtjWIWhZZqQ+mw1JAxgJDtJN2MR18Fhc1R6/5VYQU454GDlQK22b61EU6
        MGBKURelta48f7j+mdbosiimwXSH6/DS3Gf04EKDWchGt1OKoLIMb9DVxSaHUwDvb5VOBX
        mKPvXkqyfuHh/tCVGhTV3CoJXY7H6M4=
Date:   Thu, 17 Jan 2019 19:31:27 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 3/4] usb: musb: Kconfig: Drop dependency on MACH_JZ4740
 for jz4740
To:     Bin Liu <b-liu@ti.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <1547764287.2057.0@crapouillou.net>
In-Reply-To: <20190115162603.GB18026@uda0271908>
References: <20190110133700.4471-1-paul@crapouillou.net>
        <20190110133700.4471-3-paul@crapouillou.net>
        <20190115162603.GB18026@uda0271908>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 15, 2019 at 1:26 PM, Bin Liu <b-liu@ti.com> wrote:
> Hi Paul,
> 
> On Thu, Jan 10, 2019 at 10:36:59AM -0300, Paul Cercueil wrote:
>>  Depending on MACH_INGENIC prevent us from creating a generic kernel 
>> that
> 
> Again, did you mean MACH_JZ4740 instead?

Dammit. I'm sorry. Will send a v3 right now.

>>  works on more than one MIPS board. Instead, we just depend on MIPS 
>> being
>>  set.
>> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net 
>> <mailto:paul@crapouillou.net>>
>>  ---
>> 
>>  v2: Remove info about adding COMPILE_TEST in commit message, as it 
>> was
>>      there before
>> 
>>   drivers/usb/musb/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>>  diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
>>  index ad08895e78f9..6f5b0ed6a507 100644
>>  --- a/drivers/usb/musb/Kconfig
>>  +++ b/drivers/usb/musb/Kconfig
>>  @@ -111,7 +111,7 @@ config USB_MUSB_UX500
>>   config USB_MUSB_JZ4740
>>   	tristate "JZ4740"
>>   	depends on NOP_USB_XCEIV
>>  -	depends on MACH_JZ4740 || COMPILE_TEST
>>  +	depends on MIPS || COMPILE_TEST
>>   	depends on USB_MUSB_GADGET
>>   	depends on USB_OTG_BLACKLIST_HUB
> 
> Regards,
> -Bin.


