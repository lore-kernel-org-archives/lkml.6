Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA96EECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860A020C01
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OH8hA0oh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 860A020C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731041AbeGPL5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 07:57:36 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38577 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729910AbeGPL5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 07:57:36 -0400
Received: by mail-ed1-f68.google.com with SMTP id t2-v6so15081020edr.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 04:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p9t33Hx3l7sLtcqQzkOvXL3Ueqo4I1tB/3XcAWJwttI=;
        b=OH8hA0ohuceoiVLsCF+57u2jwpNxrM4VzdrYvfRKhGb9kZYbhy2XMvnJzA8gtlWiMY
         T1biqluyWtNKzkAG1z1wFLI/ma4JidCL2Xb6l5Z62nY7tyT3nXyL0nRjifCWuPnOyxI3
         WuIbMoCX0J2ePDW3f4eoRAgZVraD0+yGaCT+QZf5W6mGz2ar4Eb70uqJGRSs1t7HTVIB
         oPRW6Sv+GATOTc/YQ5J1kO/zcN1h5VLGAq+GcUBs5XDqxvxmBtnBswlFxqwzzYdAb6Ht
         RTb1XO41GM1R4UwA4YpYwVrYJz1HYEWn3Bgjl7TNzbeS5XDYWC4B9ehmGsHOUpt0Przn
         51fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p9t33Hx3l7sLtcqQzkOvXL3Ueqo4I1tB/3XcAWJwttI=;
        b=ZT146Y3d1LguD6OLZByT0GrmMfjGs89tP+3yt23dqCllieE6bNZssdor9WiYBX/7xE
         2W08NJHI1GwlJPvRxKH9siOsrWK7u2sex3DMNktjQd7uvu42R5sNOI2cmJPjMHXtHWd+
         odGO1q/18YxV9mN/7PGsxq4DKeA3v01ahf69zo3AL9iSpo5UMConj5ofWmo/mqgV5RdD
         elC9azWznTWzvOjqSTkqcQG3aK7dIvKjYPIXyF3a72cNQg5Kbta6sIrCms45SL7fEMBP
         IhiI0cqgx498RgjlUPMFPfWinPU+TVVtCND0wM0PK2TtUsYYo9RO+mhHBdLUabiwzwQJ
         hw3g==
X-Gm-Message-State: AOUpUlH+5Dxm2/8jnVoVhLD9YKtBOEThZR5ZCSGCWJJscsd9TluraLeK
        XDdSZ9oxctvGQl6Xiq40dKc=
X-Google-Smtp-Source: AAOMgpc80u8jhus0YG1ltRbaeW50QRwhSq6CKwGra3kJrj4wJ1belSTdjbjS2MVYGFq+x/M6TTqdlQ==
X-Received: by 2002:a50:a542:: with SMTP id z2-v6mr16283974edb.77.1531740635525;
        Mon, 16 Jul 2018 04:30:35 -0700 (PDT)
Received: from xux707-tw ([109.77.251.220])
        by smtp.gmail.com with ESMTPSA id g6-v6sm1794248edn.28.2018.07.16.04.30.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 04:30:34 -0700 (PDT)
Date:   Mon, 16 Jul 2018 12:30:33 +0100
From:   John Whitmore <arigead@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     John Whitmore <johnfwhitmore@gmail.com>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        kstewart@linuxfoundation.org, pombredanne@nexb.com,
        tglx@linutronix.de
Subject: Re: [PATCH 01/10] staging:rtl8192u: remove typedef of enumeration
 TR_SELECT - Style
Message-ID: <20180716113031.GA22731@xux707-tw>
References: <20180713201247.21428-1-johnfwhitmore@gmail.com>
 <20180713201247.21428-2-johnfwhitmore@gmail.com>
 <20180716084138.GB8260@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716084138.GB8260@kroah.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 10:41:38AM +0200, Greg KH wrote:
> On Fri, Jul 13, 2018 at 09:12:38PM +0100, John Whitmore wrote:
> > To clear a checkpatch issue removed the typedef of the enumeration TR_SELECT
> > this should not impact runtime code as it's only a coding style change.
> > 
> > Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> > ---
> >  drivers/staging/rtl8192u/ieee80211/ieee80211.h      |  4 ++--
> >  drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c | 10 +++++-----
> >  drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h     |  4 ++--
> >  drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c |  6 +++---
> >  4 files changed, 12 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
> > index 3b7968681f77..0fa55af7060a 100644
> > --- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
> > +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
> > @@ -2391,7 +2391,7 @@ int ieee80211_rx_DELBA(struct ieee80211_device *ieee, struct sk_buff *skb);
> >  void TsInitAddBA(struct ieee80211_device *ieee, PTX_TS_RECORD pTS,
> >  		 u8 Policy, u8 bOverwritePending);
> >  void TsInitDelBA(struct ieee80211_device *ieee,
> > -		 PTS_COMMON_INFO pTsCommonInfo, TR_SELECT TxRxSelect);
> > +		 PTS_COMMON_INFO pTsCommonInfo, enum TR_SELECT TxRxSelect);
> >  void BaSetupTimeOut(struct timer_list *t);
> >  void TxBaInactTimeout(struct timer_list *t);
> >  void RxBaInactTimeout(struct timer_list *t);
> > @@ -2402,7 +2402,7 @@ bool GetTs(
> >  	PTS_COMMON_INFO                 *ppTS,
> >  	u8                              *Addr,
> >  	u8                              TID,
> > -	TR_SELECT                       TxRxSelect,  //Rx:1, Tx:0
> > +	enum TR_SELECT                  TxRxSelect,  //Rx:1, Tx:0
> 
> This really should be "enum tr_select", right?  No ALL CAPS variable
> types please.
> 

Absolutely, I was trying to make small changes, not doing too much in a single
patch. I know there's a happy medium somewhere. I'll fix that up and resend
series again.

Cheers

John
