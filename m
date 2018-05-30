Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932563AbeEaACd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 20:02:33 -0400
Received: from mail-pl0-f54.google.com ([209.85.160.54]:34941 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932091AbeEaACa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 20:02:30 -0400
X-Google-Smtp-Source: ADUXVKKdSi9EA/vF/hfxY8qbfn5EEAY0MYygzf9l/zcYpBJtzMVTj1wU9nfgKx9al6hx0WSIzHABxQ==
Date: Thu, 31 May 2018 08:51:40 +0900
From: Jungsub Shin <supsup5642@gmail.com>
To: "J. R. Okajima" <hooanon05g@gmail.com>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Why is the length of max mount option a page size??
Message-ID: <20180530235140.GA3974@supsup-VirtualBox>
References: <20180521173959.GA12779@supsup-VirtualBox>
 <5670.1527244930@jrobl>
 <20180529002456.GA30767@supsup-VirtualBox>
 <20180529011412.GE30522@ZenIV.linux.org.uk>
 <20180529035703.GA32550@supsup-VirtualBox>
 <5878.1527648027@jrobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5878.1527648027@jrobl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 11:40:27AM +0900, J. R. Okajima wrote:
> Jungsub Shin:
> > Do you mean using symlinks or bind mount to reduce length of mount
> > options?? I can remove "~/tca_agent/image_layer_dir" string. But the
> > other character means unique ID of layer and i can't compress it or
> > replace it to another string. This is not fundamental solution. Docker=20
> 
> Can't it be a solution?
> 
> # mount -o bind /long/path0 /br0
> # mount -o bind /long/path1 /br1
> 	:::
> # mount -t aufs -o br=/br0:/br1:... none /mntpnt
> 
> or
> 
> # ln -s /long/path0 /br0
> # ln -s /long/path1 /br1
> 	:::
> # mount -t aufs -o br=/br0:/br1:... none /mntpnt
> 
> 
> J. R. Okajima

I don't test them, but they will work well.
That's temporary solution. So i'm use remount,append option.

Thanks
