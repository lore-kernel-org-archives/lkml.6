Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7BC5BC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 15:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2982A208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 15:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="IY5/mGUa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TfgvgCxq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2982A208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965968AbeFOP74 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 11:59:56 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:38470 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965593AbeFOP7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 11:59:54 -0400
Received: by mail-vk0-f67.google.com with SMTP id b77-v6so5950569vkb.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 08:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=0/oKfCb0RBBig2EBhb5AL88bePxL3pNP9Cn2/k/p+us=;
        b=IY5/mGUadd3CA+5iO9ud3J1h9jDwRy6u6ot6vWjZ8hh4iNlkY68kNJfeTseqdAJRH2
         T5yYCfndyGMFhlFKqWeuqfQKT8J1HV6lIq/yz7566EKWncx6MWKY9CeWsv3VePu4Pcco
         ION56P0wYzw2Zx/DEqNc2BJpPB6O0tn9WxoldShB38+vMxNXBcU6MvgVGrGr3gd6ASLr
         r/BCJy5NbAFKqTTbV9DHQ63VKLHOaRgVsjQIT+vFSbHGaiZ/eMn+o2pqTjlfVYjuuolm
         C1lhULO2Xy0bBuZ0AZWDBTc10SqH3yUejCwE6kqbQseJ1nwK7XYr3Nb2gEgy7wzwDsDQ
         jo7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=0/oKfCb0RBBig2EBhb5AL88bePxL3pNP9Cn2/k/p+us=;
        b=TfgvgCxqiMe26L68J0onu/TFyhKRCJjKRhajPGUng5pyV0PG1zUYPxz3kdkpRYm9B6
         UFFqMHZJf/Rc+5vXnbRydca0SQ5entr0fmYqT2+qyWGrKOxSFzacbkDM1cw3a3S6m06A
         /JHRV8OpqzCR9Oe8269fncJckuN9qBQXLQKwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=0/oKfCb0RBBig2EBhb5AL88bePxL3pNP9Cn2/k/p+us=;
        b=Bd2wwvPp/tY3NNppQh/ZghXrTU7IWB1uElzsR7sfAMq0QguLANWDmDLvuc59pMB3Pp
         Gpttc9ktMank5LLQu5XevV2TOe33d293/MPErOuHTBVd5IWejKFn4YulWztxyBO9szHD
         HORh564P4FgfZHtSUH6gJM9qfseLFb4uakcdmtVTOYr/jCV2BJVHvM7vC+3y0GY6To75
         u423YVU1R+xS/CR7qAlr36C7emecM/qL0HA1WyoFSrnd9Ilk1nZA8yi2qtmPJ7onDoOt
         zI3osA13P1qRq255tzhreUF/GSij7hV459/V4iMptYt2cux5APOMOUlPGxowrhg+rrTA
         8Vyw==
X-Gm-Message-State: APt69E2wjiUUwAFxSybDx3k0xr/LhXrj3TiDO0Iu9zsILym4ZnkMo4ba
        2uFtuXRgFdtA/4aE6Vylg/yxyk7SheW8UeQy0xuMWQ==
X-Google-Smtp-Source: ADUXVKJs/YTYLibUjFF2KlIdsXGnNTGSCi5/2O0o79JrIjcAd0aRpUCxleiNb91lbFdIhfin2t22ft2wVvPrTAhOmn0=
X-Received: by 2002:a1f:c007:: with SMTP id q7-v6mr1385522vkf.144.1529078393376;
 Fri, 15 Jun 2018 08:59:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 08:59:52
 -0700 (PDT)
In-Reply-To: <3e737866-4d59-ac2e-c53f-540912613f12@linaro.org>
References: <20180515211622.195140-1-dianders@chromium.org> <3e737866-4d59-ac2e-c53f-540912613f12@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 15 Jun 2018 08:59:52 -0700
X-Google-Sender-Auth: LvgNOSyz2Je6-P2l1didXjEZ7VI
Message-ID: <CAD=FV=UqiipbGwMuc16DSdn9VDsU8c1K+0NBYkVS0wwLXfCOyg@mail.gmail.com>
Subject: Re: [PATCH] nvmem: Don't let a NULL cell_id for nvmem_cell_get()
 crash us
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 16, 2018 at 1:38 AM, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
> On 15/05/18 22:16, Douglas Anderson wrote:
>>
>> In commit ca04d9d3e1b1 ("phy: qcom-qusb2: New driver for QUSB2 PHY on
>> Qcom chips") you can see a call like:
>>
>>    devm_nvmem_cell_get(dev, NULL);
>>
>> Note that the cell ID passed to the function is NULL.  This is because
>> the qcom-qusb2 driver is expected to work only on systems where the
>> PHY node is hooked up via device-tree and is nameless.
>>
>> This works OK for the most part.  The first thing nvmem_cell_get()
>> does is to call of_nvmem_cell_get() and there it's documented that a
>> NULL name is fine.  The problem happens when the call to
>> of_nvmem_cell_get() returns -EINVAL.  In such a case we'll fall back
>> to nvmem_cell_get_from_list() and eventually might (if nvmem_cells
>> isn't an empty list) crash with something that looks like:
>>
>>   strcmp
>>   nvmem_find_cell
>>   __nvmem_device_get
>>   nvmem_cell_get_from_list
>>   nvmem_cell_get
>>   devm_nvmem_cell_get
>>   qusb2_phy_probe
>>
>> There are several different ways we could fix this problem:
>>
>> One could argue that perhaps the qcom-qusb2 driver should be changed
>> to use of_nvmem_cell_get() which is allowed to have a NULL name.  In
>> that case, we'd need to add a patche to introduce
>> devm_of_nvmem_cell_get() since the qcom-qusb2 driver is using devm
>> managed resources.
>>
>> One could also argue that perhaps we could just add a name to
>> qcom-qusb2.  That would be OK but I believe it effectively changes the
>> device tree bindings, so maybe it's a no-go.
>>
>> In this patch I have chosen to fix the problem by simply not crashing
>> when a NULL cell_id is passed to nvmem_cell_get().
>>
>> NOTE: that for the qcom-qusb2 driver the "nvmem-cells" property is
>> defined to be optional and thus it's expected to be a common case that
>> we would hit this crash and this is more than just a theoretical fix.
>>
>> Fixes: ca04d9d3e1b1 ("phy: qcom-qusb2: New driver for QUSB2 PHY on Qcom
>> chips")
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> ---
>>
>>   drivers/nvmem/core.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>
>
> Looks good to me,
> Kishon if you want to queue this one from your tree, you can add my
>
> Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> If not I can send this via Greg's Char-misc tree.

This clearly missed the boat for 4.17, but maybe it can land for 4.18
once the merge window closes?  Is there any agreement about where it
should land?  Srinivas: do you just want to take it yourself?

Thanks!

-Doug
