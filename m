Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0117C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4ADB208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4ADB208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936375AbeFRTbv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 15:31:51 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:29833 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936040AbeFRTbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 15:31:47 -0400
Received: from belgarion ([90.55.203.186])
        by mwinf5d79 with ME
        id 0KXT1y00B41oiFu03KXT87; Mon, 18 Jun 2018 21:31:45 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Mon, 18 Jun 2018 21:31:45 +0200
X-ME-IP: 90.55.203.186
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Daniel Mack <daniel@zonque.org>
Cc:     Haojian Zhuang <haojian.zhuang@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>, Vinod Koul <vinod.koul@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Nicolas Pitre <nico@fluxnic.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 06/14] mtd: rawnand: marvell: remove the dmaengine compat need
References: <20180617170217.24177-1-robert.jarzmik@free.fr>
        <20180617170217.24177-7-robert.jarzmik@free.fr>
        <3a2a8951-f380-af99-bf97-6ff722404410@zonque.org>
X-URL:  http://belgarath.falguerolles.org/
Date:   Mon, 18 Jun 2018 21:31:27 +0200
In-Reply-To: <3a2a8951-f380-af99-bf97-6ff722404410@zonque.org> (Daniel Mack's
        message of "Sun, 17 Jun 2018 20:12:49 +0200")
Message-ID: <87h8lzriwg.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Mack <daniel@zonque.org> writes:

> On Sunday, June 17, 2018 07:02 PM, Robert Jarzmik wrote:
>> As the pxa architecture switched towards the dmaengine slave map, the
>> old compatibility mechanism to acquire the dma requestor line number and
>> priority are not needed anymore.
>>
>> This patch simplifies the dma resource acquisition, using the more
>> generic function dma_request_slave_channel().
>>
>> Signed-off-by: Signed-off-by: Daniel Mack <daniel@zonque.org>
>
> Something went wrong here, but you can simply fix that when applying the series
> :)
Indeed, fixed before applying to the pxa/for-next tree.

--
Robert
