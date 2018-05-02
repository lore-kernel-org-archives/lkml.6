Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751054AbeEBSkt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 14:40:49 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52660 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbeEBSks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 14:40:48 -0400
Date: Wed, 2 May 2018 19:40:47 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iov_iter: fix memory leak in pipe_get_pages_alloc()
Message-ID: <20180502184047.GV30522@ZenIV.linux.org.uk>
References: <1525285017-18616-1-git-send-email-idryomov@gmail.com>
 <1525285017-18616-2-git-send-email-idryomov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525285017-18616-2-git-send-email-idryomov@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 08:16:57PM +0200, Ilya Dryomov wrote:
> Make n signed to avoid leaking the pages array if __pipe_get_pages()
> fails.

Applied, with s/fails/& to allocate any pages/.
