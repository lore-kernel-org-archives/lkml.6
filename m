Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14DBC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E94D217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="pqJbbzYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbeLRJWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:22:09 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39308 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbeLRJWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:22:08 -0500
Received: by mail-wm1-f68.google.com with SMTP id f81so1955030wmd.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 01:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=reJDQjip8OvNsd/j/JXEkcYjvOIxqRk/9WRj/efcj0I=;
        b=pqJbbzYfX/Z64Xtnn6yfO2dRE6W+8UI6mgWlIBlKZza21Kaufd/KWPbykdOXq6AWg/
         BNqxsQp+eU/T6tfI5w5meCpPSSnBpEUwQIxF8H3Ek5/MNATXbCv5Q6XSsJ0ZaPUVUcvL
         PJn7T+lTDWHbQIyphebcXE3p5V6rVDpDAPsshzOL4yhni+et2e+GjVd77jg14UFhL4Sr
         rf9daEn6qE9NBs8hwZqWpA9Yi+xwuztuGnAb6sSOOCIz13YzXv4sNkxdv40wC8Zgc7/2
         ZK6Oqre/7D/l+XskFeScwyMXmoQnyIS8J0nicff/a63xZCUI85nxef0sSYS/icnYNdNS
         nvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=reJDQjip8OvNsd/j/JXEkcYjvOIxqRk/9WRj/efcj0I=;
        b=UDw8YAhYj1Oub1O5/NyA+m0+/GXADe2HGpLLWcqsSWevXbLQh/lqt6xqEmiEt2+CUQ
         Y90QX7Y35aZAOAo3ldcgwZl2YQWMTaGC5ZdMaVHHctmHNsKqH3wXuivZ9oeY5g8S8u9q
         ntS3sV+w5YNB3TV3/P/K5vJtLhnf6RzQe2An197j/B9GcExX/iP7R1Mx8H/89v8SkbNC
         PQeTAITDN2F1Hb+YcwkmU1IuTsoFp6vVW8CLfhiV2xkd2Qyh68iOIXoacdJfqYhO30gr
         V7kiui8HLl11T85ggHEIzWextQ5qKZDc8vaOYDcAMGFkzDccrcTkAcbal7nnVxXXX6g1
         V9DA==
X-Gm-Message-State: AA+aEWaYmf7kRkrTPBeqH9ENUCB1KMgwjq5VLJXeBM7k75VLranAYTaU
        Dn0/JQlffCDtbRYzTFr5wllAOA==
X-Google-Smtp-Source: AFSGD/XIEEU9DQlJqNvps/ObjEWsldN32cqEJGbpNvRVX/VpQ0Vtb6F269EHnMZdVyf/mT9Hz0uOqw==
X-Received: by 2002:a1c:7306:: with SMTP id d6mr2293444wmb.98.1545124926061;
        Tue, 18 Dec 2018 01:22:06 -0800 (PST)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at. [212.186.191.219])
        by smtp.gmail.com with ESMTPSA id w18sm1686607wru.54.2018.12.18.01.22.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 01:22:05 -0800 (PST)
Date:   Tue, 18 Dec 2018 10:22:02 +0100
From:   Lars Ellenberg <lars.ellenberg@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] drbd: Avoid Clang warning about pointless switch
 statment
Message-ID: <20181218092202.GJ5026@soda.linbit>
Mail-Followup-To: Jens Axboe <axboe@kernel.dk>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20181002171447.10765-1-natechancellor@gmail.com>
 <20181004200912.32348-1-natechancellor@gmail.com>
 <20181217172401.GA30635@flashbox>
 <0110d874-7595-1786-77e3-e2b0daec2327@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0110d874-7595-1786-77e3-e2b0daec2327@kernel.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 10:29:38AM -0700, Jens Axboe wrote:
> > Hi Lars and Philipp,
> > 
> > Could you please make sure that this patch and the other one I sent make
> > it into 4.21/5.0? I am not sure when you were planning on sending the
> > pull request to Jens that you mentioned in the other thread but I've
> > noticed most maintainers typically send their requests for the impending
> > merge window around -rc7 or so and I wanted to make sure it was on your
> > radar.

I'm sorry.
From my point of view, "fixing the pointless switch" is just "pointless",
so it (again) fell through.  I get it that it is important to others,
and getting rid of Clang warnings is a good thing.  So sorry again.

> It needs to get here now, but drbd hasn't really sent anything in for
> about a year,

Last actual fix was 2018-06-25 64dafbc9530c drbd: fix access after free
so almost six month, yes.

> so I'm starting to doubt how maintained it is at this
> point.

Oh, it is maintained.  It is just happens to be "stable".
We don't add new features there,
and I'm currently not aware of any misbehavior.

I'll prepare a pull request containing this,
the other Clang warning patch from Nathan,
and possibly other small stuff that accumulated,
if I can find any, and send that out later today.

Thanks for the reminder,

    Lars

