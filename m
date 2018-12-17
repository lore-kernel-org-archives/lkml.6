Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81723C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2822133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545055524;
	bh=/8naT9EXohJMAtwAgjscgFk1nJZDJDMyTw4h4NlaKDE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=kM1eVZF04OmMk4NSA+MNtYu0tyFiN3tsaq2m2Jua0/8dXhhtQj65a4ZKlpsqG/jJA
	 +7S+EoERUOFgkUuEl+XYuPDP1Ezro5vKe34qinGNj6b4etcW1fn3aUT/cRTpwWTMI6
	 BVdB+1OdgrL8a+hCzeZSSGi4bIGd9i4yruE7IwIo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732633AbeLQOFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:05:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:47994 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726673AbeLQOFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:05:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6DE21AD63;
        Mon, 17 Dec 2018 14:05:21 +0000 (UTC)
Date:   Mon, 17 Dec 2018 15:05:20 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Pan Bian <bianpan2016@163.com>
cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: intel-ish-hid: fixes incorrect error handling
In-Reply-To: <1542847953-127599-1-git-send-email-bianpan2016@163.com>
Message-ID: <nycvar.YFH.7.76.1812171505100.17216@cbobk.fhfr.pm>
References: <1542847953-127599-1-git-send-email-bianpan2016@163.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2018, Pan Bian wrote:

> The memory chunk allocated by hid_allocate_device() should be released
> by hid_destroy_device(), not kfree().
> 
> Fixes: 0b28cb4bcb1("HID: intel-ish-hid: ISH HID client driver")
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>  drivers/hid/intel-ish-hid/ishtp-hid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/ishtp-hid.c b/drivers/hid/intel-ish-hid/ishtp-hid.c
> index cd23903..e918d78 100644
> --- a/drivers/hid/intel-ish-hid/ishtp-hid.c
> +++ b/drivers/hid/intel-ish-hid/ishtp-hid.c
> @@ -222,7 +222,7 @@ int ishtp_hid_probe(unsigned int cur_hid_dev,
>  err_hid_device:
>  	kfree(hid_data);
>  err_hid_data:
> -	kfree(hid);
> +	hid_destroy_device(hid);
>  	return rv;

Applied to for-4.20/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

