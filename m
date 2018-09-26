Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B78BC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F2B21565
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HX6Kx8OQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F2B21565
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbeI0AQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:16:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44793 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbeI0AQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:16:56 -0400
Received: by mail-pf1-f193.google.com with SMTP id k21-v6so13819884pff.11;
        Wed, 26 Sep 2018 11:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GnBvQuL16UJO0IC+KGztOwP/ExuS4oWL8Ku1y1ES8+4=;
        b=HX6Kx8OQAIOBN3rbBbh2f6Aj6Wx9/cxIJS+1EwtD1MwA8DxrE+eS19jK5r72YX5IGh
         ISoH1YXEQ6I8AdERDlKCunNFt9BsDpqPKkCCiUsTNnieTdiSbEjC4y4MlweUOkNLG6/K
         hrQ8wc6GZNn9q3R7gtgm4nMxKsqBussttyPDsejdGh3IiFx2iJ6dOIQFqDnCu5NbJCgp
         XtzDdLiTzcoVeNBI6CvR35LQKgRhfXRJt9bgrMOWDYaM4DQ9LElipG22It90CrRHbV8r
         q8TYCV3oHe+JHkDE47o2hqlX1dTSRfbJtfXEBHga82PyXKgKJf618xWJ65UMTZAXnT75
         8xyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GnBvQuL16UJO0IC+KGztOwP/ExuS4oWL8Ku1y1ES8+4=;
        b=n9YPLp7i70k0ZK4tlSxmyKT2y8YhKFP8Ul5PFMt/c29Qfw7fART3D4aCzvoyspeqU5
         T9qIUp34IJjEqeQT6uBL7cOx4pL0fq39IleNHxaIBBrNmE+ICd1kDsUU901WuOs9w5EH
         cpIIPFKvrOMig6ssO2jbczWa/2NibdgzH33HiDi/KWeS9tPR2pD1TcWdz2g/UkZf5GcF
         81n+Zp8/cP7yJQdlub/q0ZNoOEKSEkw5DeqUl1LSfqKv4EzjonhyAmzBorygTMkZ/0MC
         xlw64T1PSD6Z7s4rPXtk/AWVkhpzyXTxc31hbC9S2IeDDq7p3DEhGDwToRXFyzlJjeIx
         dQ9g==
X-Gm-Message-State: ABuFfogN7lwKDmaPDnA22mjkcIgycnLBOJ4iKSfv1hAG6YM5pf633olk
        qQHy+lVQWDzDKePlbPNySIk=
X-Google-Smtp-Source: ACcGV63FQwi+VUibqHyk5E10nA1i1DCH+A12HVtgs4NbQm1OEKU9oJuNa2OL0djU3T2SOIgx1+oUSg==
X-Received: by 2002:a62:1089:: with SMTP id 9-v6mr7515260pfq.30.1537984969326;
        Wed, 26 Sep 2018 11:02:49 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id r205-v6sm12055000pgr.11.2018.09.26.11.02.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 11:02:48 -0700 (PDT)
Date:   Wed, 26 Sep 2018 11:02:44 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, corbet@lwn.net, afd@ti.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: ina3221: Add enable sysfs nodes
Message-ID: <20180926180243.GA6329@Asurada-Nvidia.nvidia.com>
References: <20180926064245.4091-1-nicoleotsuka@gmail.com>
 <20180926064245.4091-3-nicoleotsuka@gmail.com>
 <0cfe55e1-10d8-ac1f-8b6e-73777074a219@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cfe55e1-10d8-ac1f-8b6e-73777074a219@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 06:06:32AM -0700, Guenter Roeck wrote:
> On 09/25/2018 11:42 PM, Nicolin Chen wrote:
> > The inX_enable interface allows user space to enable or disable
> > the corresponding channel. Meanwhile, according to hwmon ABI, a
> > disabled channel/sensor should return -ENODATA as a read result.
> > 
> > However, there're configurable nodes sharing the same __show()
> > functions. So this change also adds to check if the attribute is
> > read-only to make sure it's not reading a configuration but the
> > sensor data.
 
> One necessary high level change I don't see below: With this change,
> we should no longer drop a channel entirely if it is disabled from
> devicetree. All channels should be visible but report -ENODATA if
> disabled. In other words, it should be possible for the 'enable' flag
> to override settings in DT.

Hmm...I don't feel so convinced here. The status in DT binding isn't
exactly a setting but a physical status: if a hardware design leaves
a channel to be disconnected, I don't really see a point in enabling
it in the runtime. Or maybe you can shed some light on it?

Meanwhile, I believe the enable nodes are necessary in either way as
users could decide to disable the connected channels, based on their
use cases, to save power.

Thanks
Nicolin
