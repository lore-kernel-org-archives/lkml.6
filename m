Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F1BC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755C02073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UhFFZBYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbfACIRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 03:17:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43824 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfACIRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 03:17:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=K6FJvJsAoOiPTYolO1rCSFj1BDyQuVK55bUwtTEO1EE=; b=UhFFZBYE3cTjuMU2z1atnPeGD
        HOjHFA6llExHoXujNpVzx+EXPXohTSlPI6ccxzy03qCiZn6TtR0fDiGnapGL644vBXcxnGXY1ThV2
        rRBdrzSzdoQuhAQOo0tfpO+RvA+MvvSBG8KSHy5ltWdeMFLZ2F5Dgfln3JQmlNRnanvL5L4UZwHBf
        iFmqqCItx+Q6KLpF9PlUyff2DZ9heb6U//VjG5FNsTm7UM/6my6oL6YAUhB0S0SdfkqtLMyWIOXwd
        lSgf4f4+eTxmZVmrtCoE3FqSEJjvylorSAPh5bj/QDwjx1VN22l29G1YG/19VV3yl7nQsQYuR0Vn7
        waf2o29QA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1geyBK-0003dv-I2; Thu, 03 Jan 2019 08:16:46 +0000
Date:   Thu, 3 Jan 2019 00:16:46 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 07/14] drm: move EXPORT_SYMBOL_FOR_TESTS_ONLY to
 drm_util.h
Message-ID: <20190103081646.GB31320@infradead.org>
References: <20181230174838.32330-8-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181230174838.32330-8-sam@ravnborg.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2018 at 06:48:31PM +0100, Sam Ravnborg wrote:
> +/*
> + * Use EXPORT_SYMBOL_FOR_TESTS_ONLY() for functions that shall
> + * only be visible for drmselftests.
> + */
> +#if defined(CONFIG_DRM_DEBUG_SELFTEST_MODULE)
> +#define EXPORT_SYMBOL_FOR_TESTS_ONLY(x) EXPORT_SYMBOL(x)
> +#else
> +#define EXPORT_SYMBOL_FOR_TESTS_ONLY(x)
> +#endif

Btw, why isn't this an EXPORT_SYMBOL_GPL if it is only for internal
tests?
