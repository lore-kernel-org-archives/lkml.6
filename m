Return-Path: <tytso@thunk.org>
X-Google-Smtp-Source: AB8JxZpmQln3aY7TwQhYhCPxvXJhhwi5O29CVnzM9TLPt0ukYe4WKE0+tOW8ie4mR46jeXJYBSNv
ARC-Seal: i=1; a=rsa-sha256; t=1525220338; cv=none;
        d=google.com; s=arc-20160816;
        b=Dpuiq0VWBniRaqq1Myri78LcaGHfmbmA0DwhoNh7dN5K1gerHyWqJWnP/q50sRJY4h
         dlnc5k+RJYrjGB8Mfs/S7lTaqg49HubriFl8Kfah+SvqK1Iw+Z3l5fivQJ4MEsJwXG7E
         95ngwiAGnV0fz+W9sNRUw2apwQnr7fs5AjOIJAo5M9x/TT4AmoBzqtYRy17bxcuVd3RM
         tMHXuyp6x9o4nc+fj93+gbnVdKx9pKQs170nTS40PS+mxx7nvS9HTiOgO6B1BI5KScqA
         ITpd/nSO0qiMHqDUrzfroWvIMQ46bI+Zwd4fNLnH88M11dtReuj7r1tltCVboHOsb92d
         pt3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=ZU8spsqZeAyADwtcVjayqxuLOh6O/TngEO/3Eqnbzhc=;
        b=a5ub/zDelrpOUbuHh9Ehw/IngQv+Cl9//IwRE7go2cdng0An4YNF6KZ1QGKyqrYthh
         100t1PyN5Z0h13D1e1p6xa/iMBnF1nPz+ki4hgkacb9v/5xBlB8rFQ4L7XYbz8Arja4f
         yNsCt2aoJpv/TJF1jCRPrV/5xjZgAQhxt8BWD6njsDnpr26kBxLCdJe+GdvM6R/9/Wjz
         rUjmYIjqUKSItgbWMcWLYM6M4FuRhedQLtqw47HGs6RMUuOrQNjKXOZ4dAPc14fnHFxJ
         3UatVDvHLCi+5Ts+Qjdl7l+MupBAXTxM3pNNxFb8L/Ons34a9yh593WWOoWFGaV1psPw
         OxOA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@thunk.org header.s=ef5046eb header.b=UmhDII6e;
       spf=pass (google.com: domain of tytso@thunk.org designates 74.207.234.97 as permitted sender) smtp.mailfrom=tytso@thunk.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@thunk.org header.s=ef5046eb header.b=UmhDII6e;
       spf=pass (google.com: domain of tytso@thunk.org designates 74.207.234.97 as permitted sender) smtp.mailfrom=tytso@thunk.org
Date: Tue, 1 May 2018 20:18:51 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Kees Cook <keescook@chromium.org>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] random: Fix whitespace pre random-bytes work
Message-ID: <20180502001851.GA24100@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
	"Tobin C. Harding" <me@tobin.cc>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Kees Cook <keescook@chromium.org>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
References: <1525217620-4107-1-git-send-email-me@tobin.cc>
 <1525217620-4107-2-git-send-email-me@tobin.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525217620-4107-2-git-send-email-me@tobin.cc>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599306638182795864?=
X-GMAIL-MSGID: =?utf-8?q?1599309441600238058?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 02, 2018 at 09:33:38AM +1000, Tobin C. Harding wrote:
> There are a couple of whitespace issues around the function
> get_random_bytes_arch().  In preparation for patching this function
> let's clean them up.
> 
> Signed-off-by: Tobin C. Harding <me@tobin.cc>

Acked-by: Theodore Ts'o <tytso@mit.edu>

> ---
>  drivers/char/random.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index cd888d4ee605..031d18b31e0f 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -1737,7 +1737,7 @@ void get_random_bytes_arch(void *buf, int nbytes)
>  
>  		if (!arch_get_random_long(&v))
>  			break;
> -		
> +
>  		memcpy(p, &v, chunk);
>  		p += chunk;
>  		nbytes -= chunk;
> @@ -1748,7 +1748,6 @@ void get_random_bytes_arch(void *buf, int nbytes)
>  }
>  EXPORT_SYMBOL(get_random_bytes_arch);
>  
> -
>  /*
>   * init_std_data - initialize pool with system data
>   *
> -- 
> 2.7.4
> 
