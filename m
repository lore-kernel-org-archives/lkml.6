Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932653AbeCJAGj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 19:06:39 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38746 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932503AbeCJAGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 19:06:38 -0500
X-Google-Smtp-Source: AG47ELtUwxP80jXov/HfUGhKWt/bK7VcxyDhbgH1/Fr29LSsUUIk7jsflEVZSq8dhSA420MfJn5aag==
Date: Sat, 10 Mar 2018 03:06:34 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: register filesystem last
Message-ID: <20180310000634.GA12443@avx2>
References: <20180309222709.GA3843@avx2>
 <20180309144938.d308e0bf98fb6b5bbcb82189@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309144938.d308e0bf98fb6b5bbcb82189@linux-foundation.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 02:49:38PM -0800, Andrew Morton wrote:
> On Sat, 10 Mar 2018 01:27:09 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > As soon as register_filesystem() exits, filesystem can be mounted.
> > It is better to present fully operational /proc.
> > 
> > Of course it doesn't matter because /proc is not modular
> > but do it anyway.
> > 
> > Drop error check, it should be handled by panicking.
> 
> So... shouldn't we add a call to panic()?

via FS_PANIC flag, yes. I have a patch somewhere.
There are 104 filesystems ATM, some internal, some not.
Some modular, some not.
