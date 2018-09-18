Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA57ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C96B20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZcsGG1x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C96B20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbeIRWGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:06:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45235 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730136AbeIRWGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:06:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id i26-v6so1262408pfo.12;
        Tue, 18 Sep 2018 09:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kbkq7QPlT82VaZvzmmAYBTMJShUCSXYbj45gJB1vMLk=;
        b=jZcsGG1xpwfPjkkHXCyGlQpCJMArwBeyCS5SkmTtJAYyI3C4tbLkDudtxBhgDu6Vwh
         thVy4KptcZ3dkM4+fZ58InFkXomDw8Z4G0tB8NthFgYOIvvgg8yse5VtuCeX8GGu+qsf
         lls5rNDDcFwtlu2n2MPWdRmjy7nPcRMEDMyQ6bml2YhxWJIPL86rFSore+RbJi8WoZNm
         FC5mEXv1+LSNBDS95eNNzCLOhyE1OYv14F3MwihlZfjDGt1JPQEhueX+73KazAWPkEs4
         /L1uES7SfDAPLzipdJwjOFcc0FDNJonRpHTuLFH4ZDKjXzYVkljH4Qstyuovjxqh4lcg
         cqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kbkq7QPlT82VaZvzmmAYBTMJShUCSXYbj45gJB1vMLk=;
        b=ZqHIA2QNGbRi97IHCKYpeI8bJ24b/1tp+YBsAB9N+MfieYf7b6Dk3adiTlO0BOsARQ
         iLjIq/NkALEMfeRD5zl0AqGAjNHfFvRgE5CrppTP16oaC6UG+MpXlmYNTK7K2q3tdpKY
         o7f1iSKy1QT5tBv45ISpMb3KYPk/T9vd44JWg7sfPboaQn9VT5QTWYHNbohWfml2fujP
         4kKDYUBrg0t2gMWfHAaJ7X/67aLN6Ph3IH7844Yvyy/aXgmGAmmz2y6k2TJGstVZ1k+I
         imKip+zRV5MWXidkno9fPP+mRXcQc4Qz0ZjwAYihAXzngkE3S9BbTEYywmgi9tmsNK4e
         wnSw==
X-Gm-Message-State: APzg51D++4647x5NRi7u5eXF7cEbmKo+/pFjHFp6j2joDsuh16ICaT5M
        N25PIJdBNpp0b5jXl34kKRc=
X-Google-Smtp-Source: ANB0VdYhkNpvGMOdSFb0nC0rarQ/+8Hj2oss9whzTIuAlNNQeX3QtG3bknT9Pr1L7HjAjM7RMhT8Jw==
X-Received: by 2002:a62:ba0b:: with SMTP id k11-v6mr31865860pff.171.1537288365199;
        Tue, 18 Sep 2018 09:32:45 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id s85-v6sm30330932pfa.116.2018.09.18.09.32.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 09:32:44 -0700 (PDT)
Date:   Tue, 18 Sep 2018 09:32:42 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Aaron Ma <aaron.ma@canonical.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: elantech - enable middle button of touchpad on
 ThinkPad P72
Message-ID: <20180918163242.GA177805@dtor-ws>
References: <20180907070651.6916-1-aaron.ma@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907070651.6916-1-aaron.ma@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 03:06:51PM +0800, Aaron Ma wrote:
> Adding 2 new touchpad IDs to support middle button support.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>

Applied, thank you.

> ---
>  drivers/input/mouse/elantech.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index 44f57cf6675b..2d95e8d93cc7 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1178,6 +1178,8 @@ static const struct dmi_system_id elantech_dmi_has_middle_button[] = {
>  static const char * const middle_button_pnp_ids[] = {
>  	"LEN2131", /* ThinkPad P52 w/ NFC */
>  	"LEN2132", /* ThinkPad P52 */
> +	"LEN2133", /* ThinkPad P72 w/ NFC */
> +	"LEN2134", /* ThinkPad P72 */
>  	NULL
>  };
>  
> -- 
> 2.17.1
> 

-- 
Dmitry
