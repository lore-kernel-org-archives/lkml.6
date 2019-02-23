Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFEFC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153B020850
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550911117;
	bh=FCTejTSWX+J5iLRAW+f/HYmLWd4knmJLLei+UwQMoLY=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=Uf5ll8xr7hj5qeszK9OhESBcb6zI2BVD8GchXBNesOqt6KjUdbVoh68xZAeGyyOIN
	 TUdHuAlhpwecXhlWO+koWTq7Gvc739juBobQJr5qfxqJZ6hkeV69/8ze6pFHrrLMiT
	 ROEInQs8eiFVDkRE/LOp8H27G8h+vTyZzpBNIth4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfBWIif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 03:38:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:41286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbfBWIif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 03:38:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B702D206A3;
        Sat, 23 Feb 2019 08:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550911114;
        bh=FCTejTSWX+J5iLRAW+f/HYmLWd4knmJLLei+UwQMoLY=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=BaiZMDtnS2UerpZNRPGbO5xRJ8GyCs1WWRJzTXhvreqbQZhp7dsTBelx1bQ+TVF6B
         WQVrMj4xH2Z0cWkhHYFWO3ZE5oKtza+7UDymohBu92ALT3k6rQk8VlOgF6FZ3AB3um
         UdIR7DafOOgLNyawLVl9kvNDAK5UKNKY0e3H8Kf8=
Date:   Sat, 23 Feb 2019 09:38:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     sergio.paracuellos@gmail.com, quytelda@tamalin.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        yuzibode@126.com
Subject: Re: [PATCH] staging/ks7070: Removed unused varibale
Message-ID: <20190223083830.GA4902@kroah.com>
References: <20190223063939.18261-1-tsu.yubo@gmail.com>
 <20190223074320.GA921@kroah.com>
 <20190223080941.ufsdrtxz4cewkik7@yubo-2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190223080941.ufsdrtxz4cewkik7@yubo-2>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 03:09:42AM -0500, YU Bo wrote:
> On Sat, Feb 23, 2019 at 08:43:20AM +0100, Greg KH wrote:
> > On Sat, Feb 23, 2019 at 01:39:39AM -0500, Bo YU wrote:
> > > From: Bo Yu <tsu.yubo@gmail.com>
> > > 
> > > Compiling the kernel with W=1 results in the following warning:
> > > 
> > > drivers/staging/ks7010/ks_hostif.c:465:6: warning: variable ‘mib_val_type’
> > > set but not used [-Wunused-but-set-variable]
> > >   u16 mib_val_type;
> > > 
> > > drivers/staging/ks7010/ks_hostif.c:464:6: warning: variable ‘mib_val_size’
> > > set but not used [-Wunused-but-set-variable]
> > >     u16 mib_val_size;
> > > 
> > > drivers/staging/ks7010/ks_hostif.c:786:6: warning: variable ‘result_code’
> > > set but not used [-Wunused-but-set-variable]
> > >       u16 result_code;
> > > 
> > > Remove these variables.
> > > 
> > > Rebase on next-20190222
> > > 
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > Cc: Quytelda Kahja <quytelda@tamalin.org>
> > > 
> > > Signed-off-by: Bo Yu <tsu.yubo@gmail.com>
> > > ---
> > >  drivers/staging/ks7010/ks_hostif.c | 6 ------
> > >  1 file changed, 6 deletions(-)
> > > 
> > > diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
> > > index d938b0997a53..913d8996437a 100644
> > > --- a/drivers/staging/ks7010/ks_hostif.c
> > > +++ b/drivers/staging/ks7010/ks_hostif.c
> > > @@ -461,13 +461,9 @@ void hostif_mib_get_confirm(struct ks_wlan_private *priv)
> > >  	struct net_device *dev = priv->net_dev;
> > >  	u32 mib_status;
> > >  	u32 mib_attribute;
> > > -	u16 mib_val_size;
> > > -	u16 mib_val_type;
> > > 
> > >  	mib_status = get_dword(priv);
> > >  	mib_attribute = get_dword(priv);
> > > -	mib_val_size = get_word(priv);
> > > -	mib_val_type = get_word(priv);
> > 
> > The function get_word() actually does something to the priv structure,
> > so you just broke the driver :(
> > 
> > > 
> > >  	if (mib_status) {
> > >  		netdev_err(priv->net_dev, "attribute=%08X, status=%08X\n",
> > > @@ -783,9 +779,7 @@ void hostif_ps_adhoc_set_confirm(struct ks_wlan_private *priv)
> > >  static
> > >  void hostif_infrastructure_set_confirm(struct ks_wlan_private *priv)
> > >  {
> > > -	u16 result_code;
> > > 
> > > -	result_code = get_word(priv);
> > >  	priv->infra_status = 1;	/* infrastructure mode set */
> > >  	hostif_sme_enqueue(priv, SME_MODE_SET_CONFIRM);
> > 
> > Same here, odds are you just broke things :(
> > 
> > Please be more careful.
> Ok, I have through get_word() and get_byte() before modifing the code.
> I think it should be better to encapsulate get_word without return value to do some operations
> like that? right?

Something should be done, as that api is pretty horrible.  But I think
that might be a lot more work to accomplish :)

greg k-h
