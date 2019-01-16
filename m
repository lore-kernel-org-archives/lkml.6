Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CB9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3495520840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387862AbfAPGaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 01:30:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728649AbfAPGaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 01:30:04 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DBFC6CAA7F;
        Wed, 16 Jan 2019 06:30:03 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-186.ams2.redhat.com [10.36.117.186])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33E2460A9F;
        Wed, 16 Jan 2019 06:30:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 58C8C16E03; Wed, 16 Jan 2019 07:30:02 +0100 (CET)
Date:   Wed, 16 Jan 2019 07:30:02 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Oleksandr Andrushchenko <andr2000@gmail.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel.vetter@intel.com,
        jgross@suse.com, boris.ostrovsky@oracle.com, noralf@tronnes.org,
        hch@infradead.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: Re: [PATCH v2] drm/xen-front: Make shmem backed display buffer
 coherent
Message-ID: <20190116063002.jq3aas6ofhaogmyk@sirius.home.kraxel.org>
References: <20190115140420.4652-1-andr2000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115140420.4652-1-andr2000@gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 16 Jan 2019 06:30:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> +	if (!dma_map_sg(dev->dev, xen_obj->sgt->sgl, xen_obj->sgt->nents,
> +			DMA_BIDIRECTIONAL)) {
> +		ret = -EFAULT;
> +		goto fail_free_sgt;
> +	}

Hmm, so it seems the arm guys could not come up with a suggestion how to
solve that one in a better way.  Ok, lets go with this then.

But didn't we agree that this deserves a comment exmplaining the purpose
of the dma_map_sg() call is to flush caches and that there is no actual
DMA happening here?

cheers,
  Gerd

