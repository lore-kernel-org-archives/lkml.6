Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACADC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987972156D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhrKChJJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 987972156D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbeI1RDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 13:03:38 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:42134 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbeI1RDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 13:03:38 -0400
Received: by mail-pf1-f178.google.com with SMTP id l9-v6so4039255pff.9;
        Fri, 28 Sep 2018 03:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z8YzNTWiLYPYiPw3s1OfD/yz6IlyUQ2GW/SWdFqwyzI=;
        b=VhrKChJJVKtSriC7KUsgyJF97nmghMQrgarhRc4HblnN9rYKsLg9ARfmkVpqkl/lN/
         LT/aIIOUlZgJG294a+LL1NjbzVbOAn2s2+KPtZxV9xT1v+5e2EoFK7OramijXsaabbLP
         jBFpTZNP24w4LKrLbIKL3dmHN+Ktc+LbwXRWGwUv6tJtIVQPrCuTGLgqZM0dul5Kj81c
         pkpom1PLy67K/dmtmyBuogbcj2He9nk9wT28FRc1HlRKXn676k0PIo7+yCen28/TvvD0
         /Dmy/2EEppEo5G97h+nq1g7cwIOB9rJ1GJAc26cgh3gZ4QBu18r0++Nq7Slvf7rx4lK5
         wOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z8YzNTWiLYPYiPw3s1OfD/yz6IlyUQ2GW/SWdFqwyzI=;
        b=fCv3NOkktPuQWRrC9YJ6ca1Onoa1n9x5k8M9Tws1oazkoGV6tGwqlIVPPy0ca8eNMW
         NVsqKPCmiZ/Q6lwBMNwIA1IgxwjYpP3GNLmLYgzrOJ4IIJdM7kKUx7TNumO+jfMPR5Vt
         /9/po9KY43nn25BoB4lmROH403FS0J+TMcAi+kRHo2LGq40R57e6UocQc7ayxiKTwJsr
         LplNTiRTfUh5VoPVeCT1yynUHa0nEZiy1RxxLJZA/Vqum5Q3KJRQmiFUzU9z7m1PiOh5
         of+L5zQ/dg1mQK8G1nG7k4fIrLs5UplwmdsWyHGFl9oRjUmzWmsyv+6ZUdWUC4axYdaM
         a2ZA==
X-Gm-Message-State: ABuFfohg4hgum+bk0YP+Ex8shGkeLZ79FsOk6q93Oz22Batrhl82QHbh
        /OTYcpTIYlpqL2v+rraA9dM=
X-Google-Smtp-Source: ACcGV60abqYQJPGL6qXnlofXPiXwUSjaeQ/NTkUl+Xq7r6TULxqjs6fEDTL9UjLlS+tFRQLNMrXVPA==
X-Received: by 2002:a17:902:bcc3:: with SMTP id o3-v6mr15925039pls.202.1538131228645;
        Fri, 28 Sep 2018 03:40:28 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:5ff1])
        by smtp.gmail.com with ESMTPSA id y19-v6sm10325060pff.14.2018.09.28.03.40.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 03:40:27 -0700 (PDT)
Date:   Fri, 28 Sep 2018 12:40:17 +0200
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     netdev@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v3 bpf-next 10/10] selftests/bpf: cgroup local
 storage-based network counters
Message-ID: <20180928104014.mhq7kgyle53wqgao@ast-mbp.dhcp.thefacebook.com>
References: <20180926113326.29069-1-guro@fb.com>
 <20180926113326.29069-11-guro@fb.com>
 <20180928085356.56xe7javtd6cdfz6@ast-mbp.dhcp.thefacebook.com>
 <20180928100817.GC9018@castle.DHCP.thefacebook.com>
 <20180928102814.voj6bsuslxh6ms37@ast-mbp.dhcp.thefacebook.com>
 <20180928103717.GA12917@castle.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928103717.GA12917@castle.DHCP.thefacebook.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 11:37:26AM +0100, Roman Gushchin wrote:
> > > > > +
> > > > > +	/* Let's check that bytes counter value is reasonable */
> > > > > +	if (netcnt.bytes < packets * 500 || netcnt.bytes > packets * 1500) {
> > > > 
> > > > since packet count is accurate why byte count would vary ?
> > > 
> > > Tbh I'm not sure if the size of the packet here can vary depending
> > > on the environment. Is there a nice way to get the expected size?
> > 
> > ping packets should be fixed size depending on v4 vs v6.
> > If 'ping -6' is used, it will force ipv6.
> > 
> 
> Are we ok to screw up kselftests on v4-only machines?

we already did. Some of the selftests/bpf use ping -6 already.

