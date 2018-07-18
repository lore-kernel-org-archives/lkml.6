Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4829ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504CD20693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ekzgw0SR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504CD20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbeGRCb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 22:31:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36394 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730652AbeGRCb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:31:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id h9-v6so2989416wro.3;
        Tue, 17 Jul 2018 18:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PnDw31A9Hbg5t8Jo45hF4qWH7MyD8W52/QQSX4gzbdo=;
        b=Ekzgw0SREg2LhRbn/cPNA/6Z/2m+G2ANbxfA4a5E4N/tmI86l1NgWciixd/DFCFEdA
         8/YHgyrD/ODaj4EVqJU6x4E05UFDob7phjNMkneRLNMdGv0/H87t2aZ7eUGFPd3gYErl
         z0+HcQ7pP4HlUYcpR/0Iq23gVlgKf1DRbJGXKf06Fi/KV5oKZ30QPz6l4JiSL8OHJ8yN
         0cWGQi2C3DliddZyk+zGu2EqJEu46ogBvNmSNlVs/0atdK73uGGzx2w6psj4Rcnyg0g5
         oFOh254l9QZuS1ySjgLwCNGZj4cfZXHUHqvlj0NfaTTjVR53ozjOenIa1JDL5Y7SK1ZK
         +8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PnDw31A9Hbg5t8Jo45hF4qWH7MyD8W52/QQSX4gzbdo=;
        b=hlN9SjSeVDK9FdzNKtA4Td2RXVHndU7ivJZTGE8T2mADUFGQNjJvxKYkoNLLZgzHSx
         ducKDUTi4KQfNj+I4mhO3RhBP/+Vqjc9p2NT9cAAz/8x6d+Rw3679qulibBiAxdg+fg9
         90frxNyjniCpak5pl2Ew6+w7oo8sme4gwuL337piNEbx1amJ9KX5aGJ4ZMYSJ6uHTkL8
         neoEmk9t5W7synfSwLTrumYMj3VLfuCYF0ArI2C7dSRhAOADiemnCR176VjoYxDxfWSR
         Sw6aOtFMUAu4Rw6AGu1H30n47BkPn0DcuPuCoq9lqiKEaiEfPxZun+a6YehlfYAuMaRc
         bJJQ==
X-Gm-Message-State: AOUpUlEe5l8/sZBEZ77JUj5fiPQFS9XJEMBUP+kNGRwmhgGz8zblaeUB
        6e1+F1EoJ7iO+jchA2YDWkpHQtpkcIYJz1hZvXs=
X-Google-Smtp-Source: AAOMgpe8jnKVNY0QkZpDlZnCpcNZonPmxq4SrxeQ5IMygwJFZcAVtJJKSG0c4w0RiijjfyUxc7lS67+BzdmTV0Ic6HI=
X-Received: by 2002:adf:8004:: with SMTP id 4-v6mr3011098wrk.130.1531878991774;
 Tue, 17 Jul 2018 18:56:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:8a8a:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 18:55:51
 -0700 (PDT)
In-Reply-To: <5aafc511-15a1-da3c-19f8-cc8b658f9c3d@gmail.com>
References: <20180718004639.30154-1-jmaxwell37@gmail.com> <5aafc511-15a1-da3c-19f8-cc8b658f9c3d@gmail.com>
From:   Jonathan Maxwell <jmaxwell37@gmail.com>
Date:   Wed, 18 Jul 2018 11:55:51 +1000
Message-ID: <CAGHK07D_XCpU6V6oJ2rhR1=rX5P6t8ZhTMT7GEAyrBXoc=hbcQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] tcp: improve setsockopt() TCP_USER_TIMEOUT accuracy
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        David Laight <David.Laight@aculab.com>,
        kuznet <kuznet@ms2.inr.ac.ru>,
        yoshfuji <yoshfuji@linux-ipv6.org>,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jon Maxwell <jmaxwell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After committing the patches in my net-next git branch I used git send-mail:

git send-email --identity=XXX --cover-letter --annotate origin
--compose --signoff

and manually updated it based on an example of yours:

https://lwn.net/Articles/706491/

I can see the 3 patches that I just submitted on:

https://patchwork.ozlabs.org/project/netdev/list/

Flagged as under review by DaveM.

On Wed, Jul 18, 2018 at 11:20 AM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
> On 07/17/2018 05:46 PM, Jon Maxwell wrote:
>> Based on:
>>
>> https://patchwork.kernel.org/patch/10516195/
>>
>
> I must confess I am lost with your submissions.
>
> Patchwork is also lost ( https://patchwork.ozlabs.org/project/netdev/list/ )
>
> Are you really using git format-patch ?
>
> Normally all the patches should have a common [PATCH Vx net-next] string
>
> git format-patch -o ../output --cover-letter --subject-prefix "PATCH V3 net-next" HEAD~3
>
>
