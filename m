Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D917ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2532075E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="husxZHEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2532075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbeGQVVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:21:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44462 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729730AbeGQVVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:21:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1-v6so942126pgp.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 13:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=K/5nX5Y1I6O8ODAQ+6ouL06rDh+T9EgNuRQIGdWXM8c=;
        b=husxZHEpNsrGj0vOOKliDb9Q2QlQAzZs48mGSOz1ys8fVXO+vjvFabiST6P9Dl4jb+
         BrfrF7Zr6snOPhYnzvEilO8nECuyw5XZafFqiurTdWmvOtc7qcoee5CBzHUiQkg8Yrn4
         ieisvHxNxobp7o/KQ8stJj725eY3iUuxefL2pHui+uSb2DXG59aqJOzpL+1qxb+CZT3J
         uhDFucUOdVUvC6aMuPWtP+FTHbPq8Is/TNdOU6tX8UkspBYv/PmmhfMEtXCVSPt88tnn
         96/egYbyuzs5npI/Re4djC1xBKlO1HWk0Xd0TL1kAUyQT4u8Urrn0dlqMV2UI/HHuaVe
         jvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=K/5nX5Y1I6O8ODAQ+6ouL06rDh+T9EgNuRQIGdWXM8c=;
        b=WZver3D9Cktw68ofFEpxZga339yLqlDpH+OLRaxzkAkVjZo9jZYWPYbsF7IiXBs5Mj
         KAYEoGYREMd094290OmTEB7Ei18WrUZSb1BLpuCP76Bsq8WjHlA0CDPyngdlUUx25jFy
         9BjF7dIER6B716JrUI/nBo6atzNQCZ7Qc1ON06BNsMD3dQ4fXUtsTeAFnGEiMf0k9h8A
         74bOkCqQRcNOoeQVED3a/W5LfK3KwSKH4hV0AwVruZ4k/p0M0NWsS65tbFUG2G84qRUY
         qceDO5qRdO5QlYY0VMWQIcoD0K6BB9F+tn/pXfnjVVLkwWRl0Y32XaN2u1JWHfxzGyhD
         C0JQ==
X-Gm-Message-State: AOUpUlGxoLHxzrBzMFQOGyEZ+jeRFBNPH996YhALqnYKKErd/na8DYj2
        nrrlhbLxkBnFXKEzfPlf0rGnn2HqmGI=
X-Google-Smtp-Source: AAOMgpct+o9BWwh2awbScDCzfI3S5Xi00PP06lmTKM+1JEQQ6aX6hbfS/4YdxDQucBeDgiNTViCikg==
X-Received: by 2002:a62:5a01:: with SMTP id o1-v6mr2292674pfb.0.1531860404960;
        Tue, 17 Jul 2018 13:46:44 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id r71-v6sm8190801pfg.43.2018.07.17.13.46.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 13:46:44 -0700 (PDT)
Date:   Tue, 17 Jul 2018 13:46:43 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Baoquan He <bhe@redhat.com>
cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: Deprecate kernelcore=nn and
 movable_core=
In-Reply-To: <20180717131837.18411-1-bhe@redhat.com>
Message-ID: <alpine.DEB.2.21.1807171344320.12251@chino.kir.corp.google.com>
References: <20180717131837.18411-1-bhe@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2018, Baoquan He wrote:

> We can still use 'kernelcore=mirror' or 'movable_node' for the usage
> of hotplug and movable zone. If somebody shows up with a valid usecase
> we can reconsider.
> 

We actively use kernelcore=n%, I had recently added support for the option 
in the first place in 4.17.  It's certainly not deprecated.

commit a5c6d6509342785bef53bf9508e1842b303f1878
Author: David Rientjes <rientjes@google.com>
Date:   Thu Apr 5 16:23:09 2018 -0700

    mm, page_alloc: extend kernelcore and movablecore for percent
