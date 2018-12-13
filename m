Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78018C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD2F20851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEo7xHrI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CD2F20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbeLMCIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 21:08:00 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36586 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLMCH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 21:07:59 -0500
Received: by mail-pl1-f194.google.com with SMTP id g9so261354plo.3;
        Wed, 12 Dec 2018 18:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nqXhqJSEc3Bsv4FyDvftjxdCzRUwqF3CfdmO79NM+Jg=;
        b=JEo7xHrIH/9bHtxpbYkgDv/SYSBIcY/3G6dxLDneTnZwRH6/nBlV/5YFdK6zt1a2xs
         yYpnYWzSQIEOaSuQyNROse6lJPeNmZ+6OdVYqhOqtUxKqtVwyCdZyYEeKcte94rXJXGI
         m4s3JDcX0yIG0Hdkyfbt/TdEGL/BtrT1zOVe9jQtDGkL9EwtDwCn4RSH5xsdBKWJIOnc
         o9A1xbvc4DIpAHgVdXmkFQoEBkK+33qoVUbKhhig2OaudavzamXjJXbZE1Dqwlrr3rGL
         pAE2rkE34QmNX+cZ9iWmohM3bAEf2GBEq5FAnRmNCGEdbUUIo0RZ6t+ZTFEBHIexG1M6
         Nf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nqXhqJSEc3Bsv4FyDvftjxdCzRUwqF3CfdmO79NM+Jg=;
        b=DvtvbEoWtmaNgaJB1hK3C4P2NwSLz1fkkkeMNSpZM0VxGV4BCEk5ZO5w2mtNlEzAtm
         +58Eiap0H5Il4Cfc7xa+7hfB8JvRVuB2JoUN2LA7Metb1psf34l9+BJ+RYMArpp0aDNU
         cEcd0ifknRCKfNVT1EjC3NJW1/Vi8Hw+dVma2jSIu+EuUNTklz/D75lwBxJY7nEt763A
         hRMRSsb47La7YtGDwg+qwDosSlz1uH/82wTlAwpBKdbecQMfFZno3KxV3XHfaguhnx6t
         0SHoc5/fyaUnW6NOtGWJbswgOF30GA72oL9VcHJF2rdMoX63ecJ30tONfZQ3hXphWrmx
         t88g==
X-Gm-Message-State: AA+aEWaaSaZjESaHkUZNRNvoyU0qzEXIiKqChnRKBG+msFVeL8PMZBKn
        VokzgwswGv+TUfHD3KqssMU=
X-Google-Smtp-Source: AFSGD/XukLb/mz5PDPsvqOOSuLZjURmNrer2k5iKSsoMCY1EkuszFfemkJ90a6XnQExkYa8rAYfDBQ==
X-Received: by 2002:a17:902:b943:: with SMTP id h3mr22360212pls.12.1544666879111;
        Wed, 12 Dec 2018 18:07:59 -0800 (PST)
Received: from localhost ([110.70.59.213])
        by smtp.gmail.com with ESMTPSA id t21sm357221pgg.24.2018.12.12.18.07.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 18:07:57 -0800 (PST)
Date:   Thu, 13 Dec 2018 11:07:54 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Daniel Wang <wonderfly@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org,
        Alexander.Levin@microsoft.com,
        Andrew Morton <akpm@linux-foundation.org>,
        byungchul.park@lge.com, dave.hansen@intel.com, hannes@cmpxchg.org,
        jack@suse.cz, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mel Gorman <mgorman@suse.de>, mhocko@kernel.org, pavel@ucw.cz,
        penguin-kernel@i-love.sakura.ne.jp,
        Peter Zijlstra <peterz@infradead.org>, tj@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>, vbabka@suse.cz,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Peter Feiner <pfeiner@google.com>
Subject: Re: 4.14 backport request for dbdda842fe96f: "printk: Add console
 owner and waiter logic to load balance console writes"
Message-ID: <20181213020754.GB4860@jagdpanzerIV>
References: <20181212062841.GI431@jagdpanzerIV>
 <20181212064841.GB2746@sasha-vm>
 <20181212081034.GA32687@jagdpanzerIV>
 <20181212133603.yyu2zvw7g454zdqd@pathway.suse.cz>
 <20181212135939.GA10170@tigerII.localdomain>
 <20181212174333.GC2746@sasha-vm>
 <CAJmjG2_zey77QxMzq997ALkD56d0UtHmGjF4dhq=TbEc2gox5A@mail.gmail.com>
 <20181212214337.GD2746@sasha-vm>
 <CAJmjG2_C0YRtVmNh2sg4JqhJJ11LMmbRHqwADxyO9CGh9ixQbA@mail.gmail.com>
 <20181212215225.GE2746@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212215225.GE2746@sasha-vm>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/12/18 16:52), Sasha Levin wrote:
> On Wed, Dec 12, 2018 at 01:49:25PM -0800, Daniel Wang wrote:
> > Thanks for the clarification. So I guess I don't need to start another
> > thread for it? What are the next steps?
> 
> Nothing here, I'll queue it once Sergey or Petr clarify if they wanted
> additional information in the -stable commit message.

Hi Sasha,

No, no commit message change requests from my side.

	-ss
