Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FE3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B29E2241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7E0xSKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B29E2241E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbeKMIP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 03:15:26 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42697 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbeKMIPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 03:15:25 -0500
Received: by mail-wr1-f68.google.com with SMTP id u5-v6so5813545wrn.9;
        Mon, 12 Nov 2018 14:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PIqbZ3ruDM16qNDHZPsH6OmOfOpdkdJKnFzh8awGnfI=;
        b=R7E0xSKK3evAQfL35TiZ3YnzMPWHTjqSJlfk4EsUlZZqYTG9aK7HS86TdGwrXEWCSi
         Y0Wt8KwnY94/Kct63KA+zQBh3+BBS7CgIfO0atXj3RC+rLKWzdr5u1H45Cc0lP2j/UOt
         D0QgVuxwdr0/KLKVSOKW9V08WI73Ub010dHSO7qf41Lwqr7ajLiqHaShm+kbgHkiyHT3
         aShMGLwj7ApiuVjy4mrYTP+ASBN3IJI1nJV/4EyGKSSuIuKfL51GB1QyuXrqF3VPlWbJ
         rZ8O+zglPPcBD9AFA0hcg6dRfq80bxMhLfsukhqx5zG6CDATmKTTtPROQvDBZK82pHaM
         qezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PIqbZ3ruDM16qNDHZPsH6OmOfOpdkdJKnFzh8awGnfI=;
        b=d+ethnrdoJm7/P2H3hoE0Gdz4ipri5GpoN8oiJj+LBaK4AmHRuC4OojZhyPo/T1MnO
         8L5TWCbZnY5sG1Yem482GULZ15Exb8gRkHMOHuLyitFGIJ2oK0KuYBhKxpZBu0jrfiAA
         GxcTuFhvML43Pl07anG6REuXb6/sjKQpyX/CWHhGX6dbtbjT4WWaS2vIeDGX2AVJYHL5
         l7kM+9CWqO8+Jg8Ei30vCxXCDYY05iY7UixKCxEO9glksejG0qlcR2W0Jlgc4YnUJhwL
         uGLOh0Fm+r4V5/XjPp/cpH/nvV3pkso9Zz2UoOSivquVAWM1uiqbKJ02xN9BIeqw6y7v
         hmDg==
X-Gm-Message-State: AGRZ1gIDmueoRh5ePla8YQgJWiWY2OlTxysyASPef7+1voZ00/hc52B8
        u1ua8ISUxPsLuvsK8a9ZlxDoshi2MHc=
X-Google-Smtp-Source: AJdET5fu/B6Kb9PVkXbgxlljzw405Bq305twU8r+xMBrMkK//Wj8Q2PW9jt8lynCjRweskI/nSoFJA==
X-Received: by 2002:a5d:53cd:: with SMTP id a13-v6mr2525066wrw.71.1542061216256;
        Mon, 12 Nov 2018 14:20:16 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id l17-v6sm10168898wrb.86.2018.11.12.14.20.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 14:20:15 -0800 (PST)
Date:   Mon, 12 Nov 2018 15:20:13 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] geneve: Add missing braces in addr6 initializer
Message-ID: <20181112222013.GA12856@flashbox>
References: <20181112221248.11477-1-natechancellor@gmail.com>
 <20181112231917.4f2f07b5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112231917.4f2f07b5@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 11:19:17PM +0100, Stefano Brivio wrote:
> On Mon, 12 Nov 2018 15:12:48 -0700
> Nathan Chancellor <natechancellor@gmail.com> wrote:
> 
> > Clang warns:
> > 
> > drivers/net/geneve.c:428:29: error: suggest braces around initialization
> > of subobject [-Werror,-Wmissing-braces]
> >                 struct in6_addr addr6 = { 0 };
> >                                           ^
> >                                           {}
> > 
> > Fixes: a07966447f39 ("geneve: ICMP error lookup handler")
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> Thanks for spotting this. By the way, I guess you should indicate in
> the subject when patches are meant for net-next.
> 

Sure, I'll be better about that in the future.

> Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
> 

Thank you for the review!
Nathan

> -- 
> Stefano
