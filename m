Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6438BC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0E420855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kK5e3xKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F0E420855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbeK0Du4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:50:56 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35949 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeK0Duz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:50:55 -0500
Received: by mail-ed1-f65.google.com with SMTP id f23so16478601edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 08:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4TU5EWPLOJUD/AgePTOjqipP72/q085XlRhrOSgBK8s=;
        b=kK5e3xKNjI2JbVfgXMIsWGyfvbH8ewTUKTBN955C3hZPlUTNRSQvhLBf6XljfFTOzw
         rPnxHc4Quqcx5hfFC22JefFAElMTcpU0fg5OurIEsYouyD1zHoITbUY21XM71DZWQSRJ
         UE5HTjTpu21G9KmRfpsI/Wh2QWZ6btP47xzTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4TU5EWPLOJUD/AgePTOjqipP72/q085XlRhrOSgBK8s=;
        b=LnBu+y2PNFnGaPoyb3zILla2H/rGQQxdXzoYcMtVjFYMQiEAUTGSNgN5YQ5DB8vRbv
         bFcX5pj/+bIk6L+AHKZFu0O43BrxY8Lc/Tj7mnX3Q4610OSADIZgWkeWtQnN8acxEA6c
         rJi3FT5E0NKxlyWOSBPtOdSExei4anXU2QTM+vWUfv/RzpcricTj6bdl4WhGC9urVE5H
         xRNTodveOgDcttYeOfjdDkd/KP6V7ZytW9XOww2M6zRUxB8yv08oAYuhYJaydJ46pLw9
         o8FROClWNV/ao5ljhHeZUhO918VQOMKbYMekC5PN9XsU4iM0qet767IZz3joVssEHK3+
         K91Q==
X-Gm-Message-State: AA+aEWbwSIr0z1s6Q/64hRTi1BxU/fzo5NgMMa9GOAXHKM0rm0wPTSj6
        rWDDfp3e8wKaH/zXTuNug/ZFEEfQ06zgOw==
X-Google-Smtp-Source: AFSGD/Ww8SkOmXkqTp+tgTzIUQkCK301QLz1advXudogfGtw4FLcGj9A4HOcRdU2KtEdFCKWSBmHyQ==
X-Received: by 2002:a50:ae8f:: with SMTP id e15mr24319787edd.250.1543251373294;
        Mon, 26 Nov 2018 08:56:13 -0800 (PST)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id n11sm315974edn.14.2018.11.26.08.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 08:56:12 -0800 (PST)
Date:   Mon, 26 Nov 2018 17:56:06 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     David Howells <dhowells@redhat.com>
Cc:     gregkh@linux-foundation.org,
        Kiran Kumar Modukuri <kiran.modukuri@gmail.com>,
        viro@zeniv.linux.org.uk, sandeen@redhat.com,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] fscache: Fix race in fscache_op_complete() due to
 split atomic_sub & read
Message-ID: <20181126165606.GA11282@andrea>
References: <20181017164848.GA9795@andrea>
 <20181017151134.GA8966@andrea>
 <153978619457.8478.3813964117489247515.stgit@warthog.procyon.org.uk>
 <153978621809.8478.2198040871218302573.stgit@warthog.procyon.org.uk>
 <14408.1539790333@warthog.procyon.org.uk>
 <26942.1543249596@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26942.1543249596@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 04:26:36PM +0000, David Howells wrote:
> Andrea Parri <andrea.parri@amarulasolutions.com> wrote:
> 
> > > > > Fix this by using atomic_sub_return() instead of two calls.
> > > > 
> > > > Seems a case for atomic_sub_return_relaxed()... why not?
> > > 
> > > Ummm...  In that case, should it be atomic_sub_return_release()?
> > 
> > Hard to tell for me: your diff./changelog is all I know about fs-cache
> > ... (and this suggests -no-, given that atomic_sub() and atomic_read()
> > provide no ordering...); good question though. ;-)
> 
> Yeah, that doesn't mean that it shouldn't be stricter than 'relaxed'.  It's
> kind of like an unlock/release operation, so I think 'release' is probably the
> minimum requirement.

Sure.  My point was: those operations are currently not atomic _and_
they provide no ordering; I think that the above commit message does
a good work in explaining *why* we need atomicity, but can't say the
same for the memory-ordering requirement.

  Andrea


> 
> David
