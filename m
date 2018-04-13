Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AIpwx4/w7/yb7KA1R+LeKh3lHfBWzF0t4O0iC7nR/KJUxz1u/cI3l0RrZzebDg0WCRPwp2yWKi3m
ARC-Seal: i=1; a=rsa-sha256; t=1523637908; cv=none;
        d=google.com; s=arc-20160816;
        b=aGhK2BkCU9qhMmpzYvVC0VOh6J61eC4GwG3WwsjkEBLe7inc3TeaxYzAGL6+pVf3m+
         K3x/neBsSM9JQKlxBkQv+nX3RDuo558/kewg4YdZ4J2WGnTmT8pGYuToXV9KzQsxipFk
         TvknXR2qdFfcuj03b8OkV9jfbL276W5vwe7G9ah3Bgu1WHW7I/LpbuYnkGpahUTc4IGj
         UMOFUcldH9aFt+PhLzvfWmmxxnkIVzLPDxT7yxduWNHCH/huBfB+Cx6XfLCaGza9y8U3
         5lawBYlVoXldLYMlr7sWi5ZKGBw9fscaT3YRmdyVfRE2wcv6O+biBSl9AJ5QfnYiYgwA
         tjxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :dkim-signature:arc-authentication-results;
        bh=BrWc0WM2F5pjg0eSmM854FBPqQsrSonuiC/M7Ae1v9w=;
        b=G3z6AgNkRfkVUsHW7VlWTICv3ZBbZaguuhni0rKDjUb2foSC8xrUwO+xy7qffNjqMt
         BC4m5364s74HljwoAorTw6yNMqfRwu9g56fBgV4SKCZBGhwMa68Tf4BdUZgHp5hfvGoA
         d2zY6Mg2efIiharqqKJPh4ymefOMlgNNYz2V8rhGCaoBk4S2xBO69kbl//XMDRMo5aDk
         /GUDDf3Cnn3cLLPWkQXQyTJ+PReSQ2OqkBbQdF9ytYtSJZYNkfywg7wY09+AM/QXJXwf
         U/lg5fT2AhePLvSrPCevZuHYXRtCK8cLugLNq2dTyB4qRNS1FeE0S1/7gkPjy5dudhny
         /euw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=TBeJiaZl;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=TBeJiaZl;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH 1/6] fs: use << for MS_* flags
To: Christian Brauner <christian.brauner@ubuntu.com>,
 viro@zeniv.linux.org.uk, tglx@linutronix.de, kstewart@linuxfoundation.org,
 gregkh@linuxfoundation.org, pombredanne@nexb.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, serge@hallyn.com
References: <20180413161126.31313-1-christian.brauner@ubuntu.com>
 <20180413161126.31313-2-christian.brauner@ubuntu.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f738679f-bc7e-3356-b278-ff881f6f651a@infradead.org>
Date: Fri, 13 Apr 2018 09:45:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180413161126.31313-2-christian.brauner@ubuntu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597648045071126947?=
X-GMAIL-MSGID: =?utf-8?q?1597650143761007973?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/13/2018 09:11 AM, Christian Brauner wrote:
> Consistenly use << to define MS_* constants.
> 
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  include/uapi/linux/fs.h | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index d2a8313fabd7..9662790a657c 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -105,22 +105,23 @@ struct inodes_stat_t {
>  /*
>   * These are the fs-independent mount-flags: up to 32 flags are supported
>   */
> -#define MS_RDONLY	 1	/* Mount read-only */
> -#define MS_NOSUID	 2	/* Ignore suid and sgid bits */
> -#define MS_NODEV	 4	/* Disallow access to device special files */
> -#define MS_NOEXEC	 8	/* Disallow program execution */
> -#define MS_SYNCHRONOUS	16	/* Writes are synced at once */
> -#define MS_REMOUNT	32	/* Alter flags of a mounted FS */
> -#define MS_MANDLOCK	64	/* Allow mandatory locks on an FS */
> -#define MS_DIRSYNC	128	/* Directory modifications are synchronous */
> -#define MS_NOATIME	1024	/* Do not update access times. */
> -#define MS_NODIRATIME	2048	/* Do not update directory access times */
> -#define MS_BIND		4096
> -#define MS_MOVE		8192
> -#define MS_REC		16384
> -#define MS_VERBOSE	32768	/* War is peace. Verbosity is silence.
> -				   MS_VERBOSE is deprecated. */
> -#define MS_SILENT	32768
> +#define MS_RDONLY	(1<<0)	/* Mount read-only */

Why not just use BIT(n) instead?

#include <linux/bitops.h>

#define MS_RDONLY	BIT(0)	/* Mount read-only */

etc.

> +#define MS_NOSUID	(1<<1)	/* Ignore suid and sgid bits */
> +#define MS_NODEV	(1<<2)	/* Disallow access to device special files */
> +#define MS_NOEXEC	(1<<3)	/* Disallow program execution */
> +#define MS_SYNCHRONOUS	(1<<4)	/* Writes are synced at once */
> +#define MS_REMOUNT	(1<<5)	/* Alter flags of a mounted FS */
> +#define MS_MANDLOCK	(1<<6)	/* Allow mandatory locks on an FS */
> +#define MS_DIRSYNC	(1<<7)	/* Directory modifications are synchronous */
> +#define MS_NOATIME	(1<<10)	/* Do not update access times. */
> +#define MS_NODIRATIME	(1<<11)	/* Do not update directory access times */
> +#define MS_BIND		(1<<12)
> +#define MS_MOVE		(1<<13)
> +#define MS_REC		(1<<14)
> +#define MS_VERBOSE	(1<<15)	/* War is peace. Verbosity is silence.
> +				 * MS_VERBOSE is deprecated.
> +				 */
> +#define MS_SILENT	(1<<15)
>  #define MS_POSIXACL	(1<<16)	/* VFS does not apply the umask */
>  #define MS_UNBINDABLE	(1<<17)	/* change to unbindable */
>  #define MS_PRIVATE	(1<<18)	/* change to private */
> 


-- 
~Randy
