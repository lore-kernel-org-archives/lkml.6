Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FA2ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E49820874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MBZdRDp9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E49820874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388042AbeGWIYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 04:24:53 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38846 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387775AbeGWIYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 04:24:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id x17-v6so498782pfh.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 00:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ym27d7sUunKVxkd7PQaww7jYrXQnIDGxaLavkSDcFGM=;
        b=MBZdRDp9VJewvwbeKvQyKIOTFd3PLO3gnaN/O+r2UV+t7DDT21Pi5wHo0w66OWxfSR
         jvVw2JG5xBfj+G7puRWM6ZsFKS/NLb1eeMiEtlvgoFQuFUlAu2OWhVKdgL1ngOFh2iz2
         OGjKZ+uqElrhovoxtz/q+QHg+nRo4RMT7LiDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ym27d7sUunKVxkd7PQaww7jYrXQnIDGxaLavkSDcFGM=;
        b=kxaDP6kIuHnGhNnGPPpuzcWUyJXLD0OwA8xpWJ5BJC9BGkZaViAiIZZwAyfOFdcnn7
         H/ZGnpx7S5f2jcGjtiOC7gIW9rRgVJo38kg6NlVqbtVsVkZSu5AUShcjYirlHIU2jGGK
         Ls2WdYNDs+ETelGWIqnwCAlVwljGU3rZkFI/suagDpoJOviJfT/QturJT2forMp3W9G5
         qlx/mHLZsicZcNORWp3j1/hnUqhAWSotkIc67QABtA07SrTSosiK1cDonVT9P1pgYW0t
         lqzEspuUkd48BNqVJUf9QJh0+6y91JOSuLs/1a8/8TLJ5U9aSso2KKqnPzjecj77tj9r
         DxXQ==
X-Gm-Message-State: AOUpUlHeEzvFvvhYVtFhW8epdTrWsntfTr8lgKyWJNKgtYGq9D+m9nyB
        hXvOTGeeB74D1MRKRwSitbXa
X-Google-Smtp-Source: AAOMgpcwaP5ZtdYiXfBlbKXeNq8oIv26tsIbMG9LiVft7vPU6I+aYZUGXP1cNjKWXkwRjbJdje9NQA==
X-Received: by 2002:a65:5a01:: with SMTP id y1-v6mr11096484pgs.125.1532330702758;
        Mon, 23 Jul 2018 00:25:02 -0700 (PDT)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id r16-v6sm13548245pfe.173.2018.07.23.00.24.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 00:25:02 -0700 (PDT)
Date:   Mon, 23 Jul 2018 12:54:52 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     wsa@the-dreams.de, robh+dt@kernel.org, afaerber@suse.de,
        linus.walleij@linaro.org, linux-i2c@vger.kernel.org,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com
Subject: Re: [PATCH v6 5/6] i2c: Add Actions Semiconductor Owl family S900
 I2C driver
Message-ID: <20180723072452.GA4353@mani>
References: <20180723034025.5763-1-manivannan.sadhasivam@linaro.org>
 <20180723034025.5763-6-manivannan.sadhasivam@linaro.org>
 <911dc259-7b30-9c6e-2c82-2f4c032b9d73@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <911dc259-7b30-9c6e-2c82-2f4c032b9d73@axentia.se>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, Jul 23, 2018 at 08:12:17AM +0200, Peter Rosin wrote:
> On 2018-07-23 05:40, Manivannan Sadhasivam wrote:
> > +		/* Handle the remaining bytes which were not sent */
> > +		while (!(readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT) &
> > +		       OWL_I2C_FIFOSTAT_TFF) && i2c_dev->msg_ptr < msg->len) {
> 
> You moved the OWL_ line to the left instead of right, so this is still
> misaligned and thus not helping the reader.
> 

Yes. I'm not sure which side I should shift but since the recommendation
states that we should start from the first character after parenthesis, so I
went for left.

But yeah, this could be more readable by shifting right.

Anyway, thanks a lot for helping me to cleanup/structure the code.

Regards,
Mani

> Cheers,
> Peter
> 
> > +			writel(msg->buf[i2c_dev->msg_ptr++],
> > +			       i2c_dev->base + OWL_I2C_REG_TXDAT);
> > +		}
> 
