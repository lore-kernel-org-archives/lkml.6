Return-Path: <jsimmons@infradead.org>
X-Google-Smtp-Source: AIpwx4/Zo4YAqk3MoRA+63v/aCTzHyYjJsSK66gSB4O1NqBg6lWmq7AKoTa8APZ4n9wVaZKM0nQP
ARC-Seal: i=1; a=rsa-sha256; t=1523918563; cv=none;
        d=google.com; s=arc-20160816;
        b=ipsDQkxuBUxJvo2wVPz8/ryc/7g2Z4YBGW/1ROVih3b0M6JtYo3ltDscqB1ZOJDwEw
         nrpnVH8GIOUTZb03sF8gbm3r33Ai/ROy6vGV/eM10PZgsEsqYqyMgo32oZ7XpqPZJpoe
         hMQKyW9SAriV8bdXLijiqVy/blvA8LiYgtWdaxAzXGGvbXnv1+nj5FDhzjATzixIY4AF
         UIv0oePSf3i+j/aOzWe4HLSDwUJRSBKLJq1CpDJnMkIav4y7tfAeJtv5s6hQCKezKKmv
         1HatbcYo3b5X8cdjQ8GhW3lP/pj4jgRoLEWyAYhMKqbCvJWip54ID6BJvvKQ0hB9L2LT
         jx4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=dORNuS2fE5IcpqlVz2cYz4L8Vp+EAWgFBDA4eJvTXbI=;
        b=JbpSexSH63kjQiatqH2E8wWWb0uyM/rjWepvTyakVJ3C0epehUHV0jHqffTYAWRcfY
         upfNNRXvQYza3uHIZM7l3EudTBHwqXsNOZEeHWBWEIwU58HXV4pY7+UiuPe/62qkACCX
         M8EZOY3SHvJeVhegbkweYCTL11oikXt9hV/xJkFFIwoeyeDAuhlBHPFmtcs5zUnOLKCi
         MA5Q7aYWW2Zr1XWUlkHNTsDgUAyKA8k9Xn7dNgn/EaxWSceroTeS9FCUiLrfV9hQbDaN
         /xckqeyl9esNud7+bj/m59rtK5xas7QgkUXGvSU7nQtySjFAqnH47Yhhr6ky6AZP/ybQ
         HQJw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=N4TPdnzS;
       spf=pass (google.com: best guess record for domain of jsimmons@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=jsimmons@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=N4TPdnzS;
       spf=pass (google.com: best guess record for domain of jsimmons@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=jsimmons@infradead.org
Date: Mon, 16 Apr 2018 23:42:31 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Patrick Farrell <paf@cray.com>
cc: NeilBrown <neilb@suse.com>, Oleg Drokin <oleg.drokin@intel.com>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
    Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [lustre-devel] [PATCH 1/6] staging: lustre: move stack-check
 macros to libcfs_debug.h
In-Reply-To: <6D3C7935-E7ED-4826-B459-0C4888D6048E@cray.com>
Message-ID: <alpine.LFD.2.21.1804162336220.14398@casper.infradead.org>
References: <152383910760.23409.2327082725637657049.stgit@noble> <152383935730.23409.6748888065027051683.stgit@noble> <alpine.LFD.2.21.1804160438220.16188@casper.infradead.org> <6D3C7935-E7ED-4826-B459-0C4888D6048E@cray.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1985284609-449751960-1523918551=:14398"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180416_234232_023958_AB89EC60 
X-CRM114-Status: GOOD (  35.10  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: SpamAssassin version 3.4.1 on casper.infradead.org summary:
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597861409409058351?=
X-GMAIL-MSGID: =?utf-8?q?1597944431601706896?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1985284609-449751960-1523918551=:14398
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT


> James,
> 
> If I understand correctly, you're saying you want to be able to build without debug support...?  I'm not convinced that building a client without debug support is interesting or useful.  In fact, I think it would be harmful, and we shouldn't open up the possibility - this is switchable debug with very low overhead when not actually "on".  It would be really awful to get a problem on a running system and discover there's no debug support - that you can't even enable debug without a reinstall.
> 
> If I've understood you correctly, then I would want to see proof of a significant performance cost when debug is built but *off* before agreeing to even exposing this option.  (I know it's a choice they'd have to make, but if it's not really useful with a side order of potentially harmful, we shouldn't even give people the choice.)

I'm not saying add the option today but this is more for the long game.
While the Intel lustre developers deeply love lustre's debugging 
infrastructure I see a future where something better will come along to
replace it. When that day comes we will have a period where both
debugging infrastructurs will exist and some deployers of lustre will
want to turn off the old debugging infrastructure and just use the new.
That is what I have in mind. A switch to flip between options.

> - Patrick
> 
> ﻿On 4/15/18, 10:49 PM, "lustre-devel on behalf of James Simmons" <lustre-devel-bounces@lists.lustre.org on behalf of jsimmons@infradead.org> wrote:
> 
>     
>     > CDEBUG_STACK() and CHECK_STACK() are macros to help with
>     > debugging, so move them from
>     >    drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
>     > to
>     >    drivers/staging/lustre/include/linux/libcfs/libcfs_debug.h
>     > 
>     > This seems a more fitting location, and is a step towards
>     > removing linux/libcfs.h and simplifying the include file structure.
>     
>     Nak. Currently the lustre client always enables debugging but that
>     shouldn't be the case. What we do need is the able to turn off the 
>     crazy debugging stuff. In the development branch of lustre it is
>     done with CDEBUG_ENABLED. We need something like that in Kconfig
>     much like we have CONFIG_LUSTRE_DEBUG_EXPENSIVE_CHECK. Since we like
>     to be able to turn that off this should be moved to just after
>     LIBCFS_DEBUG_MSG_DATA_DECL. Then from CHECK_STACK down to CWARN()
>     it can be build out. When CDEBUG_ENABLED is disabled CDEBUG_LIMIT
>     would be empty.
>      
>     > Signed-off-by: NeilBrown <neilb@suse.com>
>     > ---
>     >  .../lustre/include/linux/libcfs/libcfs_debug.h     |   32 ++++++++++++++++++++
>     >  .../lustre/include/linux/libcfs/linux/libcfs.h     |   31 -------------------
>     >  2 files changed, 32 insertions(+), 31 deletions(-)
>     > 
>     > diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs_debug.h b/drivers/staging/lustre/include/linux/libcfs/libcfs_debug.h
>     > index 9290a19429e7..0dc7b91efe7c 100644
>     > --- a/drivers/staging/lustre/include/linux/libcfs/libcfs_debug.h
>     > +++ b/drivers/staging/lustre/include/linux/libcfs/libcfs_debug.h
>     > @@ -62,6 +62,38 @@ int libcfs_debug_str2mask(int *mask, const char *str, int is_subsys);
>     >  extern unsigned int libcfs_catastrophe;
>     >  extern unsigned int libcfs_panic_on_lbug;
>     >  
>     > +/* Enable debug-checks on stack size - except on x86_64 */
>     > +#if !defined(__x86_64__)
>     > +# ifdef __ia64__
>     > +#  define CDEBUG_STACK() (THREAD_SIZE -				 \
>     > +			  ((unsigned long)__builtin_dwarf_cfa() &       \
>     > +			   (THREAD_SIZE - 1)))
>     > +# else
>     > +#  define CDEBUG_STACK() (THREAD_SIZE -				 \
>     > +			  ((unsigned long)__builtin_frame_address(0) &  \
>     > +			   (THREAD_SIZE - 1)))
>     > +# endif /* __ia64__ */
>     > +
>     > +#define __CHECK_STACK(msgdata, mask, cdls)			      \
>     > +do {								    \
>     > +	if (unlikely(CDEBUG_STACK() > libcfs_stack)) {		  \
>     > +		LIBCFS_DEBUG_MSG_DATA_INIT(msgdata, D_WARNING, NULL);   \
>     > +		libcfs_stack = CDEBUG_STACK();			  \
>     > +		libcfs_debug_msg(msgdata,			       \
>     > +				 "maximum lustre stack %lu\n",	  \
>     > +				 CDEBUG_STACK());		       \
>     > +		(msgdata)->msg_mask = mask;			     \
>     > +		(msgdata)->msg_cdls = cdls;			     \
>     > +		dump_stack();					   \
>     > +	      /*panic("LBUG");*/					\
>     > +	}							       \
>     > +} while (0)
>     > +#define CFS_CHECK_STACK(msgdata, mask, cdls)  __CHECK_STACK(msgdata, mask, cdls)
>     > +#else /* __x86_64__ */
>     > +#define CFS_CHECK_STACK(msgdata, mask, cdls) do {} while (0)
>     > +#define CDEBUG_STACK() (0L)
>     > +#endif /* __x86_64__ */
>     > +
>     >  #ifndef DEBUG_SUBSYSTEM
>     >  # define DEBUG_SUBSYSTEM S_UNDEFINED
>     >  #endif
>     > diff --git a/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h b/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
>     > index 07d3cb2217d1..83aec9c7698f 100644
>     > --- a/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
>     > +++ b/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
>     > @@ -80,35 +80,4 @@
>     >  #include <stdarg.h>
>     >  #include "linux-cpu.h"
>     >  
>     > -#if !defined(__x86_64__)
>     > -# ifdef __ia64__
>     > -#  define CDEBUG_STACK() (THREAD_SIZE -				 \
>     > -			  ((unsigned long)__builtin_dwarf_cfa() &       \
>     > -			   (THREAD_SIZE - 1)))
>     > -# else
>     > -#  define CDEBUG_STACK() (THREAD_SIZE -				 \
>     > -			  ((unsigned long)__builtin_frame_address(0) &  \
>     > -			   (THREAD_SIZE - 1)))
>     > -# endif /* __ia64__ */
>     > -
>     > -#define __CHECK_STACK(msgdata, mask, cdls)			      \
>     > -do {								    \
>     > -	if (unlikely(CDEBUG_STACK() > libcfs_stack)) {		  \
>     > -		LIBCFS_DEBUG_MSG_DATA_INIT(msgdata, D_WARNING, NULL);   \
>     > -		libcfs_stack = CDEBUG_STACK();			  \
>     > -		libcfs_debug_msg(msgdata,			       \
>     > -				 "maximum lustre stack %lu\n",	  \
>     > -				 CDEBUG_STACK());		       \
>     > -		(msgdata)->msg_mask = mask;			     \
>     > -		(msgdata)->msg_cdls = cdls;			     \
>     > -		dump_stack();					   \
>     > -	      /*panic("LBUG");*/					\
>     > -	}							       \
>     > -} while (0)
>     > -#define CFS_CHECK_STACK(msgdata, mask, cdls)  __CHECK_STACK(msgdata, mask, cdls)
>     > -#else /* __x86_64__ */
>     > -#define CFS_CHECK_STACK(msgdata, mask, cdls) do {} while (0)
>     > -#define CDEBUG_STACK() (0L)
>     > -#endif /* __x86_64__ */
>     > -
>     >  #endif /* _LINUX_LIBCFS_H */
>     > 
>     > 
>     > 
>     _______________________________________________
>     lustre-devel mailing list
>     lustre-devel@lists.lustre.org
>     http://lists.lustre.org/listinfo.cgi/lustre-devel-lustre.org
>     
> 
> 
--1985284609-449751960-1523918551=:14398--
