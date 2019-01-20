Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DD7C26640
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 18:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2217620861
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 18:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="plCPFwLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfATS4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 13:56:22 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44160 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfATS4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 13:56:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aeTwocZBuTE/+vKqVwEqa1BPVszrbuyizVlF3M3Co/k=; b=plCPFwLzuJVVPsEbwtHzyIYuIs
        2n9wzCTRCovV2a12CTlMrTgv/RDor3Y16umwsUJ14aTaADLDtBnrQPMUruAohrhUAw8OjDsgJ+wI9
        gQILvrDnrwfNkBnhFcoL/E7lVCoMqZps8PGuz8wvbvbBbzoAYLPgx/vlbxzBYjmDhzhEFC/ajY5ki
        +AR+FZ/IQRYHrysZOZ22t4k5rvC0V/TSWES9RVk3LxSo8RaxEiNG2vBGb5mtHzAFg8F318siZ1PV3
        R9SAkEjSws5xzUJHyL+IHDzpncGgjoAteZgiGl+pIr7HCuzq4ReyFClCic7YsGowrQdLRrnmyu7jc
        8VI7lDwQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1glIGU-00046M-Ar; Sun, 20 Jan 2019 18:56:14 +0000
Subject: Re: [RFC net-next] net: Z-Wave driver prototype
To:     =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        linux-lpwan@lists.infradead.org, linux-wpan@vger.kernel.org
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        TL Lim <tllim@pine64.org>,
        "David S. Miller" <davem@davemloft.net>
References: <20190120183315.22743-1-afaerber@suse.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5f5aa12c-604d-ca10-1873-f5f2bbe3d266@infradead.org>
Date:   Sun, 20 Jan 2019 10:56:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190120183315.22743-1-afaerber@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/19 10:33 AM, Andreas Färber wrote:
> diff --git a/drivers/net/zwave/Makefile b/drivers/net/zwave/Makefile
> new file mode 100644
> index 000000000000..1a4171308c79
> --- /dev/null
> +++ b/drivers/net/zwave/Makefile
> @@ -0,0 +1 @@
> +obj-m += zwave.o


Hi,

This will need a Kconfig file and a symbol so that the Makefile
will not always build the zwave module.

thanks,
-- 
~Randy
