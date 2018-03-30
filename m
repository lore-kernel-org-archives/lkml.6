Return-Path: <minchan.kim@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522370262; cv=none;
        d=google.com; s=arc-20160816;
        b=EMc6ZWDymlAXBma6P+huODcVwYYrggKwfl2n/uIy+Xfdmo0TtH6efIs8Sdq6PQx9Jy
         s7wmkdmYAn65btBVY/4GJNLmnbZWiDgvre3UA0tX2vsE7RN/vZdURHqBvVTNVZAZIwsz
         VVh5jeQjDWoBeCJxwO9DmuSJG6WDxBqO8o22yvlk9nwlBYlLg0Xz/Hst5R5F8fiI9L6y
         5Jv/QDUo4H+a1m6TLwv/K+GsSqdG7Kv3xc7iMboRgh14vXRAl4eSQrDoHGWDqp/GePXW
         H/WIWeTFIke3fkhw6IO32lTfEgrrrcWs7Th2exvHn65JE/i86Tk6/qsP7V5B5RcLG0wt
         /96Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=IxEwZEJj6+qbs6cuqEWTfCuKS6KvXokLm/Ahj3q6rbs=;
        b=ToR6VhPikYX3QKH42NhXBvmX+TNCRLMdOVtgIH1yEKy9/vye1jcW8d4KtBHfmlAioo
         bYdGJI3b3uN5SMnk/Feq9ynNobiEDvw75+o2ufHWEUROzAYws0mfxrtjKgNorn4CN4wg
         M4mOMv4bbG/ugwWn471H5QaKHFC0hBSZIyQYWyPIJF0HWvpTwD2kVBzPvkh4sryepDN8
         arLjBmgKrfIi02a889sk3PZU3KP1Anw3NevhSWYV2F+X9+Ai6ukj31gkiB7ncUA+FNKu
         ULha5MhOS5Ur6tPhj9zqGYnW3g6Sd1fM/1Yh9z0b3pRFDnS6x5rwHZEcLnCX4wCHQXky
         HXIg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JL20/ssP;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JL20/ssP;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
X-Google-Smtp-Source: AIpwx48RYdigI406sJJ/F5x3RShj2yu6h3Ug5yONJeDs4hNzvsAkrSkYiMoBcPeXtyXRCE/c/ECPZw==
Sender: Minchan Kim <minchan.kim@gmail.com>
Date: Fri, 30 Mar 2018 09:37:36 +0900
From: Minchan Kim <minchan@kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, LKML <linux-kernel@vger.kernel.org>,
	Todd Kjos <tkjos@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Martijn Coenen <maco@android.com>
Subject: Re: [PATCH v3] ANDROID: binder: change down_write to down_read
Message-ID: <20180330003736.GA255979@rodete-desktop-imager.corp.google.com>
References: <20180329023712.133164-1-minchan@kernel.org>
 <201803300705.KbdKYZ01%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201803300705.KbdKYZ01%fengguang.wu@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596231778699320743?=
X-GMAIL-MSGID: =?utf-8?q?1596320920764445035?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 07:42:37AM +0800, kbuild test robot wrote:
> Hi Minchan,
> 
> I love your patch! Yet something to improve:

Glad to hear.
It's first time someone loves my patch. ;-)

> 
> [auto build test ERROR on staging/staging-testing]
> [also build test ERROR on v4.16-rc7 next-20180329]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Minchan-Kim/ANDROID-binder-change-down_write-to-down_read/20180330-043057
> config: x86_64-randconfig-x014-201812 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers//android/binder.c: In function 'binder_mmap':
> >> drivers//android/binder.c:4725:24: error: 'struct vm_area_struct' has no member named 'flags'; did you mean 'vm_flags'?
>      vma->vm_flags = (vma->flags | VM_DONTCOPY | VM_MIXEDMAP) &
>                            ^~~~~
>                            vm_flags

http://lkml.kernel.org/r/<20180329065424.203172-1-minchan@kernel.org>

This time, I was little bit fast. :)
