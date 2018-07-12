Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400C6C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD0D20862
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fHq2dQZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD0D20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbeGLI3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:29:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40106 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbeGLI3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1wpOyq+XerkOxATU9+aRI1p5JFV081or7M5MbTkITKY=; b=fHq2dQZPD8yMjYqiIykWkcapa
        nadOHug8AliJyfez5mfGBcXozvRKedPEaVacw/1Fkyh14taWETaAXboWpny0JoEpRFo7CMxDFWa3d
        uO2eOmi8y+igwQTmna/Kge5ATDtCqkQYufWW7fGFlIjp95tdTpS1PbavFc9gBChHPSoeekQLdB+AN
        gprHPw1CMgen0r4QV8hQPe2c1ClZ0TyMiO1nvm3msanhInpzDm26h/WAYTxGPHPleLiB+Nqs9BJCI
        kUFuxA0+pD7rNesJSPtKrJ9zxAONXWBPcHXqniTcwimq2xrxsYYHSCifBf9F9xR3xTYR7BmEokgUA
        XcxTImF2Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdWq2-0003nh-Qv; Thu, 12 Jul 2018 08:20:34 +0000
Date:   Thu, 12 Jul 2018 01:20:34 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org, catalin.marinas@arm.com
Subject: Re: [PATCH v3 1/7] arm64: Make basic compat_* types always available
Message-ID: <20180712082034.GA8802@infradead.org>
References: <20180707054247.19802-1-deepa.kernel@gmail.com>
 <20180707054247.19802-2-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180707054247.19802-2-deepa.kernel@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 10:42:41PM -0700, Deepa Dinamani wrote:
> As we repurpose more compat syscalls to be used in non CONFIG_COMPAT
> usecases as part of solving y2038, we need to make these basic types
> available unconditionally.

NAK.  Compat code is for foreign ABIs.  If this code is going to
be used elsewhere it should not be named compat_ and not be in
compat.h.
