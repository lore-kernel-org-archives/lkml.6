Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E84C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E30206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtqGHMJZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E30206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeI2FEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:04:22 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54994 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbeI2FEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:04:22 -0400
Received: by mail-wm1-f65.google.com with SMTP id c14-v6so3606828wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 15:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DTmCp6RQli6FaQ6FZ3SE4EnuDMJz8v9/TK0Re7rvDTw=;
        b=GtqGHMJZQxbTuutebYcYhVOeqUByvcCl/eQ1fmHmOKxm7M1/ldwzx50ieCGurkw7q4
         MAVIOeItCORY1bRzM/wYFR9fLbv7cI/fM8us7ESQ+W7mallxI5D+zG14nXkcAqeFqwtY
         ZotZAbVQM5g6cD/KZpa8Wn/wE5zbzn5wTopTQU+8p1EzJ9zeolDztm/IwKBmt9ofYaxO
         OJYOn4sE2NOpiQqXRX7M6DXvR0xtvztYmLvtPMk8Geg4R91VoS+792lT7aE4KSlkacwL
         sNUdREzrdEtvp/g3/cgY5y4LwH1Jso7S3Heznac9tlRZx4YvRB0JWHJjFR6xanwz1xFr
         Suww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DTmCp6RQli6FaQ6FZ3SE4EnuDMJz8v9/TK0Re7rvDTw=;
        b=lFQvgOcrEbmxj2yuetPWvNDEGuwEg43jZobJ9JOh/rTxSb8pDfzFwYD4i/z9Ss7ApV
         u7tbe3hX5RjuU1pVdrJ72CVdUzv4COpwf3nsqUnvhQxQFcWx4jhOEsT8JICiyyT3WzCx
         BX1HpvtdUbXrqTCek03PlqPN2rFkmPYAN944qICI356Kt0CeFyMTZNtuo2am2Vo7Z0Pt
         RQ/1GZbxK7d1YvejUdSk/xE2BiyzpWjPz/nxlEpdfGsTzIXULZkfEGmoQxffunoxL5g0
         fjRMdwLG5hSUjTy9ZqYr4q6t/RQXPEwa4ygH4shQUTlVSPQNaOLrLXb6onBa0O2MzR/g
         FEQQ==
X-Gm-Message-State: ABuFfojlaqssn9+cXYF4cGbFAsBwLjBZqMg5djX96g9ab+e3CjkttTMv
        oPH6YWXHU2e5Sd+/FQ+Jkd1OVpnKSxw=
X-Google-Smtp-Source: ACcGV60xNSWSpobdG5nDay+xjdV0iGeVnD3u16/m6O02xpVbcFaG+k45CF63V8QjeUU2YNqTJhEUPw==
X-Received: by 2002:a1c:f016:: with SMTP id a22-v6mr3029791wmb.76.1538174307788;
        Fri, 28 Sep 2018 15:38:27 -0700 (PDT)
Received: from xux707-tw (host86-169-110-130.range86-169.btcentralplus.com. [86.169.110.130])
        by smtp.gmail.com with ESMTPSA id p9-v6sm4544660wrt.10.2018.09.28.15.38.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 15:38:26 -0700 (PDT)
Date:   Fri, 28 Sep 2018 23:38:52 +0100
From:   John Whitmore <arigead@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     John Whitmore <johnfwhitmore@gmail.com>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH 05/13] staging:rtl8192u: Remove AdvCoding and GreenField
 - Style
Message-ID: <20180928223851.GB4984@xux707-tw>
References: <20180926191704.16322-1-johnfwhitmore@gmail.com>
 <20180926191704.16322-6-johnfwhitmore@gmail.com>
 <20180928123550.GA7089@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928123550.GA7089@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 02:35:50PM +0200, Greg KH wrote:
> On Wed, Sep 26, 2018 at 08:16:56PM +0100, John Whitmore wrote:
> > The member variables AdvCoding and GreenField are unused in code so
> > have been removed from the structure and associated initialisation
> > function.
> > 
> > This is a coding style change which should have no impact on runtime
> > code execution.
> > 
> > Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> > ---
> >  drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h     | 2 --
> >  drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 2 --
> >  2 files changed, 4 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
> > index 64d5359cf7e2..83fb8f34ccbd 100644
> > --- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
> > +++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
> > @@ -39,10 +39,8 @@ enum ht_extension_chan_offset {
> >  
> >  struct ht_capability_ele {
> >  	//HT capability info
> > -	u8	AdvCoding:1;
> >  	u8	ChlWidth:1;
> >  	u8	MimoPwrSave:2;
> > -	u8	GreenField:1;
> 
> Don't these fields come from the hardware itself?  By removing them
> here, you just changed the memory layout of the structure.  Does the
> driver still work properly after this?  If you can't test it, I can't
> take this patch as it's too risky...
> 

Sorry, yes the structure looks like it should come from the hardware
but as the structure is allocated from memory I expected to find a
memcopy either to or from the hardware. Yes risky, just because I
couldn't find it don't mean the connection to hardware ain't there.

I'll lay off the risky and who knows if I keep wondering through the
driver I'll find that illusive connection.
