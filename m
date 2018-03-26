Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752233AbeCZOZc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 10:25:32 -0400
Received: from mail-yb0-f177.google.com ([209.85.213.177]:44282 "EHLO
        mail-yb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752053AbeCZOZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 10:25:31 -0400
X-Google-Smtp-Source: AG47ELtgOYcTtOIsAxei/D2YP6s8xzTj8FjSzVudAZ+d1axPaTBg973FucmVbMPY6YsGTqxNgiojig==
Date: Mon, 26 Mar 2018 07:25:27 -0700
From: Tejun Heo <tj@kernel.org>
To: yuankuiz@codeaurora.org
Cc: cgroups@vger.kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, pkondeti@codeaurora.org,
        cgroups-owner@vger.kernel.org
Subject: Re: [PATCH]cgroup: __cpuset_node_allowed return bool
Message-ID: <20180326142527.GJ2149215@devbig577.frc2.facebook.com>
References: <d2f9fe6096235032f445ab88e562560f@codeaurora.org>
 <0fee75e4a1b12f5fca30e04306a95788@codeaurora.org>
 <20180326141212.GI2149215@devbig577.frc2.facebook.com>
 <3540bc7869927f54c409b697c743938a@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3540bc7869927f54c409b697c743938a@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 10:20:43PM +0800, yuankuiz@codeaurora.org wrote:
>  1) return int type variable in bool function:
>  bool enabled()
>  {
>  	int ret = 1;
>  	return ret;
>  }
...
>  2)
>  bool enabled()
>  {
>  	bool ret = 1;
>  	return ret;
>  }
...
>  so the #1) style function can generate significant instructions
> than the #2).

That is a problem for the compiler, not the code.

>  While, this is happened only when "-On" is not used with *-gcc
> together. Though, it is oftern there, it is best to provide this
> with decoupling of which option is used for optimization.

We don't want to dictate minute coding styles to avoid things which
are trivially optimized by compilers.

Thanks.

-- 
tejun
