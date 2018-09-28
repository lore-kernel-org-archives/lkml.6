Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27C1C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9521A21746
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGz3YA9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9521A21746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbeI1N54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:57:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43126 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbeI1N54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:57:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id j26-v6so3702460pfi.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 00:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o7X4CZL8UiFJZ80UvtFpFuJrlBf6AP+FDJtO3KY32xI=;
        b=NGz3YA9RsQGXJF0CJ38emR4EkU0K7mygloIAUY3ru1X+LIExkzQuNP1BQynzu2oTMI
         CvWnH3q8ZwhXdzRuL1DlyKuVO12QAdME6XLnNMO0FyPWu6kGLxdUuI4qH02x7STuiHGQ
         dACSjExzYpADXRYaKpJ/M4B4AYsKCYJT072dnLEi1bII5q23Sw7fEWjfdWGe3X6jMoLh
         t4S2yd+vkNvziscJQHjQSKvz2tZ9Fmk2o2LbGe5bORdIp4TXMBCVpIAXMaQvmSivTicW
         ksPKScwTwDq3OR2LB7xn7UHWJ+JghNABa/ci80+WamTm6tZd2EzZixZE3osg/BbAJRNp
         7Gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o7X4CZL8UiFJZ80UvtFpFuJrlBf6AP+FDJtO3KY32xI=;
        b=CDcB3onjw5cpV3okmq19N0CssYKXkvoxMFLXHweED9sulZTC5QDL4RQBEBfsiZxzOH
         JaT4JfVm+Vj7LmCJ67uEknxxCekkHvnkzVghfaT9Yti1j6vPycjn4YQ4UaWxc9EIdvXo
         h/024BWFFgOf7VhhA7+4zz+iv0HFKBJXDz1uxe1+6M9eTmLq4BOVa+w0Bx1O7ECxedNd
         sC5+X419DkIIOi4knn9/uDOOMCG3zS2N8cqYMLd3OEiMSKfym+tFCOWoVYx5h1vgZe1D
         qpXDAv8rztFHGgpg4yF4NWCTB6N/tndPnc7Xl/m3Ztn0PQmmf7Vdxl2Th+FWo505VFO3
         nk6Q==
X-Gm-Message-State: ABuFfohfe916ZUS/4ErKSydpL6DJapw0axuaT//jwy0hB0p9REwRZBdf
        4+fvtN6O/QZHct4V6QIPdiyd2lo3
X-Google-Smtp-Source: ACcGV62W+GcumsVO672ZV5U4mrd82CX2vKIFjHI5l+pp9j9tgICg5QyUK3vZHfp0/anW7d3hcFbPgQ==
X-Received: by 2002:a62:2459:: with SMTP id r86-v6mr15389561pfj.31.1538120130808;
        Fri, 28 Sep 2018 00:35:30 -0700 (PDT)
Received: from localhost ([110.70.14.151])
        by smtp.gmail.com with ESMTPSA id v28-v6sm7112219pfk.12.2018.09.28.00.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 00:35:29 -0700 (PDT)
Date:   Fri, 28 Sep 2018 16:35:26 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        He Zhe <zhe.he@windriver.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] printk: Fix panic caused by passing log_buf_len
 to command line
Message-ID: <20180928073526.GA1160@jagdpanzerIV>
References: <6c354803-5341-7237-9ee3-7882252c7483@windriver.com>
 <20180919023932.GA14090@jagdpanzerIV>
 <20180918224312.6e9aef50@vmware.local.home>
 <1545bc85-b64a-4b45-d40f-79567ac621dc@windriver.com>
 <20180920123056.27b2cf18@gandalf.local.home>
 <20180921073753.mqayzofcofpmhiyu@pathway.suse.cz>
 <20180925120135.GB523@tigerII.localdomain>
 <20180925122300.qq5w4skwmxbzi6sy@pathway.suse.cz>
 <20180925133143.GB601@tigerII.localdomain>
 <20180926110500.vfroi373mookavua@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926110500.vfroi373mookavua@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/26/18 13:05), Petr Mladek wrote:
> First, I would move the check into log_buf_len_update() so that
> we catch the overflow also in other situations.

OK.

> Second, please, keep only the first line.

OK.

> It is enough to describe the problem.

OK.
He Zhe, will you pick it up?

	-ss
