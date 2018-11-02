Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF9CC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6BB204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="0bdyvRYx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6BB204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbeKBWpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 18:45:55 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40299 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbeKBWpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 18:45:54 -0400
Received: by mail-it1-f194.google.com with SMTP id e7-v6so494934ite.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 06:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eT5RmU2uzjuVby6JWjqHeJJl+o3rA3ZJsDmhkMhA8KI=;
        b=0bdyvRYx6T6VSJavijO/mInMqLrj4KzIwQMXT9biy+W5Rh1O85gLQcSwBQ4qDSY2Tz
         RAOmzXu/ykemZ2ktF0kOT4ItGQx7M8S3SQEa69J1doYbAHAZHxXs7MfZjKk89ZJi1Xyd
         gwYJHabuv1/r4JT4dydkfPiJBwXUwEVtU4oI1lRIb6UhqjlbL+ajGFP3CSuYpRbSIWyu
         aiZkSdu7cQTz5MwU4BoxNkGJKAT81+Rq5WsdNuOz2jYmn0M5hRLLgxfZQy85YW4ZyS/0
         lKDq9yvqwIL20HpLRIQs6BRgPOq5DRvPIHuTveAzpkcvyRkgMKTPv12lWMzk00617DM9
         jyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eT5RmU2uzjuVby6JWjqHeJJl+o3rA3ZJsDmhkMhA8KI=;
        b=h5Z0GtatFKm4D1UQvVQ1ghvhU97TcCbSuv5C9i52TMgXdDw1m9rcL9D/XaH18rTISV
         Os8Zxv7LVmoWSnEgVWXe8H/J3R405/9Lb0uUc1fozadhF35p/4SPe4egQFk9kbEOD9mn
         3A19g7Fhgb0RZYoZ8pbW4b1QNZHsV25aqyemUNP9FsB7niNLujhLCqAVmgfHlVX2+RTT
         U04IR1mbFh9HxKY3FZvEpLcgSZr4UCpG1JRPsHI74ktb941UEmPOG7//kq+dbUA2DucF
         TiczE1pl52I34ZFH5D9i8htZidz+29Lsg3kYZUge/LMMPzn2fhQnk7bva3Hg2QhWbln4
         f4hQ==
X-Gm-Message-State: AGRZ1gJJ7wzQqfb540OyaBdKQUyMgbdw34OWgxareJv5Ky7rUiLnF8QK
        LXDs7UmphBCNePV3ZNlLaS/Gnw==
X-Google-Smtp-Source: AJdET5cFPidD5AiPwVOiCvQI8de/SMOKjt2MVf5GIDdWtitqaQNFi39kKCM5Fu0fWPtrmaUx3cOXWg==
X-Received: by 2002:a24:a444:: with SMTP id v4-v6mr721349iti.177.1541165922639;
        Fri, 02 Nov 2018 06:38:42 -0700 (PDT)
Received: from cisco (75-166-162-63.hlrn.qwest.net. [75.166.162.63])
        by smtp.gmail.com with ESMTPSA id q24-v6sm8203357iog.61.2018.11.02.06.38.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 06:38:41 -0700 (PDT)
Date:   Fri, 2 Nov 2018 07:38:39 -0600
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
Message-ID: <20181102133839.GJ2180@cisco>
References: <20181029224031.29809-1-tycho@tycho.ws>
 <20181029224031.29809-2-tycho@tycho.ws>
 <20181101134001.GA23232@redhat.com>
 <20181101195635.GG2180@cisco>
 <20181102100234.GA12360@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102100234.GA12360@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 11:02:35AM +0100, Oleg Nesterov wrote:
> On 11/01, Tycho Andersen wrote:
> >
> > On Thu, Nov 01, 2018 at 02:40:02PM +0100, Oleg Nesterov wrote:
> > >
> > > Somehow I no longer understand why do you need to take all locks. Isn't
> > > the first filter's notify_lock enough? IOW,
> > >
> > > 		for (cur = current->seccomp.filter; cur; cur = cur->prev) {
> > > 			if (cur->notif)
> > > 				return ERR_PTR(-EBUSY);
> > > 			first = cur;
> > > 		}
> > >
> > > 		if (first)
> > > 			mutex_lock(&first->notify_lock);
> > >
> > > 		... initialize filter->notif ...
> > >
> > > 	out:
> > > 		if (first)
> > > 			mutex_unlock(&first->notify_lock);
> > >
> > > 		return ret;
> >
> > The idea here is to prevent people from "nesting" notify filters. So
> > if any filter in the chain has a listener attached, it refuses to
> > install another filter with a listener.
> 
> Yes, I understand, so we need to check cur->notif. My point was, we do not
> need to take all the locks in the ->prev chain, we need only one:
> first->notify_lock.
> 
> But you know what? today I think that we do not need any locking at all,
> all we need is the lockless
> 
> 	for (cur = current->seccomp.filter; cur; cur = cur->prev)
> 		if (cur->notif)
> 			return ERR_PTR(-EBUSY);
> 
> at the start, nothing more.

Hmm, you're right. The locking is residual from when the old ptrace()
API was also a thing: with that, you could attach a filter at any
point in the tree, so we needed to lock to prevent that. But now
that it's only possible to do it at the bottom, we don't need to lock.

> > But it just occurred to me that we don't handle the TSYNC case
> > correctly by doing it this way,
> 
> Why? Perhaps I missed your point, but TSYNC case looks fine. I mean, if 2
> threads do seccomp_set_mode_filter(NEW_LISTENER | TSYNC) then only one can
> win the race and succeed, but this has nothing to do with init_listener(),
> we rely on ->siglock and is_ancestor() check.

Yes, agreed.

Thanks!

Tycho
