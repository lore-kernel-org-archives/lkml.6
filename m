Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313AAECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB9D2214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9D2214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbeIQRRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 13:17:35 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51694 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbeIQRRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 13:17:35 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 9612E27DC2C
Message-ID: <e7b48f4f81e249ee0d9b1d558d5285d09a4c9000.camel@collabora.com>
Subject: Re: [PATCH AUTOSEL 4.9 20/57] media: sta2x11: Add video_device and
 vb2_queue locks
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Sasha Levin <Alexander.Levin@microsoft.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Date:   Mon, 17 Sep 2018 08:50:27 -0300
In-Reply-To: <20180917030340.378-20-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
         <20180917030340.378-20-alexander.levin@microsoft.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha,

On Mon, 2018-09-17 at 03:03 +0000, Sasha Levin wrote:
> From: Ezequiel Garcia <ezequiel@collabora.com>
> 
> [ Upstream commit cd63c0288fd760ce7de247fba618e2bbcfc0c35c ]
> 
> Currently, this driver does not serialize its video4linux
> ioctls, which is a bug, as race conditions might appear.
> 
> In addition, video_device and vb2_queue locks are now both
> mandatory. Add them, and implement wait_prepare and
> wait_finish.
> 
> To stay on the safe side, this commit uses a single mutex
> for both locks. Better latency can be obtained by separating
> these if needed.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>

Hm, I am not so sure this patch should go to -stable,
as it's not fixing a real bug we've seen out there.

Regards,
Eze
