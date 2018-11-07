Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098BFC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D44204FD
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D44204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbeKGVr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 16:47:56 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33005 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbeKGVrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 16:47:55 -0500
Received: by mail-qt1-f194.google.com with SMTP id l11so6293141qtp.0;
        Wed, 07 Nov 2018 04:17:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g13tRPbaZARNt8jycb2qbgn+g+V44W0ySXp+y4dS41M=;
        b=MoYJyJE6IFk9d8SSXTJr/iy8TEEhzy28LDuWbypBJ2pcmgdGduEUhS2e85DurVltjB
         7k15jsGMxMtvpxXagd93ZPhc6a8qzw6xn7ymqfvijyUSfEi/8Mx2HS2cBeYss+5OFofE
         botyfE5Tk4z5evq5JQ7mkABGBzW5sEjGa/W5lCm3HCDSTcrx0WZjT9y2nWK2jztIMqe7
         /j3al7hyxElqnh84jzZUuqH+fr6fkphfwJcu0Y20QbfS8fUzb6/3I/cvrZ9aqhOLu7aY
         ZkTo9hsNn8CxGMikLcLBt35d7ITawF2Bn7E5k+EbpbhWuGH7fdDJE6kxkXPwg71OveB7
         WYkQ==
X-Gm-Message-State: AGRZ1gLRjgWUfAfQS/LNGVaAR89lxVxaBCbMLtj0R2oHzJTrx9PaALke
        ujOIOqRVpqOuogMlFanDNhoMdh1AvnIJ21DGoYJ+/g==
X-Google-Smtp-Source: AJdET5ciMsz0U0Odb/jpVHnon9FpbnA/bX7bNGPQ3E9ncErSjyORrTm/BTFQZ0ph7VkRbCupflkzh0R17k0qRXK3Ri8=
X-Received: by 2002:ac8:410a:: with SMTP id q10-v6mr1331512qtl.96.1541593066961;
 Wed, 07 Nov 2018 04:17:46 -0800 (PST)
MIME-Version: 1.0
References: <20181107003250.5832-1-elder@linaro.org> <20181107003250.5832-3-elder@linaro.org>
In-Reply-To: <20181107003250.5832-3-elder@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 7 Nov 2018 13:17:29 +0100
Message-ID: <CAK8P3a3Hur9Kn=QLrn7XDn-Kpgfta1xTxvuwcBze4n2v7fsULw@mail.gmail.com>
Subject: Re: [RFC PATCH 02/12] soc: qcom: ipa: DMA helpers
To:     Alex Elder <elder@linaro.org>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Networking <netdev@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 1:33 AM Alex Elder <elder@linaro.org> wrote:
>
> This patch includes code implementing the IPA DMA module, which
> defines a structure to represent a DMA allocation for the IPA device.
> It's used throughout the IPA code.
>
> Signed-off-by: Alex Elder <elder@linaro.org>

I looked through all the users of this and couldn't fine one that actually
benefits from it. I'd say better drop this patch entirely and open-code
the contents in the callers. That will help readability since the dma
API is well understood by many people.

Generally speaking, try not to wrap Linux interfaces into driver specific
helper functions.

      Arnd
