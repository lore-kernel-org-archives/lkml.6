Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751372AbeBQVBY (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 16:01:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:51616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751230AbeBQVBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 16:01:22 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B00E21726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shli@kernel.org
Date: Sat, 17 Feb 2018 13:01:20 -0800
From: Shaohua Li <shli@kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-raid@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] md-multipath: Use seq_putc() in multipath_status()
Message-ID: <20180217210120.6wwgxiwcyewbubff@kernel.org>
References: <566ABCD9.1060404@users.sourceforge.net>
 <4a31d7a7-f70c-12f7-202f-963bd8706066@users.sourceforge.net>
 <6e70a1a7-fd86-914e-84ab-bd5c7facb235@users.sourceforge.net>
 <0b59904d-1be7-7a76-9c32-3f7f9696ff2d@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b59904d-1be7-7a76-9c32-3f7f9696ff2d@users.sourceforge.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 13, 2018 at 09:55:08AM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 13 Jan 2018 09:49:03 +0100
> 
> A single character (closing square bracket) should be put into a sequence.
> Thus use the corresponding function "seq_putc".
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
applied, thanks
> ---
>  drivers/md/md-multipath.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/md-multipath.c b/drivers/md/md-multipath.c
> index e40065bdbfc8..0a7e99d62c69 100644
> --- a/drivers/md/md-multipath.c
> +++ b/drivers/md/md-multipath.c
> @@ -157,7 +157,7 @@ static void multipath_status(struct seq_file *seq, struct mddev *mddev)
>  		seq_printf (seq, "%s", rdev && test_bit(In_sync, &rdev->flags) ? "U" : "_");
>  	}
>  	rcu_read_unlock();
> -	seq_printf (seq, "]");
> +	seq_putc(seq, ']');
>  }
>  
>  static int multipath_congested(struct mddev *mddev, int bits)
> -- 
> 2.15.1
> 
