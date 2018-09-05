Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84A3C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948242073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948242073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeIELDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:03:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726272AbeIELDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:03:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2B6E440216E6;
        Wed,  5 Sep 2018 06:34:39 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-66.ams2.redhat.com [10.36.116.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E9C48202704B;
        Wed,  5 Sep 2018 06:34:38 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 4452C16E08; Wed,  5 Sep 2018 08:34:38 +0200 (CEST)
Date:   Wed, 5 Sep 2018 08:34:38 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-buf/udmabuf: Fix NULL pointer dereference in
 udmabuf_create
Message-ID: <20180905063438.qpb6fpexq6rz6rxl@sirius.home.kraxel.org>
References: <20180904190749.GA9308@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904190749.GA9308@embeddedor.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 05 Sep 2018 06:34:39 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 05 Sep 2018 06:34:39 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'kraxel@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 02:07:49PM -0500, Gustavo A. R. Silva wrote:
> There is a potential execution path in which pointer memfd is NULL when
> passed as argument to fput(), hence there is a NULL pointer dereference
> in fput().
> 
> Fix this by null checking *memfd* before calling fput().
> 
> Addresses-Coverity-ID: 1473174 ("Explicit null dereferenced")
> Fixes: fbb0de795078 ("Add udmabuf misc device")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Pushed to drm-misc-next.

thanks,
  Gerd

