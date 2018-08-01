Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B70DC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB7B20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qWhDpFdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB7B20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733305AbeHAH7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 03:59:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42494 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733098AbeHAH7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 03:59:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id l9-v6so7295680pff.9;
        Tue, 31 Jul 2018 23:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UUVbcO95REXMlMMZsw5AQ4d//86tDf9ZVPLq/FunlaQ=;
        b=qWhDpFdwRd18qpkX1qjIdeIzhWLvDOJ9sRWlE6MEUMcj+T6IZ9O/hutDNvBjjzDkmc
         d/WVb6AY1rFlH+jHwGPfer7/xJf91GFrwOiQOCOTd5VeVyeW0ZzWOTQ8cLw7E0RSgPoO
         TPwtHekVy7igHh4heQyvNk3wWYsUviIlpzFzayRgnzrh9QokXp5KQJTl2PR8spLvcHMu
         4ZXKTtGbKg/WQjAF6pCHGASvShc5CPGVLeX6NxPGBin0HzRujk1R9sAc4hZs76cH13tC
         6Y4gGlzn7lPmFjlvpYj8+XwU+jCKSBuhN1s9WD2tFI0/vAu0Y7veu8U8kkuahEU0UirV
         FOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UUVbcO95REXMlMMZsw5AQ4d//86tDf9ZVPLq/FunlaQ=;
        b=NizUhyUHgKZXc6pjKUCIKJimurA/lk07LXRljqgc3PPxeYXVNin2jBxtKsgo4qcIu7
         S3LCWAeHEy3G3E+5IVcgqMTXVhFjE0hlKz6t+vauKHt4Zj0fcM9CNcbp9p4iLDSBfXuX
         naM5cVQ/xxpgZV3XUo+/FnooupLUou0ic4r6Jhjo4QtulYDeLx+uydj8/Hztuvcmgth3
         QxsqS7UtXQy/tO6IaOIfzS2rpFoD4Jm6+J16vLSCOEGhRlnEa9ZgqOKavvSNMv2/wUkm
         xLh7euktAO+SFz4KmKghTWkxQZCxvmUMguF98LqzkWXPZhlftMbYeAZ3PPntjmF7E+TU
         W/Cw==
X-Gm-Message-State: AOUpUlHzoAyvrhc7kfFqsfVTg1IDFi55HgT+LnYBbuZWRFJkUrg8J0/9
        Bz5h9QYsc6hNHv5qa2DBlypfyjO+
X-Google-Smtp-Source: AAOMgpfKk8p/ME4HAAozikRVrhOEAcI8UUd7LEeF/ZnEKkjVt4MqGww65HJ3hlP/yky3kKhfd4IRYw==
X-Received: by 2002:a62:411a:: with SMTP id o26-v6mr15329703pfa.111.1533104118166;
        Tue, 31 Jul 2018 23:15:18 -0700 (PDT)
Received: from localhost (c-24-4-233-174.hsd1.ca.comcast.net. [24.4.233.174])
        by smtp.gmail.com with ESMTPSA id i20-v6sm26076598pfj.82.2018.07.31.23.15.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 23:15:17 -0700 (PDT)
Date:   Tue, 31 Jul 2018 23:15:15 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     "Y.b. Lu" <yangbo.lu@nxp.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] ptp_qoriq: convert to use module parameters for
 initialization
Message-ID: <20180801061515.krn52iaq2kqdi3wo@localhost>
References: <20180730100154.27906-1-yangbo.lu@nxp.com>
 <20180730100154.27906-3-yangbo.lu@nxp.com>
 <20180730143043.qu66ttzwyjbw6si7@localhost>
 <DB6PR0401MB253643010802739AD55820F3F82D0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB6PR0401MB253643010802739AD55820F3F82D0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 04:36:40AM +0000, Y.b. Lu wrote:

> Could I add a function to calculate a set of default register values
> to initialize ptp timer when dts method failed to get required
> properties in driver?

Yes, it would be ideal if the driver can pick correct values
automatically.

However, the frequency on the FIPER outputs can't be configured
automatically, and we don't have an API for the user to choose this.

> I think this will be useful. The ptp timer on new platforms (you may
> see two dts patches in this patchset. Many platforms will be
> affected.) will work without these dts properties. If user want
> specific setting, they can set dts properties.

Sure.

Thanks,
Richard
