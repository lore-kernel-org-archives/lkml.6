Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20F2C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707372171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sirAQja0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfA1SJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:09:52 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45143 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfA1SJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:09:52 -0500
Received: by mail-qk1-f195.google.com with SMTP id y78so9914865qka.12;
        Mon, 28 Jan 2019 10:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G2M+1pmP8ilKUJ3JlBeKSrp0yTnaMWxCdRW4HecWV3Q=;
        b=sirAQja0bDXblwCseCkseMrvlvyR+CENaSTyb/CkuynY1Brn9xxM7EuNSgS9gbOnDZ
         3FkdxDB0faczKPna6B8LTzXD9INTGnlchJuY8CvEXDKlgpKZRYLKUXC2xNtmzGytNVZd
         eW0TC7O/uFGU4I0y+j0BrCl11BOaxtfDNw4jGjAnwaeoWlyWwdyVsRIm1FAzKNni+cON
         9PO/TNF9OgV9u1BDTy9sR+HA7mCVdQusnmEo2216LXcPgls2nGDc8jimtHaJ7vkVAKvS
         gFgDnJPZC9mUtmsB8SWP/eEGUjeFfKtVDUZXMkow2/JUiCyGZoJLRR4NWYpxSXt5q24G
         WDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G2M+1pmP8ilKUJ3JlBeKSrp0yTnaMWxCdRW4HecWV3Q=;
        b=flH5X2GeVBDY65OeqzTAuq+ia8xvYEWWfg+hSYsVL4jS9UR02RV36DAcPqsq+CmLIp
         GJ3iSHKDfsgcqQvSBaNKdcOjmDRSAZcFBFzBGVsvoF9mdeD6ge3HzacU0+Uzb07iEtDi
         7/3D+OtrTtkdp43gv/fAvqgLzyHyzIvVxb09p68ewsiggsUrvnGHTdxT+H1sroJqqZNZ
         DcPelvGii9sf3alS4z4lw+PQnyORlGNXbZoCiqDoFcp87mRKVndx5Ntsa6hgof0a4BLH
         ecA+FqhQJF8i7PSuKzhm4fCweUIS6z8k1S/rC6k47hP1hkqOeQVPYgMTfKLjxrPQfiDn
         Cxiw==
X-Gm-Message-State: AJcUukfrfiT/yj3eN1T8fRcMuyQ5L1kBACntXBxo3FzTF7PifcrAJnss
        ArgJ2SgwsXw7ooqZcI1Jv3+EkcED
X-Google-Smtp-Source: ALg8bN7sR16XJexmoA7xHKQtoVrGSgwIN87sxXbhf1iaShmxS6zhT+PmDoxnejduUh97+PehAXoqNw==
X-Received: by 2002:a37:5dc3:: with SMTP id r186mr20582944qkb.90.1548698991186;
        Mon, 28 Jan 2019 10:09:51 -0800 (PST)
Received: from localhost.localdomain ([168.194.160.129])
        by smtp.gmail.com with ESMTPSA id t40sm90873000qth.46.2019.01.28.10.09.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 10:09:50 -0800 (PST)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id C2510180B6A; Mon, 28 Jan 2019 16:09:47 -0200 (-02)
Date:   Mon, 28 Jan 2019 16:09:47 -0200
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        linux-sctp@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.19 033/258] sctp: Fix SKB list traversal in
 sctp_intl_store_ordered().
Message-ID: <20190128180947.GB10665@localhost.localdomain>
References: <20190128155924.51521-1-sashal@kernel.org>
 <20190128155924.51521-33-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128155924.51521-33-sashal@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 10:55:39AM -0500, Sasha Levin wrote:
> From: "David S. Miller" <davem@davemloft.net>
> 
> [ Upstream commit e15e067d0656625c77c52b4e5f0cfbf0c0c3583f ]
> 
> Same change as made to sctp_intl_store_reasm().
> 
> To be fully correct, an iterator has an undefined value when something
> like skb_queue_walk() naturally terminates.
> 
> This will actually matter when SKB queues are converted over to
> list_head.
> 
> Formalize what this code ends up doing with the current
> implementation.

Hi Sasha,

This one too then.

Thanks,
Marcelo
