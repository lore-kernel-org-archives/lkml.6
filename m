Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753798AbeDTHDC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 03:03:02 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:41641 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753685AbeDTHDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 03:03:00 -0400
X-Google-Smtp-Source: AB8JxZpxQBWzRSC6MuIorI3cHnSsjIQmNfzzfphfnw4z8h5UhKcGmUrk39V9AKwrRkNj6mrYxHPT5A==
Date: Fri, 20 Apr 2018 10:02:57 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, Andrey Vagin <avagin@openvz.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [v2] prctl: Deprecate non PR_SET_MM_MAP operations
Message-ID: <20180420070257.GJ19578@uranus.lan>
References: <20180405182651.GM15783@uranus.lan>
 <20180420023809.GD6397@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420023809.GD6397@jagdpanzerIV>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 11:38:09AM +0900, Sergey Senozhatsky wrote:
> On (04/05/18 21:26), Cyrill Gorcunov wrote:
> [..]
> > -
> >  #ifdef CONFIG_CHECKPOINT_RESTORE
> >  	if (opt == PR_SET_MM_MAP || opt == PR_SET_MM_MAP_SIZE)
> >  		return prctl_set_mm_map(opt, (const void __user *)addr, arg4);
> >  #endif
> >  
> > -	if (!capable(CAP_SYS_RESOURCE))
> > -		return -EPERM;
> > -
> > -	if (opt == PR_SET_MM_EXE_FILE)
> > -		return prctl_set_mm_exe_file(mm, (unsigned int)addr);
> > -
> > -	if (opt == PR_SET_MM_AUXV)
> > -		return prctl_set_auxv(mm, addr, arg4);
> 
> Then validate_prctl_map() and prctl_set_mm_exe_file() can be moved
> under CONFIG_CHECKPOINT_RESTORE ifdef.

I don't mind. Could you please make the patch on top of linux-next?
