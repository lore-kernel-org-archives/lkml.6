Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C081FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 11:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8719720663
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 11:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IOkatBRQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbfBXLjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 06:39:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34878 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfBXLjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 06:39:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kurBAzCOK3m5IGucKu0DWpuJ0RmeW0Ui+49xTU/hQEc=; b=IOkatBRQIYT//uGu2Erw6DlMr
        9bPD3EaMl0Yk7KZTOS/9Cn/ez9I07jo2MsJF3Kx3X7KT3hMfsmaVVQPyK5U4NMLua9UUpB38KMCUL
        c7Pj4aYDYyLfEfseQ0MYEG8u0fL6wKbx/Kxza8ql6LzasQ7EVAOpevSHml69EPscazTLbvre0IZvi
        P1OEbmnKaUqfNgeCIVJXDiTOaEXr9TQrKl8SMeVkta048Mh9bV4hjnPNZlw7N/vCE6fgPc5fxfxsq
        a1cXCkVuc7ZcScjMiE4y6F4edKY/+xixa+FMh8scgtm2tgUu/3rFhqgE0FT08pqN4PlNldoYcjP3q
        VgxmPDSVw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gxs51-0007pN-1b; Sun, 24 Feb 2019 11:36:23 +0000
Date:   Sun, 24 Feb 2019 03:36:22 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Gerhard Wiesinger <lists@wiesinger.com>
Cc:     arm@lists.fedoraproject.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Florian Fainelli <f.fainelli@gmail.com>, filbar@centrum.cz
Subject: Re: Banana Pi-R1 stabil
Message-ID: <20190224113622.GF24889@bombadil.infradead.org>
References: <7b20af72-76ea-a7b1-9939-ca378dc0ed83@wiesinger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b20af72-76ea-a7b1-9939-ca378dc0ed83@wiesinger.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 09:04:57AM +0100, Gerhard Wiesinger wrote:
> I guess it has something to do with virtual memory.

No, it's a NULL pointer dereference in the voltage regulator code.
Nothing to do with virtual memory.
