Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6303C31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FB520663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548090666;
	bh=ErDKDv5q1CfqI1gHTJqIwgNoZNL4xUmmr0TDKWkseMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Uw369M1kAvNuz3rsg38FZAfeG6Y7W5r57iW6IcvJiRp8ZFO+d+9HkhZuQDC0mlnf6
	 9/wXOtlQqhrKjsuKRdVyRCfCZXoQwkKn/DKaBeLI9aDXOnNJt2agnS4mT5A8bgBwIN
	 m0Paogyd3BqllAKZd57PwmONNi5PlBx5473SqSKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfAURLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:11:05 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41716 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfAURLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:11:04 -0500
Received: by mail-ot1-f65.google.com with SMTP id u16so21133559otk.8;
        Mon, 21 Jan 2019 09:11:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D+dEaEM3KM3Uc2U2QSkF6NrdJxm4gb7uvGA93VY/bpU=;
        b=SDynuw6uGzTZYFjsJNUFeLBq6hWoQ+h0OHOqh9KASMPwhu1hPLq1kC246alE8K4gJH
         HCuuAVA/E78zKWxv43bkSURWb7ncboxebYFrt2jZAtFpDGX1n8uNneByjgUKiUqvT+Gd
         Ejq2Jr3zh+e4FRV5YbLluB3p2rkGFQC3ux8NKd/lK6l1DMU5wLuxrVCuARBmO+ZPEw6E
         FM2T+Vt8CnuAbPznGPZIzR7pCqOMxgtckz/0POd3f5TgUaooEkEvfm/r+1A9J5i7kQIu
         6b84TEHETquUBihOLHtyw3/gkrqxK46RZ/0d36EejB5GLZ2bIqZrR1e1oIZe/tNVC6NS
         sNuA==
X-Gm-Message-State: AJcUukdgg7IcI2bhvj9BUVi7UA7JEXHpqqyg1Xe40/zwXwaxtt7EAPcn
        CjbTdNjbPc/jL7cErFq//g==
X-Google-Smtp-Source: ALg8bN7GDbbndCzGD6SPAzCYH/NLNHs5u9vHYhj9ARpHefaCtEmKCaKwr8JwAuyFDcfIks+F1UbvSQ==
X-Received: by 2002:a9d:2184:: with SMTP id s4mr21285492otb.46.1548090663716;
        Mon, 21 Jan 2019 09:11:03 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u65sm6401051oib.5.2019.01.21.09.11.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 09:11:02 -0800 (PST)
Date:   Mon, 21 Jan 2019 11:11:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: amlogic: add new compatible devices
 to clk_measure
Message-ID: <20190121171102.GA4325@bogus>
References: <20190118103423.15075-1-jbrunet@baylibre.com>
 <20190118103423.15075-2-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118103423.15075-2-jbrunet@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019 11:34:20 +0100, Jerome Brunet wrote:
> Add the axg and g12a SoC family compatible to the clock measure bindings
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
