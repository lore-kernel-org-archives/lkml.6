Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB83C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B65208AD
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3EwBUk+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B65208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbeHPWjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:39:40 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51647 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbeHPWjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:39:40 -0400
Received: by mail-it0-f67.google.com with SMTP id e14-v6so7883889itf.1;
        Thu, 16 Aug 2018 12:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=y2s3qWJ7AJZQpkDWKK763XfizOXHIwPJC3+H1b1KXDE=;
        b=d3EwBUk+WMWoXBhorzcx2UNmT5cbp7jhHh76HnOP3nsv8y+SIGyjJUPzKE8bM6h8in
         gwaGERn5+C5zwkrNRI39VB7Vu+3plnBhJZvs5ahZAZwLbYi8fOVFE0twsVqJXnXcB72+
         hnzG8fX8wHQTqApF0m0oq6lcGwLgdPgQbK8yMpxIH3wzL4g+BHjxAmpYB70XKZ+wamM3
         EF8e+L4/YvjTHanVehmLSSBJcyoc5nVB70T6sVbnLISqTQGv3Sbc9/E3+fHyVlpkyNoy
         IKYJ1osTv3r46v+lIMHOH8EdD710o/7znSTt0BN30Sn+rbE7TEDqkfvtcK5ElemUoCUq
         Hcsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=y2s3qWJ7AJZQpkDWKK763XfizOXHIwPJC3+H1b1KXDE=;
        b=HGA9679VpUrs3UA8Z37K6Pp6v1VVOYX9DU/tciY5V2QGDSAqE4QXd84BbxBhsGv2W9
         5zOodyZIPXwU0G9vs/0E1Q0IflkTkfy30zw1EpYhC8sQQKFB+pEl+DVwa7wyvVUluV6m
         /RUxeSPnLUPiqgoVrnewptXXGYobL3RK2fPSLVoKLiNe0iw8GruzpJlJk4PIjywlRP88
         wCv77r9yH1i1VUvBHboJ2KGiPIjwouGlGVZeRmyvdKSxpjmpIzsGSlIfzNm2ma6jMNVj
         yMhNhvz6mF9euOSoBJc1BEHH+Hx3Y+VnYq90B7U0XjvMrCBQeIe9XqfEgMEq5L8z+MsF
         +jCg==
X-Gm-Message-State: AOUpUlHrGHFPc5VWmV0atQIp/v/B4mjr2Wry0W/cbKsk1VzdlnEznQam
        kQl4nwwoosU6r7j8Q/R3odqJHwZ7DTexrMwvkDU=
X-Google-Smtp-Source: AA+uWPzt1ubEnOzr2nxTTvAW+nfOowp02khmeQ1kxgmnYN/oi7y7XUB/yMTwwgOzmUnYcdKa5v+oQCZHVgVvkYO2evY=
X-Received: by 2002:a02:9a83:: with SMTP id m3-v6mr28848068jak.116.1534448357829;
 Thu, 16 Aug 2018 12:39:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:5a03:0:0:0:0:0 with HTTP; Thu, 16 Aug 2018 12:39:17
 -0700 (PDT)
In-Reply-To: <BN7PR12MB2593B097267132250140FBEAF83E0@BN7PR12MB2593.namprd12.prod.outlook.com>
References: <20180815114107.29797-1-mikhail.jin@gmail.com> <BN7PR12MB2593B097267132250140FBEAF83E0@BN7PR12MB2593.namprd12.prod.outlook.com>
From:   Michael Jin <mikhail.jin@gmail.com>
Date:   Thu, 16 Aug 2018 15:39:17 -0400
Message-ID: <CAO6F7DmPHBpf299g40pzUAbL-JK5S2eNbhwXN0kVmLhtwcqDqQ@mail.gmail.com>
Subject: Re: [PATCH V2] EDAC, amd64: Add Family 17h Model 10h support.
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     Borislav Petkov <bp@suse.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 2:17 PM, Ghannam, Yazen <Yazen.Ghannam@amd.com> wrote:
>> -----Original Message-----
>> From: Michael Jin <mikhail.jin@gmail.com>
>> Sent: Wednesday, August 15, 2018 6:41 AM
>> To: Borislav Petkov <bp@suse.de>; Ghannam, Yazen
>> <Yazen.Ghannam@amd.com>; Mauro Carvalho Chehab
>> <mchehab@kernel.org>
>> Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org; Michael Jin
>> <mikhail.jin@gmail.com>; stable@vger.kernel.org
>> Subject: [PATCH V2] EDAC, amd64: Add Family 17h Model 10h support.
>>
>> Add support for ECC error decoding on family 17h models 10h-2fh.
>>
>
> Can you please make this more specific? Something like "Add PCI device IDs
> for Fam17h Models 10h-2Fh so that amd64_edac_mod will load".

I have submitted patch v3 with a commit message that is more specific.

>>       case 0x17:
>> +             /* Check if CPU model is in range 10h-2fh */
>
> This comment is not needed because it's obvious from the code.

The comment in patch v2 has been removed in patch v3.

Thanks,
Michael
