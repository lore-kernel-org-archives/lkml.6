Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751795AbeBAO2Z (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 09:28:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751378AbeBAO2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 09:28:23 -0500
Subject: Re: PATCH v6 0/6] livepatch: Atomic replace feature
To: Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Cc: jpoimboe@redhat.com, jikos@kernel.org, Jason Baron <jbaron@akamai.com>,
        jeyu@kernel.org, Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
References: <20180125160203.28959-1-pmladek@suse.com>
 <alpine.LSU.2.21.1802011350200.26656@pobox.suse.cz>
From: Joe Lawrence <joe.lawrence@redhat.com>
Organization: Red Hat
Message-ID: <1dd714ce-8d11-78b9-51f0-2b71734949e1@redhat.com>
Date: Thu, 1 Feb 2018 09:28:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.1802011350200.26656@pobox.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2018 08:49 AM, Miroslav Benes wrote:
> 
> Well, one more thing. I think there is a problem with shadow variables. 
> Similar to callbacks situation. Shadow variables cannot be destroyed the 
> way it is shown in our samples. Cumulative patches want to preserve 
> everything as much as possible. If I'm right, it should be mentioned in 
> the documentation.

Are you talking about using klp_shadow_free_all() call in a module_exit
routine?  Yeah, I think in this case, that responsibility would be
passed to the newly loaded cumulative patch, right?


-- Joe
