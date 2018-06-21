Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352C1C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD883208A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqX0l6gS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD883208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754378AbeFUK4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 06:56:17 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52352 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754178AbeFUK4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 06:56:14 -0400
Received: by mail-wm0-f68.google.com with SMTP id p126-v6so4429100wmb.2;
        Thu, 21 Jun 2018 03:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SCnuaOjAKMqvxAMBssQ6hQTroB43f50dPpEqurwUtrc=;
        b=eqX0l6gSSAsYA+AjFK6vw2kExDSTq+gO2s6MNoudYGVlhLvc2Zg/GcXcPsjnSjYk18
         rtzuQr+8rcJoVcj68F8BhABC6DziP9X92g3w28nMXVjLS4Gq89on/2aB7zaw5CiU7Zsr
         tBfl17DrdSd3PKJipn/GbZWbfRherCkneh1YxZUPxB2TvmP6t2QKW6j8LtwVUl6XkYxr
         vx7cEavW1o+tCxLjOmlQRMtvsTVNvbGUoF8rNNK/EnBKs65pBf5udShY01xdxws8UYP8
         CkDWbspHzt7rVTIAulU3Y2fk0v76E+RPnbrx9xND4YXPE7Hvb+1vKgjuITD9/AtaqUcc
         BbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SCnuaOjAKMqvxAMBssQ6hQTroB43f50dPpEqurwUtrc=;
        b=Udxjqxl5Ky8KAWCtef8yn0kSk38EA6FZumx5KX/fnFSfAxeHpsux8maxvTLPZgYJHZ
         K+6fREgeD7gR8M+agQxYGhG19A7gWVWD9KyKQ0nktK78IE47/Hs1InB/aA3wr3ygYyY8
         TaTzrFRoeF3WOjl2+NztUEW0h5F6Os6ULQivoOBPiqp4u6+LJ/jGL3IR8BUhVB2lNb8n
         tQHdNXZAapkOOh2Kb81kLhozwKblThOYptvEMdCGW674IV0T0OWC8T8fi8GEF1VVyK+O
         /RjUASOjiuOcKixPcUaq5p19L6ymPh2XsqNvz8QMDdhyXnzSvWxRGdN3N4xLMg/pVLes
         J33g==
X-Gm-Message-State: APt69E2LTCfqv65Uwf+Kff2UXT47FENgP3nJ2aOGqBqcLPtmpK6ttDcX
        FSMkoPEaWuAh6TO3UX4FnyM=
X-Google-Smtp-Source: ADUXVKJgvBcFHHmCvFpo1u/3Vz7y0fadXVjhzVIUefU3UvccpwhVuHVZYxLzcrwPuKrP25ws6I5yeg==
X-Received: by 2002:a1c:3504:: with SMTP id c4-v6mr4410673wma.59.1529578573346;
        Thu, 21 Jun 2018 03:56:13 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v10-v6sm6305931wrn.97.2018.06.21.03.56.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 03:56:12 -0700 (PDT)
Date:   Thu, 21 Jun 2018 12:56:10 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Hellstrom <thellstrom@vmware.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-graphics-maintainer@vmware.com, pv-drivers@vmware.com,
        Jonathan Corbet <corbet@lwn.net>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v4 0/4] locking,drm: Fix ww mutex naming / algorithm
 inconsistency
Message-ID: <20180621105610.GA28688@gmail.com>
References: <20180619082445.11062-1-thellstrom@vmware.com>
 <20180619094554.GM2458@hirez.programming.kicks-ass.net>
 <f07c53d9-a22e-41c9-59a4-71ef6f7d96bb@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f07c53d9-a22e-41c9-59a4-71ef6f7d96bb@vmware.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Hellstrom <thellstrom@vmware.com> wrote:

> On 06/19/2018 11:45 AM, Peter Zijlstra wrote:
> > I suspect you want this through the DRM tree? Ingo are you OK with that?
> 
> 
> Yes, I can ask Dave to pull this. Ingo?

Sure, no problem if it's tested and all:

  Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
