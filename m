Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6F4C282CA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 01:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1AFE2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 01:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaxerA+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfA1BXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 20:23:53 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46998 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfA1BXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 20:23:53 -0500
Received: by mail-ed1-f65.google.com with SMTP id o10so11662899edt.13;
        Sun, 27 Jan 2019 17:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Nex7muTc5dNa3qP+GX8KQf+e5aFV8mdQ3S1j/aUTUAs=;
        b=UaxerA+DjzvuoYwlpZoRMc94BCdUyQTffeqhiZQt8r09RwfPdil9GSzPwRLvr7pAv5
         EDesySTerUGdw/uQTPwewUluX2AsBhXN9HmC7f7Ra9tcT0Omm+Kd/vuUUDhRJ2UBeZYn
         cVCm0lm5MK7z5AWLEXJ8xAJSjWH0iNwaiKZitYF/Sz8adzg4CIjWXCmAkZFNZkM+VyyY
         GUyxYDXGTeAFiBn50eMkzqSeGAUYpFXfdLcXqIGucRkLoE3lidnhq8kG/af0+zd4NBqd
         Qx2aGNcDaTeNQ3U07nshB8w+NOMA7OVabufsrDDjTmKsNWC08A/Lhg02VtOgaG0C3CgE
         8Bwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Nex7muTc5dNa3qP+GX8KQf+e5aFV8mdQ3S1j/aUTUAs=;
        b=VAF8KXDXrfEG/kf616UwPui2RvNAGS/OuulrajjhHWToVeer3DxhuvBpWd7A+1iFrc
         noVcSDaZ2fweUwWWWsr1UGc/XzA7rtq4Zhy2W1yzIfRS9yOsh5NQvfqxGULKv554mpyr
         FVuz7bV84FwXjD8MYN2scmG04Nk7kCk+tVH3FU6f0lsobuWhoNNSg5WK5ATLFBneStXX
         KHfKGM1MpB5jk6STcmVoqg4qjK6o2xWzied2qLhXv191npUWJk1C0YyuEWWUVFiJuwZw
         GE8UgOtSr0mUaJ7ftYoku9a2ROrNDeMZlRmGZUcXnZ0LmkFl1dOKsSlUKtagKYkY1/8p
         J3tg==
X-Gm-Message-State: AJcUukdUXYZyjY0Uor299d/GIe18mFFDhcyWFmuehDtH7Mf4zQ/f+iuX
        UBs3DFuYaK8s0waJrag+eqk=
X-Google-Smtp-Source: ALg8bN4E9pzeMKxj/WU2o5hwOEIASfPx8mB4OaH4RbjHV4SbvdTn3FUuh4V1gAsLC0DO3UEAu4XdUg==
X-Received: by 2002:a17:906:27d3:: with SMTP id k19mr11877819ejc.154.1548638631117;
        Sun, 27 Jan 2019 17:23:51 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id t11sm2123952ejl.69.2019.01.27.17.23.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 17:23:50 -0800 (PST)
Date:   Sun, 27 Jan 2019 18:23:48 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Masanori Goto <gotom@debian.or.jp>
Cc:     YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: nsp32: Remove unnecessary self assignment in
 nsp32_set_sync_entry
Message-ID: <20190128012348.GA26318@archlinux-ryzen>
References: <20181210235156.6237-1-natechancellor@gmail.com>
 <20190126191143.GB25003@archlinux-ryzen>
 <CALZLnaEkikS6Yv-PR-kBpnrCRrn9A8yHg+ZYGXkq+d_JQvR23g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALZLnaEkikS6Yv-PR-kBpnrCRrn9A8yHg+ZYGXkq+d_JQvR23g@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2019 at 05:42:01PM +0900, Masanori Goto wrote:
> Thanks for the fix!
> 
> 2019年1月27日(日) 4:11 Nathan Chancellor <natechancellor@gmail.com>:
> >
> > On Mon, Dec 10, 2018 at 04:51:56PM -0700, Nathan Chancellor wrote:
> > > Clang warns:
> > >
> > > drivers/scsi/nsp32.c:2444:14: warning: explicitly assigning value of
> > > variable of type 'unsigned char' to itself [-Wself-assign]
> > >         offset      = offset;
> > >         ~~~~~~      ^
> > >
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> Acked-by: GOTO Masanori <gotom@debian.or.jp>

Thank you for the reply and the review :)

Nathan

> 
> > > ---
> > >  drivers/scsi/nsp32.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/drivers/scsi/nsp32.c b/drivers/scsi/nsp32.c
> > > index 5aac3e801903..7ce6e7acf2f3 100644
> > > --- a/drivers/scsi/nsp32.c
> > > +++ b/drivers/scsi/nsp32.c
> > > @@ -2441,7 +2441,6 @@ static void nsp32_set_sync_entry(nsp32_hw_data *data,
> > >
> > >       period      = data->synct[entry].period_num;
> > >       ackwidth    = data->synct[entry].ackwidth;
> > > -     offset      = offset;
> > >       sample_rate = data->synct[entry].sample_rate;
> > >
> > >       target->syncreg    = TO_SYNCREG(period, offset);
> > > --
> > > 2.20.0
> > >
> >
> > Ping?
