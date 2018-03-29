Date: Thu, 29 Mar 2018 06:15:53 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Minchan Kim <minchan@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Todd Kjos <tkjos@google.com>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Martijn Coenen <maco@android.com>
Subject: Re: [PATCH v3] ANDROID: binder: change down_write to down_read
Message-ID: <20180329041553.GA8299@kroah.com>
References: <20180329023712.133164-1-minchan@kernel.org>
 <20180329024204.GB91696@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180329024204.GB91696@rodete-desktop-imager.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 11:42:04AM +0900, Minchan Kim wrote:
> 
> On Thu, Mar 29, 2018 at 11:37:12AM +0900, Minchan Kim wrote:
> > binder_update_page_range needs down_write of mmap_sem because
> > vm_insert_page need to change vma->vm_flags to VM_MIXEDMAP unless
> > it is set. However, when I profile binder working, it seems
> > every binder buffers should be mapped in advance by binder_mmap.
> > It means we could set VM_MIXEDMAP in bider_mmap time which is
> > already hold a mmap_sem as down_write so binder_update_page_range
> > doesn't need to hold a mmap_sem as down_write.
> > 
> > Android suffers from mmap_sem contention so let's reduce mmap_sem
> > down_write.
> > 
> > Cc: Todd Kjos <tkjos@google.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Arve Hjønnevåg <arve@android.com>
> > Reviewed-by: Martijn Coenen <maco@android.com>
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> 
> Sent wrong version. Sorry for that. Please ignore this and take it.
> 
> >From 480e992d4a650fb98e1397114d75dea7af8e6d0c Mon Sep 17 00:00:00 2001
> From: Minchan Kim <minchan@kernel.org>
> Date: Wed, 28 Mar 2018 11:32:42 +0900
> Subject: [PATCH v3] ANDROID: binder: change down_write to down_read
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit

<snip>

I really don't want to hand-edit patches, please just send v4.

thanks,

greg k-h
