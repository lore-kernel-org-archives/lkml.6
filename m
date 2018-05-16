Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZqrz7X1VPCGvfeuk+H/iEdI4roY7/x0oGmGDvJJVRiHXB814dF3qf726N6L1wkFr9nkIy0S
ARC-Seal: i=1; a=rsa-sha256; t=1526489045; cv=none;
        d=google.com; s=arc-20160816;
        b=r0c1GWrryP4tnES8nhZ9MOLRoDTQr3f6oJZ9GU4bqEovFmNHkSJ5q0yCpnd2hVTVjZ
         xbdGPrXG+nGHpoWMvP68asPfolLdjwQhistShKNJZsc7YkH25pgqwUUMwvifEU3Xgq5F
         qcWeJET2au0lxA9QyKbce07k/YJKS83pO9ZjMxIeaTVWRen2y5JtEmomZFj29Mw7VPI1
         Ke6MXQvod9pmuFC7QrxozKXcIhZthcm9VZW2iJ92nZQkwxXDIJH6jc4/g/B3QFJi6Gjq
         g6sgpZa1OhGD0WPlTulddcx2/VfJI/fIgMxXaHJJ1gsa1SfmTzjP83SR7RNcdg+ckIBR
         mQQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=5Jrg6yd6JUnxs/ikY3Kph4uJ5uS0GYZpm1c4/1UcpmY=;
        b=Ks31P6lNyFcNRWYbALPHHk+Gf5InW4+cO7sTEwceyjdUdk9tRokO/j8LcXaUW/8joA
         q7MUvvCoG/QQpgIC5gi5JMMtOpcioyAqZHXlF0SOORYBmsky+M8XUzR76VEHJZAsq6KB
         mzxSLwzc/i7bjiCp0HA3Ecoq2OtrthtZMdWTeZ2wxHWpLg5Ua0LE8o4NdZ9tXpBTsOGy
         b1nhtL8qrL/AmzZsrEQBr64j9DG0tVn2Cur9+yDOY5zH95m/i5DwYc63jh4Qzu8wAGSM
         xEAl2ne6dczYWaZBUupJ8e7Sfip2HKuIkDFRQR/+iQ0fQbKNh2u8xYJr7Dtl9gBU6e1k
         aE2w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Wed, 16 May 2018 18:44:03 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: arnd@arndb.de, gregkh@linuxfoundation.org, willy@infradead.org
Cc: mcgrof@kernel.org, geert@linux-m68k.org,
	linux-m68k@lists.linux-m68k.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] mm: PAGE_KERNEL_* fallbacks
Message-ID: <20180516164403.GI27853@wotan.suse.de>
References: <20180510185507.2439-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510185507.2439-1-mcgrof@kernel.org>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600039618816101704?=
X-GMAIL-MSGID: =?utf-8?q?1600639777115561033?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 10, 2018 at 11:55:05AM -0700, Luis R. Rodriguez wrote:
> This is the 3rd iteration for moving PAGE_KERNEL_* fallback
> definitions into asm-generic headers. Greg asked for a Changelog
> for patch iteration changes, its below.
> 
> All these patches have been tested by 0-day.
> 
> Questions, and specially flames are greatly appreciated.

*Poke*

Who's tree should this go through?

  Luis

> 
> v3:
> 
> Removed documentation effort to keep tabs on which architectures
> currently don't defint the respective PAGE_* flags. Keeping tabs
> on this is just not worth it.
> 
> Ran a spell checker on all patches :)
> 
> v2:
> 
> I added a patch for PAGE_KERNEL_EXEC as suggested by Matthew Wilcox.
> 
> v1:
> 
> I sent out a patch just for dealing witht he fallback mechanism for
> PAGE_KERNEL_RO.
> 
> Luis R. Rodriguez (2):
>   mm: provide a fallback for PAGE_KERNEL_RO for architectures
>   mm: provide a fallback for PAGE_KERNEL_EXEC for architectures
> 
>  drivers/base/firmware_loader/fallback.c |  5 -----
>  include/asm-generic/pgtable.h           | 18 ++++++++++++++++++
>  mm/nommu.c                              |  4 ----
>  mm/vmalloc.c                            |  4 ----
>  4 files changed, 18 insertions(+), 13 deletions(-)
> 
> -- 
> 2.17.0
> 
> 

-- 
Do not panic
