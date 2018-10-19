Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E59ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9EFB21486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="EpMs4Ot5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9EFB21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mork.no
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbeJST2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 15:28:21 -0400
Received: from canardo.mork.no ([148.122.252.1]:44691 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbeJST2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 15:28:21 -0400
Received: from miraculix.mork.no ([IPv6:2a02:2121:34c:118b:c8fa:53ff:fe7c:53d8])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id w9JBMPOD011397
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 19 Oct 2018 13:22:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1539948147; bh=ba9Ze441Gqo/3BJd79qbxGobbmk9MtCOxZSfTAYDuMM=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=EpMs4Ot5aJUSPWh0Es0qUYD7YioqXjevKc3q6UGCBZMEJwJU5Fh5dAExfucP+T+G5
         rw23VgNitt9yD1q3tzKmKegnmizhJk17pbV8lSeiq0/S9dZctGefYO4V6ee+BjodCy
         2Lz8Ie7V+GBCxqzqm16N/NOf1/nX+a/RMAciWgHo=
Received: from bjorn by miraculix.mork.no with local (Exim 4.89)
        (envelope-from <bjorn@mork.no>)
        id 1gDSrE-0002YT-DA; Fri, 19 Oct 2018 13:22:20 +0200
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc:     grygorii.strashko@ti.com, davem@davemloft.net,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexander.h.duyck@intel.com
Subject: Re: [RFC PATCH net-next 2/4] net: 8021q: vlan_core: allow use list of vlans for real device
Organization: m
References: <20181016182035.18234-1-ivan.khoronzhuk@linaro.org>
        <20181016182035.18234-3-ivan.khoronzhuk@linaro.org>
Date:   Fri, 19 Oct 2018 13:22:20 +0200
In-Reply-To: <20181016182035.18234-3-ivan.khoronzhuk@linaro.org> (Ivan
        Khoronzhuk's message of "Tue, 16 Oct 2018 21:20:33 +0300")
Message-ID: <878t2up4er.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.100.1 at canardo
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org> writes:

> @@ -236,6 +239,13 @@ __vlan_find_dev_deep_rcu(struct net_device *real_dev,
>  	return NULL;
>  }
>=20=20
> +static inline int
> +vlan_for_each(struct net_device *dev,
> +	      int (*action)(struct net_device *dev, int vid, void *arg),
> +	      void *arg)
> +{
> +}
> +


This stub should return 0, shouldn't it?


Bj=C3=B8rn
