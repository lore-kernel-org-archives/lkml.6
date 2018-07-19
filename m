Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C826C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77962084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="x6Su2GdQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C77962084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731485AbeGSM6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 08:58:44 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:38894 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731154AbeGSM6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 08:58:44 -0400
Received: by mail-qt0-f193.google.com with SMTP id y19-v6so6925166qto.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 05:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N3oEpLPHTXz9ks1wW/amyWMiqmFylX3q9a6y6+vx0RY=;
        b=x6Su2GdQE0Vmnu8c4Qjav5ztHBlJEm7lqyzo1kAUzQt0MUBOlziFrRJpQ0yjPnk/Pk
         okAUXRQxXRs8afsOcPPKuVCAWmlpUzARpfrbn0PDs2qKTzGEDZpWvbgAP1J78AXIsd9N
         y7ydh136JnuDlU1Z2wlfPqSyOrUZf9542fhpNoWjcbX1WRiYQTzX1H7+7CuUvfoB5I0H
         rv+HmeQ/+O1TljaDks6sEGo5Zw3V4Bn46g189C/uJIpi3HmQhrQvEUBYmNB3Iszl1L4S
         HE2Lgb+8aMmX9S0DPOdWAnJ7XPUH2DIBGWBqGjM9W32o+6MCErgbGubcvBNFqzJi3w/k
         MKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N3oEpLPHTXz9ks1wW/amyWMiqmFylX3q9a6y6+vx0RY=;
        b=XYfRsiIjM3eTLTsdLcpAkHC4G62pHB64ZS8WJ9OBp63L+TiRYuTKGIVAMDxBKDuDKn
         e8ZBNM1DVsHS/9Wm5O+4n8P7lnqe+y2n1dHX8vHzaGm7p+ll07uOf2UWuapxkNUCY/gR
         f33AeB0cPrOVp/SPXTOXkmFZmYnFh8eq8pn+fz+UtzOjJFGSoVsZcW+4s+L8Wv59BjUP
         u/BZqWGtYBGdM8nTGf4pvMDAeEXfqiSqQJD6GTuCffqtu3+UdiJWjssMmJkTkxTA/nAw
         bBIPZhZRZNJoLoYiM21W6u6GPUNrQJlfHp6Vg12QjcWZ13j2STNtRqdDiLfM3mEdiTSZ
         DB4g==
X-Gm-Message-State: AOUpUlEBEbxOKeHFxkqflGfUHIp5VydZAa8w/fFeLSSlwtzzO+wvwCku
        i00ApmmkOqNe+XPJLR6Rju8OhQ==
X-Google-Smtp-Source: AAOMgpfYOMZGuMS6kK6wS4VMWzmz1lLgTroaGfi4axhMI1lS+6kVEVP5h9Td+vJ7LOKG+u3CEct6pw==
X-Received: by 2002:aed:39a3:: with SMTP id m32-v6mr9581227qte.109.1532002550909;
        Thu, 19 Jul 2018 05:15:50 -0700 (PDT)
Received: from localhost (pool-96-246-38-36.nycmny.fios.verizon.net. [96.246.38.36])
        by smtp.gmail.com with ESMTPSA id l22-v6sm5779640qkh.72.2018.07.19.05.15.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 05:15:49 -0700 (PDT)
Date:   Thu, 19 Jul 2018 08:18:37 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     peter enderborg <peter.enderborg@sony.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Daniel Drake <drake@endlessm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux@endlessm.com,
        linux-block@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Mike Galbraith <efault@gmx.de>,
        Oliver Yang <yangoliver@me.com>,
        Shakeel Butt <shakeelb@google.com>,
        xxx xxx <x.qendo@gmail.com>,
        Taras Kondratiuk <takondra@cisco.com>,
        Daniel Walker <danielwa@cisco.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Ruslan Ruslichenko <rruslich@cisco.com>, kernel-team@fb.com
Subject: Re: [PATCH 0/10] psi: pressure stall information for CPU, memory,
 and IO v2
Message-ID: <20180719121837.GA13799@cmpxchg.org>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180716155745.10368-1-drake@endlessm.com>
 <20180717112515.GE7193@dhcp22.suse.cz>
 <20180718222157.GG2838@cmpxchg.org>
 <143db4db-2613-345d-9b8e-1794b6d8c4fe@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <143db4db-2613-345d-9b8e-1794b6d8c4fe@sony.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 01:29:39PM +0200, peter enderborg wrote:
> On 07/19/2018 12:21 AM, Johannes Weiner wrote:
> >
> > Yes, we currently use a userspace application that monitors pressure
> > and OOM kills (there is usually plenty of headroom left for a small
> > application to run by the time quality of service for most workloads
> > has already tanked to unacceptable levels). We want to eventually add
> > this back into the kernel with the appropriate configuration options
> > (pressure threshold value and sustained duration etc.)
> Is that the same application as googles lmkd for android? Any source
> that you might share?

Sure! This is the oomd we've been developing and using at Facebook:

	https://github.com/facebookincubator/oomd
