Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752078AbeCMHUe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 03:20:34 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:38941 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751971AbeCMHUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 03:20:33 -0400
X-Google-Smtp-Source: AG47ELue/PqCuLjIl4Q0g5Aa2pNtHHbOxTo+XEfmwR+PPdQPJymDYCHxzogJTcwPGT7BKQHrsw+2LQ==
Date: Tue, 13 Mar 2018 10:20:29 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, eric.dumazet@gmail.com,
        xiyou.wangcong@gmail.com, fw@strlen.de
Subject: Re: [PATCH] proc: reject "." and ".." as filenames
Message-ID: <20180313072029.GA3176@avx2>
References: <20180310001223.GB12443@avx2>
 <20180312160018.5d4cb6917c84b2805ff32d1d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312160018.5d4cb6917c84b2805ff32d1d@linux-foundation.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 04:00:18PM -0700, Andrew Morton wrote:
> -	if (qstr.len == 1 && fn[0] == '.') {
> -		WARN(1, "name '.'\n");
> +	if (WARN(qstr.len == 1 && fn[0] == '.', "name '.'\n"))
>  		return NULL;
> -	}

Oh, I hate this style of WARN.
For one thing it overlaps with comma operator.
