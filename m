Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B15C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05201208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="HmgHCSMF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05201208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbeGaCXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 22:23:13 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36458 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeGaCXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 22:23:12 -0400
Received: by mail-qk0-f196.google.com with SMTP id a132-v6so9141243qkg.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 17:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=tmw/T5rJ4fdzeuEmqCo+m6/mENG3MXY4i+hJcK7k80k=;
        b=HmgHCSMF9ngA21Kdsf81IJAM+jdGcOvOkL+NpcXFVryk0lxwkGoEoZImvjSrPRh6BN
         FXwzEw94DqDS0Y7Ktnf3QzGeMybpLLFMQiwbbZ+It27N/VedTmJ1eZl0CnpwRDXKR3zb
         wzSfnsn2XYXbJct40ADo/iEVUyr6L9Z56GVMgFzTm32QidiugGlG2V4IPBmGaL6ozkep
         q8cs/AGHBvmH8G1BsXSgsC0f9UQxVxGcDjAN+j7yuZkOgXNUrgLWfi9YsjPt2cMWo3HQ
         02SZMM/QJKGvg+uUx8YhbF/u0iNlfj6/oi4K6YEH/a0eb9MVTmVUageKoynsrMBA7a3q
         17TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=tmw/T5rJ4fdzeuEmqCo+m6/mENG3MXY4i+hJcK7k80k=;
        b=j6j73nkP6kYbn5W7aTWU3qsW9B7p1xL2Jbf5oDY5+ic2NG7qR247g4n9IOFcBnXwnS
         lRn6h3toEaAy2dzMzX5wPuiLxfpHiYsU0l33yzRkl2dKAzp2rmpfxg04UhVAP0785Zbg
         VoujgGsZIHIBDsxuYsVfEMJbtjeGORE23QkflWKunpxx7dgiEVm4AH41yt23lfEQahVx
         4bWUSrgBOS3DJ9/j9OCZi2doLQE4J4dO/z5zyaczwUEZTqPwyqAcer2t7DAUCNE1EPr4
         xQs0kioIfgr8xin1knYK4E8vIwLuj4ZZw0Tclw7sUa1h/h17W/QHJeEjCBv4lI84a5zt
         WB8A==
X-Gm-Message-State: AOUpUlFbQ6Jd/dR1ljCtz7gN4DT9kz1OtmnudmDwk8wu86LI+L2kG8WK
        mVcsUIRB46MBK3dmLLGR6qnPzQ==
X-Google-Smtp-Source: AAOMgpcqDNT5fq87gmsAwruyFQUnBBeazK7eEESk9qGkyNAZXwh4oTb3MJVKZKDqjVXqAFZ8oI7uxA==
X-Received: by 2002:a37:b445:: with SMTP id d66-v6mr17500378qkf.357.1532997937144;
        Mon, 30 Jul 2018 17:45:37 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id j45-v6sm11075834qta.46.2018.07.30.17.45.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 17:45:37 -0700 (PDT)
Date:   Mon, 30 Jul 2018 17:45:32 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Daniel Colascione <dancol@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Joel Fernandes <joelaf@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Chenbo Feng <fengc@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <ast@fb.com>
Subject: Re: [PATCH v3] Add BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES bpf(2)
 command
Message-ID: <20180730174532.20010e0d@cakuba.netronome.com>
In-Reply-To: <CAKOZuesNnY8oKimMk+gnUppMgZt92F+razSZCSfHu=xfq+snGg@mail.gmail.com>
References: <CAKOZuesQ6GdNTGDFsNi4o8LYzxLBtYZ=Cz4=aZbqqCNia+QFnQ@mail.gmail.com>
        <20180729205835.34850-1-dancol@google.com>
        <e8f6e709-e694-ddad-b61e-d2ce1598dff3@iogearbox.net>
        <CAKOZuesH_LRdt15aXaRQRPSNzN-URTQWgSgr0zLsv8ZKFU9=9Q@mail.gmail.com>
        <20180730172641.7d516231@cakuba.netronome.com>
        <CAKOZuesNnY8oKimMk+gnUppMgZt92F+razSZCSfHu=xfq+snGg@mail.gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jul 2018 17:33:39 -0700, Daniel Colascione wrote:
> On Mon, Jul 30, 2018 at 5:26 PM, Jakub Kicinski wrote:
> > On Mon, 30 Jul 2018 03:25:43 -0700, Daniel Colascione wrote:  
> > > On Mon, Jul 30, 2018 at 3:04 AM, Daniel Borkmann <daniel@iogearbox.net> wrote:  
> > > > Hmm, I don't think such UAPI as above is future-proof. In case we would want
> > > > a similar mechanism in future for other maps, we would need a whole new bpf
> > > > command or reuse BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES as a workaround though
> > > > the underlying map may not even be a map-to-map. Additionally, we don't have
> > > > any map object at hand in the above, so we couldn't make any finer grained
> > > > decisions either. Something like below would be more suitable and leaves room
> > > > for extending this further in future.  
> > >
> > > YAGNI.  Your proposed mechanism doesn't add anything under the current
> > > implementation.  
> >
> > FWIW in case of HW offload targeting a particular map may allow users
> > to avoid a potentially slow sync with all the devices on the system.  
> 
> Sure. But such a thing doesn't exist right now (right?), and we can
> add that more-efficient-in-that-one-case BPF interface when it lands.
> I'd rather keep things simple for now.

You mean map-in-map offload doesn't exist today?  True, but it's on the
roadmap for Netronome.

Tangentially it would be really useful for us to have a "the map has
actually been freed" notification/barrier.  We have complaints of users
creating huge maps and then trying to free and recreate them quickly,
and the creation part failing with -ENOMEM, because the free from a
workqueue didn't run, yet :(  It'd probably require a different API to
solve than what's discussed here, but since we're talking about syncing
things I thought I'd put it out there...
