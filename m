Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C84FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27ADA2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Md4NgACB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbfAKDgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 22:36:14 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46234 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbfAKDgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 22:36:13 -0500
Received: by mail-pf1-f196.google.com with SMTP id c73so6268867pfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 19:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NPBtRH4wjGb2lES6CxEzmTjsa9sHbdQz1vhMEgaMEFI=;
        b=Md4NgACB5ZFuKd1zg+KHM6J2RJ7bvIMvMi8N1Qu52bANlbxEQ5stf9HbtZO6cs/ENo
         Ol4xlTuKwXv1YOyIgpadkQHrNVHccgyIWXXI/oGzze4DyJCiBgK/H97Eg8LFFKBc3k2w
         ykO/0wAqD8+OeXm3E20uwLI7TS2LmctZEFcKdsdH4DRf3gJ4MoSZe3RacROIndgRQ9a7
         KwW822TofV57JX7oR1+74nUURup97vh1TNlAYtshmfsxno+s7x/gIc6pn7AdaZufxQ7p
         +hVLt/Ywh4TdVBMu41D15yg0k+bLbnOctrgLvPayMyAgHbTHx0khHzg1VVchhOWiR03c
         Ykdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NPBtRH4wjGb2lES6CxEzmTjsa9sHbdQz1vhMEgaMEFI=;
        b=UbkWIfs7v4Vmg6eLkgvqa215PjUGeaiyQFLxJ70sxJJOMIvXDF31UydqTchkAhKxn9
         5wZ9NWkmIiOqGJVysUOvNLMZRe7q+z3rm7LNmh1TBWQID/cBpppOgO0LjJnyptm7x9Ik
         ZkNrWnhjWsIGvwjwqvma3Hv4FcDAtJ3zT/f+IhHCMAVKJR1v7/M+qSQKm3pj5WmaXtc0
         qFswda0pT9hT0QJdyMjcRjIgO6ULcvZhaJYCpF4C5bINxN3YjB2fzaR9h3nMOcVIAjvb
         fXClRY2C4SEHaYtpJcDIssuONqMKJtaGGzlpDTafs0jwh6ZmGqYM872lZ289LVOzyjyc
         xl+Q==
X-Gm-Message-State: AJcUukfN6YB1ieTqHUCF6jtpcanWxwxKfZzNIlyNAynL6i1s0SROVE5J
        x6jFBe+k19lDoPiBxxy9NP4=
X-Google-Smtp-Source: ALg8bN7AcmGIM0F65jqY+U1Ec42UZyfWddVpVGJDdAC3cQY2N8cFf9c1f3HaIVjh7uqgh8sre3HPaQ==
X-Received: by 2002:a62:5793:: with SMTP id i19mr12955532pfj.49.1547177772144;
        Thu, 10 Jan 2019 19:36:12 -0800 (PST)
Received: from raspberrypi ([218.147.106.184])
        by smtp.gmail.com with ESMTPSA id 186sm147536738pga.36.2019.01.10.19.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 19:36:11 -0800 (PST)
Date:   Fri, 11 Jan 2019 03:36:07 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vboxvideo: vbox_main: Remove unnecessary local
 variable
Message-ID: <20190111033607.rsuj3yii6yoiksqm@raspberrypi>
References: <20190110061347.31326-1-realwakka@gmail.com>
 <20190110122358.GC1743@kadam>
 <20190110170023.4vcyws3ktsf2sz3g@raspberrypi>
 <20190110192942.GF1718@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110192942.GF1718@kadam>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 10:44:08PM +0300, Dan Carpenter wrote:
> On Thu, Jan 10, 2019 at 05:00:24PM +0000, Sidong Yang wrote:
> > I think you just point out that my code isn't obvious because the
> > function returns negative error codes. I agree with you. But what if
> > change my code like if(hgsmi_query_conf() != 0). 
> > 
> 
> That's even worse!  :P
> 
> You should do comparisons with zero when you are talking about zero
> meaning the number zero.  In this case, hgsmi_query_conf() returns "zezro
> meaning success" not "zero meaning the number zero".  How many bytes?
> Zero.  That is the number zero.
> 
> != zero is a double negative, because NOT and ZERO are negatives.  If
> double negatives simplified the code we would add four of them instead
> of just the one:
> 
> 	if ((((hgsmi_query_conf() != 0) != 0) != 0) != 0) {
> 
> See?  Adding != 0 doesn't make it simpler...
> 
> The other place where != 0 is appropriate besides talking about the
> number is when you're using a strcmp() function because it works like
> this:
> 
> 	if (strcmp(a, b) < 0) {  <-- means a < b
> 	if (strcmp(a, b) == 0) { <-- means a == b
> 	if (strcmp(a, b) != 0) { <-- means a != b
> 
> regards,
> dan carpenter
> 

You're right. that is even worse. I understand and thank you for pointing out.

regards,
Sidong Yang
