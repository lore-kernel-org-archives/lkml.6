Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4013C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814BD26AF9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:24:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814BD26AF9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbeFZTYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:24:54 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:41134 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbeFZTYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:24:52 -0400
Received: by mail-yb0-f196.google.com with SMTP id y187-v6so6075653yby.8;
        Tue, 26 Jun 2018 12:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1UZVseZq50B20eyr2wx/4KIGKJhqFUkDWXOqE8rMoZ0=;
        b=o1h30s9d93LvzbOlojztQ9m4i9W5ukTwdbZuyZ/g1TeEpmcPU9CktceGDDENwe6KoX
         mbTahYH2pnP0e0tccue6ghXmkC2wmiicsBEWqq2YnD+BtWVG67seIt5uCiiJP+CJoLr4
         er8NYZp4rMkHZ56S4ud9dAZKTpyPD7sU/irFPTI6ZPwI/FsxOFfE4s4aVNG6XnpjMJ68
         y7ALQRHrz9oXgItsz0sIWT/fIdS8S5GQiBVZvf/oWeqH1enEJKVJhr9Pn/fiiV8AQmjo
         QqPD2HtaEHiNvmKD3vcJaUHa0gDQKzu5rob5ftm/AEs4hHDjJkqgTY29PDk12WAFFVL+
         reGQ==
X-Gm-Message-State: APt69E0Euodji8kX7verie8/HfwfUGSAshiNi7gwuMc3N8PEYZc/raIn
        F9RR5iblFlNT9tBorx14Zw==
X-Google-Smtp-Source: ADUXVKJu+FqTFThOHDdv1/2WSjmWiKWgo5zJ5N+5/2QQ6fZXVydQZazQdWpwEv33kuOXrT9p2gwRXg==
X-Received: by 2002:a25:6b50:: with SMTP id o16-v6mr1506993ybm.485.1530041091298;
        Tue, 26 Jun 2018 12:24:51 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id e5-v6sm777412ywh.52.2018.06.26.12.24.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 12:24:50 -0700 (PDT)
Date:   Tue, 26 Jun 2018 13:24:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     andy.gross@linaro.org, bjorn.andersson@linaro.org,
        kramasub@codeaurora.org, wsa@the-dreams.de,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: soc: qcom: Fix default clock-freq for
 qcom,geni-i2c
Message-ID: <20180626192449.GA24034@rob-hp-laptop>
References: <20180613175011.217585-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613175011.217585-1-dianders@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 10:50:11AM -0700, Douglas Anderson wrote:
> In an early version of the I2C patch that was posted to the list the
> default I2C frequency (if none was specified) was 400 kHz.  There was
> debate on the list and we decided that it would be more consistent
> with the rest of i2c if we defaulted to 100 kHz.  ...but we never
> updated the bindings.  Let's fix this.
> 
> NOTE: since the i2c driver itself hasn't actually landed yet and the
> SoC here is very new it seems terribly unlikely that anyone was
> relying on the old 400 kHz number, so I'll assume this is an OK
> "incompatible" device tree change.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Rob
