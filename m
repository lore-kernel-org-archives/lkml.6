Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C45DC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE40821E5B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qq4GYLD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE40821E5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732429AbeHISCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 14:02:38 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41094 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731957AbeHISCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 14:02:37 -0400
Received: by mail-pl0-f67.google.com with SMTP id w19-v6so2701579ply.8;
        Thu, 09 Aug 2018 08:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jv/F/IQ1RkQJlztgSuQvRw2qzZpT6NX5FaqeSfTSXHc=;
        b=qq4GYLD+rDMTwKLEFjPsvC+LeyvNdHRi9WENwsJJygosnL0cmmsi7OtZIe5SKHlLEm
         tGy9FW6KQ7HzUdHjh+agBysJjJjcuf6WwbvWNf+U+SGqmi402ugkdN9Y7dkXFHSMJnls
         XdSyq+hcyFo1QGp2TTPZCZx2Yv4d26CfAlo80Y37VX+cYGX1iM5Lf+YV+9Vsg8dYmlBK
         yDCLilQ7P+maXvI7oiTj9ZmRESYAJHBCNgH9vHVp+Miw4UiCTkAfFHuIl35oAx9/UVox
         leSFS4gWXVZ6rWIDuKQdkEzNo0+8PnFRdNuaxAgfC/gJfL0W4uUFwBytidaH9vkxo6P0
         8X4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jv/F/IQ1RkQJlztgSuQvRw2qzZpT6NX5FaqeSfTSXHc=;
        b=ZQ24P/oz5Zz8Ui00YAvlZcixQE4Z//hyWkOMBNniFpdnhGVhNCYlqLXd1rR8nwoQUO
         PhZ7/DIkdDyN0lndzG/PdVO6XX1IHxx8xY+WEL1gO805WaNE4TgPVdOQM/x1b4q55rbe
         o7p6rtjiHxIkawoL9eqAJSPZ/riqCu/miOAGXvyfeqSWvvzQzxkZ0+F+XZ4nieZ3fXaA
         v8umXcSJgEI+ARMTuGnL+D4M5NU7XC5HhqCnxaUV+4+DOzcnErU4/pVL+2KeKFbGK3HH
         xyq6/iHkEVf4bsSdaDPizL4qtapmpAefF4EGGxiOWmSTRw3koxgsyB1/la2CZm6Ljlo1
         2hEw==
X-Gm-Message-State: AOUpUlFBVObWX+6fdP4N9w0k1UvGl/cMyTBPVwgWyGsTaeT8PI7YFhVB
        X9vMph0i3JfHX0SAMqQ9OoU=
X-Google-Smtp-Source: AA+uWPyJwUE/boTg02yIr2gApVXX0NJxy6OTXkvYB4SFvM1ooPUFfwkDgwGaVk9JeA7ge8wmYkLYxg==
X-Received: by 2002:a17:902:7247:: with SMTP id c7-v6mr2543372pll.79.1533829031091;
        Thu, 09 Aug 2018 08:37:11 -0700 (PDT)
Received: from localhost (c-24-4-233-174.hsd1.ca.comcast.net. [24.4.233.174])
        by smtp.gmail.com with ESMTPSA id g85-v6sm20749858pfk.39.2018.08.09.08.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 08:37:10 -0700 (PDT)
Date:   Thu, 9 Aug 2018 08:37:08 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dp83640: Mark expected switch fall-throughs
Message-ID: <20180809153708.gpxozqfnnt2gnu6m@localhost>
References: <20180809150824.GA15116@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809150824.GA15116@embeddedor.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 10:08:24AM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.

Acked-by: Richard Cochran <richardcochran@gmail.com>
