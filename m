Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5A5BEC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18CB220891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18CB220891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934853AbeFLWSU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 18:18:20 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34064 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934377AbeFLWSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 18:18:18 -0400
Received: by mail-yw0-f193.google.com with SMTP id b125-v6so206776ywe.1;
        Tue, 12 Jun 2018 15:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U17BS6CeHJ/z29wyH/YiI03/K31tozKKxHXUGBJIER8=;
        b=AKIMu/NYKCYkJP3AbFfs/0LOH/z0Aw5wv2X1jMrzosiWbF7PMfYn0/IlV1oigjEvUn
         IkustiHB+XD0sJId777VtdKRP4e+y5mqYPXksdwM8uVlpVno42xMk7ioF1bUxQEPvH+g
         pDk9CRnbtbuAypEf8gxwudCs1sxajoG1jn2Fr4RqXkSEXeCBb8UmKPaJCeGFDiXu/UIW
         fHXUkLEsTXw1r4lzr40Aj/H4kBRJuFr5/wM9yJSjya1QSpH33UYn/vsN2JJ41h48bY8s
         UJf9UATmyz/3wM/NaW9+WpczBwunTphMlKAZGa91PpnAyBR/lDzJWxgy4vzQziqv5Jux
         GKvw==
X-Gm-Message-State: APt69E2zKT74WQmt0KNdPwXh3X/vWwtEJdZSYY+TSdwVZhA7lPC2EoRX
        4qkw8zj3rp6rwb7JD49Ilwha4wo=
X-Google-Smtp-Source: ADUXVKK2eIcJNWkD2hL0QacELnHoSucngkCRYM7HS/h/exOfwJ1Vlq3bv70+RS/cHcZ8rJayjszzAA==
X-Received: by 2002:a81:94c5:: with SMTP id l188-v6mr1109860ywg.463.1528841897463;
        Tue, 12 Jun 2018 15:18:17 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id g145-v6sm477821ywe.17.2018.06.12.15.18.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 15:18:16 -0700 (PDT)
Date:   Tue, 12 Jun 2018 16:18:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/of: Make of_io_request_and_map() "name" argument
 optional
Message-ID: <20180612221815.GA28761@rob-hp-laptop>
References: <22064afa92ed2e4b33a93685aabb1d07c7c8846d.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22064afa92ed2e4b33a93685aabb1d07c7c8846d.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 10:01:07AM +1000, Benjamin Herrenschmidt wrote:
> These days of_address_to_resource() puts a reasonable name
> in the resource struct, thus make the "name" argument an
> optional override.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> Just something I noticed ... we should probably update the
> callers to stop passing stupid names..

Sounds like a coccinelle patch.

When do we need an actual name passed in? It does get exposed to 
userspace, but no one seemed to care when names changed from full path 
(which is commonly used) to just the node name.

Rob
