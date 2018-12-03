Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83782C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF4E20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NK+dcPpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF4E20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbeLCOzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:55:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:37234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbeLCOzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:55:13 -0500
Received: from [192.168.1.75] (cpe-24-28-70-126.austin.res.rr.com [24.28.70.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DE812082F;
        Mon,  3 Dec 2018 14:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543848835;
        bh=7QLRPFUy76EzZq8m+d6qy6CP2Pv2mnEya/rkHsisPc8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NK+dcPpI6Z+Y9CzoXVNnXXNSH1REYIObMbDq3UY9A1a5n9qjmss0AiF/boFbBFNOO
         rkdYf//teIzyFemSGSOlzFVUgE/3iwm8sLnvHNt+gznU80Qr1yKMIhxzubYZK1+QSI
         G+milisorWfSe1jN86GPnGwAv7PhIj7RSe/lQWCM=
Subject: Re: [PATCH] fbdev: fsl-diu: remove redundant null check on cmap
To:     Wen Yang <wen.yang99@zte.com.cn>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn
References: <20181203064317.57054-1-wen.yang99@zte.com.cn>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <bda8bdc3-46cb-883d-1ddc-8fda0cf241be@kernel.org>
Date:   Mon, 3 Dec 2018 08:53:53 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181203064317.57054-1-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/18 12:43 AM, Wen Yang wrote:
> The null check on &info->cmap is redundant since cmap is a struct
> inside fb_info and can never be null, so the check is always true.
> we may remove it.
> 
> Signed-off-by: Wen Yang<wen.yang99@zte.com.cn>

Acked-by: Timur Tabi <timur@kernel.org>
