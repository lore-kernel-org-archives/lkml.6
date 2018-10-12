Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BEDC6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0760520868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NieFi0s6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0760520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbeJMDg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:36:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46499 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeJMDg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:36:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id v5-v6so6393622plz.13;
        Fri, 12 Oct 2018 13:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lYSpIWQWYS9WKuwLeJZxZwDWBgw5oqI+ITRNiswJJ8s=;
        b=NieFi0s66+8IRIpX7tE4TsJwrFsRWTKs3oaiU115W3mowRU7OghvPhhA3/B/ibfr8F
         QcOAvyDIVtWLH4VBJ/Z9qeI5hypVHxX1ghLRAok/9MN+si0mBP9xmsxbQ+Zm6KyGfLXc
         jpZuY7k6J1m0wScGWcU/ze7eOtHP2RT71qONsJqqj4S7FYKuIFwTB9GcieZwdJQyc1nC
         pme0EFHIGhPh1e75f0UVq4t3rscpiTTxtQeGgm7erxA4jjv0Rsv2H1jAea868T+oWMKv
         +rOc7/UzvRuRJpmC6lFiH4JAAOSet5poPaMBHODFtk2fayRyqlpEk7hQ9bFylQZdSLnE
         Zsgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lYSpIWQWYS9WKuwLeJZxZwDWBgw5oqI+ITRNiswJJ8s=;
        b=LDu3SoWzy81WfThrax++V0WOy3yl3KJLYWUzkgRfa9Oe8zyHJIzN5XS+/ztWC7ijcL
         /MTz+8jfOYoqJjBIvdLKZsiYenHeOshte4mOoCJbNi/TIFlqWryDHvAjGIum0k77pN0m
         vA9VhrVeqJcC50W0+aQH9deACyJ9K7Z5UnWGhienMSkS4T0qMaAFzWcabeWKsI4hdrGZ
         tN1l4/doRUwNK48a/EP7DWlS/oOFK6Cjcg9EPq9q3q/qKrw7rFnYU0CxS9nZBIBa1Ype
         2PR3hMsc3y7icUUpZTfW9dem3Dn5yhoTR4sN70bizL7UGFTQR3T/1b/eBdxtg0Q6THjb
         jMSg==
X-Gm-Message-State: ABuFfohpIig7B+v01YQCwrgPbWjqWAMaOnaseZbWMXCg2v5ykq2fTTBB
        5wj67UUItM1tqgaObeTeYtS0gPh0RhM=
X-Google-Smtp-Source: ACcGV632VZmO0TWkn1Kbqj+5rgoFHXIH3+kdWUKwBLpsG2UvLEPvXyzxCs99h/6fWKvuNI12x9p9bA==
X-Received: by 2002:a17:902:6184:: with SMTP id u4-v6mr7060627plj.121.1539374570593;
        Fri, 12 Oct 2018 13:02:50 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id s2-v6sm3043011pfk.133.2018.10.12.13.02.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 13:02:49 -0700 (PDT)
Date:   Fri, 12 Oct 2018 13:02:46 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [git pull] Input updates for v4.19-rc7
Message-ID: <20181012200246.GB35430@dtor-ws>
References: <20181011235736.GA68543@dtor-ws>
 <20181012105152.GB19643@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012105152.GB19643@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 12:51:52PM +0200, Greg KH wrote:
> On Thu, Oct 11, 2018 at 04:57:36PM -0700, Dmitry Torokhov wrote:
> > Hi Greg,
> > 
> > Please pull from:
> > 
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
> > 
> > to receive updates for the input subsystem:
> > 
> > - we added a few scheduling points into various input interfaces to
> >   ensure that large writes will not cause RCU stalls
> > 
> > - fixed configuring PS/2 keyboards as wakeup devices on newer platforms
> 
> That feels like a really "late" contribution, I hope it goes well :)

Yeah, that is true, but I'd be marking it for 4.19 stable anyway as we
do want newer devices to wake up on keyboard activity, so there was no
reason not to send it now. If we have to revert we'd be reverting
everywhere anyways.

FWIW Daniel posted the patch a while ago, we just have been working out
kinks in handling builds with different config options.

Thanks.

-- 
Dmitry
