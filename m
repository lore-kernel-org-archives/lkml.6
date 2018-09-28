Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B63C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A315A21748
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s5puFnFZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A315A21748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbeI1Qve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 12:51:34 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:39607 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729116AbeI1Qve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 12:51:34 -0400
Received: by mail-pf1-f171.google.com with SMTP id j8-v6so4040180pff.6;
        Fri, 28 Sep 2018 03:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qbq/X7eoo9EJZNyBJkEgxVflsqzIG0hZc1qxAvp3PDs=;
        b=s5puFnFZsVMUiL9KOYiX50rQUwlkVwoeTn3yxKJwZKBm04LknxAo0bR8njlnnhf+7Z
         9M+ns17YAm5wat27XuGjmzjj5txhD4jZbMlAJ0I9FKm4ceuqO1EgQT37+ypm6QVGkJMb
         O6X+VsJcAXwjc0tTUH7OLVFCw1A/HUrTSoli9Q12V2dSMl5CxJHBg7GkIQKar7DiUdA+
         0rUVacZHqGO4e4Zbvrla+2j5swY1m7yAPk176z/ILMO9tzY84OPBY0q7GDJdAzHmHcX/
         KvOvU1Z7XKJBLPV4AeCYi/K8GiPQNNaXjtb1BatMldizsI2MH/ljSpAm1osRJ4E/nuti
         hWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qbq/X7eoo9EJZNyBJkEgxVflsqzIG0hZc1qxAvp3PDs=;
        b=Msb7QLlZVzFwBMnTnlyhQv3SMDz+4g0er4T/kjP5Y2PRFfh7km6mWNsETsiWyoq8mL
         AEpPm202BrBEHfNVcC8b3TmKzOjRwKv8FtSlp9QHN2hbfigwcR6h+uvT1g9Ie4BRlOg2
         3jBiS9AwFhy+f4Q/OzSTTrf0SbXCL5683VWUKxO/7lvxPGZlE+EbLelOT++mXqTqq8LJ
         TD4M/9cS9bogdPapSkBRbZRFZ/rA5oHi9S0z5d7OwESlMGZ7kbD7Kwe7y9vZ713L784j
         ukoiXnYc5LVIPawh72kO1bDPm3CcPW+/DnsAAkVLuwWYpcs3n04Z60JdebOl/MkbaULj
         +63g==
X-Gm-Message-State: ABuFfojIx+wRQFATOo93rrsfvzqEMHW9/xyfhWoZadDVD3avxf4zLD1W
        xrGumY4M8ochZQrgpej65oQ=
X-Google-Smtp-Source: ACcGV60SNHMkR8sfyxlTFJSjrlrXBo1diyEdKgulqYdXYuNn8OozaUqqV05BiX0JGvYcTtHIBrV3ww==
X-Received: by 2002:a17:902:6843:: with SMTP id f3-v6mr5410462pln.64.1538130507544;
        Fri, 28 Sep 2018 03:28:27 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:5ff1])
        by smtp.gmail.com with ESMTPSA id v8-v6sm6560412pfl.6.2018.09.28.03.28.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 03:28:26 -0700 (PDT)
Date:   Fri, 28 Sep 2018 12:28:16 +0200
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     netdev@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v3 bpf-next 10/10] selftests/bpf: cgroup local
 storage-based network counters
Message-ID: <20180928102814.voj6bsuslxh6ms37@ast-mbp.dhcp.thefacebook.com>
References: <20180926113326.29069-1-guro@fb.com>
 <20180926113326.29069-11-guro@fb.com>
 <20180928085356.56xe7javtd6cdfz6@ast-mbp.dhcp.thefacebook.com>
 <20180928100817.GC9018@castle.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928100817.GC9018@castle.DHCP.thefacebook.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 11:08:29AM +0100, Roman Gushchin wrote:
> > > +	/* Some packets can be still in per-cpu cache, but not more than
> > > +	 * MAX_PERCPU_PACKETS.
> > > +	 */
> > > +	packets = netcnt.packets;
> > > +	for (cpu = 0; cpu < nproc; cpu++) {
> > > +		if (percpu_netcnt[cpu].packets > 32) {
> > 
> > pls use MAX_PERCPU_PACKETS in the above check.
> > could you also double check that if that #define is changed to 1k or so
> > the exact "!= 10000" check below still works as expected?
> 
> Do you mean adding a new test with a different MAX_PERCPU_PACKETS?

good idea! If it's easy to compile the same source twice with different
MAX_PERCPU_PACKETS that would certainly make the test stronger.
Not sure how feasible though.

> 
> > 
> > > +			printf("Unexpected percpu value: %llu\n",
> > > +			       percpu_netcnt[cpu].packets);
> > > +			goto err;
> > 
> > > +		}
> > > +
> > > +		packets += percpu_netcnt[cpu].packets;
> > > +	}
> > > +
> > > +	/* No packets should be lost */
> > > +	if (packets != 10000) {
> > > +		printf("Unexpected packet count: %lu\n", packets);
> > > +		goto err;
> > > +	}
> > > +
> > > +	/* Let's check that bytes counter value is reasonable */
> > > +	if (netcnt.bytes < packets * 500 || netcnt.bytes > packets * 1500) {
> > 
> > since packet count is accurate why byte count would vary ?
> 
> Tbh I'm not sure if the size of the packet here can vary depending
> on the environment. Is there a nice way to get the expected size?

ping packets should be fixed size depending on v4 vs v6.
If 'ping -6' is used, it will force ipv6.

