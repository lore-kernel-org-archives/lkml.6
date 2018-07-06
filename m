Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C62C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C3022BEA
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="xNp+tJ2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C3022BEA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754300AbeGFVi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:38:26 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:43832 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753956AbeGFViY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:38:24 -0400
Received: by mail-qt0-f195.google.com with SMTP id f18-v6so11104884qtp.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 14:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=ma+0xKX+tdd8ql1mVgBDcmFuEzBsUagY2yCqpkHo8sU=;
        b=xNp+tJ2IjuASUcJqO6p5zsO8ocPxhXG4JLubXgpyCzUsveAdm7u2fBPuOuv/eq6ffp
         fa45sbpmqm8wEqnrwaboRhWwrcb1GOBWminEk9htqcm1xi0Ub4vObJxR8sy115dJ/RWJ
         eXFOdG7qthXcCOJUjx5HhtWYhYqHBCV+8/4Uvuef2vfhDxe7XtVxkhNpLG2pxJFx3Pt2
         xBJYU90t/FCdnah+0oyu6fKXBVlE//3+7RMYHvtptLf+/MKceAdakjJCVNUF6E5Gy3/w
         Yv2fDdtAYqqyj2kJk6wncZ4fWatUKh5KH0kevaFrzMPoT2vu9IDz5nR/2yPykp938JKa
         q5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=ma+0xKX+tdd8ql1mVgBDcmFuEzBsUagY2yCqpkHo8sU=;
        b=qc4CUCnhdnpr8Jhm/EzcCdreIIGlIUUiaKb83VUzZLVvrTplXBQyquSsZ6ehceNwfZ
         PGtXOCotLAf+X6Ap0lW+zxky0YFyEzKKN3YWdwV88otOChFcoWpTMB+KNy8OtV+LBw4t
         JeBQgJOY9OafyL7YnT1UkQpQ8ABAIvbGUw9a+M4Gfwa+oY0rL0olszeRwOQTMClifqOW
         DWEKw6w6JhJ4gMeeAQH3KS3DQMggSuSsq3EnCMtvzFVB3/YTTXOIY13G8L3pRF5RFehh
         ENIt6QyozotMGrGL38WGyoNLqXRIDGYsMlU/a3FzubEPmpo/tYNBLPnGFYfOWN+RnY/c
         pSrQ==
X-Gm-Message-State: APt69E0IactZUbEoS59Hl0NX/RSA9oZR0DwlI5Kwh4WvqeYR0hVp9fSb
        4nyeJB92hPrZui0bAMzfF3EI7A==
X-Google-Smtp-Source: AAOMgpeQF6KvRKOH9LIEfdxD3SXXzeQ2TsBLgcsQoP8JxR9aSVC/71q/B9ViOyYA2cFWU0oiRpVlPQ==
X-Received: by 2002:a0c:af04:: with SMTP id i4-v6mr10317480qvc.125.1530913103756;
        Fri, 06 Jul 2018 14:38:23 -0700 (PDT)
Received: from cakuba.netronome.com ([75.53.12.129])
        by smtp.gmail.com with ESMTPSA id a127-v6sm5874977qkd.9.2018.07.06.14.38.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 14:38:23 -0700 (PDT)
Date:   Fri, 6 Jul 2018 14:38:20 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v3 bpf-next 3/3] bpftool: add bash completion for cgroup
 tree command
Message-ID: <20180706143820.639b2548@cakuba.netronome.com>
In-Reply-To: <20180706212816.3760-3-guro@fb.com>
References: <20180706212816.3760-1-guro@fb.com>
        <20180706212816.3760-3-guro@fb.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2018 14:28:16 -0700, Roman Gushchin wrote:
> This commit adds a bash completion to the bpftool cgroup tree
> command.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
> Cc: Quentin Monnet <quentin.monnet@netronome.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Alexei Starovoitov <ast@kernel.org>

Looks good! :)

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
