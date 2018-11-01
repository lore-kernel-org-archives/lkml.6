Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAEFC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 19:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AABDA20657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 19:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="Irc4MEGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AABDA20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeKBFBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 01:01:04 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37898 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbeKBFBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 01:01:04 -0400
Received: by mail-qk1-f193.google.com with SMTP id d19so2733471qkg.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 12:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w8EX9DyP27t+5ZTQBjl2uq3Kd+oOoLjCwILy/qKcEyM=;
        b=Irc4MEGrFFGw28hQ9UE41MsDyB5UdtJkEEu9r4l5sJJxYMxrAZ956EXsEhNFHDq+qF
         fo4YOm1NM0ckkS2HI5gyd209ULwZaAvFhoIMz3i/eW1ycZTtkcporOzbM5SW3DhFsoTQ
         dIDGBkSMPIJpcjfMG0mK0D2gxZRsKDBPXllQKYzWDTqkGjYeMBGEvtg16fIdoXOeVsCC
         80f66AgkXTWw7h07zXdavq4oK3wbNI5aZOLpDQBOotER5UupDR4ao8WdD4kMFn/iAlon
         fdCVejtA8dNklgP2eZWt7+boajTdlcJX2FDO3MlyZ6RU5q1MS3uyb7S9WlwOKE4PyRQK
         MvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w8EX9DyP27t+5ZTQBjl2uq3Kd+oOoLjCwILy/qKcEyM=;
        b=gbnqcoDFe39RsPnDXN5Vy9o8fKqjDiFJuKcoN2L/Blce4QaU+kcPOw/6C71I5P62O0
         yCOUYp/xTFgfgZ9uSeXdeQ1/met9piVuniwMejzgLikD299SxE6I1BDzohKE60LtXTbq
         DhTujwmA3qfo4CyBwOZ4tVvPIygvHH++yaQHTXmM1RUVevxaMWTtGqBTB/9vkqmjilcw
         kebxUp/efXlUyo1KAxd9rOmgl8M4EGJ+dfxxiDPrFQTDEh859i2/KnY5QaU41JGDx90O
         lRpxtBvSw8Y8u/+9vh5EYZygywzMJhDwMCsZOQ8286V4c4hWwhBEQQSnnLJ4Heltp7pJ
         ZrWg==
X-Gm-Message-State: AGRZ1gIP6jWCN4C/PoFGD8KLy6j4ICtEizVeAjbjtQZHjWFtyJsByXKc
        Znsq4FebfuIUYZNrZNLrPPue0g==
X-Google-Smtp-Source: AJdET5dvGJSiZ0h+hphFRev4Hw8gtl5Z52JWV86xpDrYkd1lYE/JGHYlZ6J6l1Y9r7YX40D7hzc0bw==
X-Received: by 2002:ae9:e901:: with SMTP id x1mr7278669qkf.332.1541102199398;
        Thu, 01 Nov 2018 12:56:39 -0700 (PDT)
Received: from cisco ([173.38.117.87])
        by smtp.gmail.com with ESMTPSA id g2-v6sm19145365qkf.91.2018.11.01.12.56.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 12:56:38 -0700 (PDT)
Date:   Thu, 1 Nov 2018 13:56:35 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Aleksa Sarai <asarai@suse.de>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v8 1/2] seccomp: add a return code to trap to userspace
Message-ID: <20181101195635.GG2180@cisco>
References: <20181029224031.29809-1-tycho@tycho.ws>
 <20181029224031.29809-2-tycho@tycho.ws>
 <20181101134001.GA23232@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101134001.GA23232@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 02:40:02PM +0100, Oleg Nesterov wrote:
> On 10/29, Tycho Andersen wrote:
> >
> > +static struct file *init_listener(struct seccomp_filter *filter)
> > +{
> > +	struct file *ret = ERR_PTR(-EBUSY);
> > +	struct seccomp_filter *cur, *last_locked = NULL;
> > +	int filter_nesting = 0;
> > +
> > +	for (cur = current->seccomp.filter; cur; cur = cur->prev) {
> > +		mutex_lock_nested(&cur->notify_lock, filter_nesting);
> > +		filter_nesting++;
> > +		last_locked = cur;
> > +		if (cur->notif)
> > +			goto out;
> > +	}
> 
> Somehow I no longer understand why do you need to take all locks. Isn't
> the first filter's notify_lock enough? IOW,
> 
> 		for (cur = current->seccomp.filter; cur; cur = cur->prev) {
> 			if (cur->notif)
> 				return ERR_PTR(-EBUSY);
> 			first = cur;
> 		}
> 
> 		if (first)
> 			mutex_lock(&first->notify_lock);
> 
> 		... initialize filter->notif ...
> 
> 	out:
> 		if (first)
> 			mutex_unlock(&first->notify_lock);
> 
> 		return ret;

The idea here is to prevent people from "nesting" notify filters. So
if any filter in the chain has a listener attached, it refuses to
install another filter with a listener.

But it just occurred to me that we don't handle the TSYNC case
correctly by doing it this way, and it's not necessarily obvious to me
how we can :). So let me look into that.

Tycho
