Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6254C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E6220824
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KjSPL9x1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E6220824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406402AbeKWFbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 00:31:47 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35405 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729748AbeKWFbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 00:31:47 -0500
Received: by mail-ed1-f66.google.com with SMTP id x30so8484264edx.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 10:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MQYlOI5IN7jfm84tWq4wo6pHzU2JRJvXRvwwg84DDcQ=;
        b=KjSPL9x1riWy3Il2X78+kxVkYI6MWZ4jIs1zF9I0kryavBaYkm11VBzL6MLrbYNBPS
         BQ+wdnMvDJj8uan2SxvbAT7InJSDysYBU86pcmqZPutdNcByWGHmjKdwhoCkdul/VB/T
         m1jDEa2eLgu+05jHnjJzpz7yGCcXgAMBB6BQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MQYlOI5IN7jfm84tWq4wo6pHzU2JRJvXRvwwg84DDcQ=;
        b=Pu8K8zmfuVsm/4AS+kaz4+bL7BOEvNWbf4PNkdI8IdjjaOxnHMTiAaHcHrwM10nQmp
         ZsQQNrrMlfe96ZZskrM3EQTu+nWH4M7aGDa4ejn5XXFRrsgwNwIHSm0MdLz1WUT7N4s9
         M6YTKwGN4kjUxnw1Snvog5XTQLaYh46ZRPbnXTXZT7/DnfRS+sZvMx6J+dIEj4IwD4q4
         Jao2+d6VwgwF+1voEE/YCFOz7yL6SVZW20XiF56lQOSrzKGp+RpFkHuE4yNXa1n7Xlxe
         dDqgsH/VwEhLQUh1dZZMgDsxa7wD0S5ZbsnJDi2SxGRLOpWO5L7gedIAj9fWN6Gdatbc
         XVuw==
X-Gm-Message-State: AGRZ1gLd4Jq9xiaXuXXZ4gsUjV1q2QcaWyYa43loX6YAvaO8bULh3Ds3
        5J3rUwdxI0wizvWYikdvsmGmMQ==
X-Google-Smtp-Source: AJdET5fU7ewCwnuVn43K4fAkAFTPGLqrsw7xUMiSWgXfHe0dsaUhftXqK6GHyfyql534RJ1+1KCkBQ==
X-Received: by 2002:a17:906:b799:: with SMTP id dt25-v6mr9137280ejb.217.1542912667999;
        Thu, 22 Nov 2018 10:51:07 -0800 (PST)
Received: from andrea (dynamic-2a00-1028-8386-da8a-eacb-c188-78b9-634c.ipv6.broadband.iol.cz. [2a00:1028:8386:da8a:eacb:c188:78b9:634c])
        by smtp.gmail.com with ESMTPSA id bq26-v6sm8208926ejb.3.2018.11.22.10.51.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 10:51:06 -0800 (PST)
Date:   Thu, 22 Nov 2018 19:50:58 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH 05/10] staging: erofs: add a full barrier in
 erofs_workgroup_unfreeze
Message-ID: <20181122185058.GA3466@andrea>
References: <20181120143425.43637-1-gaoxiang25@huawei.com>
 <20181120143425.43637-6-gaoxiang25@huawei.com>
 <20181122102230.GF3189@kroah.com>
 <1d1fd688-0cb5-cbac-9213-f56f7e356bca@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d1fd688-0cb5-cbac-9213-f56f7e356bca@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 06:56:32PM +0800, Gao Xiang wrote:
> Hi Greg,
> 
> On 2018/11/22 18:22, Greg Kroah-Hartman wrote:
> > Please document this memory barrier.  It does not make much sense to
> > me...
> 
> Because we need to make the other observers noticing the latest values modified
> in this locking period before unfreezing the whole workgroup, one way is to use
> a memory barrier and the other way is to use ACQUIRE and RELEASE. we selected
> the first one.
> 
> Hmmm...ok, I will add a simple message to explain this, but I think that is
> plain enough for a lock...

Sympathizing with Greg's request, let me add some specific suggestions:

  1. It wouldn't hurt to indicate a pair of memory accesses which are
     intended to be "ordered" by the memory barrier in question (yes,
     this pair might not be unique, but you should be able to provide
     an example).

  2. Memory barriers always come matched by other memory barriers, or
     dependencies (it really does not make sense to talk about a full
     barrier "in isolation"): please also indicate (an instance of) a
     matching barrier or the matching barriers.

  3. How do the hardware threads communicate?  In the acquire/release
     pattern you mentioned above, the load-acquire *reads from* a/the
     previous store-release, a memory access that follows the acquire
     somehow communicate with a memory access preceding the release...

  4. It is a good practice to include the above information within an
     (inline) comment accompanying the added memory barrier (in fact,
     IIRC, checkpatch.pl gives you a "memory barrier without comment"
     warning when you omit to do so); not just in the commit message.

Hope this helps.  Please let me know if something I wrote is unclear,

  Andrea


> 
> Thanks,
> Gao Xiang
> 
> > 
> > thanks,
> > 
> > greg k-h
