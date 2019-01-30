Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA57C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FB22087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548866251;
	bh=Xovs7zzscOfkLExa0sKV+MfLDMGn4e8B/iWpoIrLy3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T5HyUupkTcaav0oISH8FZCnL0yvK3HZG6thGUrjapCl56flQJihePhBOqKsYf67wv
	 qlLkbkTvU4VteME62h6Eyo562qawC3JavZVpTGUwZInlQgU1rVUwrOd0Vba4d49h8x
	 JqMAxMwpW76MQAfN7mWzAldvh4avZuvHWS7NBaMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732084AbfA3Qha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:37:30 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37398 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfA3Qh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:37:29 -0500
Received: by mail-ot1-f66.google.com with SMTP id s13so152013otq.4;
        Wed, 30 Jan 2019 08:37:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LM1RAGH3n+6lR88MIvu5YuNbIs4+YEQmWLTLxBYIKZo=;
        b=LpXbJGFDbJWIWu6jx3xY9cr5JJTUR6PWAXu6SVkNj5dg7G9GABamYVnn6I2VvQZwj+
         67REMXkzL2yKIIftxajuqvHoTBWyTGlhYsdhN8lILMhW0oYPkbqli/8IeKTtYC/oKC7+
         0EqGAhFGPZb9RWGqza7Hu160LLq46RnkVw7P+VN2fxWvAkIYSSWg0iqdZauNxsxXdHkf
         lvc0AzU3ilo4iHQiVct5iQe+yKmMM78ZS8ORHLyf0cc4Rw8bCtWRZGo+gVnaEiCTCGJ5
         sSd68k2klvOBXEJ5GLk/sppLtAygAg6SnWIt6dWaCdFRU12V9IWzhne9SwlVqf8Z3PO0
         rr/A==
X-Gm-Message-State: AHQUAuY7m5VWGG6mm44EK2QpZLAjHkcln+/0Y4pr6yo+zNb/BjH2DIh7
        ReVEg/z0uD8Tm05ygua/Kg==
X-Google-Smtp-Source: ALg8bN7A28O3be2wzTegqUkMWd3BgmIaae4tdr3LEEWzQitv/SmK5DHYuBucAyajSoENQ9w3AxrvGg==
X-Received: by 2002:a9d:740e:: with SMTP id n14mr14357687otk.340.1548866248844;
        Wed, 30 Jan 2019 08:37:28 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b18sm826859oii.51.2019.01.30.08.37.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 08:37:28 -0800 (PST)
Date:   Wed, 30 Jan 2019 10:37:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        bkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        thierry.escande@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v4 1/5] misc: dt-bindings: Add Qualcomm Fastrpc bindings
Message-ID: <20190130163727.GA28911@bogus>
References: <20190124152412.10503-1-srinivas.kandagatla@linaro.org>
 <20190124152412.10503-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124152412.10503-2-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019 15:24:08 +0000, Srinivas Kandagatla wrote:
> The FastRPC driver implements an IPC (Inter-Processor Communication)
> mechanism that allows for clients to transparently make remote method
> invocations across DSP and APPS boundaries. This enables developers
> to offload tasks to the DSP and free up the application processor for
> other tasks.
> 
> Co-developed-by: Thierry Escande <thierry.escande@linaro.org>
> Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/misc/qcom,fastrpc.txt | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
