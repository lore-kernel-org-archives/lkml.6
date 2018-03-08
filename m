Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934343AbeCHPJz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 10:09:55 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45608 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932085AbeCHPJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 10:09:50 -0500
Subject: Re: [PATCH v10 00/10] livepatch: Atomic replace feature
To: Petr Mladek <pmladek@suse.com>
Cc: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>, Jason Baron <jbaron@akamai.com>,
        Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180307082039.10196-1-pmladek@suse.com>
 <45877626-2d41-4af8-a8ff-5897585122ad@redhat.com>
 <20180308150150.guwwj2exrymugoeq@pathway.suse.cz>
From: Joe Lawrence <joe.lawrence@redhat.com>
Organization: Red Hat
Message-ID: <2f94c399-fe72-58f9-bd63-b08c46bb47b3@redhat.com>
Date: Thu, 8 Mar 2018 10:09:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180308150150.guwwj2exrymugoeq@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2018 10:01 AM, Petr Mladek wrote:
> On Wed 2018-03-07 16:55:53, Joe Lawrence wrote:
>> Running against v10, callbacks seem to be good up until I disable an
>> atomic replace patch.  My understanding is that the original patch's
>> unpatch callbacks should be skipped (as they were).  I was surprised to
>> see that atomic replacement patch only ran it's post-unpatch callback.
> 
> Great catch!
> 
> I guess that it is caused by the heuristic used in
> klp_unpatch_object() to decide whether the object is patched
> or not.
> 
> We need to change the state only when manipulating the
> statically defined functions.
> 
> Thanks a lot for so extensive testing!!!

Sorry for not getting to this series sooner.  I'm trying to refit these
tests into a kselftest so we can more easily reuse them.  Still hacking
away at it, but I'll post when something soon to start a livepatch
selftests conversation :)

-- Joe
