Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751147AbeEJWbM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 18:31:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43422 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbeEJWbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 18:31:11 -0400
Date: Thu, 10 May 2018 15:31:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Chengguang Xu <cgxu519@gmx.com>
Cc: ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [V9fs-developer][PATCH v3 1/2] net/9p: detecting invalid
 options as much as possible
Message-Id: <20180510153109.ca9ac1c8d2308c37952a42c7@linux-foundation.org>
In-Reply-To: <1525340676-34072-1-git-send-email-cgxu519@gmx.com>
References: <1525340676-34072-1-git-send-email-cgxu519@gmx.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  3 May 2018 17:44:35 +0800 Chengguang Xu <cgxu519@gmx.com> wrote:

> Currently when detecting invalid options in option parsing,
> some options(e.g. msize) just set errno and allow to continuously
> validate other options so that it can detect invalid options
> as much as possible and give proper error messages together.
> 
> This patch applies same rule to option 'trans' and 'version'
> when detecting -EINVAL.

Looks OK.

It does mean that if two or more options cause errors, we will now
return the error code arising from the final error rather than from the
first error (or from some mish-mash mixture of both, as the present
code does).  But I don't think this matters.
