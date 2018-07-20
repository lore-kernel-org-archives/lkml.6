Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BCFECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 22:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E936720671
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 22:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kAnm1VGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E936720671
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbeGTXKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 19:10:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40313 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbeGTXKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 19:10:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id e13-v6so129364pff.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 15:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Wrt6sDJAJhpOOl7QbXUyo2gRYC6wTC8TzRDILTARuwg=;
        b=kAnm1VGf9cuikItQHzQ7D+VIlTWXU8OcLBB56NUWGHIGNXjDp4yu1KQPmUKa+zejgC
         BNCE3NbKSWJwd4uP4jzd03LbXHbAD0JkNzOV7RGcNsqBj9CjmhC6AVTHChi8wJJAE/g0
         b0YCqPd68Up/edU8ydVNNn2FcsElcOO1fvA74NpyqMzN6jR8Q+zxdvsA0CDlBSL2VU3C
         NDWFThHri3oPNQM5/TSqCTxW4CbHxwvPco0UZLHfAVf3CAVKUx1Xn2wHJabtmRHbQaMF
         IICyrL+h+TzA83sub2zK4yNUuRsaC0isj5ntfX5NlITsgMhcGc5SI+tU0nN82uzFxIHz
         xTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Wrt6sDJAJhpOOl7QbXUyo2gRYC6wTC8TzRDILTARuwg=;
        b=PdxkGNlPuEW95SkmG5/csFPonArfesuZrou2xNtfgU4JgytvUOhAkfnqtxxgxdhaV6
         HR15ZltXt31vpuI+yWB2uYg4/7Usa4ZB6XrAbUQSiF6E4vVR8EpuBoxVfRTppDDRvtXb
         yXd4cTyKqWqRENVZLltrtwzdCOSkrI21y2h1gEX2WXuS06bTByeo4NfOQeKcwpwoSMwR
         r9Twl8F5iZjYPPEI0D3VhV9neKUXm3FlAoFTIvtEff2vmULxYSWDvyTeD5UDUK4RK6ES
         ErjLSzRKUd6YnKt7egM+ONocFslCJhSSKLFFzXCNzPXk0iOhRApKl0FEuTuEsXhprAj/
         Rycg==
X-Gm-Message-State: AOUpUlHtX5AnJQ/y6G4giPvp6BLJX69xBKqKVHNY29+BtXMSTYyLkSEo
        UZGgCO7KoU9r5sCRMos6/RGNJQ==
X-Google-Smtp-Source: AAOMgpf435m3PpNNKBjXMhurpSLMtf7SJPTLuhBRrHzqSoswvToyZFxOv4tX6rKKe4d6O90iWvp/GQ==
X-Received: by 2002:a62:1a4a:: with SMTP id a71-v6mr3885493pfa.190.1532125200304;
        Fri, 20 Jul 2018 15:20:00 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id t88-v6sm6159313pfg.10.2018.07.20.15.19.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 15:19:59 -0700 (PDT)
Date:   Fri, 20 Jul 2018 15:19:59 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch v3] mm, oom: fix unnecessary killing of additional
 processes
In-Reply-To: <569cf225-f1d3-f81b-5947-cff7bd21381f@i-love.sakura.ne.jp>
Message-ID: <alpine.DEB.2.21.1807201515180.38399@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1806211434420.51095@chino.kir.corp.google.com> <d19d44c3-c8cf-70a1-9b15-c98df233d5f0@i-love.sakura.ne.jp> <alpine.DEB.2.21.1807181317540.49359@chino.kir.corp.google.com> <a78fb992-ad59-0cdb-3c38-8284b2245f21@i-love.sakura.ne.jp>
 <alpine.DEB.2.21.1807200133310.119737@chino.kir.corp.google.com> <9ab77cc7-2167-0659-a2ad-9cec3b9440e9@i-love.sakura.ne.jp> <alpine.DEB.2.21.1807201315580.231119@chino.kir.corp.google.com> <569cf225-f1d3-f81b-5947-cff7bd21381f@i-love.sakura.ne.jp>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Jul 2018, Tetsuo Handa wrote:

> Why [PATCH 2/2] in https://marc.info/?l=linux-mm&m=153119509215026&w=4 does not
> solve your problem?
> 

Such an invasive patch, and completely rewrites the oom reaper.  I now 
fully understand your frustration with the cgroup aware oom killer being 
merged into -mm without any roadmap to actually being merged.  I agree 
with you that it should be dropped, not sure why it has not been since 
there is no active review on the proposed patchset from four months ago, 
posted twice, that fixes the issues with it, or those patches being merged 
so the damn thing can actually make progress.
