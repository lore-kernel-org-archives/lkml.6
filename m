Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753987AbeDAXKy (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 19:10:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45498 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753915AbeDAXKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 19:10:53 -0400
Subject: Re: [PATCH 38/45] C++: mutex_trylock_recursive_enum() int->enum
To: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
 <152261544366.30503.65430592511529554.stgit@warthog.procyon.org.uk>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <100fd0de-2c7c-cbec-ac99-ea3a4aff383b@infradead.org>
Date: Sun, 1 Apr 2018 16:10:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <152261544366.30503.65430592511529554.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/2018 01:44 PM, David Howells wrote:
> Make mutex_trylock_recursive_enum() cast the int it derives to the enum
> return type.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  include/linux/mutex.h |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
> index cb3bbed4e633..2bacc5065980 100644
> --- a/include/linux/mutex.h
> +++ b/include/linux/mutex.h
> @@ -224,13 +224,14 @@ enum mutex_trylock_recursive_enum {
>   *  - MUTEX_TRYLOCK_SUCCESS   - lock acquired,
>   *  - MUTEX_TRYLOCK_RECURSIVE - we already owned the lock.
>   */
> -static inline /* __deprecated */ __must_check enum mutex_trylock_recursive_enum
> +static inline /* __deprecated */ __must_check
> +enum mutex_trylock_recursive_enum

nak that change from 1 to 2 lines. It's only 79 characters.

>  mutex_trylock_recursive(struct mutex *lock)
>  {
>  	if (unlikely(__mutex_owner(lock) == current))
>  		return MUTEX_TRYLOCK_RECURSIVE;
>  
> -	return mutex_trylock(lock);
> +	return (enum mutex_trylock_recursive_enum)mutex_trylock(lock);
>  }
>  
>  #endif /* __LINUX_MUTEX_H */
> 


-- 
~Randy
