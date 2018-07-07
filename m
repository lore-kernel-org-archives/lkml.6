Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CC4C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C8C20C0C
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10C8C20C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754074AbeGGOFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 10:05:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52242 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753173AbeGGOFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 10:05:23 -0400
Received: from localhost (unknown [37.168.185.56])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3BF49DB7;
        Sat,  7 Jul 2018 14:05:21 +0000 (UTC)
Date:   Sat, 7 Jul 2018 16:05:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tamir Suliman <tsuliman@linuxvaults.com>
Cc:     w.d.hubbs@gmail.com, speakup@linux-speakup.org,
        dhowells@redhat.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, chris@the-brannons.com
Subject: Re: [PATCH 3/3] drivers/speakup: kobjects : Fixed Coding issues
 -Debugging
Message-ID: <20180707140518.GB7052@kroah.com>
References: <1530756740-14168-1-git-send-email-tsuliman@linuxvaults.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530756740-14168-1-git-send-email-tsuliman@linuxvaults.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 02:12:20AM +0000, Tamir Suliman wrote:
> Updated printk() of i18n messages to include KERN_INFO facility level to improve debuggin.
> then later noticed that I forgot to add a space on printk.
> 
> Signed-off-by: Tamir Suliman <tsuliman@linuxvaults.com>
> ---
>  drivers/staging/speakup/kobjects.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/speakup/kobjects.c b/drivers/staging/speakup/kobjects.c
> index 7e79f99..af664f0 100644
> --- a/drivers/staging/speakup/kobjects.c
> +++ b/drivers/staging/speakup/kobjects.c
> @@ -740,7 +740,7 @@ static void report_msg_status(int reset, int received, int used,
>  			snprintf(buf + (len - 1), sizeof(buf) - (len - 1),
>  				 " with %d reject%s\n",
>  				 rejected, rejected > 1 ? "s" : "");
> -		printk(KERN_INFO "i18n messages rejected\n",buf);
> +		printk(KERN_INFO "i18n messages rejected\n", buf);
>  	}
>  }
>  
> -- 
> 1.8.3.1

Where are patches 1 and 2 of this series?

And the changelog text does not match what the text itself does, so I
can't take this as-is :(

greg k-h
