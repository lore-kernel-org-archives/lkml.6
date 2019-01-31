Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2D6C282C7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4BD621919
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="C7VLVJk2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfAaKu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:50:29 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:54143 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfAaKu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:50:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=CZ2EqIkkJ+k5aPJQbMXgWSGGCCpZSt7JD2cE7yH0X3E=;
        b=C7VLVJk2Uh8lya3jtHUn6icbxstLPtHNWSOw1xztR4Mc3WmJ8IbR4lpodL1xlVNCop3fc65Rsw+9JtfR8L+RNzDTaHQ42Uh3m/kC2DBDitM0w5n3GvUEJS6nLzj3D/WBbXnTEeqEQNlzB+etrstmQQJweVqWNp8Nc4ey/hiUtYZDBiMoy5KavqGGsxkjFpqFKfQAbBG9eDFP+v6+lX4hMwGCF3+6wrzEcJe6ctoSKogfjnNLdTDlPaVbCCGsZT/7iBINq1ypV7wmi9ewnyWdZqWzYapMCpPiZycVrSIZyQiuGTZMO7HlR8OJY6z/zktzWVb39tOdTM88HVtWg+Px6Q==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:52655 helo=[192.168.10.176])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gp9vP-0007Jn-0h; Thu, 31 Jan 2019 11:50:27 +0100
Subject: Re: [PATCH v2 5/6] drm/virtio: drop fencing in
 virtio_gpu_resource_create_ioctl
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
References: <20190130094338.14203-1-kraxel@redhat.com>
 <20190130094338.14203-6-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <def6f74a-9817-1bc0-0c4e-b0e2a93a7eb2@tronnes.org>
Date:   Thu, 31 Jan 2019 11:50:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190130094338.14203-6-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 30.01.2019 10.43, skrev Gerd Hoffmann:
> There is no need to wait for completion here.
> 
> The host will process commands in submit order, so commands can
> reference the new resource just fine even when queued up before
> completion.
> 
> On the guest side there is no need to wait for completion too.  Which
> btw is different from resource destroy, where we have to make sure the
> host has seen the destroy and thus doesn't use it any more before
> releasing the pages backing the resource.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>
