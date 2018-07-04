Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4035C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 02:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8876723D77
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 02:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8876723D77
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933204AbeGDClG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 22:41:06 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:56481 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932999AbeGDClF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 22:41:05 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 9635D2800C7D8;
        Wed,  4 Jul 2018 04:41:03 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 35D6722153; Wed,  4 Jul 2018 04:41:03 +0200 (CEST)
Date:   Wed, 4 Jul 2018 04:41:03 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/nouveau: Fix runtime PM leak in drm_open()
Message-ID: <20180704024103.GA23762@wunner.de>
References: <20180703220602.16664-1-lyude@redhat.com>
 <20180703220602.16664-2-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703220602.16664-2-lyude@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[cc -= stable]

On Tue, Jul 03, 2018 at 06:05:59PM -0400, Lyude Paul wrote:
> Noticed this as I was skimming through, if we fail to allocate memory
> for cli we'll end up returning without dropping the runtime PM ref we
> got. Additionally, we'll even return the wrong return code! (ret most
> likely will == 0 here, we want -ENOMEM).
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>
