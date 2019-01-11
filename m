Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3387C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706A020874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547199763;
	bh=GpbqKr9FE4wSb4TSnHkz8ogcPEIWfV7Aq9ULtqOOsF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CikJsp/L93a5LHmAFtiC0oURa68NoTe+nwuUrX558pJ1pFapxs/f5hVnFjC1NXZhC
	 lI2+hp6JzK1ymSvGazFpXXZyhQwkSHNnbAx81f7AncGoWDEOz0syynobQBk2WpLiAn
	 GWKed3aJGvRx8ge6Ok7QJAK4t5GWqym9IcVryrpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbfAKJmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:42:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:37814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729413AbfAKJmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:42:42 -0500
Received: from localhost (unknown [178.228.36.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0142620874;
        Fri, 11 Jan 2019 09:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547199761;
        bh=GpbqKr9FE4wSb4TSnHkz8ogcPEIWfV7Aq9ULtqOOsF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wFXcQSxEasiW6RDApKAsNIY9TBGS6LHX88gpC3812FEjJCamlMULzbTaKpyIpeaI1
         j/Rym9vKtOj4IHozQoBEgknfnz4TmZSF0LUwRTTf8ZSWLHbulL7dyBLlti8yAY0xkZ
         145fL7UPGxprhB9VhKDTtxTI6kmLT7X7erWw9oGo=
Date:   Fri, 11 Jan 2019 10:42:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vboxvideo: vbox_main: Remove unnecessary local
 variable
Message-ID: <20190111094238.GA28232@kroah.com>
References: <20190110061347.31326-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110061347.31326-1-realwakka@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 06:13:47AM +0000, Sidong Yang wrote:
> Removed unnecessary local variable in have_hgsmi_mode_hints.
> The result of hgsmi_query_conf should be directly compared without
> assigning to local variable.
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
>  drivers/staging/vboxvideo/vbox_main.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/vboxvideo/vbox_main.c b/drivers/staging/vboxvideo/vbox_main.c
> index e1fb70a42d32..62a69fde7435 100644
> --- a/drivers/staging/vboxvideo/vbox_main.c
> +++ b/drivers/staging/vboxvideo/vbox_main.c
> @@ -170,18 +170,15 @@ static void vbox_accel_fini(struct vbox_private *vbox)
>  static bool have_hgsmi_mode_hints(struct vbox_private *vbox)
>  {
>  	u32 have_hints, have_cursor;
> -	int ret;
>  
> -	ret = hgsmi_query_conf(vbox->guest_pool,
> -			       VBOX_VBVA_CONF32_MODE_HINT_REPORTING,
> -			       &have_hints);
> -	if (ret)
> +	if (hgsmi_query_conf(vbox->guest_pool,
> +			     VBOX_VBVA_CONF32_MODE_HINT_REPORTING,
> +			     &have_hints))
>  		return false;

As Dan says, the original is best here.  I'm dropping this from my patch
queue.

thanks,

greg k-h
