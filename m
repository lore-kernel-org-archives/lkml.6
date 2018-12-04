Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC6DC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD5D2081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:43:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD5D2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbeLDVnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:43:16 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41696 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbeLDVnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 16:43:16 -0500
Received: by mail-ot1-f66.google.com with SMTP id u16so16683514otk.8;
        Tue, 04 Dec 2018 13:43:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E41MDGt3xWvlm5rTZmexxgoeabfdTgar8o1DuxgF8R8=;
        b=WWF1FIy9fuj/Z02zulr/RCpbP1W2WXFm6OkTJXoBeB9BucYTqAharl6H5Vj04dlyks
         4sUn/sJe3aBVN7Jt5E3lS0l2YCxkXHTDRClF5XJCYdKweqCzfgypZnAn5qGII9KNJXOj
         ffLOuGA7XbHFmFfDCB1FxBbq0GH6UhSDSE8Yi+t5ilEp1KG+BGNOvYaiGfZ4LEh3wY/r
         J8A4mMdO0JF3u2N+rJr0d/AAtqHE1XyTR4rQ/WR4yMaz6WtXtV557efQ1JHERsfYbteW
         0AZfICSaye69sGSTniY7ackDqKKlSL3h4maEErvYt6eLR7SnOGYrsvulnmKiBvQSm0a9
         dlDQ==
X-Gm-Message-State: AA+aEWb3wj82P+Qh+VxLplRJwfdWLIvvy2rQiy2ZIrO85/p10GkIRF4H
        jCqKvVQlzmMJo0I+nhJ+zg==
X-Google-Smtp-Source: AFSGD/XqfvI2yMZHFpnAtsVhhJJmSH06FjbhrrOpqZVESYwGWLBMDyKEwDMfDw2ZVcf3b/SZOp/ycA==
X-Received: by 2002:a9d:1d29:: with SMTP id m38mr13306389otm.264.1543959794962;
        Tue, 04 Dec 2018 13:43:14 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s186sm6913605oie.13.2018.12.04.13.43.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 13:43:14 -0800 (PST)
Date:   Tue, 4 Dec 2018 15:43:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kirill Marinushkin <kmarinushkin@birdec.tech>
Cc:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        devicetree@vger.kernel.org
Subject: Re: [resend PATCH] dt-bindings: sound: Add documentation for pcm3060
 property out-single-ended
Message-ID: <20181204214313.GA7847@bogus>
References: <20181115071253.22558-1-kmarinushkin@birdec.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115071253.22558-1-kmarinushkin@birdec.tech>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Nov 2018 08:12:53 +0100, Kirill Marinushkin wrote:
> Output of pcm3060 codec may be configured as single-ended or differential
> 
> Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
> Cc: devicetree@vger.kernel.org
> ---
> Hello Mark,
> 
> yesterday there was a misunderstanding: when I wrote you
> 
> > I think you forgot one patch in the series
> 
> you accidently applied the already-applied patch instead of the forgotten
> one. To avoid the confusion, in this e-mail I resend you the proper
> forgotten patch in a separate mailing thread.
> 
> Please apply this patch for-next.
> 
> Best Regards,
> Kirill
> ---
>  Documentation/devicetree/bindings/sound/pcm3060.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
