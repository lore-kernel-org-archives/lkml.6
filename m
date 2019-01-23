Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A93C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7852621872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbkZEx2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfAWWVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 17:21:35 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41314 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfAWWVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 17:21:34 -0500
Received: by mail-yw1-f68.google.com with SMTP id f65so1585424ywc.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 14:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O0mGc987OtQsEjsYvbycooF1cumBqoiFK5EIP321jyE=;
        b=FbkZEx2WChHfVrey6sz2jvIgKtXWWhgq2d9YpjBkGUf66ZezutKjJRkFd8Ju/WptJm
         NW6OzsPvhhFWsPa/xD01s/zgVuJdTa9GzcELjAHRBiQsaVbspMX790fTHl5Vd5nYgj6y
         DFmDHa35K50ND0QslEbdJvup1NcmxYNlQR6h0xpFOMq70kVCSYw3ZsbUNfSFfcn3m0Hc
         UfXtT4MwoCalzrJrsmTN6ZX3fUEU9LdmFBHOBw4XSjFpLeKWwxmNmpBTi5Cg0qZIZXAH
         2CS9i/hCHm2d+Anu0zCZvU8kiqFyqdJXg3l9QTlyS6XDbtqSw0Oqb5HpRQJpk+ZUXdNU
         9dNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O0mGc987OtQsEjsYvbycooF1cumBqoiFK5EIP321jyE=;
        b=i0Dp0hWSaQgJIqXZjCAm11h6JxbdEmMlBntiDjLyhKGeI114dYFCFVMpF94cCFk1p9
         +xQGNKke0/NLJrfZR4RlQwjh/cHBFQaQYkpZeqOvfJLlY1HT8KHlIKaBW0Wdaa3eVhPP
         FoGplbcHf7rOoyd87yApUcjJ0ieQhTTjO9sOhMyegw/FP6KHvnjMKIf29fSwjl4xTEua
         O1AQPEH6uVZzCd7rB/p1QocbKfPzRYWJ/ZjB8yeuEfi6wfjHT8RR3bwDuUQCQYXpDF5R
         ZEFjYMfHmlg6QRCuLiOMB6l3Hvx2F46V+XmZTD5CrM3OAWJg7VxyF1Za6HRCgc6KzD3B
         hxXw==
X-Gm-Message-State: AJcUuke9g9f7qDRKz+Lkd6hwre6s53zZdOMV/t5t/chKd1WhdKhkL2Q0
        fXCI+BHoBSs2HNwJD03uxClWV+Or/ns=
X-Google-Smtp-Source: ALg8bN6SqbvHs66GYHEQnjlB+VTui8IVUPBWNMNoxIKNmqV53ACJHkQGaskQ3fR2lWcmQdXSZoSAFQ==
X-Received: by 2002:a0d:de87:: with SMTP id h129mr4050360ywe.200.1548282093289;
        Wed, 23 Jan 2019 14:21:33 -0800 (PST)
Received: from mmccoy (cpe-2606-A000-111F-7E1-241A-8A48-C4E8-C468.dyn6.twc.com. [2606:a000:111f:7e1:241a:8a48:c4e8:c468])
        by smtp.gmail.com with ESMTPSA id z139sm10482034ywa.36.2019.01.23.14.21.32
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jan 2019 14:21:32 -0800 (PST)
Date:   Wed, 23 Jan 2019 17:21:31 -0500
From:   Matt McCoy <mattmccoy110@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Quytelda Kahja <quytelda@tamalin.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: ks7010: remove unnecessary parentheses
Message-ID: <20190123222131.GA10543@mmccoy>
References: <20190123021816.GA3478@mmccoy>
 <de570801f163a8d4972661ef794e910a8e1beed5.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de570801f163a8d4972661ef794e910a8e1beed5.camel@perches.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 06:45:37PM -0800, Joe Perches wrote:
> On Tue, 2019-01-22 at 21:18 -0500, Matt McCoy wrote:
> > Remove unnecessary parentheses reported by checkpatch.
> []
> > diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
> []
> > @@ -171,7 +171,7 @@ int get_current_ap(struct ks_wlan_private *priv, struct link_ap_info *ap_info)
> >  		   "- rate_set_size=%d\n",
> >  		   ap->bssid[0], ap->bssid[1], ap->bssid[2],
> >  		   ap->bssid[3], ap->bssid[4], ap->bssid[5],
> > -		   &(ap->ssid.body[0]),
> > +		   &ap->ssid.body[0],
> >  		   ap->rate_set.body[0], ap->rate_set.body[1],
> >  		   ap->rate_set.body[2], ap->rate_set.body[3],
> >  		   ap->rate_set.body[4], ap->rate_set.body[5],
> 
> This bit:
> 
> []
> 	netdev_dbg(priv->net_dev, "Link AP\n"
> 		   "- bssid=%02X:%02X:%02X:%02X:%02X:%02X\n"
> []
> 		   ap->bssid[0], ap->bssid[1], ap->bssid[2],
> 
> should instead use the vsprintf %pM extension
> 
> 		"- bssid: %pM\n"
> []
> 		ap->bssid,
> 
>

Should I just make a v2 of this patch with 2 parts ?
One being this change and the other using the %pM extension.
