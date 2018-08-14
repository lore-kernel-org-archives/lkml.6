Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743F0C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CEB21723
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26CEB21723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbeHOAHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 20:07:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33468 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbeHOAHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 20:07:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id r5-v6so9679569pgv.0;
        Tue, 14 Aug 2018 14:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QcB6+rw5qVtVn4KrKpZHJyxXhFcSILqL/inxkHjvFuk=;
        b=UqRy2kk3CGwv/qFEenLcg1Sl9/2c40EtocLELjz02OijC3H7zbBepKns3Zgb4mZTjS
         Ez8rnpRSnBa9wiirzfaZd2w6zqUF0i9YbpwQC0qiASbhXMFlak1YSqeqRsFMH5hX1Rdt
         I66TwJmdseyevlStUo9nMkUNwRJKfbWVElV+tttWbqg/pl+D982af8AL/RX2Sz/jFb4R
         0QXbnynXb/HULHXb0JYVaJAqTQu2cqKUZOLTCPFn40eMyqa5p2gkb6DRgRjXULPjbuVb
         UNEIcA/IXq93gSvT8LUjYHNm/lHyOiq1pqSt4GhgW6KT9nE2F0rnMe4qrCfjFvFfwyUs
         sjSQ==
X-Gm-Message-State: AOUpUlHwM+gDqNfTIAZ+tSMvLu6pNKoAe1fzmN/wSTunXWGYxBRg7uqR
        ML3yICotRVwLkLraalh39Q==
X-Google-Smtp-Source: AA+uWPxYb7YWj7MPrb7ocrHssuYziCZP9BYN0crE3+ncpGi54HxDuLeSCwsitNtDThlPhmxbqCl+Ag==
X-Received: by 2002:a63:f14d:: with SMTP id o13-v6mr23138847pgk.236.1534281502424;
        Tue, 14 Aug 2018 14:18:22 -0700 (PDT)
Received: from localhost ([74.118.88.158])
        by smtp.gmail.com with ESMTPSA id i25-v6sm43468257pfi.150.2018.08.14.14.18.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 14:18:21 -0700 (PDT)
Date:   Tue, 14 Aug 2018 15:18:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: dac: add bindings for ltc166x
Message-ID: <20180814211818.GA19760@rob-hp-laptop>
References: <20180811200226.28776-1-marcus.folkesson@gmail.com>
 <20180811200226.28776-2-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180811200226.28776-2-marcus.folkesson@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Aug 2018 22:02:25 +0200, Marcus Folkesson wrote:
> LTC1665/LTC1660 is a 8/10-bit Digital-to-Analog Converter (DAC)
> with eight individual channels.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  .../devicetree/bindings/iio/dac/ltc166x.txt         | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ltc166x.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
