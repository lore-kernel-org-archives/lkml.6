Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA40ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C67A213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="iUPxVU4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C67A213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbeJRAp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 20:45:29 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43956 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbeJRAp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 20:45:29 -0400
Received: by mail-ed1-f66.google.com with SMTP id y20-v6so25516757eds.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 09:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xcDmeePrpewnH6pESDvdQ4mHrQ6Kc4wKvGV2Wd6BQJM=;
        b=iUPxVU4V8sWrEDpQAjBpz6CjYAEsUoNWb0f82ZCecAM0BrbuG/hVNXVW1GvtItjapi
         Vsu17ldOUH4zIIS5Btrc+9X1NLNOuTzSQIH/7mFksc1Cll7G8Rb5MPsX7ei1sDoJY2br
         feMJyeIeKDAoAUbF7l/+SqudXbCTmpYdWk6+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xcDmeePrpewnH6pESDvdQ4mHrQ6Kc4wKvGV2Wd6BQJM=;
        b=hqyH3wCwPa98TNfIX4i5cZYuAYQFluk1n7jYniohSbiXtpfvac6SjVpkTYh2MX3FR3
         f96MybQ/XhN8yUSi0BxJ3j0TMymG5y2N7ZGmqQyHI4vWjFzDYVD4tWlfymtvP5u96uIE
         1VTNzfGkTqK3VFx9eJIZqpzUK3NlQICr347+P9gYEdjxze1RVor2QCLJmBOtMKIBzSVW
         RWuNTvObf5Yb+SWKPqVhV61IEPBQM2xFwfZiCRHCLwjjm19iHSv9SeNAPM1nsNAJjfqW
         2Z+NMh8aVBrawjEAG5lTIOU+SFl/cv2ctnXSv7zU4Dr+Uoyr51WP0hMfwJnSEQQ+pqTk
         qAJw==
X-Gm-Message-State: ABuFfoj5k8NG1k5vZC3pY3XkDWHj3PUqM1A4f/6uK0vHGTUyepIlcNfJ
        fxl9jgD2XzX3j+qKtDd7Pm5mkA==
X-Google-Smtp-Source: ACcGV62DTSguD+XfZ13sr6BL9ZDv59k0MMFDd2y0ExQQ8BaHIvbVNSVvUp/7hn2Usl2HKUuRl/1N0Q==
X-Received: by 2002:a17:906:64c:: with SMTP id t12-v6mr27436292ejb.113.1539794935762;
        Wed, 17 Oct 2018 09:48:55 -0700 (PDT)
Received: from andrea (15.152.230.94.awnet.cz. [94.230.152.15])
        by smtp.gmail.com with ESMTPSA id a3-v6sm3713090ejr.55.2018.10.17.09.48.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 09:48:55 -0700 (PDT)
Date:   Wed, 17 Oct 2018 18:48:48 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     David Howells <dhowells@redhat.com>
Cc:     gregkh@linux-foundation.org,
        Kiran Kumar Modukuri <kiran.modukuri@gmail.com>,
        viro@zeniv.linux.org.uk, sandeen@redhat.com,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] fscache: Fix race in fscache_op_complete() due to
 split atomic_sub & read
Message-ID: <20181017164848.GA9795@andrea>
References: <20181017151134.GA8966@andrea>
 <153978619457.8478.3813964117489247515.stgit@warthog.procyon.org.uk>
 <153978621809.8478.2198040871218302573.stgit@warthog.procyon.org.uk>
 <14408.1539790333@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14408.1539790333@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 04:32:13PM +0100, David Howells wrote:
> Andrea Parri <andrea.parri@amarulasolutions.com> wrote:
> 
> > > Fix this by using atomic_sub_return() instead of two calls.
> > 
> > Seems a case for atomic_sub_return_relaxed()... why not?
> 
> Ummm...  In that case, should it be atomic_sub_return_release()?

Hard to tell for me: your diff./changelog is all I know about fs-cache
... (and this suggests -no-, given that atomic_sub() and atomic_read()
provide no ordering...); good question though. ;-)

  Andrea


> 
> David
