Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA00C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4681F2082D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBSDao4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4681F2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbeJYTPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:15:14 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45440 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbeJYTPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:15:14 -0400
Received: by mail-lj1-f195.google.com with SMTP id j4-v6so7710866ljc.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 03:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QiD4FXXbYlMKcFTyVvCXKqmeleZY73jo2ABzKqj91VI=;
        b=ZBSDao4nN0OJKwMqLjC6sm3lrfpI+ycCjMcJBZ9JDc0g4MujYMn4OiIZxrWpiKt44J
         tzMyibVUviY3AEKVss4LWWKbJWQ2n+n/lFzRdEMXduYqiro9oB3QvSYdOsZmbSx4U5zw
         +eTR6KhU13n8Q6iW/RWuvjbzrWaIN37sC0TWsQHOBPDGK/SIv7koJ/TVFDSHmCHza483
         x67MWlSN45GKWRLgkLgYZ9XY7JA+roVHv+qo762X1+nQK1in1N4a7fo9l1n58MskhVog
         xCu+nUFJbanHBkhoFTej/ljWJZwWmUTcPJc7VDorNgkwZo/L6kFvdf/GhZtmIWOv5OSs
         LsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QiD4FXXbYlMKcFTyVvCXKqmeleZY73jo2ABzKqj91VI=;
        b=kwfJbzY32Jxl8pXNjQrPRHJV10KqlFI0u3ZNYFvL+OOX6suKhQ4BTjucKNVHdHk08y
         +aX80rYlVhyUQYy4i1WodEtLaStWcFtRU4vhRmLWBYAlWfLiA1a0VWQaHWCGQ3WB5RGP
         PkwWBFWXXXzMrt3q+puoNlftNOrCiVoEjrsxhTWAGKMLaBijS6HX/Ftt8oZdAK1JMH3k
         dMGWBTkhZ8zth7roFjFUQCViwg3YJ6jfX73AjTBUD8BCywIQaL+IE5DWXOQMuy64sqUY
         y6hGdx22mcko/RIPTQ0iRbUmUlTGxVj8mmFOhsQK3u5SODeeYrCle1pbTfgXK+BsCH7A
         yXLg==
X-Gm-Message-State: AGRZ1gKM4TWwEdXRsvCm434DvdGvmQhm9NwPcxjrY02/3PBHHhz1EyC7
        USpOQNE4NrOeewpJuhv8wYk=
X-Google-Smtp-Source: AJdET5euJIyYLjHh3ShT9qhfLqHkfjhuwd6dd0ToKqdfcHKXRpea0aDQ6TWzMowcD/SIRXtn8Hn2nA==
X-Received: by 2002:a2e:501c:: with SMTP id e28-v6mr866706ljb.45.1540464181258;
        Thu, 25 Oct 2018 03:43:01 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id g3-v6sm880214lfj.3.2018.10.25.03.42.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 03:43:00 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 25 Oct 2018 12:42:57 +0200
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Shuah Khan <shuah@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>,
        maco@android.com
Subject: Re: [RFC PATCH 0/2] improve vmalloc allocation
Message-ID: <20181025104257.adtktxmggxewspvy@pc636>
References: <20181022165253.uphv3xzqivh44o3d@pc636>
 <20181023072306.GN18839@dhcp22.suse.cz>
 <dd0c3528-9c01-12bc-3400-ca88060cb7cf@kernel.org>
 <20181023152640.GD20085@bombadil.infradead.org>
 <20181023170532.GW18839@dhcp22.suse.cz>
 <98842edb-d462-96b1-311f-27c6ebfc108a@kernel.org>
 <20181023193044.GA139403@joelaf.mtv.corp.google.com>
 <20181024062252.GA18839@dhcp22.suse.cz>
 <20181024173418.2bxkdjbcyzfkgfeu@pc636>
 <20181025084327.GN18839@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025084327.GN18839@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 10:43:27AM +0200, Michal Hocko wrote:
> On Wed 24-10-18 19:34:18, Uladzislau Rezki wrote:
> > Hi.
> > 
> > On Wed, Oct 24, 2018 at 08:22:52AM +0200, Michal Hocko wrote:
> > > On Tue 23-10-18 12:30:44, Joel Fernandes wrote:
> > > > On Tue, Oct 23, 2018 at 11:13:36AM -0600, Shuah Khan wrote:
> > > > > On 10/23/2018 11:05 AM, Michal Hocko wrote:
> > > > > > On Tue 23-10-18 08:26:40, Matthew Wilcox wrote:
> > > > > >> On Tue, Oct 23, 2018 at 09:02:56AM -0600, Shuah Khan wrote:
> > > > > > [...]
> > > > > >>> The way it can be handled is by adding a test module under lib. test_kmod,
> > > > > >>> test_sysctl, test_user_copy etc.
> > > > > >>
> > > > > >> The problem is that said module can only invoke functions which are
> > > > > >> exported using EXPORT_SYMBOL.  And there's a cost to exporting them,
> > > > > >> which I don't think we're willing to pay, purely to get test coverage.
> > > > > > 
> > > > > > Yes, I think we do not want to export internal functionality which might
> > > > > > be still interesting for the testing coverage. Maybe we want something
> > > > > > like EXPORT_SYMBOL_KSELFTEST which would allow to link within the
> > > > > > kselftest machinery but it wouldn't allow the same for general modules
> > > > > > and will not give any API promisses.
> > > > > > 
> > > > > 
> > > > > I like this proposal. I think we will open up lot of test opportunities with
> > > > > this approach.
> > > > > 
> > > > > Maybe we can use this stress test as a pilot and see where it takes us.
> > > > 
> > > > I am a bit worried that such an EXPORT_SYMBOL_KSELFTEST mechanism can be abused by
> > > > out-of-tree module writers to call internal functionality.
> > > > 
> > > > How would you prevent that?
> > > 
> > > There is no way to prevent non-exported symbols abuse by 3rd party
> > > AFAIK. EXPORT_SYMBOL_* is not there to prohibid abuse. It is a mere
> > > signal of what is, well, an exported API.
> > 
> > Can we just use kallsyms_lookup_name()?
> 
> Heh, this is the abuse I've had in mind ;)
> > <snip>
> > static void *((*__my_vmalloc_node_range)(unsigned long size,
> >     unsigned long align,unsigned long start, unsigned long end,
> >     gfp_t gfp_mask,pgprot_t prot, unsigned long vm_flags,
> >     int node, const void *caller));
> > 
> > __my_vmalloc_node_range = (void *) kallsyms_lookup_name("__vmalloc_node_range");
> > <snip>
> 
> This is just too ugly to live. So I would go with it only if there is no
> reasonable way to export what tests need with a sane interface.
Agree, that is a bit ugly and not generic even though it is easy :)

--
Vlad Rezki
