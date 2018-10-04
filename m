Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864AFC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3372220652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a19Z5dg4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3372220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbeJDXVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:21:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39436 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbeJDXVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:21:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id 61-v6so9859028wrb.6;
        Thu, 04 Oct 2018 09:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XIA1ZvnKWpftSOkTPOG3oD3jvwGncr86OWqIj7+OoMQ=;
        b=a19Z5dg4k6wvZLbkQtxL1SAuKd4WCKmklGuNKdI76pTe1KThfOtCLwByYTGbSxjyhM
         P9Dv+VF0fJy9QI4FYzklHft1yd1ALCu4oMl1I8O2SYq5CwecyQcGefASJwDRMuoRwv5b
         tPlx1RugGezRWDUrb1X+JqjhvY/h8NSrUnzzt92UwubXU96EhoFvjynauVyteGmPrCS9
         Q4F8gQw4tuhlGV7iL5l7BG6H1JophH3ZhmmOZlW8w1IsifaGnk/NB7Nk+2ViEbrdayf9
         rgmgO28vzqO16vFrUUKn7YYPN2rTqH0BLshBWF4wardsLiDff55SlUsEw4Mp3yILdJ9f
         QatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XIA1ZvnKWpftSOkTPOG3oD3jvwGncr86OWqIj7+OoMQ=;
        b=Ybz8agYBt+ilAtJF7mLwda2pU5sa8vIOBMH73EoeeG1f1yLqd8XMO+Y2FhwoWjV2bq
         yf1wlK7rzjGXbGBIQfSvOncwnjQBn55z2h+/PO2dadq4uOsEkMmYcfEufHmolNhpz0LQ
         FlFBmcyo2yMZ35tC/13XONeRjgPsVLABlwfZTNhW9daosSzUG392GxgT2HIhg3UUEwVH
         /ymhJ0MPeVbKkq4LRzEQrnU4e9XJ6MMxFyts+093uWj0x2CoJ4nIjgUD+DEPpvWZFWAr
         962QswId+sq1DwZojL31Yi6iguISiZ9LSlU2lhKyJHSOC3aAhfXDFObvxojpS05WTFpo
         0V4w==
X-Gm-Message-State: ABuFfoiITsoRrdiNsdyZI9LVR09ZKrENUYcawoLV53pfigyyb4wRlvz0
        a//e9eJR77+sRDT5Bk1BPEA=
X-Google-Smtp-Source: ACcGV61yTN3x0uN3YDjXufSwKtuD+lD0lFfLLS2mVng6C55wn0OQ1kURXG410cL9qblHotooPQfWug==
X-Received: by 2002:adf:fe83:: with SMTP id l3-v6mr5585387wrr.322.1538670458125;
        Thu, 04 Oct 2018 09:27:38 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id e142-v6sm12515080wmf.20.2018.10.04.09.27.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 09:27:37 -0700 (PDT)
Date:   Thu, 4 Oct 2018 09:27:36 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "Tayar, Tomer" <Tomer.Tayar@cavium.com>
Cc:     "Elior, Ariel" <Ariel.Elior@cavium.com>,
        Dept-Eng Everest Linux L2 <Dept-EngEverestLinuxL2@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] qed: Remove unneeded enumerated type core_tx_dest
Message-ID: <20181004162736.GA9947@flashbox>
References: <20181004000912.22242-1-natechancellor@gmail.com>
 <CY1PR07MB2554AFA55E8084990E14D55780EA0@CY1PR07MB2554.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY1PR07MB2554AFA55E8084990E14D55780EA0@CY1PR07MB2554.namprd07.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 04:23:43PM +0000, Tayar, Tomer wrote:
> From: Nathan Chancellor <natechancellor@gmail.com>
> Sent: Thursday, October 04, 2018 3:09 AM
>  
> > Clang warns when one enumerated type is implicitly converted to another.
> > 
> > drivers/net/ethernet/qlogic/qed/qed_ll2.c:799:32: warning: implicit
> > conversion from enumeration type 'enum core_tx_dest' to different
> > enumeration type 'enum qed_ll2_tx_dest' [-Wenum-conversion]
> >                 tx_pkt.tx_dest = p_ll2_conn->tx_dest;
> >                                ~ ~~~~~~~~~~~~^~~~~~~
> > 1 warning generated.
> > 
> > These enumerated types are not 1 to 1:
> > 
> > /* Light L2 TX Destination */
> > enum core_tx_dest {
> >     CORE_TX_DEST_NW,
> >     CORE_TX_DEST_LB,
> >     CORE_TX_DEST_RESERVED,
> >     CORE_TX_DEST_DROP,
> >     MAX_CORE_TX_DEST
> > };
> > 
> > enum qed_ll2_tx_dest {
> >     QED_LL2_TX_DEST_NW, /* Light L2 TX Destination to the Network */
> >     QED_LL2_TX_DEST_LB, /* Light L2 TX Destination to the Loopback */
> >     QED_LL2_TX_DEST_DROP, /* Light L2 Drop the TX packet */
> >     QED_LL2_TX_DEST_MAX
> > };
> > 
> > Fix this conversion warning by adding CORE_TX_DEST_DROP to
> > qed_ll2_tx_dest and converting all values of core_tx_dest to
> > the equivalent value in qed_ll2_tx_dest so that there is no
> > conversion warning or functional change.
> > 
> > Link: https://github.com/ClangBuiltLinux/linux/issues/125
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> [...]
> 
> > -/* Light L2 TX Destination */
> > -enum core_tx_dest {
> > -       CORE_TX_DEST_NW,
> > -       CORE_TX_DEST_LB,
> > -       CORE_TX_DEST_RESERVED,
> > -       CORE_TX_DEST_DROP,
> > -       MAX_CORE_TX_DEST
> > -};
> 
> [...]
> 
> >         QED_LL2_TX_DEST_NW, /* Light L2 TX Destination to the Network */
> >         QED_LL2_TX_DEST_LB, /* Light L2 TX Destination to the Loopback */
> >         QED_LL2_TX_DEST_DROP, /* Light L2 Drop the TX packet */
> > +       QED_LL2_TX_DEST_DROP_CORE, /* CORE_TX_DEST_DROP value */
> >         QED_LL2_TX_DEST_MAX
> >  };
> 
> Thanks Nathan for finding this issue.
> "enum core_tx_dest" is for the interface with the device FW, while "enum qed_ll2_tx_dest" is for the interface with other qed* kernel modules.
> The distinction is on purpose, so "enum core_tx_dest" shouldn't be deleted.
> Maybe an explicit switch/case would be better as a fix?
> E.g. -
> -		tx_pkt.tx_dest = p_ll2_conn->tx_dest;
> +		switch (p_ll2_conn->tx_dest) {
> +		case CORE_TX_DEST_NW:
> +			tx_pkt.tx_dest = QED_LL2_TX_DEST_NW;
> +			break;
> +		case CORE_TX_DEST_LB:
> +			tx_pkt.tx_dest = QED_LL2_TX_DEST_LB;
> +			break;
> +		case CORE_TX_DEST_DROP:
> +			tx_pkt.tx_dest = QED_LL2_TX_DEST_DROP;
> +			break;
> +		default:
> +			tx_pkt.tx_dest = QED_LL2_TX_DEST_DROP;
> +		}
> 

Hi Tomer,

Yes, that should work and it would match the rest of the driver's
handling of this distinction. I will go ahead and spin up a v2 here
shortly for review, thank you.

Nathan
