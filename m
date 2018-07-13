Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A74ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880BA2124D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ve4cfl1q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 880BA2124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbeGMJ2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:28:06 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35159 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeGMJ2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:28:06 -0400
Received: by mail-pf0-f193.google.com with SMTP id q7-v6so21210082pff.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 02:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qUL9eRb7CMCPznzPEAIGrich6NgUhKSPLc5d4ZDuCQk=;
        b=ve4cfl1qFL0m2pQFW37wo9n1lAso2jbkKFZD1FkORRQJrEwFDF9P2I2iT6xA3+Vgad
         leyzgz3f4jUg9Vix47bei1OFHgx1LH4kMoQ6RSWDmjjGhyedwTje+i+pInuSMF9abLDl
         jR+1deseLwDUUypDEANn5QnIoAkCr0N53AAXCQuAJp6J6GtbSnWGc/wfHFoPu4ddWHPB
         4q64XF5cmcrpvrd7u5hfo/JEFq5i+IWtLAswf39czMhIITkeVHXJV4ctk3HVo6ePQbH0
         Iq3wrvFKX6W8mg7TDocdw83g5cLQOI2kQS08fcmh4fv0yCUyqWkfPgDa40QUhoc0dkJZ
         0NDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qUL9eRb7CMCPznzPEAIGrich6NgUhKSPLc5d4ZDuCQk=;
        b=ceSCINEQWFeJ/60SowRHkivICfllGv96WhlOTuyhieHkx56q9z88uYGLWfZgOXrocY
         0NGoihzNSmx5KOm72gqrJf5HN8eKhHe7sa9oar1c0QbUDSEzyiJg+q2I/iKyJ8s6Iuj/
         WoRbDOthqk9QtqGrgObbS2t9GOpJwFlJoykNo/mSWqGK23CN326G+pn3d9nUbvYNpt2D
         YXItwnVwLUN+wP7/R8cPbo8sETcCwgzR3Gkpmqyju5Bu7Q7LZbGljHWrj9RGRvTIVZxy
         LeQIbNzT1cVOPJI/DxC6xjw00xpoRrTrpq6KsoPaWCM8BT2eKFFOzvZSgg0mScEHAeHx
         waFQ==
X-Gm-Message-State: AOUpUlG8yMKKaW4BNN/brzpo4mzOXQWMtAWJKQwyUTBjc1MYrFLi2ADm
        6J54ONh+DjL+SCDUREZ3PX4=
X-Google-Smtp-Source: AAOMgpcbMt1ug7HsIlQYtoA56S83p8NWgiHZB/BJe2KXBkwLTTYtLcspwmrGLURkyJ3m8YIBuHbeEw==
X-Received: by 2002:a62:9cd7:: with SMTP id u84-v6mr6216595pfk.90.1531473260040;
        Fri, 13 Jul 2018 02:14:20 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id a191-v6sm24692919pge.45.2018.07.13.02.14.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 02:14:19 -0700 (PDT)
Date:   Fri, 13 Jul 2018 14:44:12 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>
Subject: Re: [Cocci] [PATCH 01/18] coccinelle: change strncpy+truncation to
 strlcpy
Message-ID: <20180713091412.GA11250@himanshu-Vostro-3559>
References: <1531444483-17338-1-git-send-email-asmadeus@codewreck.org>
 <20180713074455.GA6859@himanshu-Vostro-3559>
 <20180713080023.GB9638@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713080023.GB9638@nautica>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 10:00:23AM +0200, Dominique Martinet wrote:
> Himanshu Jha wrote on Fri, Jul 13, 2018:
> > > I expect each maintainer will pick their share of the patchs if they
> > > agree with it and the rest will just be dropped?
> > 
> > Masahiro Yamada <yamada.masahiro@socionext.com> takes coccinelle patches,
> > so please cc him or your patch would be lost.
> 
> Thanks, will do.
> 
> > > +virtual patch
> > > +virtual context
> > 
> > You might consider adding context rule or remove this line perhaps ?
> 
> Victim of copypasta, I'll remove this.
> 
> > > +-strncpy@p(
> > > ++strlcpy(
> > > +  dest, src, sz);
> > > +-dest[sz - 1] = '\0';
> > 
> > The above rule produces an output that I think is not correct:
> > --------------------------------------------------------------
> > diff = 
> > diff -u -p a//ti/wl1251/acx.c b//ti/wl1251/acx.c
> > --- a//ti/wl1251/acx.c
> > +++ b//ti/wl1251/acx.c
> > @@ -150,14 +150,7 @@ int wl1251_acx_fw_version(struct wl1251
> >  	}
> >  
> >  	/* be careful with the buffer sizes */
> > -	strncpy(buf, rev->fw_version, min(len, sizeof(rev->fw_version)));
> > -
> > -	/*
> > -	 * if the firmware version string is exactly
> > -	 * sizeof(rev->fw_version) long or fw_len is less than
> > -	 * sizeof(rev->fw_version) it won't be null terminated
> > -	 */
> > -	buf[min(len, sizeof(rev->fw_version)) - 1] = '\0';
> > +	strlcpy(buf, rev->fw_version, min(len, sizeof(rev->fw_version)));
> > 
> > -----------------------------------------------------------------
> > 
> > I think the comment is useful and should not be removed.
> 
> I agree this comment is useful now that I'm taking a closer look, I
> glanced at this too fast.
> I'm not sure how to make coccinelle not remove comments between lines
> though?

Well, there is no such facility in Coccinelle to ignore comments.
You can hack with other facilities provided in SmPL though ;)

Try this:

$ spatch -D patch --sp-file strlcopy.cocci --very-quiet drivers/net/wireless/ti/wl1251/acx.c

---------------------------------------------------------------------
virtual patch

@depends on patch@
expression dest, src, sz; 
identifier f;
@@

(
- strncpy(
+ strlcpy(
  dest, src, sizeof(sz));
- dest[sizeof(sz) - 1] = '\0';
|
- strncpy(
+ strlcpy(
  dest, src, f); 
- dest[f - 1] = '\0';
)
---------------------------------------------------------------------

This eliminates that case because expression is generic metavariable and
it somehow matched whole "min(len, sizeof(...)..", so it better to
divide the rules as done above to be more specific about the matching
pattern.

I thought to replace "identifier f" with "constant F" but that misses
few cases.

Also, it is advised to put a space affer '+/-'

Thanks.
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
