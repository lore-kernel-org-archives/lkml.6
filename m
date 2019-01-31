Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7710C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81DA9218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="Ipi4WVIp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732063AbfAaKeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:34:31 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:35937 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfAaKea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:34:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=DhDRi2YQZUl+67ggz7PcGmgcHRyoVakW483511IqMUU=;
        b=Ipi4WVIpSy18CFZi4If3tryGW5Y5E5sk++l/hbeVvm01991G34PTnEIiFl1ShRYNvOgsBLdVQlTDbt/ehprwi3iF+kqYuAMzVIBBrYRD33kzlWM6m8IGaA1lW276z0nCUQje8mA5cgWJwpeirxS12ja5uaswowVDy8ifuvLspannzNB0jOeeDYkGK6m8tFpjBXKYf8O1vBOjakav3+Mf142Xpq3PfMQmvBjEKV7BimO00I1009e/QGAmT5LJZdSmEVifgncbiYH446BCtpjYmkGwBt0d3GCJN/QoIMv5oqtwcgbEZDt8caa1/I3pd/pYPHeguJ56QCMaPJS3blnN1w==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:23964 helo=[192.168.10.176])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gp9fw-0000fw-9k; Thu, 31 Jan 2019 11:34:28 +0100
Subject: Re: [PATCH v2 1/6] drm/virtio: move virtio_gpu_object_{attach,
 detach} calls.
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
References: <20190130094338.14203-1-kraxel@redhat.com>
 <20190130094338.14203-2-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <355f535c-8a5f-f3e8-f715-66ddcc52da5f@tronnes.org>
Date:   Thu, 31 Jan 2019 11:34:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190130094338.14203-2-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 30.01.2019 10.43, skrev Gerd Hoffmann:
> Drop the dummy ttm backend implementation, add a real one for
> TTM_PL_FLAG_TT objects.  The bin/unbind callbacks will call
> virtio_gpu_object_{attach,detach}, to update the object state
> on the host side, instead of invoking those calls from the
> move_notify() callback.
> 
> With that in place the move and move_notify callbacks are not
> needed any more, so drop them.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>
