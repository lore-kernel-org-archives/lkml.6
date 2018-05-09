Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935455AbeEIQI2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 12:08:28 -0400
Received: from mail-pl0-f42.google.com ([209.85.160.42]:34553 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933409AbeEIQI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 12:08:27 -0400
X-Google-Smtp-Source: AB8JxZrg6QtvkFgKuaAvgn4L4O1hxm3rTRn0ZnuH50KIIX5fCmXR/Z4J/Mr2p51F6yQ+ZcqjLYv5UQ==
Subject: Re: [RFC][PATCH 00/13] Provide saturating helpers for allocation
To: Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <mawilcox@microsoft.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com
References: <20180509004229.36341-1-keescook@chromium.org>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <4baffc55-510e-96d3-3487-5ea09f993a0c@redhat.com>
Date: Wed, 9 May 2018 09:08:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509004229.36341-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2018 05:42 PM, Kees Cook wrote:
> This is a stab at providing three new helpers for allocation size
> calculation:
> 
> struct_size(), array_size(), and array3_size().
> 
> These are implemented on top of Rasmus's overflow checking functions,
> and the last 8 patches are all treewide conversions of open-coded
> multiplications into the various combinations of the helper functions.
> 
> -Kees
> 
> 
Obvious question (that might indicate this deserves documentation?)

What's the difference between

kmalloc_array(cnt, sizeof(struct blah), GFP_KERNEL);

and

kmalloc(array_size(cnt, struct blah), GFP_KERNEL);


and when would you use one over the other?

Thanks,
Laura
