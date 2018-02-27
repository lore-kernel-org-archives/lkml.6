Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeB0VK2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 16:10:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50140 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751518AbeB0VK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 16:10:27 -0500
Date: Tue, 27 Feb 2018 13:10:22 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Waiman Long <longman@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 1/5] sysctl: Add kdoc comments to
 do_proc_do{u}intvec_minmax_conv_param
Message-ID: <20180227211022.GB29918@bombadil.infradead.org>
References: <1519764591-27456-1-git-send-email-longman@redhat.com>
 <1519764591-27456-2-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519764591-27456-2-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 03:49:47PM -0500, Waiman Long wrote:
> +/**
> + * DOC: do_proc_dointvec_minmax_conv_param
> + *
> + * The do_proc_dointvec_minmax_conv_param structure provides the
> + * minimum and maximum values for doing range checking for those sysctl
> + * parameters that use the proc_dointvec_minmax() handler. The error
> + * code -EINVAL will be returned if the range check fails.
> + *
> + *  min: ptr to minimum allowable value
> + *  max: ptr to maximum allowable value
> + */

This isn't how to document a struct; see Documentation/doc-guide/kernel-doc.rst

/**
 * struct do_proc_dointvec_minmax_conv_param - Range checking for sysctls
 * @min: Pointer to minimum allowable value.
 * @max: Pointer to maximum allowable value.
 *
 * Provides the minimum and maximum values allowed for a parameter.  A
 * pointer to this structure should be passed to proc_dointvec_minmax().
 */

Also, it's inappropriate to document the return value from
proc_dointvec_minmax() here; that should be in the kernel-doc for the
function.
