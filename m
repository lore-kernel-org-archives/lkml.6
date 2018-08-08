Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4802CC46471
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07DB216F3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="juVwbzkz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07DB216F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbeHHC34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 22:29:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37465 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeHHC34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 22:29:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id n7-v6so204573pgq.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 17:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=dWyiKeJP09EBuoXptEr6ZWLui8tsXxPnjRQ5HLbTHWc=;
        b=juVwbzkzNUC7lT7rCZRdy7YUM97OOH3hf+bUlzuc2nVux81GwIqUjwOP13bIBAhcjC
         zM4PnnyMmeEjm0O+HYoVAODVcyO3/l+3WiAOeE0l0EGnWxNNiW8OHRSsmaiJbJrmA5sj
         NNO2beTTaKglQSgpUi3wViJ3lP66PVckKbSauh3GSJXUa/LMSGpXmnI9ukwpu5RcWXAH
         72GC+A3JV9jRD4WDFeE5CFkrhduKsayQXu6l0k1DE1kVpPcEt4of4RbOG79F8p+zWS8q
         C1THbir2+3xjW22hqq+Md4lmnUV0XpE4JOMoAFXhDJi4E5WgyJQOMyc/xML/vYUShBrr
         lnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=dWyiKeJP09EBuoXptEr6ZWLui8tsXxPnjRQ5HLbTHWc=;
        b=H0wG8aoNCclY3CG3dNtqWurbMsxyDbuuF/gagd2oiDYQWTWdISE1QuNOYNJEVKiPtu
         Ho68OWUKhFU0v/d92IgJgreEmj3K0BG6IcOUb6zyPVt61GPsElG6DEOno317I/VOemA2
         aTJuxObDLPkB4FVj1ZWjLmCRMdeQaZwX+6Mdi/Hmx020JxdqtBVex4SZpi3x9178IDTT
         PVROe/9ZHkqS4Jjxe3ANLLovE8cjSu1PqS22jcyCHEhARc2thqd8dpek7mJaxRVRkR36
         OL3o11vMPLHXg/XHGqsXCfuppQDfqNuY4lh3OvHC0CNuWCRssulrW/XaTs7bbk8KAP2A
         hXjw==
X-Gm-Message-State: AOUpUlHEiaHDMUYmpC0uZKjDhb4KE7iOApZNYm1Y8e0wGCf3iUEiEfGa
        0phbpksy+4ZGZgYXuMtsskjrWw==
X-Google-Smtp-Source: AA+uWPwamK2QjgGWpM5AB9E2swGwjzVQ/6CfODvB8n4DtwOceJig/edTU41UkO+nRukBMHSfgtUtmw==
X-Received: by 2002:a65:5803:: with SMTP id g3-v6mr424900pgr.117.1533687181565;
        Tue, 07 Aug 2018 17:13:01 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id z184-v6sm3536899pgd.83.2018.08.07.17.13.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 17:13:00 -0700 (PDT)
Date:   Tue, 7 Aug 2018 17:12:59 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Dennis Zhou <dennisszhou@gmail.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Lameter <cl@linux.com>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>, kernel-team@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2] proc: add percpu populated pages count to meminfo
In-Reply-To: <20180807184723.74919-1-dennisszhou@gmail.com>
Message-ID: <alpine.DEB.2.21.1808071712310.48479@chino.kir.corp.google.com>
References: <20180807184723.74919-1-dennisszhou@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Aug 2018, Dennis Zhou wrote:

> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> 
> Currently, percpu memory only exposes allocation and utilization
> information via debugfs. This more or less is only really useful for
> understanding the fragmentation and allocation information at a
> per-chunk level with a few global counters. This is also gated behind a
> config. BPF and cgroup, for example, have seen an increase use causing
> increased use of percpu memory. Let's make it easier for someone to
> identify how much memory is being used.
> 
> This patch adds the "Percpu" stat to meminfo to more easily look up how
> much percpu memory is in use. This number includes the cost for all
> allocated backing pages and not just isnight at the a unit, per chunk
> level. Metadata is excluded. I think excluding metadata is fair because
> the backing memory scales with the numbere of cpus and can quickly
> outweigh the metadata. It also makes this calculation light.
> 
> Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>

Acked-by: David Rientjes <rientjes@google.com>
