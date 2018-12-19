Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF5AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA1D20989
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545225715;
	bh=7RxqZi9aFWcWGOXdBq33CgM2ix0xxeYeTeyI3IMwPQY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=gehuyGnEtjAs0RnNMhUIVhwJZ0Cpy9tNk3K0sIgwPakWTjyAhwcye3k4lVb8YPe/n
	 t5/5OTmVqVoJ17xurIzxJyM1DwNLpWGCc7eXlLsJ3iOxOdVzlavsVPSK/ZvqTxUOhO
	 HsqUuwCB8NhNv9okfmQfqD+ptc7oOnEyhXtJk+BY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbeLSNVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:21:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:53884 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728135AbeLSNVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:21:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 810ABAEF3;
        Wed, 19 Dec 2018 13:21:51 +0000 (UTC)
Date:   Wed, 19 Dec 2018 14:21:50 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: debug: Change to use DEFINE_SHOW_ATTRIBUTE macro
In-Reply-To: <20181201024951.5508-1-tiny.windzz@gmail.com>
Message-ID: <nycvar.YFH.7.76.1812191421360.17216@cbobk.fhfr.pm>
References: <20181201024951.5508-1-tiny.windzz@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018, Yangtao Li wrote:

> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/hid/hid-debug.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
> index b48100236df8..c530476edba6 100644
> --- a/drivers/hid/hid-debug.c
> +++ b/drivers/hid/hid-debug.c
> @@ -1072,11 +1072,6 @@ static int hid_debug_rdesc_show(struct seq_file *f, void *p)
>  	return 0;
>  }
>  
> -static int hid_debug_rdesc_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, hid_debug_rdesc_show, inode->i_private);
> -}
> -
>  static int hid_debug_events_open(struct inode *inode, struct file *file)
>  {
>  	int err = 0;
> @@ -1211,12 +1206,7 @@ static int hid_debug_events_release(struct inode *inode, struct file *file)
>  	return 0;
>  }
>  
> -static const struct file_operations hid_debug_rdesc_fops = {
> -	.open           = hid_debug_rdesc_open,
> -	.read           = seq_read,
> -	.llseek         = seq_lseek,
> -	.release        = single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(hid_debug_rdesc);

Applied to hid.git#for-4.21/core. Thanks,

-- 
Jiri Kosina
SUSE Labs

