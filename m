Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57DDC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B348120854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kF+JL6/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfAVHIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 02:08:42 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38325 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbfAVHIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 02:08:41 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so11310668pfi.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 23:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o0nmHr8G0bQ0Us1nP+IiA/u14t5bq2SldrHCSL70QKs=;
        b=kF+JL6/xVkWydBoo7K6mGc8R+oRsF2Ynw4XtGgWeGxWnICsRpOBHq37EQZZcRCBskF
         g3FKf9oIBg4SenrFXjsUDfH2vS1aNyIeOvJP9p6qMb6NonOW6dQY1Vwy8t6obKoQbs72
         QePa5OiSndj0wMJqXNvX7guPugf6ou+yhYlns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o0nmHr8G0bQ0Us1nP+IiA/u14t5bq2SldrHCSL70QKs=;
        b=MlrMoEQO4lEEbj2pqnO972aC8UeWI1k70EvWY+AgwRW8/HriaKYK97b7JYqlzwJHdB
         aIl3HqQgZPd7t3u9N3Xh46J7ES6IzWhD/ua90FoxJtTgURfnBnU0MEA8/8fXDKjiyf5m
         UBABM0dYiDNS1QOeomDui+wmlubzejBa4l9kZWg8FU7xobYhiubOpJg68ufkBNEDSVmI
         9JRTEOyV+R7rxOh6jrOtuRT4IWOqISSL637XwTT24DqzLO/WYq//LTSJF3hLQ/RSh7Bp
         ja2zF95sZX9YxXyML6mxtqsIjSYD96N6ooCRX/PS5+xI88KMjW7wRfk5npuqe2UKpuFl
         sE4Q==
X-Gm-Message-State: AJcUukfFSYUQssgGtKUsMDXPmRyYSinlklLOzn28TDkYHchoJvuaQIH2
        0SU0HQrPlLdtcSwiNSS3drRjIw==
X-Google-Smtp-Source: ALg8bN6TXZD00SL76ryFSJDjAEau43iQYDjewBpGNZnXnSNhokdO88eq/E58rv6y+GMgHQph++x3Xg==
X-Received: by 2002:a63:a16:: with SMTP id 22mr30817064pgk.318.1548140920834;
        Mon, 21 Jan 2019 23:08:40 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id f64sm47094917pfh.0.2019.01.21.23.08.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 23:08:39 -0800 (PST)
Date:   Tue, 22 Jan 2019 12:38:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        edubezval@gmail.com, swboyd@chromium.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v1 0/2] thermal: trivial fixes to error messages
Message-ID: <20190122070837.leg4xi5dbankixhu@vireshk-i7>
References: <cover.1548063429.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1548063429.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-01-19, 15:12, Amit Kucheria wrote:
> Fix up a couple of error messages
> 
> Amit Kucheria (2):
>   thermal: of-thermal: Print name of device node with error
>   thermal: cpu_cooling: Clarify error message

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
