Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A2CC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25ED820857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oIiuV5WH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25ED820857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389653AbeG0Vzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 17:55:42 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:48935 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389368AbeG0Vzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 17:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=E1OHhHlXKr/sMgtGidslBz87k/Wun/mjYBYwvCAVnmk=;
        b=oIiuV5WHn0twYl8l4OkGX614vSZkMCwf9HQh6pyH482/1l/YfLTKTZOwG/iJmma1m9cxtMSTHlZ0q4bZwO7MrU+b9Nou7w6bKG6pgGAbvAOqFvvVzl1R8Hdvd44rjxso+DXmUC1vH+5KNEgu9/W1LblikRDsRjLqZM0btVhFz0Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fj9P9-0004wv-DJ; Fri, 27 Jul 2018 22:32:03 +0200
Date:   Fri, 27 Jul 2018 22:32:03 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc:     grygorii.strashko@ti.com, davem@davemloft.net,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: replace unnecessarily
 macroses on functions
Message-ID: <20180727203203.GB17441@lunn.ch>
References: <20180727191318.18698-1-ivan.khoronzhuk@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727191318.18698-1-ivan.khoronzhuk@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static inline void cpsw_src_port_detect(struct cpsw_common *cpsw, int status,
> +					struct sk_buff *skb)

Please don't use inline. Let the compiler decide.

       Andrew
