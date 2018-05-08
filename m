Return-Path: <minchan.kim@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525776535; cv=none;
        d=google.com; s=arc-20160816;
        b=qLwKK/nHsDTQDIumZp4uxflGiGCsQUIIeFZM56Y+0WHB1zEiMNZ/xvJqAZQvD+Kgqv
         vkZOGKimS+867+/JL2CAbIoiqJryTDD6pT2vNB5e++TEyKaMSIoxtBPwkcs3+ohlAfIN
         ykMtT90KponAfZ0Q7A32r/z6TExpucAgRbUpOu9hHNkpquHb/ULKkzWNI+HURhWYn+rF
         dkg2XkUL6GIiOcUfF5DEKv3QSa2WDPQEZBdNCbj9PbrjacWK7pE/DCdyMV9xZ1lZXa45
         PaKUqqVFZymXIXVc3LXsb+eMsPq3ZDkHjRFgFcoTuNDpcTH4vNHaDvwLW03JWI+KfihA
         JlQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=XNfvqaVn2eTUao1sgVRFj1ClcqKQmDKIEY2+1Hod84c=;
        b=Htm84p9kxDlHOwBMIXe2/mvvIXs3bEzbjoGNC77nXj5KEjaIdDNQYn5ZCsoHBV3NsH
         lgEf4SrkM+ZfpaR5KAtkBxbn8fMiVt/0m0PuI5UCZO1ZcT6E7Rhvz3agqXVGFjp6i4/Q
         4yZrIzcmdRINthUJ1Hpxrz56OHD2T9YWQknkOS0ZYV9RPVnXgPeOEvEI3ucbLlhh7VFc
         3ZQznAOTNTqQCuKv574nZomktk5LkVmZ2oCsYBGTiOX29xtGk+94RVU/1FHprucUQmaR
         2ZxyFS7spLrZm4qZSsWBtKxvHDzrP6AgwSYCp99MlPwy/Ga2fILp/ncHk++sJ7v/hsmj
         DAng==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Jf0soNTi;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Jf0soNTi;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
X-Google-Smtp-Source: AB8JxZq3PRf6glzv1EOWmq4bVGgZMwQEVNfkwzCM/9mgBc6mkh3m1DqLxACVYi5YRkT6sGiH3WN1JA==
Sender: Minchan Kim <minchan.kim@gmail.com>
Date: Tue, 8 May 2018 19:48:49 +0900
From: Minchan Kim <minchan@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux-Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: linux-next: build warning after merge of the akpm-current tree
Message-ID: <20180508104849.GA8209@rodete-desktop-imager.corp.google.com>
References: <20180504141756.670dc3f3@canb.auug.org.au>
 <4fb39549-8902-950d-3076-82a11b1c5102@infradead.org>
 <20180507141039.GA1934@rodete-desktop-imager.corp.google.com>
 <f7c0ebfe-1986-6ce5-8641-5503ea6a05fb@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7c0ebfe-1986-6ce5-8641-5503ea6a05fb@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599505695773381278?=
X-GMAIL-MSGID: =?utf-8?q?1599892656894537190?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 07, 2018 at 09:47:54AM -0700, Randy Dunlap wrote:
> On 05/07/2018 07:10 AM, Minchan Kim wrote:
> > On Fri, May 04, 2018 at 08:39:43AM -0700, Randy Dunlap wrote:
> >> On 05/03/2018 09:17 PM, Stephen Rothwell wrote:
> >>> Hi Andrew,
> >>>
> >>> After merging the akpm-current tree, today's linux-next build
> >>> (x86_64_allmodconfig) produced this warning:
> >>>
> >>> drivers/block/zram/zram_drv.c: In function 'read_block_state':
> >>> drivers/block/zram/zram_drv.c:674:16: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 5 has type '__kernel_time_t {aka long int}' [-Wformat=]
> >>>     "%12lu %12llu.%06lu %c%c%c\n",
> >>>            ~~~~~^
> >>>            %12lu
> >>>     (unsigned long)index, ts.tv_sec,
> >>>                           ~~~~~~~~~
> >>>
> >>> Introduced by commit
> >>>
> >>>   827c7dbda8eb ("zram-introduce-zram-memory-tracking-update-fix-fix")
> >>>
> >>
> >> typedef __s64 time64_t;
> >>
> >> struct timespec64 {
> >> 	time64_t	tv_sec;			/* seconds */
> >> 	long		tv_nsec;		/* nanoseconds */
> >> };
> >>
> >> time64_t is signed. Also, %lu on i386 et al is for 32-bit longs.
> >> I guess that "we" will need to cast ts.tv_sec to (s64) and use %lld to print it
> >> in order to satisfy other $arch.
> >>
> >> Andrew, want to add a fix-fix-fix patch?
> > 
> > Thanks for the fix during I am absent, Andrew and Randy.
> > Here goes fix.
> > Andrew please fold this patchset.
> > 
> > From 16569c7abb641930b4e4ec66b4dc2005e6c87be8 Mon Sep 17 00:00:00 2001
> > From: Minchan Kim <minchan@kernel.org>
> > Date: Mon, 7 May 2018 23:00:16 +0900
> > Subject: [PATCH] zram-introduce-zram-memory-tracking-update-fix-fix-fix
> > 
> > fix compile warning
> > 
> > drivers/block/zram/zram_drv.c: In function 'read_block_state':
> > drivers/block/zram/zram_drv.c:674:16: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 5 has type '__kernel_time_t {aka long int}' [-Wformat=]
> >     "%12lu %12llu.%06lu %c%c%c\n",
> >            ~~~~~^
> >            %12lu
> >     (unsigned long)index, ts.tv_sec,
> >                           ~~~~~~~~~
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  drivers/block/zram/zram_drv.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > index f2f3104b2b48..635307e3238b 100644
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -671,8 +671,8 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
> >  
> >  		ts = ktime_to_timespec64(zram->table[index].ac_time);
> >  		copied = snprintf(kbuf + written, count,
> > -			"%12lu %12llu.%06lu %c%c%c\n",
> > -			(unsigned long)index, ts.tv_sec,
> > +			"%12lu %12lld.%06ld %c%c%c\n",
> > +			(unsigned long)index, (s64)ts.tv_sec,
> >  			ts.tv_nsec / NSEC_PER_USEC,
> >  			zram_test_flag(zram, index, ZRAM_SAME) ? 's' : '.',
> >  			zram_test_flag(zram, index, ZRAM_WB) ? 'w' : '.',
> > 
> 
> 	ssize_t index,
> 
> 	so why not print it with %zd (or %12zd) and skip the cast?

Thanks for the suggestion.
Resend.

Andrew, Could you pick up this?

>From 8af033804a8a7a0538629545957728c48d14d261 Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Mon, 7 May 2018 23:00:16 +0900
Subject: [PATCH] zram-introduce-zram-memory-tracking-update-fix-fix-fix

fix compile warning and use zd for ssize_t by Randy's suggestion.

drivers/block/zram/zram_drv.c: In function 'read_block_state':
drivers/block/zram/zram_drv.c:674:16: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 5 has type '__kernel_time_t {aka long int}' [-Wformat=]
    "%12lu %12llu.%06lu %c%c%c\n",
           ~~~~~^
           %12lu
    (unsigned long)index, ts.tv_sec,
                          ~~~~~~~~~
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/zram_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index f2f3104b2b48..ceadcd1245b3 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -671,8 +671,8 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 
 		ts = ktime_to_timespec64(zram->table[index].ac_time);
 		copied = snprintf(kbuf + written, count,
-			"%12lu %12llu.%06lu %c%c%c\n",
-			(unsigned long)index, ts.tv_sec,
+			"%12zd %12lld.%06ld %c%c%c\n",
+			index, (s64)ts.tv_sec,
 			ts.tv_nsec / NSEC_PER_USEC,
 			zram_test_flag(zram, index, ZRAM_SAME) ? 's' : '.',
 			zram_test_flag(zram, index, ZRAM_WB) ? 'w' : '.',
-- 
2.17.0.441.gb46fe60e1d-goog
