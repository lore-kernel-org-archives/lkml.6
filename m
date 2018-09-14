Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EB8FC6183
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6625C20861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXH70VWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6625C20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbeINVjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 17:39:08 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43292 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbeINVjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 17:39:07 -0400
Received: by mail-lf1-f68.google.com with SMTP id h64-v6so8355690lfi.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 09:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NCZ1eaj+OKkcyVUklNU0zSrBr2asDxM8LtBGq/hB6uY=;
        b=WXH70VWUXvbgh+Ft+ji9dpdZYqv+3qg4noWzvzY8cwqsBULM64vJlnFEU+iSzCIEil
         X+PiJ455Ot4ss33Tqk4mWHoirn1mennnsvKj32qOv6SE9+FMnyekQNLNtWWGjdIZPH7H
         8U8U1gG8NYOfm0tX1ZMO4iUJC0EBUdBqNObCIKf8hpUo2QiRJIsTP6YRWW52O6y2088y
         7tucws1ZQx6E0NXMCBmjK8lx31f4f50yqg1DpjcX4gAfh6feKGNOsnWwB+HDrjSFTegx
         HnL2KiJA6TC4fq5T04oS7jM8LA+G68Urf3UrI90pp2JA9bebdv0+rZmfSJ6J+ED8KDjv
         DycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NCZ1eaj+OKkcyVUklNU0zSrBr2asDxM8LtBGq/hB6uY=;
        b=HjwuHcEffsT+dOMnMyh/Tn3X5PuGuh5LNiIMHGGYsWUUODOwSUSK2PkvAlNE/BMp4m
         l509o8vL2nl9BSOYUx4Wg71IqDpIU0C2MHrFgugHzz8Kbwu8IRF0t2+5a9G1D1AtlJfA
         rKKEHXZuibjuaM8ZRN0C+/EIFJkvEPM/sUKaj8AkTAaH5eWTV7XcAY86RDqNDPZUMNwB
         g2zx8iqnimZXefeK3AUvy//tbkE4h8gNycrN1mA1jUxWrUh5PouTvO+f9AyFt/eePXZo
         kFC77IEk3HasFlNtHf8QXJLFSxHWoz1yLG1kCc2fFRyt+ACfbra6WMVVINK1FwQ5iuAS
         6vOQ==
X-Gm-Message-State: APzg51B9ut2EKdHSVvSVUnZu5O14epyMp+8e/jKFLjL3PAyeZSKTCJ70
        pr9tJCKM/0WReujPlQEoTnxaETDc
X-Google-Smtp-Source: ANB0VdZ72WWR5OEFExDRkX6VRgIbevpLAfrfdzPDJ+jYntZyFPlk9J8LUdjqSHT++xF2Fzbpw7PSeg==
X-Received: by 2002:a19:f802:: with SMTP id a2-v6mr8788176lff.33.1536942233281;
        Fri, 14 Sep 2018 09:23:53 -0700 (PDT)
Received: from xi.terra ([85.230.190.116])
        by smtp.gmail.com with ESMTPSA id z17-v6sm1327443lfb.21.2018.09.14.09.23.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 09:23:52 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g0qsq-0006fp-WD; Fri, 14 Sep 2018 18:23:53 +0200
Date:   Fri, 14 Sep 2018 18:23:52 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Johan Hovold <johan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/50] tty_ioctl(): start taking TIOC[SG]SERIAL into
 separate methods
Message-ID: <20180914162352.GC3443@localhost>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
 <20180913024049.24567-5-viro@ZenIV.linux.org.uk>
 <20180914132216.GC1362@localhost>
 <20180914151854.GA19965@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914151854.GA19965@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 04:18:54PM +0100, Al Viro wrote:
> On Fri, Sep 14, 2018 at 03:22:16PM +0200, Johan Hovold wrote:
> > On Thu, Sep 13, 2018 at 03:40:04AM +0100, Al Viro wrote:
> > > From: Al Viro <viro@zeniv.linux.org.uk>
> > > 
> > > ->set_serial() and ->get_serial() resp., both taking tty and
> > > a kernel pointer to serial_struct.
> > > 
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > ---
> > >  drivers/tty/tty_io.c       | 36 ++++++++++++++++++++++++++++++------
> > >  include/linux/tty_driver.h |  3 +++
> > >  2 files changed, 33 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> > > index 2b34ccf269e0..91d73732e11c 100644
> > > --- a/drivers/tty/tty_io.c
> > > +++ b/drivers/tty/tty_io.c

> > > +	memset(&v, 0, sizeof(struct serial_struct));
> > > +
> > > +	if (!tty->ops->set_serial)
> > 
> > You want get_serial here.
> 
> Nice catch.  Fixed.
> 
> > > +		return -ENOIOCTLCMD;
> > > +	err = tty->ops->get_serial(tty, &v);
> > > +	if (!err && copy_to_user(ss, &v, sizeof(struct serial_struct)))
> > > +		err = -EFAULT;
> > > +	return err;
> > >  }
> > >  
> > >  /*
> > > @@ -2602,8 +2621,13 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> > >  		}
> > >  		break;
> > >  	case TIOCSSERIAL:
> > > -		tty_warn_deprecated_flags(p);
> > > -		break;
> > > +		retval = tty_tiocsserial(tty, p);
> > > +		if (retval != -ENOIOCTLCMD)
> > > +			return retval;
> > 
> > Missing break.
> 
> *blink*
> Right you are... that's a bisect hazard (in the end of the series returns
> become unconditional anyway).  Fixed.

What's in your work branch now looks good, so feel free to add:

Reviewed-by: Johan Hovold <johan@kernel.org>

Thanks,
Johan
