Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFA3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7987C218AF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbeLRPSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:18:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33029 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbeLRPSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:18:38 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B454389AD7;
        Tue, 18 Dec 2018 15:18:38 +0000 (UTC)
Received: from jlaw-desktop.bos.csb (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C976672CE;
        Tue, 18 Dec 2018 15:18:37 +0000 (UTC)
Subject: Re: [PATCH V2] livepatch: fix non-static warnings
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Petr Mladek <pmladek@suse.com>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1544965657-26804-1-git-send-email-hofrat@osadl.org>
 <alpine.LSU.2.21.1812171256390.3087@pobox.suse.cz>
 <20ef1d3a-2916-ce00-2938-3397746efac9@redhat.com>
 <alpine.LSU.2.21.1812180934090.9644@pobox.suse.cz>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Organization: Red Hat
Message-ID: <adeb1bca-9fa1-b150-d551-a9cf0853a63b@redhat.com>
Date:   Tue, 18 Dec 2018 10:18:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.1812180934090.9644@pobox.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 18 Dec 2018 15:18:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/2018 03:49 AM, Miroslav Benes wrote:
> On Mon, 17 Dec 2018, Joe Lawrence wrote:
> 
>> I'm just being picky about its documentation and how we should note its
>> usage in the v3 patch.  Think that s/__noclone/used/g of the v2 commit
>> message would be sufficient?
> 
> We could rephrase it. After all it is not only about symbol names in the 
> symbol table. The traceable/patchable code has to be present...
> 
> "Sparse reported warnings about non-static symbols. For the variables
> a simple static attribute is fine - for the functions referenced by
> livepatch via klp_func the symbol-names must be unmodified in the
> symbol table and the patchable code has to be emitted.
> 
> Attach __used attribute to the shared statically declared functions."
> 
> ?

That works for me.

-- Joe
