Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949CEC07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665EA2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 665EA2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbeLDLpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:45:35 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44881 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbeLDLpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:45:34 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so14566673lji.11;
        Tue, 04 Dec 2018 03:45:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9lyH6tyDnPML3RDDJuGI/lJe2+4NHy67zfhOq9Tt+Hc=;
        b=V0/doGAa/mXxksjgKFpHh47Bgydjbn4pqFrIWfqNtwlw1w0IwGYYGt8fIYMHQVBoN5
         i9dhnJajE1ONw8DM+ByyOcoXiy15ATkmytg6glXrmL96a+vWIFsKPfqKwoVuiHdf+JOD
         2X5WAYAD4CFHQZRXEvZUIhmDizVB26aFLFKfx5T/H5sijEGvMZi0x6JoD57ej0ZhL+9K
         J5ni/7S9NCxbocyKSklpKfyo2qTb8taLX7mq52j+hdHXXVxKT07394TtK9Rr9n2n5b23
         Ugfa4c1QtYK/oZ/Ba3E8GLv7nbdpmzdJZShkQr6RUjAmXbGJ+jMtv5pQm4wIanByRP/R
         yHEA==
X-Gm-Message-State: AA+aEWZJxXoN5yZF+a6st0iWlD6ZlcaDfMGz/DhKW/EVydOATrfGVtam
        6uIiEolkrndWBgoKKI2RPvg=
X-Google-Smtp-Source: AFSGD/XASlqggDkini/davVrrJ/kWhZDrlA7co2DQulhti4C5FWny9V3epSYvazwOutGQt9IM3FicA==
X-Received: by 2002:a2e:55d3:: with SMTP id g80-v6mr13915624lje.78.1543923930534;
        Tue, 04 Dec 2018 03:45:30 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id e14-v6sm3011099ljb.31.2018.12.04.03.45.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 03:45:29 -0800 (PST)
Date:   Tue, 4 Dec 2018 13:45:27 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, cw00.choi@samsung.com,
        krzk@kernel.org, b.zolnierkie@samsung.com, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, pavel@ucw.cz,
        andrew.smirnov@gmail.com, pombredanne@nexb.com,
        sjhuang@iluvatar.ai, akshu.agrawal@amd.com, djkurtz@chromium.org,
        rafael.j.wysocki@intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 00/10] clk: clkdev/of_clk - add managed lookup and
 provider registrations
Message-ID: <20181204114527.GC31204@localhost.localdomain>
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 01:31:43PM +0200, Matti Vaittinen wrote:
> Series add bd71837/bd71837 PMIC clock support + managed interfaces

> Changed drivers are:
> clk-max77686, clk-st, clk-hi655x, rk808, clk-twl6040
> and apcs-msm8916. New driver is clk-bd718x7
> 
> Changelog (for this series) v6
> - Drop 'devm_of_clk_add_parent_hw_provider'. Change
>   'devm_of_clk_add_hw_provider' to look the parent device node for
>   provider information if device's own node does not contain
>   #clock-cells - property.
 
Forgot to mention the obvious - I did also convert the call to
devm_of_clk_add_parent_hw_provider to call to devm_of_clk_add_hw_provider
from all drivers where I had this new call added.

I kept Reviewed-by and Acked-by tags from Peter Ujfalusi and Krzysztof
Kozlowski as the devm_of_clk_add_hw_provider should now do same thing
as devm_of_clk_add_parent_hw_provider did. Please let me know if this
is not Ok.

Br,
	Matti Vaittinen
