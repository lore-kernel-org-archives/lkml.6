Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B416C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24DD320865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K2FsWy2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24DD320865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbeIJO0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:26:53 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33202 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbeIJO0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:26:52 -0400
Received: by mail-lf1-f67.google.com with SMTP id m26-v6so16881075lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 02:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=axeLWSghoDFQLpc11pi/AURy7Pq9cAxxdpbSE6p5YWM=;
        b=K2FsWy2z9gO6UMzfzCCXP4gb2RhIeAPw20BevoxqnjK5/jgPs1UNULdQIZpApz5s8Q
         8BY8vrE0+Ds++ibL5fwS74TqCZqBYUIHRUN68GHUq/K83ahPk5F2uBz7bnXocv4TXPsO
         5e9wpWM629MIMGOIyO6pupDnfgEC4paImiBbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=axeLWSghoDFQLpc11pi/AURy7Pq9cAxxdpbSE6p5YWM=;
        b=BBV7+63mCpA93CC5sJKyAvPN5KWSsESBpmwKCCHPwVQiT/V/nuimKPFo557at9Q4T4
         Z9wSCVHQse/yfpnu/xcU9B6sIc9MumegreL6JqbmhDUMSuuATwkHzOI3XMsY2XaPQFD4
         +KKGnnOrglMjQnpw+bZAbMuLC/pQCH2wio0/y9kQNmuCjhCow3luDAZpeOBuRB/1fTgm
         /1lFwzBWlaWWv8++W1ZcWVtB4zcdR2w8PwAIGkQNR9viYvNabrBu+55l9FhehNNSsEI/
         haRJlCf6RZ4eTR9ke7i2b4Wkv2q9/Q0hOl7N6d3Nf7KGg6awUmrOHAZEByDDIgZ6dRrs
         KT2g==
X-Gm-Message-State: APzg51AeUDGq8Tmurh8Ef9J7FsKRgMfjiELQsQ0AfmRSy4LPnGOqn6Mj
        VbPYVHuCWjz1xfdG+K1Q1VDuqD8YdO2qs/VeXu9Byw==
X-Google-Smtp-Source: ANB0VdZxmlDjJYnNE7kh49/IzB5ekSMjSosFeyXjPaoiVhfiIBIHZqNN0btL8M78v2ka0CqbTqfd2VbNN+dTiKumO+4=
X-Received: by 2002:a19:f802:: with SMTP id a2-v6mr11497817lff.33.1536572022681;
 Mon, 10 Sep 2018 02:33:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:118f:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 02:33:02
 -0700 (PDT)
In-Reply-To: <20180910092009.y2p5n5owozaz6etw@holly.lan>
References: <CAHqM-Qgy7zPjrnNm0Xdyz_F_BYbSPgDfQrkv0tGv_rB1G7tSXg@mail.gmail.com>
 <CAHqM-QgH3d3Fz=P-_Gj_ZJODK1YOxT49G=qhzAnM=g2HAYqoow@mail.gmail.com> <20180910092009.y2p5n5owozaz6etw@holly.lan>
From:   Victor Chong <victor.chong@linaro.org>
Date:   Mon, 10 Sep 2018 18:33:02 +0900
Message-ID: <CAHqM-QgaweVSYPqqKwdwZQdqN6YT6gWpM5XdTZ7_KiSjPgrD+w@mail.gmail.com>
Subject: Re: Fwd: [PATCH] tee: optee: log message if dynamic shm is enabled
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 6:20 PM, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
> On Mon, Sep 10, 2018 at 05:57:28PM +0900, Victor Chong wrote:
>
> This (empty) patch description seems unusually terse! Surely there
> should be some clues in the description about why this messages
> deserves user/dev/admin attention...

Ok. Will add description and send out v2.

Thanks

>
>
>> Suggested-by: Jerome Forissier <jerome.forissier@linaro.org>
>> Signed-off-by: Victor Chong <victor.chong@linaro.org>
>> Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  drivers/tee/optee/core.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
>> index e1aafe842d66..cca5c091e55a 100644
>> --- a/drivers/tee/optee/core.c
>> +++ b/drivers/tee/optee/core.c
>> @@ -631,6 +631,9 @@ static struct optee *optee_probe(struct device_node *np)
>>
>>         optee_enable_shm_cache(optee);
>>
>> +       if (optee->sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
>> +               pr_info("dynamic shared memory is enabled\n");
>> +
>>         pr_info("initialized driver\n");
>>         return optee;
>>  err:
>> --
>> 2.17.1
