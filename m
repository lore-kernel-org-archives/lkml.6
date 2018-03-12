Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932480AbeCLVAC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 17:00:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59474 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932302AbeCLVAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 17:00:00 -0400
Subject: Re: [PATCH v4 5/6] ipc: Clamp semmni to the real IPCMNI limit
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
References: <1520885744-1546-1-git-send-email-longman@redhat.com>
 <1520885744-1546-6-git-send-email-longman@redhat.com>
 <20180312205235.GB4449@wotan.suse.de>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <1a506f57-a91b-aae9-7756-03268b6447f7@redhat.com>
Date: Mon, 12 Mar 2018 16:59:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180312205235.GB4449@wotan.suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2018 04:52 PM, Luis R. Rodriguez wrote:
> On Mon, Mar 12, 2018 at 04:15:43PM -0400, Waiman Long wrote:
>> +	if (clamped)
>> +		pr_warn_once("sysctl: \"sem[3]\" was set out of range [%d, %d], clamped to %d.\n",
>> +			     0, IPCMNI, ns->sc_semmni);
> Why warn if the kernel already does that? If we can avoid more code on
> drivers the better.
>
>   Luis

As said before, this case is special because "sem" is a collection of 4
different values. The last one is semmni which I tries to apply the same
range clamping here, whereas the other 3 are left as they are. The
standard proc_dointvec_minmax() handler cannot be used here because of
that. I will clarify that in the commit log.

Cheers,
Longman
