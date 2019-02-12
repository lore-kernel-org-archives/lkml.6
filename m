Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F3DC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729C6217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YrQfRLlw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfBLHMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:12:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37926 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfBLHMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:12:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=x+e9gHJ5HmfyutRvhOpEYggNpG/K8AlrmxzDp64cBJ4=; b=YrQfRLlw+SszeeO0x7odcLKAF
        Cfb+D61w/NVkVUm94u7QQtu4PbKLRy4TJjL1LvBh6amdRh++oxBkGmy7SmzOdrqJ3kWV1QSrWxDlV
        C2ywrx6jlGF8rf/jHckrSwF5WLHby8r0jeo8vRd8rHIGICaJOCIML9dd4i4M7pf3Hy2nsW8LUqHgp
        ElxLKbb0mrlaeOuH6TyQSpDbl/DKV5Qf9sVZRJicznr6L4EohdsSMOFb4OT2K1wyS86/hLGszP+HV
        VVamlMHr5Ng02XMthdIasxr51hkdneR1vW1BCSZ9yHlZQog4zyaZUInKd44a1qUrmHsOQGyShVs5+
        31rUJnehA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtSFP-00038B-QJ; Tue, 12 Feb 2019 07:12:51 +0000
Date:   Mon, 11 Feb 2019 23:12:51 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 4/5] riscv: treat cpu devicetree nodes without status as
 enabled
Message-ID: <20190212071251.GK26747@infradead.org>
References: <20190118140308.9599-1-johan@kernel.org>
 <20190118140308.9599-5-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118140308.9599-5-johan@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 03:03:07PM +0100, Johan Hovold wrote:
> Follow the Linux convention and treat devicetree nodes without a status
> property as enabled rather than disabled, while also allowing "ok" as a
> shorthand for "okay".
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
