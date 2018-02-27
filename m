Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751838AbeB0VwP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 16:52:15 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42338 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751455AbeB0VwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 16:52:14 -0500
Subject: Re: [PATCH v2 1/5] sysctl: Add kdoc comments to
 do_proc_do{u}intvec_minmax_conv_param
To: Matthew Wilcox <willy@infradead.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <1519764591-27456-1-git-send-email-longman@redhat.com>
 <1519764591-27456-2-git-send-email-longman@redhat.com>
 <20180227211022.GB29918@bombadil.infradead.org>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <14cad206-114f-3320-8818-8799fad4e10e@redhat.com>
Date: Tue, 27 Feb 2018 16:52:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180227211022.GB29918@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/27/2018 04:10 PM, Matthew Wilcox wrote:
> On Tue, Feb 27, 2018 at 03:49:47PM -0500, Waiman Long wrote:
>> +/**
>> + * DOC: do_proc_dointvec_minmax_conv_param
>> + *
>> + * The do_proc_dointvec_minmax_conv_param structure provides the
>> + * minimum and maximum values for doing range checking for those sysctl
>> + * parameters that use the proc_dointvec_minmax() handler. The error
>> + * code -EINVAL will be returned if the range check fails.
>> + *
>> + *  min: ptr to minimum allowable value
>> + *  max: ptr to maximum allowable value
>> + */
> This isn't how to document a struct; see Documentation/doc-guide/kernel-doc.rst
>
> /**
>  * struct do_proc_dointvec_minmax_conv_param - Range checking for sysctls
>  * @min: Pointer to minimum allowable value.
>  * @max: Pointer to maximum allowable value.
>  *
>  * Provides the minimum and maximum values allowed for a parameter.  A
>  * pointer to this structure should be passed to proc_dointvec_minmax().
>  */
>
> Also, it's inappropriate to document the return value from
> proc_dointvec_minmax() here; that should be in the kernel-doc for the
> function.
>
Thanks for the advice. I will change the comments in the v3 patch.

-Longman
