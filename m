Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AIpwx481dPVF2owO4GkDYh7Pcvou3rZepzsgUo6aeJBbzRVGOM32CaCJzv3R7aEhbSvLTeyGmQnf
ARC-Seal: i=1; a=rsa-sha256; t=1522306127; cv=none;
        d=google.com; s=arc-20160816;
        b=UpHNdVYYR91Xfupr0jZb9fWRIgi4+FZTw0kigYUtSsiUvmABj6RqlixYrYgCgRvwQB
         W7C1ytFdMZSJxRET4N0V7z7JuKFE+XwB46WPvD7oRQbKA+31QJ57NQ381t4/njaTqMGQ
         hdF4roAw9xIMhBv1u1YGquaZrBAmhmqJOL1T9y8kFyMeG+9CwFVFTfyr0BVM8gZEPSTX
         SbIVL1RCs7Q/ofHqePfcqEQHwDcw6C2h2e7tXeM/+5JfKg0944wRoKeuUdCaZZi7fHsq
         QTA2nfvekqPXUyEcqZ+B/v2tMyfVVP5343j8qu54YlTjj5oVsK0jqjxvvdkvQDMRM6B3
         zZqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=YvBwUw/AkmGV2sxMsZMNPlaDit1uvlJWd7Oax4JpScs=;
        b=qo2UAbjchaSzX/vVB4BcAGLe6qcQmWMjpm1jcSggoJm/WdlyXj2kAj3rtSUFBNa/Gx
         uh57njla1QNYG/KeoqxfhrgfdG9wRv+TFSISTwykV0DwKeMY/ZVt28gB9e4wqO6TABk8
         Nb2Q3fntyWDsOgR9D71AX/tGoqQVP7UydyqCEU17p0PrQeYON2ELS4uXMmSqN3W/Gu3V
         ZEwQzOXt6fP5boucReEIyiITl4d0m2rxzsZdox7QyznmYCs/8sA9P3oE9jCUraueJlbS
         7Y6cxbJfruNo5K4DBd5ecCBw2Ca/vBm082lQmHygfQgJVs76tqE5lQTmapxVx18M+kGM
         jvxA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.172 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.172 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:541:599:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3866:3867:3868:3870:3871:3872:4321:5007:7774:7903:10004:10400:10848:11026:11232:11658:11914:12296:12438:12679:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21451:21627:21740:30054:30070:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: heat91_1221e815dc220
X-Filterd-Recvd-Size: 1954
Message-ID: <1522306123.2210.28.camel@perches.com>
Subject: Re: [PATCH v4] ANDROID: binder: change down_write to down_read
From: Joe Perches <joe@perches.com>
To: Minchan Kim <minchan@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>, Todd Kjos
 <tkjos@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Martijn Coenen <maco@android.com>
Date: Wed, 28 Mar 2018 23:48:43 -0700
In-Reply-To: <20180329064013.198620-1-minchan@kernel.org>
References: <20180329064013.198620-1-minchan@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596231778699320743?=
X-GMAIL-MSGID: =?utf-8?q?1596253670066217456?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-03-29 at 15:40 +0900, Minchan Kim wrote:
> binder_update_page_range needs down_write of mmap_sem because
> vm_insert_page need to change vma->vm_flags to VM_MIXEDMAP unless
> it is set. However, when I profile binder working, it seems
> every binder buffers should be mapped in advance by binder_mmap.
> It means we could set VM_MIXEDMAP in bider_mmap time which is

typo trivia: binder_mmap

> already hold a mmap_sem as down_write so binder_update_page_range
> doesn't need to hold a mmap_sem as down_write.

and style trivia:

> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
[]
> @@ -4722,7 +4722,8 @@ static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
>  		failure_string = "bad vm_flags";
>  		goto err_bad_arg;
>  	}
> -	vma->vm_flags = (vma->vm_flags | VM_DONTCOPY) & ~VM_MAYWRITE;
> +	vma->vm_flags = (vma->vm_flags | VM_DONTCOPY | VM_MIXEDMAP) &
> +							~VM_MAYWRITE;

Perhaps this is clearer as

	vma->vm_flags |= VM_DONTCOPY | VM_MIXEDMAP;
	vma->vm_flags &= ~VM_MAYWRITE;
