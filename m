Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0A2C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F13620658
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F13620658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbeH3AdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:33:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33044 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbeH3AdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:33:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id v90-v6so6029946wrc.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 13:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5KdLqEy/lMlUJABiqnnQ+7Qa0Gbn0qySS//fRdbw8zM=;
        b=j7OQ/n7mvBK8I3jpZr9PX4Y1G+fyc9Z39ufKrxnZRf5JrOAdu96VnuJurklD5KCaaN
         j5qk2VbBJMxunOuQa70Jcd46o3/290AcD8Rb0QGoO1bA+XBxoGI7hGDKjXQwvpGQNdJq
         mer39MQO+7lHQVuFvBM+TytYSJAhWpWwcnZkLzxsurVbaLXMB2RkAclzYHv/kLAlTju5
         bUXDF3AlJE8nKRXpdyPybFp+liRkYAGMwImrLplRFGp0Hv0sUo+42klRls3vrehn8TJu
         DGuu1wOwvgMwRLi4o9+99qW8sPutAJ9BNhjdVBoM1/NboB89ZmUoEtFgpOfLzxr33EKg
         t2uA==
X-Gm-Message-State: APzg51AJqDa2gIv09XezY7yyRLF3HC8dI3Uuuw//POO4c8aa5FRRi6zG
        kMu/RJv13io0NShpcPqxnOo=
X-Google-Smtp-Source: ANB0VdYNDX/C18GKNqwuNCSthsd1ubReGIhx+FbzpINurJPZ0uVoQVUoLshe4l0ydRCyCL23/eTGwQ==
X-Received: by 2002:adf:e1c5:: with SMTP id l5-v6mr5448698wri.36.1535574873993;
        Wed, 29 Aug 2018 13:34:33 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id j16-v6sm3439345wmc.25.2018.08.29.13.34.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 13:34:33 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 6E908124C52; Wed, 29 Aug 2018 22:34:32 +0200 (CEST)
Date:   Wed, 29 Aug 2018 22:34:32 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     mhocko@suse.com, vbabka@suse.cz, Pavel.Tatashin@microsoft.com,
        sfr@canb.auug.org.au, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
        Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: Re: [PATCH] mm/page_alloc: Clean up check_for_memory
Message-ID: <20180829203432.GA24978@techadventures.net>
References: <20180828210158.4617-1-osalvador@techadventures.net>
 <20180828143530.4b681bf9e0b3c03519fbe943@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828143530.4b681bf9e0b3c03519fbe943@linux-foundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 02:35:30PM -0700, Andrew Morton wrote:
> > First, we should only set N_HIGH_MEMORY in case we have
> > CONFIG_HIGHMEM.
> 
> Why?  Just a teeny optimization?

Hi Andrew,

Optimization was not really my point here, my point was to make
the code less subtle and more clear.
One may wonder why we set N_HIGH_MEMORY unconditionally when
__only__ CONFIG_HIGHMEM matters for this case, and why we set 
N_NORMAL_MEMORY __only__ for CONFIG_HIGHMEM when we should not care
about that at all.

I do not really expect a big impact here, mainly because check_for_memory
is only being used during boot.

-- 
Oscar Salvador
SUSE L3
