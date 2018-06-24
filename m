Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43265C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 07:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A0C24DF9
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 07:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQ04Bd70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A0C24DF9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751899AbeFXHNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 03:13:48 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37874 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751689AbeFXHNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 03:13:47 -0400
Received: by mail-wm0-f67.google.com with SMTP id r125-v6so6651004wmg.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 00:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NJQG1XmEjzjlWJG8Q2YEv5a9r2hgwOWk3cmc0jQR67E=;
        b=cQ04Bd7035uPL+Q0XM7jyXaMXuB56aPZcrz4u9rnlejNii9zw1/ioxPbnwwn5thKTK
         qvLMVmISbqzrk64vlMywsJ8cxwmaSunw411xPIeTYRyAfGPR4S7oO39xRoCEiu7z8PGA
         j5szpCYiGVzA1q2RDfik+OT6RS4lIKtiVH+rKdXV7RlqmfsKCBOLN2jHUA0qCFKeC7ou
         OdgRiGGJTA9DYQCX4m4D07DmzimapCSvUn1wNrxIj1NckBN4rsNHXnGjy9WUHOVh0kZn
         1QYekCQUR+4pbi1IdUi/wPSIqoepy8XSDxzcQXNnuj7qGBHmeSX07kr+JWVNamaf1A6I
         piRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NJQG1XmEjzjlWJG8Q2YEv5a9r2hgwOWk3cmc0jQR67E=;
        b=VoCKl1Q737ofx9zzCmBlDdxwJhboxzvjpIkQBN9AE3pwd4YOSBjzpx67d2KZCdkQj6
         4qyh1UW2nL4weUbUv6U6KP43MIChhll1E7/gwMofFqQV4klqzsR5qdTnCdMyd9QP50rs
         vUduSq9uuuLwc4y+2vdC4jwvXSzg8fKEAa0lLuzeo88klNvX7+i/ptQh0Voz8lSTu+3s
         tK3hRc8XZB0gmKkLGZm82++D42sFOysR2BLtvzn8+cdq6fHGlXTkasXeHIHVt50+YNjQ
         k3AbsuFOgBJw8sKib+RXQyCYbj9b7YvvEAMMjyglckePFdGQKzXf69pBFN5LG1oLt4oW
         vsDw==
X-Gm-Message-State: APt69E1Mt8IccESlpXXw2+uFxR374eFEhDIXww8Ni8rOi0PzMVXaNCaa
        v+vWWY++AjbFCAGtFVzbM/Q=
X-Google-Smtp-Source: ADUXVKLbemzX09zjRGc6oYGuEmdcN6wMQ8PUl5Xpb0mCQ8Rl3aDWK1p2f/rYZolSyyim866ScF81SA==
X-Received: by 2002:a1c:8fd5:: with SMTP id r204-v6mr6488499wmd.77.1529824426256;
        Sun, 24 Jun 2018 00:13:46 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id m10-v6sm15237225wrq.56.2018.06.24.00.13.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Jun 2018 00:13:45 -0700 (PDT)
Date:   Sun, 24 Jun 2018 09:13:43 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, lcapitulino@redhat.com,
        keescook@chromium.org, tglx@linutronix.de, x86@kernel.org,
        hpa@zytor.com, fanc.fnst@cn.fujitsu.com, yasu.isimatu@gmail.com,
        indou.takao@jp.fujitsu.com, douly.fnst@cn.fujitsu.com
Subject: Re: [PATCH 1/2] x86/boot/KASLR: Add two functions for 1GB huge pages
 handling
Message-ID: <20180624071343.GC29407@gmail.com>
References: <20180516100532.14083-1-bhe@redhat.com>
 <20180516100532.14083-2-bhe@redhat.com>
 <20180621150111.GA23607@gmail.com>
 <20180622121445.GP29979@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622121445.GP29979@MiWiFi-R3L-srv>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Baoquan He <bhe@redhat.com> wrote:

> On 06/21/18 at 05:01pm, Ingo Molnar wrote:
> > 
> > * Baoquan He <bhe@redhat.com> wrote:
> > 
> > > +/* Store the number of 1GB huge pages which user specified.*/
> > > +static unsigned long max_gb_huge_pages;
> > > +
> > > +static int parse_gb_huge_pages(char *param, char* val)
> > > +{
> > > +	char *p;
> > > +	u64 mem_size;
> > > +	static bool gbpage_sz = false;
> > > +
> > > +	if (!strcmp(param, "hugepagesz")) {
> > > +		p = val;
> > > +		mem_size = memparse(p, &p);
> > > +		if (mem_size == PUD_SIZE) {
> > > +			if (gbpage_sz)
> > > +				warn("Repeadly set hugeTLB page size of 1G!\n");
> > > +			gbpage_sz = true;
> > > +		} else
> > > +			gbpage_sz = false;
> > > +	} else if (!strcmp(param, "hugepages") && gbpage_sz) {
> > > +		p = val;
> > > +		max_gb_huge_pages = simple_strtoull(p, &p, 0);
> > > +		debug_putaddr(max_gb_huge_pages);
> > > +	}
> > > +}
> > 
> > This function has at least one style problem and one typo.
> > 
> > Also, we don't put statics in the middle of function variable blocks.
> > 
> 
> Sorry, I will check all of them carefully and repost according to your
> comments.

Thanks!

	Ingo
