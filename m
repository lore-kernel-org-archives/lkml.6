Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3560CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CB820870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="gdPVx15h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387862AbfAKSMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:12:41 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46420 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbfAKSMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:12:40 -0500
Received: by mail-qt1-f196.google.com with SMTP id y20so19781753qtm.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 10:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/faNOUmzdO023/qiPPvya8217BgcMHSLrRb/VXt8ZY4=;
        b=gdPVx15hHseBGGCZOUdjz0yeoaTlruoMNKfOAXWY+xRYvGd7sRhEtmR7NS9tSXFIkj
         qf3QC6D3nDGGG2IrhJ6aZ3noFrzA0/Svo5blkzb1wp6ll6CEhfYFrkDwibLKmaIPuSid
         LMoTLg9abUVZpSPA/6aGZHe+RovRlwueS0WT2cytsnIqjsbyG/j1ZIF46qiOs3UbbxJl
         3W27aMYcQ0z+X1ZchE5F5M5c9D0DQUnt37Lq9Q5RUPjcbBdQDiatVqfLmvs0vnwr6puL
         sKDfG2LTl3NWbJW+f4ifsBf8sKNLw1kHHeSA2fPNUA/BoU/eVwzedJ1vKWHB0pmp+K5G
         M4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/faNOUmzdO023/qiPPvya8217BgcMHSLrRb/VXt8ZY4=;
        b=sYiI5A7A3jl+/3Yf8SENVYVURKVD/VdvTkm8/vGv9tGI6D6u1bcyda4U7hK/VObqD8
         4Di9fR6wULq2CeNrJlYdJUvtTgClbmd7F1LoSlKeXUxBVK4ElPavyJgNu76yUgg4aODj
         q9GwZXpjRdJ15FyZF9nFtbhyI3asGGoJLmV+Xsk+Ecgng3UG9w4OE9PzvXP6URpRaClD
         NHguv8uL6IRFQyL7bOasMcs4cAlivJ7rhd0GjHmYR/6QcrwLhogJYOWMo5LHfyXogMwV
         b2+lamGEcVK4YnzIw/8K4g0z1Q3hc9UlDQqoiAnpQl14wn8AZIis65WgZdjvrw1NZLmv
         nt5w==
X-Gm-Message-State: AJcUukeb8oYBQ7r7WnVorRqwhFI6iZBV/CnvjEVvQwbjo0+dCf1JvgXa
        JcTCm8/lH5UYA4lSq6hYWLZRoQ==
X-Google-Smtp-Source: ALg8bN49eg+xjlGxb/eQ3GdLrp3F1VZNrPjZ9Uz2+2vzzBiQrfxejzlh48d2ckGvBkfT+WoaPRtvBQ==
X-Received: by 2002:aed:26e1:: with SMTP id q88mr14659000qtd.148.1547230358612;
        Fri, 11 Jan 2019 10:12:38 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w52sm47628307qtc.51.2019.01.11.10.12.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 10:12:38 -0800 (PST)
Message-ID: <1547230356.6911.23.camel@lca.pw>
Subject: Re: [PATCH] rbtree: fix the red root
From:   Qian Cai <cai@lca.pw>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, esploit@protonmail.ch,
        jejb@linux.ibm.com, dgilbert@interlog.com,
        martin.petersen@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, walken@google.com,
        David.Woodhouse@intel.com
Date:   Fri, 11 Jan 2019 13:12:36 -0500
In-Reply-To: <20190111173132.GH6310@bombadil.infradead.org>
References: <YrcPMrGmYbPe_xgNEV6Q0jqc5XuPYmL2AFSyeNmg1gW531bgZnBGfEUK5_ktqDBaNW37b-NP2VXvlliM7_PsBRhSfB649MaW1Ne7zT9lHc=@protonmail.ch>
         <20190111165145.23628-1-cai@lca.pw>
         <20190111173132.GH6310@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-11 at 09:31 -0800, Matthew Wilcox wrote:
> On Fri, Jan 11, 2019 at 11:51:45AM -0500, Qian Cai wrote:
> > Reported-by: Esme <esploit@protonmail.ch>
> > Signed-off-by: Qian Cai <cai@lca.pw>
> 
> What change introduced this bug?  We need a Fixes: line so the stable
> people know how far to backport this fix.

It looks like,

Fixes: 6d58452dc06 (rbtree: adjust root color in rb_insert_color() only when
necessary)

where it no longer always paint the root as black.

Also, copying this fix for the original author and reviewer.

https://lore.kernel.org/lkml/20190111165145.23628-1-cai@lca.pw/
