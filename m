Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903ABC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 16:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498122147A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 16:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tziRTvpj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 498122147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbeHVTxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 15:53:15 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38432 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbeHVTxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 15:53:15 -0400
Received: by mail-oi0-f65.google.com with SMTP id z185-v6so3732097oia.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 09:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=5f674gdTOoYB4MOXo6SLNpTo0jpC34o3oO+PhVRILBc=;
        b=tziRTvpjczahyKqWb80CDI34DDBknsDOEWOfG/4CHFILRMZmxhTU/BuVzFF1x8ZqqE
         /WPXiIPmDLMIF8B+nZK29NWziV/JeTKRez6ZaInOVisUjpaZmWyktBzkM0agwBCxYz9n
         hGxsdTdCwOz7q9DbU7xolxvGFexk537bM1W/bZ23XTiYgJefm33x3X9ZqhAMc883gETI
         Mfz6cPBStL5jsZslYVmkVNPUibVT6WHjU3/2wk9LTzCnAtWPLrtkb/OFfofl9LWoMgpc
         xsz4b6VyIPZuUlE0Jyqf+wx86a1W+5RHBYat5T2LnV61Kek8OVBbrLM6rU8LKsTsSBWD
         5W7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=5f674gdTOoYB4MOXo6SLNpTo0jpC34o3oO+PhVRILBc=;
        b=ASI/f+Xe2+f8xmNP4/Kfs1tCip/TubAhPDNXnxgY8c+faJBMHmHhAV+lzyyJBEgsjZ
         ucKoFkxEnPG5frfGGhKfxnvhClKorvWV9S3pKEM73KQMO/uFVzx/KycWL8t6GLyOggrZ
         yr1404NCoPfSfVW4Aji4oEF3flzjltFMBHcraoWNrwPxvjcL4GbwakDjLf/fUhqy9KBa
         pVBeMAKir9W6fgIAz8VsAZpb7tBe38wGL49us/KfUfSUWSHyBPJ91b6fl2irEpP96qL8
         Cys7+dxR7KK7hxeHAZjHU9w35xO4vWP3tMPviCw5LD4vXPMRf5ZsSAdhluwdJ58zKyBF
         C88A==
X-Gm-Message-State: APzg51B2TzwkQ8EOvF3npLVcWJvMtDXgz4GLSPfjGJt+PHhHS+VlDnQX
        xSckMsbH2RhlBBHQsZuV+elilX4=
X-Google-Smtp-Source: ANB0VdZosweQ4av3vktHhFrQnJXnXwDU0MZMc+DkABIfOcnoqvytPuRp/1UJGcTyotFZc6y5LTBwog==
X-Received: by 2002:aca:3ad4:: with SMTP id h203-v6mr4350118oia.294.1534955260895;
        Wed, 22 Aug 2018 09:27:40 -0700 (PDT)
Received: from [192.168.27.3] ([47.184.170.128])
        by smtp.gmail.com with ESMTPSA id s3-v6sm1115929oif.22.2018.08.22.09.27.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 09:27:40 -0700 (PDT)
Reply-To: minyard@acm.org
Subject: Re: [PATCH] Remove redundant cleanup in ipmi_register_smi
To:     Justin Ernst <justin.ernst@hpe.com>,
        Corey Minyard <minyard@acm.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Russ Anderson <russ.anderson@hpe.com>
References: <20180821152534.30367-1-justin.ernst@hpe.com>
From:   Corey Minyard <tcminyard@gmail.com>
Message-ID: <42513566-6982-c9c4-dbbb-ed98bd332fe9@gmail.com>
Date:   Wed, 22 Aug 2018 11:27:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180821152534.30367-1-justin.ernst@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/21/2018 10:25 AM, Justin Ernst wrote:
> When ipmi_register_smi fails, it performs a small cleanup routine
> before returning its error value. In try_smi_init, on the condition that
> ipmi_register_smi fails, ipmi_unregister_smi is called. ipmi_unregister_smi
> performs the same cleanup routine as ipmi_register_smi. This results in
> a kernel NULL pointer dereference. Removing the cleanup routine in
> ipmi_register_smi results in proper cleanup of a ipmi_register_smi failure.

This is almost certainly wrong.  If ipmi_register_smi() fails, the 
calling code shouldn't call
ipmi_unregister_smi().

However, I think I know what is going wrong.  ipmi_register_smi() can 
fail after the interface
is initialized, if so the registering code will think it is registered 
and call ipmi_unregister_smi()
on a failure.  I'll send a patch for this.

-corey

>
> Cc: Corey Minyard <minyard@acm.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jeremy Kerr <jk@ozlabs.org>
> Cc: openipmi-developer@lists.sourceforge.net
> Cc: linux-kernel@vger.kernel.org
> Cc: Russ Anderson <russ.anderson@hpe.com>
> Acked-by: Andrew Banman <abanman@hpe.com>
> Signed-off-by: Justin Ernst <justin.ernst@hpe.com>
> ---
>   drivers/char/ipmi/ipmi_msghandler.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index 51832b8a2c62..3b0b50c4f064 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -3395,12 +3395,12 @@ int ipmi_register_smi(const struct ipmi_smi_handlers *handlers,
>   
>    out:
>   	if (rv) {
> -		ipmi_bmc_unregister(intf);
> -		list_del_rcu(&intf->link);
> +		/*
> +		 * ipmi_unregister_smi must be called to clean up after
> +		 * failure. We unlock the mutex to allow ipmi_unregister_smi
> +		 * to lock it and perform cleanup.
> +		 */
>   		mutex_unlock(&ipmi_interfaces_mutex);
> -		synchronize_srcu(&ipmi_interfaces_srcu);
> -		cleanup_srcu_struct(&intf->users_srcu);
> -		kref_put(&intf->refcount, intf_free);
>   	} else {
>   		/*
>   		 * Keep memory order straight for RCU readers.  Make


