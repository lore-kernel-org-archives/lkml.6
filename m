Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD8CC10F0B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBFF2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mahU/fAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfBTQAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:00:45 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37532 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfBTQAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:00:45 -0500
Received: by mail-pl1-f193.google.com with SMTP id q3so5050369pll.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 08:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RY11cIriJiQSAMxw9Y+OKRZpU3gInWMmnwtnKL7ESTo=;
        b=mahU/fAmVgFJMmY1HOrY8vlYPp1BtdCssDMXjzZqDddjWiIGNhISThFMZb2monQuv6
         bXnuK6ZOOo05OLlTz/LGTn6MqZHSeOly4OOujYAp81eVrR91l/HLIJC9Mhen/L+pbUc3
         TeGKiMYx/cXTTfaWE8c5v0WGPBWI5TdvrpoWBBjxCaRuVkb0ivPAKKcVbarh0pmIDlSa
         CakG2PtkATIpnfM3L5dbPvxQ8EPWhl9g15J53gJ8zxGarf6Ih7eu1VMyYAoTeslmrCFZ
         Rz6r0X0CBd6IsrA2AX9hOHYK0lp1R0QNaRotXa1nZxbTFX69Sd5wGjB4fsOopaHIohzs
         oXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RY11cIriJiQSAMxw9Y+OKRZpU3gInWMmnwtnKL7ESTo=;
        b=VNLWxksz93BXqrHE4lqC6qcxO6HSBPQaqYn6Ir5VofRdZbebwyuUuv+/44CfJ3pCld
         iSvOLTyLVZoHbb0xWmznLQcrHOIj0SN9TQU2l4QmbWPhiqsAIfDix8h8ufm1LgviLma4
         G/YEYeM9WUEmRHGMgoKrYPLzCOGjY2VBMbtoaI2vnIliwAzqCw4vgSanOWiP1sXxnSE6
         hKm56hx6Dy3xRLQHKczOZbGWRKiCB4iKQ/tLhAzspmiW1Yp1YJoDmnwUYBn6q1fP22qW
         QZpXCzLusjJe8YeqQEX6mm4+SM+7Oyp95urYomtCg9qkfU8JaRqbRZq9tX4D/MGKnz1y
         Ko/A==
X-Gm-Message-State: AHQUAuYoyg9Wy7Gh+mmkb+UDPnCWuZ6al8RGUhpA5h7DAzQZLyc6tuPJ
        zm3UnvKR6NbtClVZ1B/JzPAvyw==
X-Google-Smtp-Source: AHgI3IZrMSSAdOlqKlcGRid3pAKHrrIxikBSsRqtAHc7I/ueTGAhyQslkMGqf53BI49555BCCocLpw==
X-Received: by 2002:a17:902:7c98:: with SMTP id y24mr19525405pll.191.1550678444132;
        Wed, 20 Feb 2019 08:00:44 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id l2sm6129849pgj.64.2019.02.20.08.00.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 08:00:43 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gwUIc-0007vb-PL; Wed, 20 Feb 2019 09:00:42 -0700
Date:   Wed, 20 Feb 2019 09:00:42 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     YueHaibing <yuehaibing@huawei.com>, peterhuewe@gmx.de,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 -next] tpm: Fix the type of the return value in
 calc_tpm2_event_size()
Message-ID: <20190220160042.GD8429@ziepe.ca>
References: <20190220022300.25888-1-yuehaibing@huawei.com>
 <20190220063159.GA23027@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220063159.GA23027@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 08:31:59AM +0200, Jarkko Sakkinen wrote:
> On Wed, Feb 20, 2019 at 10:23:00AM +0800, YueHaibing wrote:
> > calc_tpm2_event_size() has an invalid signature because
> > it returns a 'size_t' where as its signature says that
> > it returns 'int'.
> > 
> > Fixes: 4d23cc323cdb ("tpm: add securityfs support for TPM 2.0 firmware event log")
> > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Two remarks:
> 
> - git config user.name "Yue Haibing"
> - "Cc: stable@vger.kernel.org" before the fixes tag.

'Theoretical' bug fixes are not suitable for stable

Jason
