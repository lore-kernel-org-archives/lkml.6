Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751783AbeBAOZJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 09:25:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42311 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751378AbeBAOZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 09:25:05 -0500
Subject: Re: PATCH v6 2/6] livepatch: Free only structures with initialized
 kobject
To: Petr Mladek <pmladek@suse.com>, jpoimboe@redhat.com, jikos@kernel.org,
        mbenes@suse.cz
Cc: Jason Baron <jbaron@akamai.com>, jeyu@kernel.org,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
References: <20180125160203.28959-1-pmladek@suse.com>
 <20180125160203.28959-3-pmladek@suse.com>
From: Joe Lawrence <joe.lawrence@redhat.com>
Organization: Red Hat
Message-ID: <677eed76-a5bc-6ce2-a157-53d5696cee1a@redhat.com>
Date: Thu, 1 Feb 2018 09:25:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180125160203.28959-3-pmladek@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/25/2018 11:01 AM, Petr Mladek wrote:
> We are going to add a feature called atomic replace. It will allow to
> create a patch that would replace all already registered patches.
> For this, we will need to dynamically create funcs' and objects'
> for functions that are not longer patched.

Super small nit: funcs', objects' ?  More on this in the next inline
comment.

> [ ... snip ... ]
>  /*
> - * Free all functions' kobjects in the array up to some limit. When limit is
> - * NULL, all kobjects are freed.
> + * Free all funcs' that have the kobject initialized. Otherwise,
> + * nothing is needed.

In new comment, what is the apostrophe in funcs' for?  The code (still)
deals with the kobject embedded in the klp_func, but the comment text
moved "kobject" such that I think the apostrophe can now be removed.

> [ ... snip ... ]
>  /*
> - * Free all objects' kobjects in the array up to some limit. When limit is
> - * NULL, all kobjects are freed.
> + * Free all funcs' and objects's that have the kobject initialized.
> + * Otherwise, nothing is needed.
>   */

Ditto.

-- Joe
