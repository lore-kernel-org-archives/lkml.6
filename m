Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A85C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D1A218A4
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548323049;
	bh=KT5/D09lump03qxt3Q6u+waWb0v6Kge9kbPjqcIlsGI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iQ35LM8vzrinJS0/ZP6wWN1DsFxxohJ91HCfBH9UeLvWPgjPtcFlx+b1dug3N7IB/
	 GFkMrFQ2gfCj614I3RYzaNQF6VpYTH+4PeM2T6rNqkcPbvcEzAu1IwbnktI26RZbxC
	 v8LUt3/uHhWdBS/Tp0tZFFVw8w92FguvtWBaZ3Ig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfAXJoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:44:07 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41730 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbfAXJoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 04:44:07 -0500
Received: by mail-oi1-f194.google.com with SMTP id j21so4313895oii.8;
        Thu, 24 Jan 2019 01:44:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KT5/D09lump03qxt3Q6u+waWb0v6Kge9kbPjqcIlsGI=;
        b=P1UB/igZqe8TJ/PKP95MAgCTLFZb4qlzf8FMc9u7I5MB5yeKHBl5FN57D22KDPRCHx
         YggtpcCoiTe/57IJ26waSHCBb6gnM82TFMXwNnzRJj0eonPah2drPVMdatXPvpJh3+z+
         4zd9HLBcS5kMr9yHp43XICcvsk04wEict5270oj0m0Mkpt5iY0CJlpZVegQCjUIF+pZK
         ywHPcxDWjPM0DyDE2mIAUBI1SrxyY/Yj+niaD3/cYLJBcR1pbPc0hpRV7h18QsFsO0xw
         S7ch/jPg/yBceODNBrEYHKJ0pQDuO2gCDZnkYozZvGfVyRY9hsY9OMEFLOvcWHhgJDvz
         zDDQ==
X-Gm-Message-State: AJcUukeT2ay7tKA9M+/4A7x/+DAe4sw3remGm03vjTnXFPDwI1fCwr3t
        inSgOa0ae9uavrZPXakFOlU7J+i676JRVDNdIdU=
X-Google-Smtp-Source: ALg8bN67XjYS/b3/QkQlxdY6n4KskIphddSSaT3lhopvDJwGHnyriTKVBo402xdty79b270BM9PjRq79hDONpNZEINo=
X-Received: by 2002:aca:e715:: with SMTP id e21mr695356oih.76.1548323046168;
 Thu, 24 Jan 2019 01:44:06 -0800 (PST)
MIME-Version: 1.0
References: <1547722811-18052-1-git-send-email-wangxiongfeng2@huawei.com> <20190124065614.gnnwd6lhbyjiph2e@vireshk-i7>
In-Reply-To: <20190124065614.gnnwd6lhbyjiph2e@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 24 Jan 2019 10:43:56 +0100
Message-ID: <CAJZ5v0i-DP=ZYBBhqAGZB2btnQnqfXhGyQ4D=CqY6GFXMwK2Pw@mail.gmail.com>
Subject: Re: [RFC PATCH] cpufreq / cppc: Work around for Hisilicon CPPC cpufreq
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        George Cherian <george.cherian@cavium.com>,
        Prashanth Prakash <pprakash@codeaurora.org>,
        Robert Moore <robert.moore@intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 7:56 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> +George/Prashanth.
>
> Guys please see if you have any objections to this patch. I am not
> very familiar with this stuff and it would be good to get some
> feedback from you guys.
>
> @Rafael: Do you have any comments on this ?

Not yet, give me some time to noodle on it, please.
