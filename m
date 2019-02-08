Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9797EC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F2D21924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RUt2Uoyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfBHKdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:33:55 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43574 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbfBHKdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:33:54 -0500
Received: by mail-pf1-f193.google.com with SMTP id w73so1472269pfk.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 02:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E4aDbG+h49gMi+lMknGngASD6+imYcXlMSFN+gonIpE=;
        b=RUt2UoyqKW9QWfur2/w9dMCYQu2p4IGIxBuwtTJz01FpRIhuCsYiJtAvSI6+JUrMH5
         SW8Oafv5UNm7WVWHK8lF2DK7ECjW9stCKUi4m0Z9E70rjPwkF5xtPerPY6SHI6gw7Ky1
         4OTtYTXVTQId215ceEbpxcWS5CPYnVRBNGUaoj2cQOCBUOJVvu2gjqCNckT2jpT2Twkj
         Hv0gT23CDYRxkEhOBZZKb5tdF6fwGzYe0YNzA/Eg9hmQH4yZYXvJG6yxo3i+Twydh2gI
         +BS4toQGZk6IiQrReC4knu8G4yebngeFuZQkh5Mkn9iuj2sKhOemL1A1P8nuRStlMiDU
         HqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E4aDbG+h49gMi+lMknGngASD6+imYcXlMSFN+gonIpE=;
        b=SDp2sr+7g6Q8KhG6KbHOm6ze1j12RVP7YdpXOwdelsICBCJ7EW5JR6uEAwZmxehx66
         ja6gHnqDa/yPx/wjvldmFkIopVHY81RE4LM+ETUfjTh1K4tCFcNul39Cjm/+FTJre1lY
         Nk62DCu4Hgz6lknGRvIiwpcpAxWtMgT0YAuTCARi/JGeuzQvtOqDR2ss47wdgeiWHVG6
         PXYl3WBCUsaQhCUL7vsdyTH57wMmzq4Avb3h9hWW0NgadxMq+4qbYDHzA0LloDJQ7qiJ
         meo+60is0zZq5SOtPFaDrwck6gW0+cQpr4bJLXNv3HsbpzjL5VxR7P60yVlT7unstXHy
         baXA==
X-Gm-Message-State: AHQUAubnu0gi6EoQI/Teu9EGe46tCevZuiYkV0zSSu+IDkvg73K1BLUn
        mzmPUUGRMHKQaZzBq5hvRcmtsA==
X-Google-Smtp-Source: AHgI3IZBNGpn095b5ylNAPdb5G3Nkm0hDIUztEDXos2IZFkTMi8WGPwzbpHL43IX/kca+e8rxKYUfA==
X-Received: by 2002:a63:d20f:: with SMTP id a15mr19631170pgg.171.1549622033543;
        Fri, 08 Feb 2019 02:33:53 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id f81sm449412pff.97.2019.02.08.02.33.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 02:33:52 -0800 (PST)
Date:   Fri, 8 Feb 2019 16:03:50 +0530
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
Message-ID: <20190208103350.jnmpsd3hkehzwbo3@vireshk-i7>
References: <20190129015547.213276-1-swboyd@chromium.org>
 <20190131092349.fksfqemm23qddkhw@vireshk-i7>
 <154952629766.115909.11259861549408107064@swboyd.mtv.corp.google.com>
 <CAPDyKFrrncpfEfbZJ1LHvqDbkc29CaJxZnXwh4Mz7PT6Efbctg@mail.gmail.com>
 <20190208071726.urevxs5a3vaf7gwh@vireshk-i7>
 <CAPDyKFrXWAzDChd3d2acQnF6GZw57+g6XeNtHo29q3i1qjidnQ@mail.gmail.com>
 <20190208100529.l2y75ua3bfa6nnyx@vireshk-i7>
 <CAPDyKFpmZNW7KgsgagD_6tKTQ07AJS7Kc=AGCQmMpNASuOG-Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpmZNW7KgsgagD_6tKTQ07AJS7Kc=AGCQmMpNASuOG-Dg@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-02-19, 11:31, Ulf Hansson wrote:
> On Fri, 8 Feb 2019 at 11:05, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 08-02-19, 10:45, Ulf Hansson wrote:
> > > On Fri, 8 Feb 2019 at 08:17, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > >
> > > > On 07-02-19, 14:37, Ulf Hansson wrote:
> > > > > I think we also need to consider cross SoC drivers. One SoC may have
> > > > > both clocks and OPPs to manage, while another may have only clocks.
> > > >
> > > > We already have that case with CPUs as well and dev_pm_opp_set_rate()
> > > > takes care of it.
> > >
> > > I think you may have misunderstood my point. Or maybe I don't get yours. :-)
> >
> > It was me. I thought you are talking about regulators and that is what
> > is already managed, i.e. to work with or without regulators.
> >
> > > What if there is no OPP at all to use, then dev_pm_opp_set_rate() is
> > > just a noop, right? In this scenario the driver still need to call
> > > clk_set_rate().
> > >
> > > How do we cope with these cases?
> >
> > Yeah, that would be a problem and hacking the OPP core may not be the
> > right solution :(
> 
> I guess one simple way forward could just be to check if there is an
> OPP handle/table available, then use dev_pm_opp_set_rate(). When no
> OPP handle/table, use clk_set_rate() *instead*, not both.
> 
> That could work, don't you think?

Yeah, just that it adds more conditional code in drivers, while we
wanted to make them light-weight :)

-- 
viresh
