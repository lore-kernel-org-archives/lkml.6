Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A4CC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 02:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8994223B9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 02:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LC5yhXa+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8994223B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbeHJEly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 00:41:54 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:36934 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725724AbeHJElx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 00:41:53 -0400
Received: by mail-ua1-f68.google.com with SMTP id y10-v6so367244uao.4;
        Thu, 09 Aug 2018 19:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4g+E5NdjQX4HGRwIcIrlDzreG5ciJjqx4hAYwdO6j2o=;
        b=LC5yhXa+J6Nastp6J7qXKQJl6/LTbshLsE6QCZW4MWXy3vwHGVEoZXY+m2f2Tn5r4j
         J9yZ+mxsE1bsTSAVzdxdUe9Iohk7LbVFQ/z02mCx9nOnly9vKgFcXMoK9tpaqmYNd6mZ
         fmiy3oyyPz9bb3++tUiknayHT73iJwabgomIdXFtaFaMtdJqHReLE/CTcOQoas2qaE/o
         ym0J7Bnd+rm1MzUJggdeyGy4xhFwHtJCWxeQpwltXfPModxwWHeGsr92Ups4fMYC8YtV
         vMFXgH7n3hAaNy+qtKSsjMmKlhZEwmn5SF7mBiHbyWeaH1jU6X4s2JN45r7wt5g9OQIr
         KHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4g+E5NdjQX4HGRwIcIrlDzreG5ciJjqx4hAYwdO6j2o=;
        b=Bydfl6Ssbq/ST2XUHfUJ/mUu1iGQGAlqvhRCRzsdas8uievdxpEucjw3AEKMFXF1wP
         ymmimkoLSNYcOVV6pkDTNu/JYAki5BwS0FQQq8I1RIy6RhVr0cnXVjTfFr/B6V+zghIA
         8vxhKXPwnwpZx4KR7XCuWphCRjM2JsotI5PtyFDUvM31PERD/RSPexpienSHWQT12+K2
         wQFCSjvskoe89PMVSEKGG5YFcJ53JdPpcOXLzuFedQLU9OO7aw1P22gxbL44uMZNj/R9
         +mnqAkPfSkDsBHnvQtiW4LVpuFme15W2h6PsMm0bFLFkHamnFIxUbM0ZaRi4YIjRZtRh
         OPkQ==
X-Gm-Message-State: AOUpUlGgY/jG4N/dsUxSSx15Qz8XVrWF7/KINGaztASQnzXILUyr0X9h
        b6QvW1lg+STwzhMimtoKVmkBznhnND4oWcmHdMY=
X-Google-Smtp-Source: AA+uWPzn/zycejk9Nn2FFidJkrXdLkvkH2KYMpzLW41JHyMMHqSB6eywstY29WbsWNZO/OWMRlzobSBUal9lDaXGFKA=
X-Received: by 2002:ab0:41e5:: with SMTP id 92-v6mr3159710uap.50.1533867253215;
 Thu, 09 Aug 2018 19:14:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:1927:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 19:14:12 -0700 (PDT)
In-Reply-To: <CAMj-D2De_LzxMjNT_w-N2iiqBYq4wbdY6vEvjxr5yaAuhBg+jw@mail.gmail.com>
References: <1533659175-47076-1-git-send-email-gengdongjiu@huawei.com>
 <CAMj-D2Arv-ZxUMTB_zKKy58CghWsZJbTOcNdiD3KVzxJ-v973g@mail.gmail.com>
 <CABo9ajBKEWmgh6tBbUnrY8zM3vAH+TKWwBHn-Vz556Up+614Zw@mail.gmail.com> <CAMj-D2De_LzxMjNT_w-N2iiqBYq4wbdY6vEvjxr5yaAuhBg+jw@mail.gmail.com>
From:   Tyler Baicar <baicar.tyler@gmail.com>
Date:   Thu, 9 Aug 2018 22:14:12 -0400
Message-ID: <CABo9ajB-FYDxubuJ6=PnoX5D_x4ujm7Snc+OA=AQ-K564JUJoQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2] arm64: clean the additional checks before
 calling ghes_notify_sea()
To:     gengdongjiu <gengdj.1984@gmail.com>
Cc:     Dongjiu Geng <gengdongjiu@huawei.com>,
        Borislav Petkov <bp@suse.de>,
        Will Deacon <will.deacon@arm.com>, rafael.j.wysocki@intel.com,
        James Morse <james.morse@arm.com>,
        Tyler Baicar <tbaicar@codeaurora.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, devel@acpica.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 9, 2018 at 6:16 PM, gengdongjiu <gengdj.1984@gmail.com> wrote:
> 2018-08-10 5:05 GMT+08:00 Tyler Baicar <baicar.tyler@gmail.com>:
>> On Thu, Aug 9, 2018 at 8:32 AM, gengdongjiu <gengdj.1984@gmail.com> wrote:
>>>
>>> 2018-08-08 0:26 GMT+08:00 Dongjiu Geng <gengdongjiu@huawei.com>:
>>> > In order to remove the additional check before calling the
>>> > ghes_notify_sea(), make stub definition when !CONFIG_ACPI_APEI_SEA.
>>> >
>>> > After this cleanup, we can simply call the ghes_notify_sea() to let
>>> > APEI driver handle the SEA notification.
>>> >
>>> > CC: Tyler Baicar <tbaicar@codeaurora.org>
>>> > CC: James Morse <james.morse@arm.com>
>>> > Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>>> > Acked-by: Will Deacon <will.deacon@arm.com>
>>> > ---
>>> > This cleanup is ever mentioned by Mark Rutland in [1]
>>> >
>>> > [1]:
>>> > https://lkml.org/lkml/2018/5/31/289
>>> >
>>
>> FWIW - Looks good to me!
>
> Thanks very much for this comments and review,
> whether I can get your "Acked-by" or "Reviewed-by"? thanks
>
Sorry, yes!

Reviewed-by: Tyler Baicar <baicar.tyler@gmail.com>
