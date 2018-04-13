Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AIpwx4+08vG9a9aYMQ0BdTOLUi+nuDAanlw3CEvXLot/amrqveqORktLVNRDE0kYxQToG37tAFLD
ARC-Seal: i=1; a=rsa-sha256; t=1523638069; cv=none;
        d=google.com; s=arc-20160816;
        b=aYk134HgPlFBh3IR16cDAziL9QXlRzjvqkj8h746JkwVvLxsUIPXOvOgNpDpUdDRof
         nHN7FjyLFfdK9gD9S0EOMd+Q7ua7ru8ixUff/8GmF3BuPWVzPvS2nfHr8ihY1PHJY6ep
         s17fj2ucZzIQyc7L+pUdSkTbnlUTKzDnR4goS8Z1YEkb8M2sju34vgr1X3myp2cVblw0
         xHpWxFVJpxUJiwIJo8vrZJDg7luQgFAVJm8M/Lk7UqOuMK5+PlrLzq1HcOGPRE7Yoeq7
         zoQm2UBgZ7aS5AWM8SI/uV4WS4z05oXweJLFR+8IbHTUW/sfwJeDn27g2owqz6HDQdvz
         m+8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :dkim-signature:arc-authentication-results;
        bh=/To355o1r3uvE/0MnTVDKGbnuQ+zsoLDPUUU9RfpvwQ=;
        b=BrAaqxI0jbK8wTxQwWJ07nfWqZJiN/hwaU8OWXBNRomF0Az5skhvOMksz8SQ6Czccj
         xYja8Ok0NwFTng/9mLe2U8W5Bl84IEX6z45MUYCSl5n4HfPpo4ESd+bF7yLxRomrWB/S
         a9wmPAGf05BwMMOUWmWq13kTd9SrMLFXWRoZnoMIZWNflnjL56kqThD2xOhHPETW/qNE
         ELJgnySSODgKSqQxIqHkmkaXUW6zFqqD8a7FROeQmiPv2zM+0+HM127Ky9ef8DxmYZrc
         1ipOVIKJ1i5qCIcVo20sK6bkUKRWvyuGpou/BXcTkg0xaP/Q1wCf0BTMpDfsDZ7GF13P
         k50Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=I7wvFRjz;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=I7wvFRjz;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH 2/6] statfs: use << to align with fs header
To: Christian Brauner <christian.brauner@ubuntu.com>,
 viro@zeniv.linux.org.uk, tglx@linutronix.de, kstewart@linuxfoundation.org,
 gregkh@linuxfoundation.org, pombredanne@nexb.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, serge@hallyn.com
References: <20180413161126.31313-1-christian.brauner@ubuntu.com>
 <20180413161126.31313-3-christian.brauner@ubuntu.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f526b1d7-4240-5617-f185-3b751ace0982@infradead.org>
Date: Fri, 13 Apr 2018 09:47:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180413161126.31313-3-christian.brauner@ubuntu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597648046265390168?=
X-GMAIL-MSGID: =?utf-8?q?1597650313079451773?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/13/2018 09:11 AM, Christian Brauner wrote:
> Consistenly use << to define ST_* constants. This also aligns them with
> their MS_* counterparts in fs.h
> 
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  include/linux/statfs.h | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)

Lots of opportunities to use BIT(n) macro.
Is there some reason not to do that?


> diff --git a/include/linux/statfs.h b/include/linux/statfs.h
> index 3142e98546ac..b336c04e793c 100644
> --- a/include/linux/statfs.h
> +++ b/include/linux/statfs.h
> @@ -27,18 +27,18 @@ struct kstatfs {
>   * ABI.  The exception is ST_VALID which has the same value as MS_REMOUNT
>   * which doesn't make any sense for statfs.
>   */
> -#define ST_RDONLY	0x0001	/* mount read-only */
> -#define ST_NOSUID	0x0002	/* ignore suid and sgid bits */
> -#define ST_NODEV	0x0004	/* disallow access to device special files */
> -#define ST_NOEXEC	0x0008	/* disallow program execution */
> -#define ST_SYNCHRONOUS	0x0010	/* writes are synced at once */
> -#define ST_VALID	0x0020	/* f_flags support is implemented */
> -#define ST_MANDLOCK	0x0040	/* allow mandatory locks on an FS */
> -/* 0x0080 used for ST_WRITE in glibc */
> -/* 0x0100 used for ST_APPEND in glibc */
> -/* 0x0200 used for ST_IMMUTABLE in glibc */
> -#define ST_NOATIME	0x0400	/* do not update access times */
> -#define ST_NODIRATIME	0x0800	/* do not update directory access times */
> -#define ST_RELATIME	0x1000	/* update atime relative to mtime/ctime */
> +#define ST_RDONLY	(1<<0) /* mount read-only */
> +#define ST_NOSUID	(1<<1) /* ignore suid and sgid bits */
> +#define ST_NODEV	(1<<2) /* disallow access to device special files */
> +#define ST_NOEXEC	(1<<3) /* disallow program execution */
> +#define ST_SYNCHRONOUS	(1<<4) /* writes are synced at once */
> +#define ST_VALID	(1<<5) /* f_flags support is implemented */
> +#define ST_MANDLOCK	(1<<6) /* allow mandatory locks on an FS */
> +/* (1<<7) used for ST_WRITE in glibc */
> +/* (1<<8) used for ST_APPEND in glibc */
> +/* (1<<9) used for ST_IMMUTABLE in glibc */
> +#define ST_NOATIME	(1<<10) /* do not update access times */
> +#define ST_NODIRATIME	(1<<11) /* do not update directory access times */
> +#define ST_RELATIME	(1<<12) /* update atime relative to mtime/ctime */
>  
>  #endif
> 


-- 
~Randy
