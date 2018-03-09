Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932774AbeCIWtk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 17:49:40 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36512 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932195AbeCIWtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 17:49:39 -0500
Date: Fri, 9 Mar 2018 14:49:38 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: register filesystem last
Message-Id: <20180309144938.d308e0bf98fb6b5bbcb82189@linux-foundation.org>
In-Reply-To: <20180309222709.GA3843@avx2>
References: <20180309222709.GA3843@avx2>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Mar 2018 01:27:09 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> As soon as register_filesystem() exits, filesystem can be mounted.
> It is better to present fully operational /proc.
> 
> Of course it doesn't matter because /proc is not modular
> but do it anyway.
> 
> Drop error check, it should be handled by panicking.

So... shouldn't we add a call to panic()?
