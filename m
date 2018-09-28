Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB73C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 11:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B6C215F0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 11:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1mqZRJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B6C215F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbeI1RdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 13:33:00 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41003 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729183AbeI1RdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 13:33:00 -0400
Received: by mail-lj1-f195.google.com with SMTP id y17-v6so5428699ljy.8;
        Fri, 28 Sep 2018 04:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3auzNwdhXwqUf7Lms3lpVUZPv9EB8LIwpUjJDKNc/pE=;
        b=M1mqZRJkLicaIEL0pQ3cs57TytwMIpNWz7rIpGrbp9z2LuWlMeQMXV3+qrhpidExLa
         Mp23q4pqfGfdUTVKDhJa6Za/GeXtp2hwE9mbT0FMbaEJSUlT7JEPkl954B9V31eXHEn2
         wWbu4PUzuQYPNHFwWzld0N9lQLSGi+w2TuB2tfK8/RpmEAV0vO/OrcDO88ujMIZRA3fG
         sH94NQMhRUqnMQorX+zcL7HJaCFym5haBVmGjPmHjWEgv70LkCky3zejHXyxA098eLWz
         DhF8j7n8wTMIyBxs5D42TEnNrOP+xe3u3JHU+8gSp5eoYvysHia2Mdnt+G7+43vMPmnE
         g82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3auzNwdhXwqUf7Lms3lpVUZPv9EB8LIwpUjJDKNc/pE=;
        b=WbgLFojfHGvDXb0NOGw/oaiehtPdNEw+Z/YSbKbtYpahhM5CegeFoL+8uuZD/0TGrR
         iRdP4Yv8uzOPX8pzR9zqS0DkASd4wIEYPxyN/9qQHOHPsESg0hsrNYj2Og/bF//8wprO
         1kwfYD0m3oqk1l8s1av4sNtfj6CR+glI+lyhRk01acRU28Qu71iP0/REPyCErSLslZpa
         tee4FeoLCQK+fKtXSsz5ewpiF5fUg1ovk2l3YCDGHia7u0JQRaK9qCyEbqURht1c0hJz
         LY/AnGUw8k2JfUgsl7q//fEwE8qOyKtnOnPzv+QYZFYn70QtFwMSIqR8uQD5sYHow7p2
         tg8A==
X-Gm-Message-State: ABuFfogTnWOClbwEOuHQUu7DqxzSmVGmFteFp9/05hjeFtSJNh/+Di7e
        inn/z60OR5fZ6v5STMsvdWmS7aS7cGXseJ5xgNQ=
X-Google-Smtp-Source: ACcGV61beW2afoAWk7vKFDtTfo5Ine9XVbkDPKz0CJf+zvQCnpZAhu/peWH9Bjcw+rTMEf9usr/diiH/GIY6yCUxHTs=
X-Received: by 2002:a2e:44d0:: with SMTP id b77-v6mr8637732ljf.47.1538132982966;
 Fri, 28 Sep 2018 04:09:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:619:0:0:0:0:0 with HTTP; Fri, 28 Sep 2018 04:09:02 -0700 (PDT)
In-Reply-To: <CAK8P3a2WWFp5W5-7o-X3joOpSGgnK=s_ZyGev7gsVV0SjN0p0A@mail.gmail.com>
References: <20180912135352.19722-1-suzuki.poulose@arm.com>
 <20180912135352.19722-5-suzuki.poulose@arm.com> <ccc61e1b-768c-2a6d-3ff5-95b72bc58a6f@arm.com>
 <CAAfSe-swWPgCWN6cZbQxLL6fwaJ1qLXnC_X7A0zeYuHDaZ_A1Q@mail.gmail.com> <CAK8P3a2WWFp5W5-7o-X3joOpSGgnK=s_ZyGev7gsVV0SjN0p0A@mail.gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Fri, 28 Sep 2018 19:09:02 +0800
Message-ID: <CAAfSe-sD-Yk2N-7aRuBW8UuX5=111Ofb5GLZRTHQKJ5n+Y=uog@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] arm64: dts: sc9836/sc9860: Update coresight
 bindings for hardware ports
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Chunyan Zhang <chunyan.zhang@spreadtrum.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        coresight@lists.linaro.org, Leo Yan <leo.yan@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 September 2018 at 18:45, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Sep 27, 2018 at 11:19 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>>
>> Hi Suzuki,
>>
>> On 27 September 2018 at 16:51, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>> > +To: Chunyan Zhang
>> >
>> > Chunyan Zhang,
>> >
>> > On 09/12/2018 02:53 PM, Suzuki K Poulose wrote:
>> >>
>> >> Switch to the new coresight bindings for hw ports
>> >>
>> >
>> > How can we push this patch ? Do you generally send the spreadtrum
>> > specific changes to ARM soc folks ? Or would you like me to post
>> > this directly to ARM soc folks ?
>>
>> Yeah, at present sprd dts files generally got merged through arm-soc
>> (I've added arm@kernel.org).
>
> Yes, that's fine. Generally, we prefer if you collect patches for your
> platform first, and then send them as a pull request or short set
> of patches. for inclusion, rather than picking them up from the list.
>

Ok, I will send you a patchset once merge window open.

Thanks,
Chunyan

> If this is the only DT patch for spreadtrum in 4.20, I can also just
> pick it up with your Ack.
>
>        Arnd
