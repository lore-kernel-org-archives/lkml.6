Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FEDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6AD120C01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550504771;
	bh=zdnchGj0B+zoYprwQWKAS16+9YNCDFACwy1TRwkYD+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Byj9fsai8Shf/oPwZ0i076ctTAD/GWzTpZCaSrd7KSb4cRPmbf7eboCDHCnKtYrgs
	 AMFqrXNKJLjoMtxehpjE2YWruReMcnpr4lwGczoK/6RlVXq788twM/brBGuwm6cnj9
	 z5rC0l9MpbBMG1bXg3GiaE9YJB+qljT8GRNK4lxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387440AbfBRPqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 10:46:09 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46201 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733234AbfBRPqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 10:46:09 -0500
Received: by mail-ot1-f65.google.com with SMTP id c18so7393817otl.13;
        Mon, 18 Feb 2019 07:46:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I+UkTyKXds8AWZJZLWrOo5AsNeP6eo6Bon1x1+zYxeA=;
        b=MAEc+L7c0VLqCm+g+DYhiQ43HJmZkkht29C+t/pk8e/yLHbj3jBjnETI4xE4HJCdJl
         heJwvNx4C+4PZqdxL8fIevFjbbQYxxgOMpq+TUMf0OF6Z3RFRlKbaby/xVe0tFWY+7wV
         4wftmH6IKwmkDZpRWiG1EdcKoYbPdKQPXQjqqv2EJULFzyDuJHL6k/k1gZxAuvyeoEXG
         y8mlZpDyNi5nvvzNnz19kcdP+BZms6XsfAfRFH9oY2TO6TkLuZsdQ9Fp6zZ+jVlFTg01
         0p0vbbNJzqpxo/6J0Sgox3R1vTQlnvnUK3iZx8kbBDpyr3bOysVHgMQp3NAdBX16rLzV
         Iw4A==
X-Gm-Message-State: AHQUAubapTyO8dGOBNmUrDw0IbmBx/31tK+yGYBeEFl673LD4M/sdvUn
        5e+5D2cbYt+se0mhojIu8E0DvL4=
X-Google-Smtp-Source: AHgI3Ibx+yATMb5kobRrdMlYDLkgOqfwOmFfYV9PXmMbUXx0cIMtJd/rbIwZRv7zoGcjoKZQspYYkQ==
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr15210604otl.343.1550504768354;
        Mon, 18 Feb 2019 07:46:08 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i22sm5733717otl.20.2019.02.18.07.46.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 07:46:07 -0800 (PST)
Date:   Mon, 18 Feb 2019 09:46:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Artem Panfilov <panfilov.artyom@gmail.com>
Cc:     Artem Panfilov <panfilov.artyom@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: rtc: add ABEOZ9 support
Message-ID: <20190218154607.GA651@bogus>
References: <20190217185321.2189-1-panfilov.artyom@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190217185321.2189-1-panfilov.artyom@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Feb 2019 21:53:21 +0300, Artem Panfilov wrote:
> Signed-off-by: Artem Panfilov <panfilov.artyom@gmail.com>
> ---
>  Documentation/devicetree/bindings/rtc/rtc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
