Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E70C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 13:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D563255A8
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 13:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3ktPo1o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D563255A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937017AbeF3NE0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 09:04:26 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33079 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936658AbeF3NEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 09:04:22 -0400
Received: by mail-vk0-f68.google.com with SMTP id k194-v6so6433596vke.0;
        Sat, 30 Jun 2018 06:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uWX5JvZOL1/5xBDsmDcbNpQFrqOITpByAXSdsp0Fz1o=;
        b=b3ktPo1oLP6YHU/dWDoEMjPRJ8pSOiJxxFzGaaAb7TpdM+RIHy6i5/zWXXMbv8Z7Pv
         s/v42Haxou4hSjMhg8HNI+jQ1guzfGeLfbeQU+ueiRzXWjJsVbLeGcwF1dLD4mElDCPr
         qxfTjaZlQbFo6Dxg9ptki5ke8wQwBS5Cn+DC8hspi2QFd2VML4wexGRb6r14ob8+KbrE
         svazGcuBF/7D96+CkxORsst+3pN/tvGBoWs7hCxiRhYDgBUXdsCGIJMQC9bTGBdGLEc1
         vArtD5XogKbjLqp0VgSyCIijiR63qwHzbz+IkQujud3kKRFAV1WMOdyfDP+xDRnSD49g
         f5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uWX5JvZOL1/5xBDsmDcbNpQFrqOITpByAXSdsp0Fz1o=;
        b=lOc/Ps8RGK8LCLejjOSqTnoz9r6s7WiYrh0yGDJ9bhCia698/WyJ8i5bh+xT6ft2ZJ
         iRVxNKXQL8MymknaA4hIrAM6gV3OY/vo8rTFdwuDFv/x7g7wH/My49jYHR6TWdoB9oO7
         FdcV6UgTYTa8srqSnNWTxzXPN5BCEhCyBXP7/vA2VaLPnVYpPeuJixZ3KUREl7zcPQSL
         Py9D/aYBfH2r0Td37hujD85F2+BVfFMGGwMRVlfvirA8EDILYw3F/mMnDflES2Vj6Ph7
         Qs4bBajNPSl7Ksauogtol5HmGt8U0Z3APKLSu0EcrWiNRgaPAI/HjYk4znBLrYlq/j1i
         DMrg==
X-Gm-Message-State: APt69E2HBle6NPzz4bxgJO+bW/Yt3JQbu6bdMF4Fxqnj5eyaoa+ljvsJ
        KNeF399JDxLWnmxqNAzz8ROn0gD9m54kzKkfdCI=
X-Google-Smtp-Source: AAOMgpf4FlO92D66AWl1sLkYap8HkSCslxDaiXMb7FpAgtwaXGbSEYo+C6Qp8jczb/ItfXp3QIpDOJR32hlcNYKR4FQ=
X-Received: by 2002:a1f:7d09:: with SMTP id y9-v6mr5448548vkc.15.1530363861581;
 Sat, 30 Jun 2018 06:04:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Sat, 30 Jun 2018 06:04:20
 -0700 (PDT)
In-Reply-To: <20180630124400.GB16775@Mani-XPS-13-9360>
References: <20180628181042.2239-1-manivannan.sadhasivam@linaro.org>
 <20180628181042.2239-6-manivannan.sadhasivam@linaro.org> <CAHp75Vd__qOXVxZTdxREwD6p1sEw49R2Kqb+esAmr_EhtT=gFg@mail.gmail.com>
 <20180630124400.GB16775@Mani-XPS-13-9360>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 30 Jun 2018 16:04:20 +0300
Message-ID: <CAHp75Ve5Thjsux6oaZis7axF3jZwqhr2CfrXFcpZuziszB_E9A@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] i2c: Add Actions Semi OWL family S900 I2C driver
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        =?UTF-8?B?5YiY54Kc?= <liuwei@actions-semi.com>,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree <devicetree@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        amit.kucheria@linaro.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        Mani Sadhasivam <manivannanece23@gmail.com>,
        Thomas Liau <thomas.liau@actions-semi.com>,
        jeff.chen@actions-semi.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 3:44 PM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> On Sat, Jun 30, 2018 at 03:14:37PM +0300, Andy Shevchenko wrote:
>> On Thu, Jun 28, 2018 at 9:10 PM, Manivannan Sadhasivam
>> <manivannan.sadhasivam@linaro.org> wrote:

>> > +static int owl_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>> > +                               int num)
>> > +{
>>
>> > +       int ret = 0, idx;
>>
>> Redundant assignment.
>>
>
> No. Actually the return path will be fixed in next iteration. Please
> see my reply to Peter's review for explanation.

How come? I didn't find anything related to this comment in reply you
are referring to.
I left deliberately the below part to show you the pointlessness of an
assignment to 0.

>> > +       ret = owl_i2c_hw_init(i2c_dev);
>> > +       if (ret)
>> > +               return ret;

Do you mean you are dropping this in next revision?

-- 
With Best Regards,
Andy Shevchenko
