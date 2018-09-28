Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9111C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA3F2170E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nosnCNdp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA3F2170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbeI1PLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:11:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40650 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbeI1PLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:11:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id o2-v6so1330742wmh.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 01:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=s75buDw2mMzBLZeMnGxvWNt1SFXgFzKNUBdlljzot/g=;
        b=nosnCNdpQl+AYUNW9bms9uvMisffHdRfh7H1xj/sg3C4PhKmfDb51UFACUyoy/wGnW
         iME6zSjT1uA7FKJL40Otne7I4TeCyda7wn8ErnvPfbR0oocJ1xF4IBlA4g/cSXRDlZSw
         MtOp910TdKAzlQGtFxhB8Q3oWxx8bq/gnSa8V0bmiB8RR+JgG7MIr5sl9xiUOAUgRp9h
         id8TZtCEZvT+qiyylsAkWYTqkWLAIswtMtTddmSaY2Gs9pMbhDYxHJWLULNg34meEB2a
         O+w6kbDfXhZer2xC6rD70SSVG5i1VBKBbco6BIr+zU5blvjvvwtTf45JpOY9eDboYNaQ
         HdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s75buDw2mMzBLZeMnGxvWNt1SFXgFzKNUBdlljzot/g=;
        b=F91tIR9QjFgIvvbakxg4OzrM+/aV/BGXhT1iylAZ0wY8IyjceuysgxUVZP5AyooXak
         qfpQTp8wAUI5UD2jAJKfqWhiszz64MkF8brxRvKUwgB60L5fuPX1hNPPOwyc0i8smAnG
         7G4KoofJDffjJxFZcLseyRnikzskOzC85fp7ddqhKkRH5BkmJhOA28EUT+Folwv53xXk
         kYWoYmk17qPWUX4dNz7Q8zXAtJUu0hbzVvvNRrzWV6iuj6wzovMGbMOtfooiElIhZaa1
         R0AwD1Ysu037CflC6FDpgI8WYo6eWxIDx6edxxcRRZVXvSi/p7pKc+dWsGKykZi9Imhl
         1G5Q==
X-Gm-Message-State: ABuFfojSYuYK/35Q6jkt7GXYUp/UAUN27Ty7lgn6PITc4f319/gYhXXk
        VOmyHXR6yZE4AotZH+u/Bs7QaN7hjPo=
X-Google-Smtp-Source: ACcGV60oHf4OX19rnMyp5pBxFFrJj5LcKbsBW3yt39XSafP2p271/7YAc7XqqNqDwKMVzC3SimbFVA==
X-Received: by 2002:a1c:545d:: with SMTP id p29-v6mr979019wmi.94.1538124516778;
        Fri, 28 Sep 2018 01:48:36 -0700 (PDT)
Received: from localhost.localdomain ([2a01:388:3ce:110::1:5])
        by smtp.gmail.com with ESMTPSA id q5-v6sm2328282wmd.29.2018.09.28.01.48.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 01:48:36 -0700 (PDT)
Date:   Fri, 28 Sep 2018 09:48:34 +0100
From:   Aymen Qader <qader.aymen@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: ks7010: Add null pointer check for skb
Message-ID: <20180928084834.dwmc4dpnr7tgoxhi@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928082239.disbtllum3duvdcg@mwanda>
 <20180928081325.krgawue3cs6mavw2@mwanda>
 <20180928081601.is2gl764krxcvtlv@mwanda>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 11:13:25AM +0300, Dan Carpenter wrote:
> You might want to try running Smatch on your patches.  This is the
> second one where maybe the results would have been interesting.
> 
> git clone http://repo.or.cz/w/smatch.git
> cd smatch
> make
> cd ~/kernel/src/
> ~/smatch/smatch_scripts/kchecker drivers/staging/ks7010/ks_hostif.c
> 
> This patch introduced a problem, but the earlier one fixed a potential
> problem in rtl8723bs:
> 
> drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:1274 OnAssocReq() error: uninitialized symbol 'ie_len'.
> 
> Unfortunately, Smatch missed the potential NULL dereference in
> OnAssocReq()...  It wouldn't be that hard to fix...
> 
> regards,
> dan carpenter

Oh thanks, I've not used Smatch before--that's really helpful, I'm going
to use that a lot in the future.

On Fri, Sep 28, 2018 at 11:16:01AM +0300, Dan Carpenter wrote:
> Btw, if you have the cross function DB built then Smatch says that the
> NULL check can be removed here no problem.
> 
> $ smdb hostif_data_request
> [ snip ]
> drivers/staging/ks7010/ks_wlan_net.c |   ks_wlan_start_xmit |  hostif_data_request |  PARAM_VALUE |  1 | skb | s64min-(-1),1-s64max
> 
> regards,
> dan carpenter
> 

Again, thanks very much! That's really cool, Smatch looks like a great
tool, I wish I found it before!

On Fri, Sep 28, 2018 at 11:22:39AM +0300, Dan Carpenter wrote:
> On Thu, Sep 27, 2018 at 07:04:43PM +0100, Aymen Qader wrote:
> > Retraction: in hindsight I see that with the current usage of this
> > function, there is already a check for the socket buffer so this check
> > is unnecessary. However, I'm not sure if it's considered good practice
> > to keep this check anyway--in any case, ENOMEM isn't the right error
> > to return.
> 
> When we find inconsistent NULL checks then we fix it to make sense.
> Generally, we prefer a minimal style, with no extra code for future
> proofing.  (The future seldom goes the way you expect and those extra
> NULL checks would be easy to add back).

Hm I understand, so if a parameter can currently never be null there's
no need to add unnecessary checks for in case that changes in the
future. I'll be sure to keep that in mind from now on.

> 
> So, yes, do remove the NULL check but also fix the indenting while
> you're at it.
> 
> Take your time to write patches.  I write them, then I sit on them over
> night then I send them in the morning.  It means that sometimes other
> people have already sent it but that's fine.  If you have to redo a
> patch then don't send the v2 patch on the same day.  v2 patches are
> stressful and you imagine that everyone is waiting for you to send it
> or something.  We are not waiting for you.  We don't care if you wait
> until next week to send these...
> 
> So when you write a v2 patch wait until the next day to send it.  Then
> you will be calm when you review it.
> 
> regards,
> dan carpenter
>  

Thank you very much for all of these tips, I really appreciate you
taking the time. I'm definitely going to try and apply this philosophy
in the future, I think I've been too impulsive with my patches so far.
I've been thinking "oh no, I made a mistake--I need to quickly send a
v2!" and then end up making even more mistakes, so I completely
understand what you mean.

Thanks again.

Kind regards,
Aymen Qader

