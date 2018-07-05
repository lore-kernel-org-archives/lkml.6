Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD852C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723892403F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723892403F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753551AbeGEXgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 19:36:46 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:44475 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753123AbeGEXgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 19:36:44 -0400
Received: by mail-oi0-f67.google.com with SMTP id s198-v6so20095847oih.11;
        Thu, 05 Jul 2018 16:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C1ni/1htfRpsgtY/qrS2SvURLMBm8v1QoEiWHlUW4fk=;
        b=UoNfaEfqpSHf7Q7vFvheK9DTyfeGMZ1mXNy9rrlN95Yw1B81qFM8vXr2BKxA8TJItT
         k/oKsfDHImq0qkFpaVmvTFMvwGWkypaXX/kBkkqRKVxdZ94d4dUXLudifMCRGGO+OamA
         pwl3GFv9ypQcNQFARQfCDX3bMvuTq6qkuYYJcsz1ZXXzYtzF7JuxwrHpD2btHr8GCbNx
         xm5KdCBpUIIpozyiNIl34N59ZYGNkxR/lRmm8MS0cLG8enbn+IQh0vlUdg/8RNwuHlHE
         +HjSNcsYHuo/KyAtQLcQgBp6HEMO2dt9k1N1gjrWbO7Rgu66oYW0vEITH5RGfl0TDbcz
         Au2Q==
X-Gm-Message-State: APt69E1bSlL5s6W+cLEhx5ylbU1FODvsyUlf0k0lg4eDhbfZJJrUdqRK
        RATo4u/N7i1CkTkrpK3PBQ==
X-Google-Smtp-Source: AAOMgpc84mrH0nE25JzEzqFZE7nMh4qYVO0hLfRK909zlFEReiuK2BzNhDf4Mg8ZvB3Pnyjmc4pkWg==
X-Received: by 2002:aca:3d05:: with SMTP id k5-v6mr8261282oia.86.1530833803625;
        Thu, 05 Jul 2018 16:36:43 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id e202-v6sm11909082oih.8.2018.07.05.16.36.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 16:36:42 -0700 (PDT)
Date:   Thu, 5 Jul 2018 17:36:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vikash Garodia <vgarodia@codeaurora.org>
Cc:     stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        arnd@arndb.de, bjorn.andersson@linaro.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, acourbot@chromium.org
Subject: Re: [PATCH v3 4/4] venus: firmware: register separate driver for
 firmware device
Message-ID: <20180705233642.GA27823@rob-hp-laptop>
References: <1530731212-30474-1-git-send-email-vgarodia@codeaurora.org>
 <1530731212-30474-5-git-send-email-vgarodia@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530731212-30474-5-git-send-email-vgarodia@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 12:36:52AM +0530, Vikash Garodia wrote:
> A separate child device is added for video firmware.
> This is needed to
> [1] configure the firmware context bank with the desired SID.
> [2] ensure that the iova for firmware region is from 0x0.
> 
> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
> ---
>  .../devicetree/bindings/media/qcom,venus.txt       | 17 +++++++-

Reviewed-by: Rob Herring <robh@kernel.org>

>  drivers/media/platform/qcom/venus/core.c           | 49 +++++++++++++++++++---
>  drivers/media/platform/qcom/venus/firmware.c       | 18 ++++++++
>  drivers/media/platform/qcom/venus/firmware.h       |  2 +
>  4 files changed, 80 insertions(+), 6 deletions(-)
