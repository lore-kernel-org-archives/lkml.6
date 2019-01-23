Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C917C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF19D21726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="gXkVoL3h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfAWO1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:27:08 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39738 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfAWO1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:27:07 -0500
Received: by mail-ed1-f65.google.com with SMTP id b14so1840843edt.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 06:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=feJszqOm+t6LmNOdJ9EmU9eVZCJWJPHtlk1c7IJtgqc=;
        b=gXkVoL3htvwW4oJrfQO/PV8k0OtWeWUAgTxO7ekaqIVzMATK8OX1I/Yt5rywmVtLG0
         7UiIpz5i0qwAhzEWhJLUYHBjFXSNAT64UkwfVwwOt5q9CaOD9ZsU9Mh+4KH2z+6iIKYc
         bcSYJcV8WquCe25UHPewSRDvEUJY3tv+caJ6up5yX2zdow8wEcqsB6IqZOdnasDAYboB
         BG4wWU3rNXrPggBvJ8x8NiNvALat/6xH7vyl4sBq9+rtLMcykJiDQBh6fMhf+eNUALZj
         yb5KH8zZfQbblubxsYUwLWitypIN8TrIOEeLWdpxupRdXuWrP6kqcCvVMI+cTIJ5Euuw
         DUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=feJszqOm+t6LmNOdJ9EmU9eVZCJWJPHtlk1c7IJtgqc=;
        b=a8mgKK5pjskaHycRZaFOWLIZYkSD1XRhmF3HDmmtPSC/ihEbh60WHyEAYwl4w4m1Gp
         cTaWR/bilR62aKvcHTaBONpXr067NGhkF0JvrOZ3XybBP1caIP5VsUcIPMkRfgDODu6k
         bEIXED3lPxGaMQo5pNk8B14qjFKaoqrGxULcD4wxcVg8CHUpj4mPz6ZCu8KpayQQ+PW1
         pr+8VoJ5VA5MnSYWFn458k8mfmfcRsTATWdDD3fk5kwOIyQcN0P+dvA00RaNcIIzF3yI
         mr0vz9eU70BsNvx2GMM/R7VVjpKT5qE/ZK4lyHGCOeKkEx5WjMwmXGAuFg6KIwOP0T0K
         Cxrw==
X-Gm-Message-State: AJcUukd5JWmgt2UVuyaCkqAn6lFMEje9SBoyAOWKhxMAB2ycIQDzomEP
        dGL8nJDNq1fNyp8UYj9BwHmGYg==
X-Google-Smtp-Source: ALg8bN7KMpyunBJIzEBpI3dcuIRVK1PDHxJf5JYVTxXZ4AlFT4uVyh7uSdnNITDFjJFjS2egLioWtw==
X-Received: by 2002:a50:d84d:: with SMTP id v13mr2907363edj.103.1548253625955;
        Wed, 23 Jan 2019 06:27:05 -0800 (PST)
Received: from brauner.io ([2a02:8109:b6bf:f9e4:9473:6b39:afaf:14d4])
        by smtp.gmail.com with ESMTPSA id e51sm10403383edd.35.2019.01.23.06.27.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 06:27:05 -0800 (PST)
Date:   Wed, 23 Jan 2019 15:27:04 +0100
From:   Christian Brauner <christian@brauner.io>
To:     shuah <shuah@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, tkjos@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, arve@android.com,
        maco@android.com, joel@joelfernandes.org, tkjos@google.com
Subject: Re: [PATCH v3] selftests: add binderfs selftests
Message-ID: <20190123142703.ta7j3jnyaqc7ahgn@brauner.io>
References: <20190117114854.15132-1-christian@brauner.io>
 <20190123105457.k7oobylgq6rwka55@brauner.io>
 <20190123110052.GB22520@kroah.com>
 <d1893da7-1222-d303-04c7-fb0500b55088@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d1893da7-1222-d303-04c7-fb0500b55088@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 07:15:01AM -0700, shuah wrote:
> On 1/23/19 4:00 AM, Greg KH wrote:
> > On Wed, Jan 23, 2019 at 11:54:58AM +0100, Christian Brauner wrote:
> > > On Thu, Jan 17, 2019 at 12:48:54PM +0100, Christian Brauner wrote:
> > > > This adds the promised selftest for binderfs. It will verify the following
> > > > things:
> > > > - binderfs mounting works
> > > > - binder device allocation works
> > > > - performing a binder ioctl() request through a binderfs device works
> > > > - binder device removal works
> > > > - binder-control removal fails
> > > > - binderfs unmounting works
> > > > 
> > > > The tests are performed both privileged and unprivileged. The latter
> > > > verifies that binderfs behaves correctly in user namespaces.
> > > > 
> > > > Cc: Todd Kjos <tkjos@google.com>
> > > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > 
> > > Hey Shuah,
> > > 
> > > If you're ok with the patch in its current form, can you please make
> > > sure that this still lands in 5.0? If at all possible I'd like to have
> > > all ducks in a row and release binderfs with selftests and everything.
> > > :)
> > 
> 
> The patch is good and I was planning to get this into 5.1.
> 
> > I can take it in my tree with the other binderfs patches if I can get an
> > ack from Shuah.
> > 
> 
> Great. It is good for the test patch to go with the other binderfs
> patches.
> 
> Acked-by: Shuah Khan <shuah@kernel.org>

Thanks for the quick response!
Christian
