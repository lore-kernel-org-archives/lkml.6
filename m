Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD57C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDED32080A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gKxilJJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfBHKFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:05:33 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34503 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfBHKFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:05:33 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so1488742plz.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 02:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EEbZsKKw7/YxAj9xmKlOqlh+cmU27tiyDvHOSXr6R0c=;
        b=gKxilJJECqRdJU6BJSc/saNZtZgVbxP22OTXAZeS67jqQ+uN5evDIZWRAX3PQbnN6E
         +vqWY33nwZjtI/vua2VMFv+rEE/83EVxZz2b5gYmkHvT694RJlx6xINoMnkFwtkcrZWl
         EZCtTM5jCclxKIpelhfvQfwbIMhSN37ywdRLq//j8F+Aaz55+MsseBHlFMBLhpchtuhx
         +lrBQGRZ6i+w9rWmEDmzLM7Dohn1YIDSQ78fNQh7chAKOd9eUSeNbF3+gDrnJHfbxVf3
         O8+sDne2e3+oMX2b12/qVWZyKp9itm2uCJv0N13Dj8X8fIYFkE7Pwsullg5QDtQlckx9
         Gq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EEbZsKKw7/YxAj9xmKlOqlh+cmU27tiyDvHOSXr6R0c=;
        b=sZfp3MNdTXa5UAHgSRP9E+JVpFOOmw7R8LG52JJrzICKI85E+CeEacLruwjBIyqR8o
         FZm3swjyi2oDHgnOW9q5FXqvCBHxIdwrn64Y7mnTeN6R1m1mblPfaX/9XTlOFhq098xn
         JMVxFr/vlSa1l9MhLF8LlzSLSw4o2oGqPETYDFv32IT9EhJKRzx+NcF6QDdnSO6fqogL
         r6ZlNSa/JzoYpUpNq3ltEFdv/Esow+64msdQ7fxco2QI8i/eUQjVnB1qrPmNbq/RDRyI
         KooEDwVcG1QRjDnYdt2wycIADvaBlUOQwE6t9QdV/KlM1+eROIH6pIG+DuXOdCuSV1We
         QLdA==
X-Gm-Message-State: AHQUAuaf7oPLWFMeRq5sD09ldiK+hXI1EjqSalsFm5N0Clo4axYoGx7i
        XaJwOm9n//5ZLKRRQeHp+FiDOg==
X-Google-Smtp-Source: AHgI3IYKmgHzSo5SZYhd24EpD3q3JlLSvXjHcSh/V0tElwMFiL9FMKwglWAogme5+bNnBf+vnnYupw==
X-Received: by 2002:a17:902:2ec1:: with SMTP id r59mr22137462plb.254.1549620332588;
        Fri, 08 Feb 2019 02:05:32 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id y184sm5063633pgd.71.2019.02.08.02.05.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 02:05:31 -0800 (PST)
Date:   Fri, 8 Feb 2019 15:35:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Graham Roff <grahamr@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC/PATCH 0/5] DVFS in the OPP core
Message-ID: <20190208100529.l2y75ua3bfa6nnyx@vireshk-i7>
References: <20190129015547.213276-1-swboyd@chromium.org>
 <20190131092349.fksfqemm23qddkhw@vireshk-i7>
 <154952629766.115909.11259861549408107064@swboyd.mtv.corp.google.com>
 <CAPDyKFrrncpfEfbZJ1LHvqDbkc29CaJxZnXwh4Mz7PT6Efbctg@mail.gmail.com>
 <20190208071726.urevxs5a3vaf7gwh@vireshk-i7>
 <CAPDyKFrXWAzDChd3d2acQnF6GZw57+g6XeNtHo29q3i1qjidnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrXWAzDChd3d2acQnF6GZw57+g6XeNtHo29q3i1qjidnQ@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-02-19, 10:45, Ulf Hansson wrote:
> On Fri, 8 Feb 2019 at 08:17, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 07-02-19, 14:37, Ulf Hansson wrote:
> > > I think we also need to consider cross SoC drivers. One SoC may have
> > > both clocks and OPPs to manage, while another may have only clocks.
> >
> > We already have that case with CPUs as well and dev_pm_opp_set_rate()
> > takes care of it.
> 
> I think you may have misunderstood my point. Or maybe I don't get yours. :-)

It was me. I thought you are talking about regulators and that is what
is already managed, i.e. to work with or without regulators.

> What if there is no OPP at all to use, then dev_pm_opp_set_rate() is
> just a noop, right? In this scenario the driver still need to call
> clk_set_rate().
> 
> How do we cope with these cases?

Yeah, that would be a problem and hacking the OPP core may not be the
right solution :(

-- 
viresh
