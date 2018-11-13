Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019D7C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 07:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F442245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 07:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J447sX7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F442245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731243AbeKMRqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 12:46:10 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46628 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbeKMRqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 12:46:10 -0500
Received: by mail-ed1-f65.google.com with SMTP id b34-v6so9525618ede.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 23:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kFyGLJGScux46tDAW2V2AI4YR5qEz1PlppR6tQG0R/E=;
        b=J447sX7fILPj0ow6TAwH84lT8CEeSJM9RkTYwgcnR9yF9OECOp7IVrEvinup3fIrPE
         jUJ+k/WvyZqb878crvhUOK8yiSC38f8IR605lsbhAfsTElD8hrhyPnWMjwkIc8Rf+RB+
         XaaN1I824YDeN9A9nu8omsHmqBxefvo7mbz8Om8C9M03/VRQI746xLx9IeDP3pNbYxK9
         I4dI++mdWiIWVLnxJABIppVZY+cTwX3HGj1pwKoOS9BwI7QLzn+Z8TWi8yROQiX5ESPj
         Pki6z3sZL7Qd8kaDiBt3TMqcxl5iaj3OsTdqYm3qvC2PGtoUpfz0u63mzCyQlwqIeccN
         RnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kFyGLJGScux46tDAW2V2AI4YR5qEz1PlppR6tQG0R/E=;
        b=KG4aApjk6CCCcYTQW4BQaO5S7v8c31q65Jox7fAXTxR6pHN53FZr7sy2jUF2v6bRjj
         yxdtZdXDq+kngrUUrqC363Po6nomBmabNjvpKvcCdsWY5nixiEesMsed5RAeISWH6UEt
         2qDEeotd4gyToajnjtdU0/RrlqNryyBAORe0x/kY01hkKMobq7uI71JCnEWCnExMYOEf
         orNGngIvWvXSO/bHmyp4eN4QNC2ueVwDEsQVWjhuxuhLMvDadw4u0CfZ/DBHqqrGgE0c
         Er9VmaRlp72m8a3wbR9pfNCBatNej51DI8aN1DdrCGFu1aloZ84yixVSFCSAO5gm+c/4
         zzug==
X-Gm-Message-State: AGRZ1gJt2/i032iPojxRoHMzlevk+MK4eTf0s9egH/u8Fch8UHOoS46n
        B3QEnfImk2TtbraZ+oCIa/4=
X-Google-Smtp-Source: AJdET5fs4S2XzMXJDjHpAh+dHmxYmyoNeUsjVuTtKNuy4R7yxDyDGWy5nLc5FJEaE560VV0bruKu4A==
X-Received: by 2002:a17:906:c44a:: with SMTP id ck10-v6mr11937884ejb.25.1542095355904;
        Mon, 12 Nov 2018 23:49:15 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id w26-v6sm2758513eja.75.2018.11.12.23.49.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 23:49:15 -0800 (PST)
Date:   Tue, 13 Nov 2018 07:49:14 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vmscan: return NODE_RECLAIM_NOSCAN in node_reclaim()
 when CONFIG_NUMA is n
Message-ID: <20181113074914.5kgiww44gpqit45y@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20181113041750.20784-1-richard.weiyang@gmail.com>
 <20181113053615.GJ21824@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113053615.GJ21824@bombadil.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 09:36:15PM -0800, Matthew Wilcox wrote:
>On Tue, Nov 13, 2018 at 12:17:50PM +0800, Wei Yang wrote:
>> Commit fa5e084e43eb ("vmscan: do not unconditionally treat zones that
>> fail zone_reclaim() as full") changed the return value of node_reclaim().
>> The original return value 0 means NODE_RECLAIM_SOME after this commit.
>> 
>> While the return value of node_reclaim() when CONFIG_NUMA is n is not
>> changed. This will leads to call zone_watermark_ok() again.
>> 
>> This patch fix the return value by adjusting to NODE_RECLAIM_NOSCAN. Since
>> it is not proper to include "mm/internal.h", just hard coded it.
>
>Since the return value is defined in mm/internal.h that means no code
>outside mm/ can call node_reclaim (nor should it).  So let's move both
>of node_reclaim's declarations to mm/internal.h instead of keeping them
>in linux/swap.h.

That's reasonable, thanks.

-- 
Wei Yang
Help you, Help me
