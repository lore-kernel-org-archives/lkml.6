Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A45C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45FA23F27
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45FA23F27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753746AbeGEXWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 19:22:34 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36790 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753151AbeGEXWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 19:22:32 -0400
Received: by mail-oi0-f67.google.com with SMTP id r16-v6so20093208oie.3;
        Thu, 05 Jul 2018 16:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QHEuLHSjSy6oBwFyySZSsQBBKM7MQscn19/jkIr2FuM=;
        b=Nxgsh03UOfzfRmqOUHiU49HK+zS5EeEbBosk6DN0H45qkDVKjylCyQ3H0FewrHV8OK
         Ev9EsDdQNhSFJ+g6nCG5YaMVUboz6+GNxlSX7HE59MHiIEluNQDhminZ+k64Ziub+Ofd
         Ki8vnTS+GEMv0TxeMdEywk7gQKgRseoryxVGVOTqiKEalRqAmk6U6LqYudbaO4GtiPzR
         ib+dUp3VBCG4ATBTi3RVk4moYAzpVUgJ/JzgoHAQbyrustYYzLwfN+zszoqquyE1lRKE
         bzGfaYGOQBx90ocw9OyutkWmADhmi0WXaU0Nx/6PFa8auHP7j8Js4OP0QVwTF+Hf+8jk
         ZB9w==
X-Gm-Message-State: APt69E3eRCtwbwi8EvRklNeu9omQFcEw62VnifVlebn7Ez6RPCTj5i58
        zeKO2BmPRx+CQUAjNNmIqg==
X-Google-Smtp-Source: AAOMgpecmenxnEqCAF9e/QjvfuFczbrpVlARVA0KGky2WEsHFIVwrdPWbmXlVyz1mk6DfoOeQKbJIg==
X-Received: by 2002:aca:c790:: with SMTP id x138-v6mr8256545oif.20.1530832951355;
        Thu, 05 Jul 2018 16:22:31 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id g65-v6sm2581727oia.23.2018.07.05.16.22.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 16:22:30 -0700 (PDT)
Date:   Thu, 5 Jul 2018 17:22:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mars Cheng <mars.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/4] dt-bindings: mediatek: add support for mt6765
 reference board
Message-ID: <20180705232229.GA14001@rob-hp-laptop>
References: <1530669174-17623-1-git-send-email-mars.cheng@mediatek.com>
 <1530669174-17623-2-git-send-email-mars.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530669174-17623-2-git-send-email-mars.cheng@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 09:52:51AM +0800, Mars Cheng wrote:
> Update binding document for mt6765 reference board
> 
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.txt |    4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
