Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5FFC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD4A20C09
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=horus.com header.i=@horus.com header.b="lnH86wR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD4A20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=horus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbeHTNie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 09:38:34 -0400
Received: from mail.horus.com ([78.46.148.228]:57798 "EHLO mail.horus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbeHTNie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 09:38:34 -0400
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Aug 2018 09:38:33 EDT
Received: from [192.168.1.20] (62-46-134-118.adsl.highway.telekom.at [62.46.134.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "E-Mail Matthias Reichl", Issuer "HiassofT CA 2014" (verified OK))
        by mail.horus.com (Postfix) with ESMTPSA id 6CEDD6408F;
        Mon, 20 Aug 2018 12:16:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=horus.com;
        s=20180324; t=1534760178;
        bh=LJNTDbDsifenGZ7ozV6J6iyYgAnvNiO1kbSRUjdlXeM=;
        h=Date:From:To:Cc:Subject:From;
        b=lnH86wR29QUC3fM7HBeyzGuBZEyXPjGB0CS9zxZWDsf1325hkkX0rhA5i3WOT3rKE
         rBhE5itJux5ffwhCS8Wkcc+gkIc0h4hH7s8L8sEDGJd9pNS+A4FyXH53kLdMr9GrKR
         ppctDGZmAGAxva/GJeoOK+4ILO6lu+JecaXRi4kU=
Received: by camel2.lan (Postfix, from userid 1000)
        id 586F11C7349; Mon, 20 Aug 2018 12:16:17 +0200 (CEST)
Date:   Mon, 20 Aug 2018 12:16:17 +0200
From:   Matthias Reichl <hias@horus.com>
To:     stable@vger.kernel.org
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Add "regulator: arizona-ldo1: Use correct device to get enable GPIO"
 to 4.18 stable tree
Message-ID: <20180820101617.5zzqizi6g7ivnqge@camel2.lan>
Mail-Followup-To: Matthias Reichl <hias@horus.com>, stable@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems the arizona-ldo1 ldoena fix hasn't made it into 4.18. It
was added to 4.19/mainline, though:

commit a9191579ba1086d91842199263e6fe6bb5eec1ba
Author: Charles Keepax <ckeepax@opensource.cirrus.com>
Date:   Tue Jun 19 16:10:00 2018 +0100

    regulator: arizona-ldo1: Use correct device to get enable GPIO

Could you please add this commit to the 4.18 stable queue?

Without this fix LDO control via GPIO is broken and Arizona devices
can't be used as no power is applied.

I tested locally with a WM5102 (Cirrus Logic Audio Card on RPi),
with stock 4.18 tree device detection fails:

[    6.075981] arizona spi0.1: Unknown device ID: 0

with this commit added to 4.18 the WM5102 is detected fine:

[    6.060887] arizona spi0.1: WM5102 revision C

so long & thanks,

Hias
