Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96B8FA373B
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 09:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6849D20882
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 09:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2my9FqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6849D20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbeG2LUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 07:20:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46632 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeG2LUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 07:20:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id h14-v6so9473069wrw.13
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 02:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h4ezVHGpL7964zKt2rtWA/kjG8XqZcnGW7Lj5Ks3ldY=;
        b=f2my9FqC/BYQD0VmLLiTA0NkWYY3hIayc4k5+TGddLwGmzJeqLThxDmj5EWgI/BQ5r
         LHQ5zcCkkMvPcXmViElSftkVqXPcS72EPYTV1J73jrhkGPYqA6OyHpPmx/sFCZCtCFMN
         0DgOUE1IGJ3HW9B2JhxhUYerPk8F3X9KWRIN2Dm1TO75tNBMKSyqOXlr9gd+eunMV3m+
         hkLkSJoO3tlx7uChv38IOvjROKxCnoiCE4K2gStjCy7o4I2/sRGA9PWsIJ/Q00Yn8waK
         qKw8XnRGjMYzaCUNWYmNTzjaNylr8MBfOQfTDCKjIYecK/TbH1qu5567Q/Yn233LP54U
         +Qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h4ezVHGpL7964zKt2rtWA/kjG8XqZcnGW7Lj5Ks3ldY=;
        b=IE1VP098UOI5e8S7HqFstiz7qMc+YSFN8Spm0g4OHrTrVF1b9tuVn4+rxw1mpBPTLF
         Cr4CIZcehzrKLN5EqK1uQeCB0/bNFkC+HobQl4IWpCZMiMmVK9eqIENkFzhtt71IV7Lg
         aWdr8V/kzr26qMUR9P0EMeNHqit9sgYwO2eCkgLAd9PpKHJpvk40tXO5EAnGX9zszBzm
         zdZq/8K7JhiXdzkgSrW8KKJ2HmbT+/vVFakKWeVJYIbYcHhLVS4cKivARVJ18R0+vIKu
         rf5UwbKfXJDjKOuZtn/2dK/t8dRHe2ZWGFOZvuCdPTC5S/zpT0VOuNb+kWYK9x/JKRAV
         pxxg==
X-Gm-Message-State: AOUpUlGtp9mg/Dd21olZLZXuASmYSSj5+lsaT7ZXukUdEhv41CRsNZDd
        uOfEOWzJMZkGfVSBzNec1Is=
X-Google-Smtp-Source: AAOMgpf/htmfAfc8G6dJLuopHeV3A3I6N1cU6dam2wrIouKojIvaowC9vfEcUv93iO04OU7kPRDMLw==
X-Received: by 2002:adf:a0f3:: with SMTP id n48-v6mr13051286wrn.23.1532857810612;
        Sun, 29 Jul 2018 02:50:10 -0700 (PDT)
Received: from xux707-tw (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id 68-v6sm10530046wmi.31.2018.07.29.02.50.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jul 2018 02:50:09 -0700 (PDT)
Date:   Sun, 29 Jul 2018 10:50:10 +0100
From:   John Whitmore <arigead@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     John Whitmore <johnfwhitmore@gmail.com>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH 02/10] staging:rtl8192u: Refactor use of enum
 dm_dig_sta_e - Style
Message-ID: <20180729095009.GB21046@xux707-tw>
References: <20180727232826.28014-1-johnfwhitmore@gmail.com>
 <20180727232826.28014-3-johnfwhitmore@gmail.com>
 <20180729081726.GA2216@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180729081726.GA2216@kroah.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 29, 2018 at 10:17:26AM +0200, Greg KH wrote:
> On Sat, Jul 28, 2018 at 12:28:18AM +0100, John Whitmore wrote:
> > Refactor the use of the enumerated type dm_dig_sta_e, which is not
> > actually used for type checking by the compiler.
> > 
> > The enumerated type defines values for the enumeration, which are used
> > by both dig_state and dig_highpwr_state, (members of the struct dig).
> > Both of those variables were defined as being of type u8. This negates
> > any usefulness of the use of the enumeration, (compiler type checking).
> > 
> > To make use of the compiler's type-checking the two member variables,
> > dig_state and dig_highpwr_state have been changed to being of type
> > enum dm_dig_sta_e. The enumerated type has been moved above the
> > struct dig definition so that the enumeration is already defined when
> > compiler reaches the two types using the enumerated type.
> > 
> > In addition the 'typedef' of the enumerated type has been removed to
> > clear the checkpatch issue with declaring new types.
> > 
> > These changes, whilst convoluted, are purely coding style in nature and
> > should not impact runtime code execution.
> > 
> > Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> > ---
> >  drivers/staging/rtl8192u/r8192U_dm.h | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
> > index e86dda99c223..2444e1c1357b 100644
> > --- a/drivers/staging/rtl8192u/r8192U_dm.h
> > +++ b/drivers/staging/rtl8192u/r8192U_dm.h
> > @@ -64,6 +64,13 @@
> >  
> >  
> >  /*------------------------------Define structure----------------------------*/
> > +
> > +enum dm_dig_sta_e {
> 
> Don't end an enum with "_e", as that's not needed at all.
> 
> thanks,
> 
> greg k-h

Oh! Thanks for that, it never occured to me that the '_e' was notation.
Again I'll fix up all those affected and resend.

jwhitmore
