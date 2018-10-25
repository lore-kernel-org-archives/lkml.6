Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0E9C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECDC92075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcstzngy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECDC92075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbeJYTFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:05:31 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40833 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbeJYTFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:05:31 -0400
Received: by mail-lf1-f66.google.com with SMTP id n3-v6so6371672lfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 03:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SnEWKtwOlecDkNGg9wnFmuPPTMp4tXqYjE1sXY7dOTA=;
        b=hcstzngyW/frle40ukBcn8B5eISoY2PlR6az5vRo+i1OZ3ppplTdVeQ+z1VLXVRiba
         h64LmSAZg7Zx+2gPofQOBs96AvEpTbO3jUCpwlkU4F03nQghqrIFL1oENfHK4sC6tvRG
         xXU8vvgeXU6+2eOFoexRfUL1awCrIijGcK6AMnQqGOrqeUU+nhzg7Hh61iJu6JDJ45aO
         rnAlyiFusitj/OOWEkPpRdFEqFJL3PJNKi4KHB1eIwm+IiW4EecErxt0HhZ1Uc2i9Y58
         l3ZQkUws9J87aM/EQgb/6+rbC+AaFXUpQFL6cu4LHL4nvgoMi6lrm6frD6HzGSr73D1I
         LsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SnEWKtwOlecDkNGg9wnFmuPPTMp4tXqYjE1sXY7dOTA=;
        b=jvxGdjMkMeCZ7Fa42yPcXRP7qvJP8qD9MYg9Okonkk+G2mYrQmDd4mXVzrI58jAcYU
         B0cdclb4WKbUzSI0ZGhARltJ3SDWKUGBcln/ohrx7J/9fTMn8aqdKUJBWlrXFQPwP+Kr
         jboTP6GmleXe7AJa01ahs4t0uwAbGDOOe4FGvhgF0lGCsGDm1PbKb6bxN2/SQRyIfmRF
         scDhljc2LFNevtqd+QikZD4+5OuyoBCyzNIwQSf+L6xDv5VY5BNwFXI1l5sn7LWozOIO
         FBlvSNQVUNTLLtFrC70tcDGvMzsstvwCdUuXgyMfBRYw4zvKQK+lUvNJg3sXA02WE7eY
         WBeg==
X-Gm-Message-State: AGRZ1gKgR2lYXo0avidG9o13JYYtZokUJ85ef/tqvE6EWeqKO0pqJBDO
        dog2hoCimMAgov1pCQ6Uvk0=
X-Google-Smtp-Source: AJdET5cNzHz5wTe/sixi0pj+x8NZ7bNMlR5MBf7a66vJc/aU6fXFeAD3AlxuvVAdbCIMoARDejd89w==
X-Received: by 2002:a19:1f46:: with SMTP id f67mr771578lff.1.1540463600784;
        Thu, 25 Oct 2018 03:33:20 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id l65-v6sm1209031lfe.1.2018.10.25.03.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 03:33:19 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 25 Oct 2018 12:33:12 +0200
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH 0/2] improve vmalloc allocation
Message-ID: <20181025103312.5oamrqsrdseeatir@pc636>
References: <20181019173538.590-1-urezki@gmail.com>
 <20181024160106.29ff3877d06fa1de520cc48a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024160106.29ff3877d06fa1de520cc48a@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 04:01:06PM -0700, Andrew Morton wrote:
> On Fri, 19 Oct 2018 19:35:36 +0200 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:
> 
> > improving vmalloc allocator
> 
> It's about time ;)
> 
> Are you aware of https://lwn.net/Articles/285341/ ?  If not, please do
> take a look through Nick's work and see if there are any good things
> there which can be borrowed.
> 
No, i have not known about that. I will go through that work to see if
there is something there!

Thanks :)

--
Vlad Rezki
