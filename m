Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04330C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23A82154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23A82154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbeI0Euh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:50:37 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41121 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbeI0Eug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:50:36 -0400
Received: by mail-ot1-f68.google.com with SMTP id e18-v6so609704oti.8;
        Wed, 26 Sep 2018 15:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZCPMc2kfOHUnBe2OYsn5nAtOlPAid8JdJNnPFjdoOA8=;
        b=MlIQXbyEiZX5STsiAfYqExlaAVFvrbWPwIyo7lGzQ7u3/YT0CjQEdOfT8B7xkbryc5
         J/qUH/xxHBJJvGcUmHNcfXzpWghIp+7RZnvigZH+QDlLKSxn8PoYoQgohiWnku18Smmo
         92Ix84kUfi1PNfM9e8tRtkKH6b8XTwO5MnqX5HgZzAG/Nq8YsUvI7b4kRtIuHAcPvxgf
         0LCIYdewiwSD9jLntREgL6m7AvwWv62GOdBk8ENxlZ+lqCMUuWUge9k+cMGgNfuacWwV
         UJFka0Y5zKI2dIBSSqLcqhnCZMuUDXaVCFoKsgsUwMhiTYuJAe0HNlMD/lCgvvZICxGr
         /vCQ==
X-Gm-Message-State: ABuFfogWiSleQyqZ7IWpqtP5P9B/MwQxMXlTBLSXh1jSpc4Rj0D3WFZO
        GRDPC+i7kprDAPRchOoZ+FmdPGTMIw==
X-Google-Smtp-Source: ACcGV62Vjg/jV/AEFya8H0ChB5D9nRNnbs5IEKmZRm3ep38zA8RX7qhzB6oYHSGXj7E2aIV+UymbCw==
X-Received: by 2002:a9d:42f1:: with SMTP id c46-v6mr5879873otj.331.1538001327109;
        Wed, 26 Sep 2018 15:35:27 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q204-v6sm98736oih.49.2018.09.26.15.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 15:35:26 -0700 (PDT)
Date:   Wed, 26 Sep 2018 17:35:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Radu Rendec <radu.rendec@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/3] dt-bindings: watchdog: add mpc8xxx-wdt support
Message-ID: <20180926223525.GA25002@bogus>
References: <c09f541d459c29aca40d54fff152d5645e24b50d.1537163776.git.christophe.leroy@c-s.fr>
 <e3e0bcfd7b779b978d07e088a8bd667ea9ddf4aa.1537163780.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3e0bcfd7b779b978d07e088a8bd667ea9ddf4aa.1537163780.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Sep 2018 06:22:53 +0000 (UTC), Christophe Leroy wrote:
> Add description of DT bindings for mpc8xxx-wdt driver which
> handles the CPU watchdog timer on the mpc83xx, mpc86xx and mpc8xx.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  .../devicetree/bindings/watchdog/mpc8xxx-wdt.txt   | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/mpc8xxx-wdt.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
