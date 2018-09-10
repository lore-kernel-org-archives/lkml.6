Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C94DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A6020870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="vAVw7K5/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A6020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbeIJQZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:25:16 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:40229 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728475AbeIJQZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:25:15 -0400
Received: by mail-it0-f66.google.com with SMTP id h23-v6so28141946ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 04:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5hzN2CbjlcVlmmDcho0jfhM4nc92z2Fa+lWUPpwRG0k=;
        b=vAVw7K5/5aT19KgdSr1/5HleIJjSuXgeZuJkktYHDtFcwmexkUIEKmmukG6/H8RHrS
         J86Fs8FHQJ6TkX4JXU99c0ptfpJrmuVPZlynwUuZkJuiAZm1fF1LEV/luiV9ZnMA6Bvh
         PevMjKt361h77FWp6nmMhHVDlvU5SJxBcuDYzOro0nBAIT0vBRQLHaF4xfCn5PArsTNs
         UhPng3qgHehzRBB02q1RGaPYvpaUL7YZJPdeDR4JBMkHzBicwsFrIJkqfw0w1We+6YgM
         Bwc4HWGMOQL+m4jfzIsah/vaWiwcxQRIkl8pUyUfB2IvL7RyCuONtAyUMUBDMuXkce7p
         jaIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5hzN2CbjlcVlmmDcho0jfhM4nc92z2Fa+lWUPpwRG0k=;
        b=cJheedBceffmAnKb0xqtEPp5eFR/gZc+uuhJJTe9P9sWhi81lCGnW9mStXHBx0I2RC
         cHML6DmuNMSiLy90Lo2xQTcnFEHwjrn/88Asoc4MU84BnXVzsf3lR3qxRPhfVUbawSHa
         Rj8uSO0q2Y0Jo5qR/vVpYpPpExcMvMO0+oB+7DtQ5gUpsWHjAViOVwMGb+haHWLh1Ltk
         hnim6RAnknfhpJcDwoTtzErHggRutwXd48ktqPOSuDwubZEpeNsnGv55J9ikc12bpjmF
         8NrWvgfNlquDOojyBCA1t//W/icpJtGwSjmUmGLHvWoel3D4qUDbSc1iDMUCdt2gMCAv
         4bBg==
X-Gm-Message-State: APzg51DFaD1qiqjEvXbebDgN1UYYgWF2H6Z7Fp/yvUdv3wEAB0d9QeG+
        gVXBVTNyJUupJ1a3vyFAXNsJzEzuOjlSXWoTiCoaNQ==
X-Google-Smtp-Source: ANB0VdZ1/c3cqIPl+LUiPtrSE7gf92ijrPSqv2xGkN2vEuKuKmNh3QzXPJ8NRXed06fLjjRxW2OiUhSpsheOk6QCjt8=
X-Received: by 2002:a02:5f44:: with SMTP id r65-v6mr18151637jab.34.1536579097944;
 Mon, 10 Sep 2018 04:31:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:1905:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 04:31:37
 -0700 (PDT)
In-Reply-To: <3dbd65e5-c948-a784-0362-930fc41b840e@linaro.org>
References: <20180907100750.14564-1-brgl@bgdev.pl> <20180907100750.14564-2-brgl@bgdev.pl>
 <c0b0c411-65f6-62f9-6d6d-2884e5a17250@linaro.org> <CAMRc=MfO01EQAfY4Uu3UwzzvhVOMF7_BpCOPVz2yVXqDgpb0AA@mail.gmail.com>
 <7e138142-8161-3646-4daf-619995baf395@linaro.org> <CAMRc=Mduu4CmLX5DFtJd8NSbzs5g65U9AmM=rbscit0JyQKVAQ@mail.gmail.com>
 <3dbd65e5-c948-a784-0362-930fc41b840e@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 10 Sep 2018 13:31:37 +0200
Message-ID: <CAMRc=Mck=rAJ6jbm57ZecJWNvOYR5pjLy0JnyxFzA8kFvoK7Ew@mail.gmail.com>
Subject: Re: [PATCH v2 01/16] nvmem: remove unused APIs
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-09-10 11:55 GMT+02:00 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>:
>
>
> On 10/09/18 09:43, Bartosz Golaszewski wrote:
>>>>
>>>> this series. Later patches are MUCH cleaner thanks to this removal and
>>>> I believe it makes them easier for review.
>>>
>>> Am not sure about that, it definitely did not help me!
>>>
>> Why exactly? Aren't clean patches resulting from this removal easier
>> to read then if they'd also have to take into account the burden of
>> existing code that will be changes anyway later? I really don't see
>> why you insist on removing this.
>
>
> Here are few reasons:
>
> 1> TBH, This cleanup patch removes more than one feature from nvmem
> subsystem.
> Ex: it remove ability to add static cell from nvmem config, secondly it
> removed ability to read/write cells directly using nvmem_cell_info.
>

About that: there are no users of nvmem_device_cell_read/write()
currently and with the new API I'm not sure this is still needed. Are
you alright with removing those two?

Bart

> 2> If you do changes as part of each patch, it will be much traceable on
> what is changed exactly and will allow much better review, and understand
> the reasoning.
>
> Having a clean start and writing code on top of it is alway nice, but we
> will definitely miss things in review in this particular instance.
>
>
> thanks,
> srini
>
>>
>> Best regards,
>> Bart
>>
>
