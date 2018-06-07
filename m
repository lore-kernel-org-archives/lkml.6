Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ZebICNvdGFt2cwAAmS7hNA
	; Thu, 07 Jun 2018 07:25:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 351C8607E7; Thu,  7 Jun 2018 07:25:20 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kP7TmKA8"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B8DD3605A2;
	Thu,  7 Jun 2018 07:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B8DD3605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753379AbeFGHZR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 03:25:17 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:44473 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753085AbeFGHZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 03:25:14 -0400
Received: by mail-io0-f194.google.com with SMTP id g7-v6so10658824ioh.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 00:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=N0zCOep2IMmMvU+TRrqvIWq9/q3BCyvmptabR2ICIyQ=;
        b=kP7TmKA8IUdBAyEiXJ/E5AA8PBMsaMHv2bWCFZSdbp+vIiHCT4QYNN1EGWlIawkEqF
         QwRqRIdsnMS6BwR0iqVzo5zogUwNnyXiQQkldQ9vlRpssTbKX8A8RkgMWlGuDXOaqyvH
         ieT/0w/ebUZdh1gIykKvQUi5kuV03LRP0dJEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=N0zCOep2IMmMvU+TRrqvIWq9/q3BCyvmptabR2ICIyQ=;
        b=UmdQh4Fq1naj/vMHW4PnoekUreTigF7kgN62fzMP1x6YQp9RSoi+fedY9xyVTK32X+
         rpH11ES9Ay7ct5Ah9WVrs9l5q2q4jV4x/o0aVxFQAOGpp7kpNhyLVKMH4zvmvZ0ppz4A
         4TZt0g3+qDgrrlQ1ZCtCvQH64tnc+ZtKup8PfpGV+nitATH9i6b88OVq2/+LY6DxRf2f
         t6+T1b2OrghhfppYcWB6icCpBj6aJq1jvgBp09Aun2s2k8Wt/7cZT7hEUqLHkcNABOZV
         21MLqpt2UIX07xLLzH37BArPNmElZ56LJtAT6aRkiY4bHfdOX8OVJm8Vulhoo5ApMXa8
         cJOA==
X-Gm-Message-State: APt69E0lLr5gOAGluF/ex4dO7EQwMXG6csiyO1/ldOtlAhGT3HycImQH
        bxD4DJDjbFch71mPJITw5z+lHCTeOGBbDoty93BQIi5aiWk=
X-Google-Smtp-Source: ADUXVKJrf12+d0SfOsSOH2rUNi7LXsesvVMnzMjnJf+Km+RQzRyZD96j3l8fH1t//2k0KsHCiAf0+Ni/600+0Jdlm3o=
X-Received: by 2002:a6b:8b91:: with SMTP id n139-v6mr535705iod.109.1528356313624;
 Thu, 07 Jun 2018 00:25:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:78c9:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 00:25:12 -0700 (PDT)
In-Reply-To: <7c34ccef-2fa8-8b53-2677-29f6fbe71a04@dd-wrt.com>
References: <20180528100240.256525891@linuxfoundation.org> <20180528100302.722883806@linuxfoundation.org>
 <7c34ccef-2fa8-8b53-2677-29f6fbe71a04@dd-wrt.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 7 Jun 2018 09:25:12 +0200
Message-ID: <CACRpkdZghHkbyKrP=QAT5DSPEJ07hp07wU+UvrZFs7z2oOLtXg@mail.gmail.com>
Subject: Re: [PATCH 4.16 269/272] pinctrl: msm: Use dynamic GPIO numbering
To: Sebastian Gottschall <s.gottschall@dd-wrt.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Timur Tabi <timur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 1:21 PM, Sebastian Gottschall
<s.gottschall@dd-wrt.com> wrote:

> this patch creates a regression for me. on ipq8064 the systems gpios now
> start somewhere in the sky
(...)
> this broke my userspace gpio handling. i can override this, but still it
> doesnt look correct since there is a hole at the beginng likelly reserved by
> unused arm gpios

Out of curiosity: what is this userspace?

We do not break userspace, so I guess we should put in some hack
to keep the base 0 on ipq8064 then, but as pointed out by Bjorn
there will be problems when we get multiple gpiochips in later
platforms so it is just a stopgap solution.

Have you looked into using the new character device with your
userspace, either as shown in the examples:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/gpio

or using libgpiod:
https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/

Yours,
Linus Walleij
