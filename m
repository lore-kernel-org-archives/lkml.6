Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0036C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D712146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550661417;
	bh=PvXdjRkvDcbcPHfYilUSzfgtxy/QwAsBNKfvGOmewRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gzEmGQz90ZA3SUvWYwc5tgjsUl1m2RCP4r9tpYl/F0e4Xm+TLbTMcsd1b+jAK8WVE
	 /NX05KVok8eM7gbL4zZDu274MSumauvF0jhmkBJt73yo/g3m7MRFvfEFW/dm8MC9Ug
	 SQUNa/ezdESFgUce+nQTC8JaHXOra/E2lr6Bhar0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfBTLQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:16:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:45052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727322AbfBTLQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:16:55 -0500
Received: from localhost (unknown [195.134.171.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DE58205F4;
        Wed, 20 Feb 2019 11:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550661414;
        bh=PvXdjRkvDcbcPHfYilUSzfgtxy/QwAsBNKfvGOmewRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sV562K4Ga5wF/bFImCLcRgTNjhtIug5RDNnly3IVs/p3WvS9gCkkv3MrNZ+4LsbVq
         yuCZncTVBM6Xrm6xTAVoT5hNgSmSJwnwn6vt8+BzyeoRmdyAbGBcxo3BDoLKz51H3i
         rvDldMK1rRynQlMYJ0yICuWcMamCFfJ6daaT/Hlo=
Date:   Wed, 20 Feb 2019 12:16:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 1/2] drivers: provide devm_platform_ioremap_resource()
Message-ID: <20190220111650.GA13077@kroah.com>
References: <20190220111240.10041-1-brgl@bgdev.pl>
 <20190220111240.10041-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220111240.10041-2-brgl@bgdev.pl>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 12:12:39PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> There are currently 1200+ instances of using platform_get_resource()
> and devm_ioremap_resource() together in the kernel tree.
> 
> This patch wraps these two calls in a single helper. Thanks to that
> we don't have to declare a local variable for struct resource * and can
> omit the redundant argument for resource type. We also have one
> function call less.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

