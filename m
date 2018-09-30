Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A836C64EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 06:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD654206B2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 06:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="RmEQrNGv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD654206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbeI3N1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 09:27:49 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:48662 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727613AbeI3N1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 09:27:43 -0400
Received: from avalon.localnet (unknown [212.145.226.69])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7B77D6F8;
        Sun, 30 Sep 2018 08:55:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1538290557;
        bh=bIyiiJ3IrEiDXCO2vGjfcu5QiekmiRbikE5uWYXLdII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RmEQrNGvuYpCR9Se6i1J9+FBS3q9XkM2AmfhBGYAYazWKQIb4qSCb6Xph75SYeNTE
         C2Vo4wrUXHOjVIfNo3wlOQSmQcMFHaWhZw0oEHVoKA0DJxBTgxsQ6DSzBmzLIiY/J4
         ax2foMLp70NABa/3lHpii18HOYExeGkXzmE2p/M8=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        Eugen Hristev <eugen.hristev@microchip.com>,
        linux-media@vger.kernel.org,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Subject: Re: Bad MAINTAINERS pattern in section 'MICROCHIP ISI DRIVER'
Date:   Sun, 30 Sep 2018 09:56:14 +0300
Message-ID: <2223255.eWctWe8uvF@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180928215721.30421-1-joe@perches.com>
References: <20180928215721.30421-1-joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

Thank you for the report.

On Saturday, 29 September 2018 00:57:21 EEST Joe Perches wrote:
> Please fix this defect appropriately.

I've just submitted a patch named "MAINTAINERS: Remove stale file entry for 
the Atmel ISI driver".

> linux-next MAINTAINERS section:
> 
> 	9550	MICROCHIP ISI DRIVER
> 	9551	M:	Eugen Hristev <eugen.hristev@microchip.com>
> 	9552	L:	linux-media@vger.kernel.org
> 	9553	S:	Supported
> 	9554	F:	drivers/media/platform/atmel/atmel-isi.c
> -->	9555	F:	include/media/atmel-isi.h
> 
> Commit that introduced this:
> 
> commit 92de0f8845adcd55f37f581ddc6c09f1127e217a
>  Author: Nicolas Ferre <nicolas.ferre@microchip.com>
>  Date:   Wed Aug 29 16:31:46 2018 +0200
> 
>      MAINTAINERS: move former ATMEL entries to proper MICROCHIP location
> 
>      Standardize the Microchip / Atmel entries with the same form and move
> them so that they are all located at the same place, under the newer
> MICROCHIP banner.
>      Only modifications to the titles of the entries are done in this patch.
> 
>      Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>      Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
>   MAINTAINERS | 154 ++++++++++++++++++++++++++++----------------------------
>   1 file changed, 77 insertions(+), 77 deletions(-)
> 
> Last commit with include/media/atmel-isi.h
> 
> commit 40a78f36fc92bb156872468fb829984a9d946df7
> Author: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Date:   Sat Aug 1 06:22:54 2015 -0300
> 
>     [media] v4l: atmel-isi: Remove support for platform data
> 
>     All in-tree users have migrated to DT, remove support for platform data.
> 
>     Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>     [josh.wu@atmel.com: squash the commit to remove the unused variable:
> dev] Signed-off-by: Josh Wu <josh.wu@atmel.com>
>     Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
>     Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
> 
>  drivers/media/platform/soc_camera/atmel-isi.c      | 24 +++++--------------
>  .../media/platform/soc_camera}/atmel-isi.h         |  0
>  2 files changed, 6 insertions(+), 18 deletions(-)

-- 
Regards,

Laurent Pinchart



