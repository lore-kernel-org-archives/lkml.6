Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC08FC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B188B20C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HyRVuB0M";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Wq2mZ8GL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B188B20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbeJAVFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:05:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37052 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729378AbeJAVFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 17:05:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 80EA8601DA; Mon,  1 Oct 2018 14:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538404060;
        bh=V60tHifDm3NlAkqi+4FxBHwYykHmND9jnXP4yC66Rr4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HyRVuB0MrgF4853ufifIDO5U9K1V6wekoFctt2++kxv7A1Sdlqct0qAyChLOLmiFe
         9uPU6/FSTOfyYA+9Ap6Pn6T4345n50QG2SYGVV1xZgH8WXO7e16KwYBk0TKVT/CHkb
         +jXUPD7B6DYzgYw2izvy82ERi7I6/QECfPTdTy80=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4A32F60128;
        Mon,  1 Oct 2018 14:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538404059;
        bh=V60tHifDm3NlAkqi+4FxBHwYykHmND9jnXP4yC66Rr4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Wq2mZ8GLh3sgA/PFM1t1F1mR33UQJmFqviR4FAGRnkVcSv7oHPWPLOELmj9rZD2He
         KUa+MmfvOZ1t8PoOYJRu+DLMbEWBfzNs8jM4N8ZD6ILeHOjPy8Bg4+OKi/yAFzcrCK
         nuPc7Ws1oq2SSmbggHSD72ByRzLa/fXHsggZml4o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4A32F60128
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v2] gpiolib: Show correct direction from the beginning
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Timur Tabi <timur@kernel.org>, Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>
References: <20180921103604.13361-1-ricardo.ribalda@gmail.com>
 <20180921103604.13361-2-ricardo.ribalda@gmail.com>
 <153803107307.119890.10052910965015646333@swboyd.mtv.corp.google.com>
 <ffe11a8c-368b-8c74-54a7-a088c3997032@kernel.org>
 <3e07cab8-0f3e-7474-8f6d-e6bb16e8f998@codeaurora.org>
 <5aea282d-6fc9-cd70-cec4-10f28aa819b9@codeaurora.org>
 <CAOZdJXUUWUWHzus+3sbEXbW_q92e+SSzTQJCqCyQp6Y6_HOo3g@mail.gmail.com>
 <D3E6F4C4-E1C4-4D88-B118-878576BF5281@gmail.com>
 <CACRpkdawwrpEe6AAfdaxw6OMFXkCnq0gpznk1Up5p1=Wigx_2g@mail.gmail.com>
 <CAPybu_1P-RWCP8yjQKkFYAX11KtYGhAfASY24Q_NZ19PD09gxA@mail.gmail.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <79878ad4-1c2a-39fa-5baa-042140a6f1ad@codeaurora.org>
Date:   Mon, 1 Oct 2018 08:27:39 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPybu_1P-RWCP8yjQKkFYAX11KtYGhAfASY24Q_NZ19PD09gxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/2018 7:36 AM, Ricardo Ribalda Delgado wrote:
> Hi Linus
> On Mon, Oct 1, 2018 at 1:54 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>> On Fri, Sep 28, 2018 at 9:30 PM Ricardo Ribalda Delgado
>> <ricardo.ribalda@gmail.com> wrote:
>>
>>> How do we proceed from here? Can you fix your driver somehow to
>>> init the valid mask before enabling the gpio?
>>
>> Just include a hunk to the qcom driver reordering this call
>> at the same time. No need to make it separate patches,
>> it need to be tested together anyways.
>>
>> I guess just switch the order of these two:
>>
>>          ret = gpiochip_add_data(&pctrl->chip, pctrl);
>>          if (ret) {
>>                  dev_err(pctrl->dev, "Failed register gpiochip\n");
>>                  return ret;
>>          }
>>
>>          ret = msm_gpio_init_valid_mask(chip, pctrl);
>>          if (ret) {
>>                  dev_err(pctrl->dev, "Failed to setup irq valid bits\n");
>>                  gpiochip_remove(&pctrl->chip);
>>                  return ret;
>>          }
>>
> 
> the problem is that valid_mask is not a long/integer, is a struct that
> needs to be malloced, and is malloc at gpiochip_add_data :(
> 
> Maybe we need a callback from the driver to init that mask just after
> the allocation?
> 
> A fast grep shows that the only driver using need_valid_mask (not for
> irq) is msm:
> 
> ricardo@neopili:~/curro/kernel-upstream$ git grep "need_valid_mask ="
> | grep -v irq
> drivers/gpio/gpiolib.c: gpiochip->need_valid_mask = true;
> drivers/pinctrl/intel/pinctrl-cherryview.c: bool need_valid_mask =
> !dmi_check_system(chv_no_valid_mask);
> drivers/pinctrl/qcom/pinctrl-msm.c: chip->need_valid_mask =
> msm_gpio_needs_valid_mask(pctrl);
> 
> so hacking something in the driver might not be a terrible idea.
> 

IMO, hack up the driver and I'll test it.  We can figure out what is 
needed to work, then determine what is the proper solution for that.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
