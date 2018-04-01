Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753976AbeDAXFA (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 19:05:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44946 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752325AbeDAXE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 19:04:59 -0400
Subject: Re: [PATCH 01/45] Use UINT_MAX, not -1, to represent an invalid UID,
 GID or project ID
To: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
 <152261522136.30503.14306229915768504613.stgit@warthog.procyon.org.uk>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <84a48fa6-cd05-f666-e64c-5f913f942b0a@infradead.org>
Date: Sun, 1 Apr 2018 16:04:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <152261522136.30503.14306229915768504613.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/2018 01:40 PM, David Howells wrote:
> Use UINT_MAX, not -1, to represent an invalid UID, GID or project ID as the
> parameter is an unsigned integer.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  include/linux/projid.h |    2 +-
>  include/linux/uidgid.h |    4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/projid.h b/include/linux/projid.h
> index 613730622a1a..7c60a79424c9 100644
> --- a/include/linux/projid.h
> +++ b/include/linux/projid.h
> @@ -30,7 +30,7 @@ static inline projid_t __kprojid_val(kprojid_t projid)

+#include <linux/kernel.h>

>  #define KPROJIDT_INIT(value) (kprojid_t){ value }
>  
> -#define INVALID_PROJID KPROJIDT_INIT(-1)
> +#define INVALID_PROJID KPROJIDT_INIT(UINT_MAX)
>  #define OVERFLOW_PROJID 65534
>  
>  static inline bool projid_eq(kprojid_t left, kprojid_t right)
> diff --git a/include/linux/uidgid.h b/include/linux/uidgid.h
> index b0542cd11aeb..75f602075b63 100644
> --- a/include/linux/uidgid.h
> +++ b/include/linux/uidgid.h
> @@ -55,8 +55,8 @@ static inline gid_t __kgid_val(kgid_t gid)

+#include <linux/kernel.h>

>  #define GLOBAL_ROOT_UID KUIDT_INIT(0)
>  #define GLOBAL_ROOT_GID KGIDT_INIT(0)
>  
> -#define INVALID_UID KUIDT_INIT(-1)
> -#define INVALID_GID KGIDT_INIT(-1)
> +#define INVALID_UID KUIDT_INIT(UINT_MAX)
> +#define INVALID_GID KGIDT_INIT(UINT_MAX)
>  
>  static inline bool uid_eq(kuid_t left, kuid_t right)
>  {
> 


-- 
~Randy
