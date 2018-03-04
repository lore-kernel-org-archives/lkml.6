Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932283AbeCDUxW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 15:53:22 -0500
Received: from mail-lf0-f48.google.com ([209.85.215.48]:39542 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932096AbeCDUxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 15:53:20 -0500
X-Google-Smtp-Source: AG47ELvh8kjU7vjCFUnpjNj4I9eZYnd71e4ByitWZLLf6L0YrCxB0njcvKb18vlslDd/bPeQxff8fw==
Date: Sun, 4 Mar 2018 23:53:17 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        xemul@virtuozzo.com
Subject: Re: [PATCH v2] proc: fix /proc/*/map_files lookup some more
Message-ID: <20180304205317.GB6757@uranus.lan>
References: <20180303215130.GA23480@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180303215130.GA23480@avx2>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 04, 2018 at 12:51:30AM +0300, Alexey Dobriyan wrote:
> I totally forgot that _parse_integer() accepts arbitrary amount of
> leading zeroes leading to the following lookups:
> 
> 		OK
> 	# readlink /proc/1/map_files/56427ecba000-56427eddc000
> 	/lib/systemd/systemd
> 
> 		bogus
> 	# readlink /proc/1/map_files/00000000000056427ecba000-56427eddc000
> 	/lib/systemd/systemd
> 	# readlink /proc/1/map_files/56427ecba000-00000000000056427eddc000
> 	/lib/systemd/systemd
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
