Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CD4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9BAA2184B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547226264;
	bh=WsXmDCzsRluvqmCXH60etw/O+UixccCKD57ol44qOL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PuoY8iClx0MYgDVkGKZ7TkNzI3JJMzVRxUaAEmGzj0JXW6xz6pGycMDULQkSle611
	 CCJuP2MqYZqLTIB+rxV+eu25+dY2RQ0QoYNaJ+3ucIJZMxoq8VUTq5qPjvfcSIPcXN
	 DE71HGtHTLuIcWH+V8FDcN0PPoY5I5983KTdFP7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388020AbfAKREX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:04:23 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35448 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbfAKREX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:04:23 -0500
Received: by mail-ot1-f66.google.com with SMTP id 81so13739331otj.2;
        Fri, 11 Jan 2019 09:04:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eec5GYghdJ9rYhpPp737P8CJjJH63ZXJVzsaMQcHy08=;
        b=o/1/G79yk4kWGFwZ3WnvNJXEQQnDEWLTYE0I0HEZrL+wVGxhRcvlK22bX/K1iWTlAE
         ukaYZdOcEhRy1yTCX0QU9L+FflvjeZJnM6/xlzTmu5ExEC2+qxUsOkRzoRT+iL3gFm+t
         DF4ypx/l74hI9QKJGsJTuvJ3/ugqnnSsBdcixSKDjz06yuFMKlSjbzWLIUEy9bibi+AQ
         Sf+blga0qOJW+uq2IcGK3OAkHGvcuwb9U++ZwAbirKBNQcMfrg4zrQY9gbWyB0bGsOf0
         XaCpa2FQoHFUTbizy9FvsCzjOfWo273AIb9ATK3UZGQcR8Ym2fMOmeDbZn51wnYufTy6
         2lIQ==
X-Gm-Message-State: AJcUukfxqgoTDxYzHKYYsG/u1cA1ykK0+IUTk6qDsk4Q3nw87yblfSFM
        +cW7Ou72XHI5yy+imkGqxQ==
X-Google-Smtp-Source: ALg8bN585bLnAJUC4ztZQg0zYlc6fPGMbgVv1v7JSOxgt94ceotl5JBjm9lE3nRYJpDAa1gFdabMrA==
X-Received: by 2002:a9d:2aa2:: with SMTP id e31mr9347919otb.246.1547226261350;
        Fri, 11 Jan 2019 09:04:21 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f76sm50452177oih.58.2019.01.11.09.04.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 09:04:20 -0800 (PST)
Date:   Fri, 11 Jan 2019 11:04:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Otavio Salvador <otavio@ossystems.com.br>
Cc:     linux-arm-kernel@lists.infradead.org,
        Jason Zhu <jason.zhu@rock-chips.com>,
        Vicent Chi <vicent.chi@rock-chips.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Philipp Tomsic <philipp.tomsich@theobroma-systems.com>,
        Otavio Salvador <otavio@ossystems.com.br>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 3/4] dt-bindings: Add vendor prefix for elgin
Message-ID: <20190111170420.GA8995@bogus>
References: <20190104014023.17973-1-otavio@ossystems.com.br>
 <20190104014023.17973-3-otavio@ossystems.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104014023.17973-3-otavio@ossystems.com.br>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  3 Jan 2019 23:40:22 -0200, Otavio Salvador wrote:
> Add elgin vendor definition as 'Elgin S/A.'
> 
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
> ---
> 
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
