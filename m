Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55F1C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 05:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B110D20873
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 05:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J2SzzXw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbfBKFnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 00:43:42 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42627 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfBKFnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 00:43:41 -0500
Received: by mail-pl1-f193.google.com with SMTP id s1so4787124plp.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 21:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IXgHbpUGeaZUkOqbfvRFs6J88f38M5Qv+oaZZan4jOc=;
        b=J2SzzXw+kdDf34ErVlaNGAqBd6g9Vxg9iHd2vqnD5FMoN5BB9LFG2Jay6hbtBtwPBt
         8cJhSmWQSHU2OolqMy5+8yKgkTfJHe7Qin2Tq4m+4uDe9Em2KDelncpxaLWDqPE8OQbZ
         R6oybTbljAbSjY3netS763RtzYBaDvPn+mbgW/TZVIAI5e3/aD5utMSjJt1qWh21vvZy
         R0nh09LGgXeqTqNspoP6JjbNAFAOj2UoobtYh4uC6fmKP9uaL2ZjMeo1b+276JRyp5vM
         4lqHFJwAxHD1DFAS22ICH9IKys4qu9J/CEvzs8ooxS1PQ4rH2Ha0xrQkvb3lwm6x6sVG
         YKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IXgHbpUGeaZUkOqbfvRFs6J88f38M5Qv+oaZZan4jOc=;
        b=HqSZtwZawo4mSDyDhsCbj8yN0AlYptiDU6SwSfhbJOcYOJsCurgd7KkgnuRk4K+vBN
         5aeFk7Sj+o+aSLJKyyj7qdVMraUBtj6qHlq8imiP/GkU++ar/bP5v1C88JlKixLfAQD3
         Mj2ADtihVN+Zr2m5gLWrVGH2DtWWCrDab6J95uXhwTqDdfT5OUXb4TxYWBe3poUOwoGq
         psxsq+5qRaIUooQpN8Nqukdw9VT9e26A6uoQj/6M0JutspRrA4UTutDfRgJItMYIwibF
         6Iw2lUGjNA15ajIMf/GcM3fu0XFoJXZMomG74HkE0LqaZfOayH8h56mqcN8b9uycvt0L
         SVmw==
X-Gm-Message-State: AHQUAubyRvSqXJXabwdI0FfcSOelCUKKDCmWtyoOOjckj36mdg38zHFq
        uqudKP+iAVodWeOoJgTmZIT7VA==
X-Google-Smtp-Source: AHgI3IYtEKbtplkOKWkw75ou63/kSV1cFre9Yh86ptNJM4jPaXNxOaIUw0e+sg8egUX50nlfjl7SWg==
X-Received: by 2002:a17:902:6bc9:: with SMTP id m9mr35446032plt.173.1549863820996;
        Sun, 10 Feb 2019 21:43:40 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id r83sm3555783pfa.92.2019.02.10.21.43.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 21:43:40 -0800 (PST)
Date:   Mon, 11 Feb 2019 11:13:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] drivers: Frequency constraint infrastructure
Message-ID: <20190211054338.nxw4dbs75wkqolr3@vireshk-i7>
References: <cover.1547197612.git.viresh.kumar@linaro.org>
 <CAJZ5v0gs3FnCgFS8rg7vwCeATJKfR+mfMVrpkTbM237XVhpDJQ@mail.gmail.com>
 <20190208090912.43aao5kny42iirum@vireshk-i7>
 <CAJZ5v0iE9tFt9Xs27EYcjv6N1KAq-LaAQnv=QBvnbNRpfwrWCg@mail.gmail.com>
 <20190208102346.ophy3eqhxjzaqsxr@vireshk-i7>
 <CAJZ5v0gNhmqY_oem9SZk2fEkOikmjTK3YfFRuOi8f=66GSgVuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gNhmqY_oem9SZk2fEkOikmjTK3YfFRuOi8f=66GSgVuw@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-02-19, 11:35, Rafael J. Wysocki wrote:
> At least some of the underlying mechanics seem to be very similar.
> You have priority lists, addition and removal of requests etc.
> 
> Arguably, PM QoS may be regarded as a bit overly complicated, but
> maybe they both can use a common library underneath?
 
> As I said I like the idea of replacing cpufreq notifiers with
> something nicer, so if you can avoid doing almost-the-same-ting in two
> different frameworks, it would be fine by me.

Ok, will try to move to PM QoS. Thanks.

-- 
viresh
