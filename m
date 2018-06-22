Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA05C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D870C22B4B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+1n/L/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D870C22B4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933919AbeFVAQi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 20:16:38 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40157 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932397AbeFVAQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 20:16:36 -0400
Received: by mail-pl0-f67.google.com with SMTP id t12-v6so2528037plo.7;
        Thu, 21 Jun 2018 17:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4JBZPpPX15gRLq7QH5Mcmip3+N6iKZsEuFVrdgm8Jcg=;
        b=s+1n/L/wfKn0CaHUW+MKVsQdYKGh31l6EH7ti10O1swOxrfxucdXPabzjWRV6hJbw6
         FgtvC502v6vfJzvEIddkZ/qsZIW/zgy38Ap+5V8ZrNI3bbUYYjXWUmm4snTLdtvOQ4cO
         87kT3j0knV20rcBjWqKO9KrjxSJfc6xJf8MgAgXiYOu5yPpZ9G91Eg976l8ymaR58zBR
         mpKzSwLyglgkvpvWvB7ct7oFxwuqrfMitK+uZfXegpd2hvKB7Vo3LhwHu/XBdcJF2B2n
         AVLCHAAeGkKMGQDVZ/XgKqXUGbZF3q7L7hc80f/5OYvRn9Rio2bpKoJVJfCH9Lqg4f0n
         XLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4JBZPpPX15gRLq7QH5Mcmip3+N6iKZsEuFVrdgm8Jcg=;
        b=j+9zVXDUTGyvXfUAZXQykVQ/bQfx7+VvkUHs5c9c7sboCFYRFnaG5Zm5rro87zm4iF
         ZbIZ7jZ84zDBhSrLYhz/Yi/t/XtvL5YaueUmxeoy3sqQp7YPDtXl74oYvLJjt4aH1Stm
         uVN3vYeRtQV05b52x/XGBTWAKRkH1n3cP+bgH8vq5gnRFgs/nQmMQgib+64FYGgEMPCM
         6rk+qFevPaa2WPUSsLDRDV6Ok5KU1mcy2FXP5zWEZPJ+QMwvUiM/mpGt3kiXUsrNZuPP
         63k0l7UAEjkfIhnBNVvKuEKDMmNNiAkhxqwEfYfL5J/kvALWNQxA6M7W24osoIcBQuMv
         dFpQ==
X-Gm-Message-State: APt69E1WfwscjW0yuO/CMH32Ai1dIzI47MJPzSJbrrlPasW0/TxqkEFp
        lOHyEf8Y+l4iG3JqmeGhqR0=
X-Google-Smtp-Source: ADUXVKJITb837kut5xnNjZ9J4BTyz5XP7wmQP7TgbT+q+i2ReQ3X2DqmqTtrnGyi/2N3AUZa5BAIGg==
X-Received: by 2002:a17:902:d807:: with SMTP id a7-v6mr3369082plz.92.1529626595431;
        Thu, 21 Jun 2018 17:16:35 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id w10-v6sm9607769pfa.135.2018.06.21.17.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 17:16:34 -0700 (PDT)
Date:   Thu, 21 Jun 2018 17:16:32 -0700
From:   'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
To:     =?utf-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        ulrik.debie-os@e2big.org, phoenix@emc.com.tw,
        aaron.ma@canonical.com, josh.chen@emc.com.tw
Subject: Re: [PATCH] Input: elantech - Fix V4 report decoding for module with
 middle key
Message-ID: <20180622001632.GI79890@dtor-ws>
References: <1527507182-3858-1-git-send-email-kt.liao@emc.com.tw>
 <20180529180506.GB167092@dtor-ws>
 <000301d3f7e4$5c9e51c0$15daf540$@emc.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <000301d3f7e4$5c9e51c0$15daf540$@emc.com.tw>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 03:03:50PM +0800, 廖崇榮 wrote:
> Hi Dmitry,
> 
> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com] 
> Sent: Wednesday, May 30, 2018 2:05 AM
> To: KT Liao
> Cc: linux-kernel@vger.kernel.org; linux-input@vger.kernel.org;
> ulrik.debie-os@e2big.org; phoenix@emc.com.tw; aaron.ma@canonical.com;
> josh.chen@emc.com.tw
> Subject: Re: [PATCH] Input: elantech - Fix V4 report decoding for module
> with middle key
> 
> Hi KT,
> 
> On Mon, May 28, 2018 at 07:33:02PM +0800, KT Liao wrote:
> > Some touchpad has middle key and it will be indicated in bit 2 of
> packet[0].
> > We need to fix V4 formation's byte mask to prevent error decoding.
> 
> Could you please let me know what devices this patch fixes? Are they
> released or new hardware?
> 
> 
> The primary target is Lenovo thinkpad P52 and it will be released in 6/M.
> 
> force_crc_enabled will fix the issue too because less bit-check in the
> specific byte. 
> I guess Fujitsu H730/H760 in elantech_dmi_force_crc_enabled may have the
> same issue.
> I leave them in DMI table because I am not sure of it.

OK, thank you for the info. Applied.

> 
> Thanks
> KT
> > 
> > Signed-off-by: KT Liao <kt.liao@emc.com.tw>
> > ---
> >  drivers/input/mouse/elantech.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/input/mouse/elantech.c 
> > b/drivers/input/mouse/elantech.c index fb4d902..f39dc66 100644
> > --- a/drivers/input/mouse/elantech.c
> > +++ b/drivers/input/mouse/elantech.c
> > @@ -799,7 +799,7 @@ static int elantech_packet_check_v4(struct psmouse
> *psmouse)
> >  	else if (ic_version == 7 && etd->info.samples[1] == 0x2A)
> >  		sanity_check = ((packet[3] & 0x1c) == 0x10);
> >  	else
> > -		sanity_check = ((packet[0] & 0x0c) == 0x04 &&
> > +		sanity_check = ((packet[0] & 0x08) == 0x00 &&
> >  				(packet[3] & 0x1c) == 0x10);
> >  
> >  	if (!sanity_check)
> > --
> > 2.7.4
> > 
> 
> Thanks.
> 
> -- 
> Dmitry
> 

-- 
Dmitry
