Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477F7ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D964D2150F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="NYXxFalv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D964D2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=networkplumber.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391419AbeIVCMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 22:12:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33178 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390726AbeIVCMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 22:12:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id d4-v6so6463441pfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 13:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r3uBCRo2p/xGTc+biix2QsYJ8JW1hlb72ebhgEmstuk=;
        b=NYXxFalvFErlqRRUDKXQ1DnWgpsmk/R0pwDxG1Yusa59QCnW7A1+xu7AcQClEH9bPN
         NAoXRUBCbCfUbJiaHIn2xE7EmGmsK+f1LvjGgAXz7JwUjG9TKPnoQ2yjVJ17LSxKzeCT
         APRjEzS6tCOC0qnN8kMGQwrs3UXfoBKwkVLRK0S1zJ+15I/pd2yAxGcvGGp+/ni2AFSs
         Q6FU5cIuxjRVjCiIDxHwf6l6Ainz2t1tekP95mNvjEajlP1jD0mPpma5Z1+9PVPowLRJ
         JnDytAwBayZkVe2bORsJNxS5EvD/vZ6a2Wdd8Z/HxuZwgxM2vshSMGbkVpvaoF4lSAId
         6AVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r3uBCRo2p/xGTc+biix2QsYJ8JW1hlb72ebhgEmstuk=;
        b=ZKdvPonkh16vA2xZO2pQq3+8ZlNhYKtWp5l0onuxltaLZK6D3exliZKHX7Jc0s6IDB
         HOduvKny5eFw9a8TEXGfOvLlXCVyuBD+ggQ3xNYni1Q//kRRxqA/gP11oLefVtbNzeAP
         467zFbfTmcFYKyprU5lt0rVemT47/tOhAQpfL13gmwEC6FB/QuaWlYMZ59xgohstSH9e
         xpgMVToW/XHhlX6/ZzfsNBSG3RxteyFhIyXNjPA/GCXuO6xfOcVZ8d9K5uhDWbeHZtUD
         12ZXFSvzp/Hpsro0rHWOuxbnD938IjMIupHIS/yMieD/FQib6xbfH9XpLzCctsrxEj7Z
         tQZQ==
X-Gm-Message-State: APzg51Ab5N6RYExspP+JBd2NmiGOjgX3GvLNy4uppIewNmueM8rdkfg3
        O420VctgVOzMrSs5WPnTR1bQDw==
X-Google-Smtp-Source: ANB0VdZwR0eCeKFspn7znsCf06qi/MSGPyf4hVj8D7ckDr3VJ9MzYhEXygwd7vqOhRo08/y5LkQaYg==
X-Received: by 2002:a62:1c7:: with SMTP id 190-v6mr47960147pfb.1.1537561333959;
        Fri, 21 Sep 2018 13:22:13 -0700 (PDT)
Received: from xeon-e3 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id i185-v6sm38778827pfg.89.2018.09.21.13.22.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 13:22:13 -0700 (PDT)
Date:   Fri, 21 Sep 2018 13:22:06 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        vkuznets <vkuznets@redhat.com>
Subject: Re: [PATCH net-next, v2, 1/3] hv_netvsc: Add support for LRO/RSC in
 the vSwitch
Message-ID: <20180921132206.417f3714@xeon-e3>
In-Reply-To: <BN6PR21MB0161160A6A07055B24473327CA120@BN6PR21MB0161.namprd21.prod.outlook.com>
References: <20180921182037.10077-1-haiyangz@linuxonhyperv.com>
        <20180921182037.10077-2-haiyangz@linuxonhyperv.com>
        <20180921113620.62a004cb@xeon-e3>
        <BN6PR21MB0161160A6A07055B24473327CA120@BN6PR21MB0161.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2018 18:51:54 +0000
Haiyang Zhang <haiyangz@microsoft.com> wrote:

> > -----Original Message-----
> > From: Stephen Hemminger <stephen@networkplumber.org>
> > Sent: Friday, September 21, 2018 2:37 PM
> > To: Haiyang Zhang <haiyangz@linuxonhyperv.com>
> > Cc: Haiyang Zhang <haiyangz@microsoft.com>; davem@davemloft.net;
> > netdev@vger.kernel.org; olaf@aepfle.de; linux-kernel@vger.kernel.org;
> > devel@linuxdriverproject.org; vkuznets <vkuznets@redhat.com>
> > Subject: Re: [PATCH net-next, v2, 1/3] hv_netvsc: Add support for LRO/RSC in
> > the vSwitch
> > 
> > On Fri, 21 Sep 2018 18:20:35 +0000
> > Haiyang Zhang <haiyangz@linuxonhyperv.com> wrote:
> > 
> > Overall, this looks good. Some minor suggestions.
> >   
> > > +struct nvsc_rsc {
> > > +	const struct ndis_pkt_8021q_info *vlan;
> > > +	const struct ndis_tcp_ip_checksum_info *csum_info;
> > > +	u8 is_last; /* last RNDIS msg in a vmtransfer_page */
> > > +	u32 cnt; /* #fragments in an RSC packet */
> > > +	u32 pktlen; /* Full packet length */
> > > +	void *data[NVSP_RSC_MAX];
> > > +	u32 len[NVSP_RSC_MAX];
> > > +};
> > > +  
> > 
> > This new state structure is state on a per-channel basis.
> > Do you really need this to be persistent across packets?
> > 
> > Could this be on stack or do you need it to handle split packets arriving in
> > different polls? Or is the stack space a problem?
> > 
> > Also, maybe data and length could be in one structure since they are related.  
> 
> The stack space is a problem. NVSP_RSC_MAX is 562, which is defined by host.
> It will be too large for limited stack space. 
> 
> struct nvsc_rsc includes the data, len, cnt, chksum, vlan for one RSC packet. They
> are all related to construction of one SKB and its meta data. So I put them in
> one structure.
> 
> Thanks,
> - Haiyang
> 

That makes sense. How big is sizeof(struct net_device) + netdev_priv now?
Need to make sure it doesn't become an order 2 (ie keep it less than 4K).
