Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC3FECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92AA2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="slZCi4wJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92AA2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbeINPBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:01:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45479 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbeINPBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:01:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id 20-v6so9777852wrb.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 02:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mzDtYNZ1NR2pqdWOT197eVDTZ65IUpVm7AAGTD7eHO4=;
        b=slZCi4wJfX5MB3ZMobku32dhdkapMMFRgMIXVG3L/berb/awn5jKpU380Y2W8XXebe
         nF0gA4145xW6ZMBl8dVhKKTZKJeqBKT1wl+XNZsP2yGei+pJj0Ul0Lm2v2K3/V44XIW5
         JflFfUCYte7WdC9UE0fzwBm1vbXbKR070/MyyzY44rkGiTLpRq/NeRudJC8b28V+ffEl
         c2eY58QKmHeuuvZV9lUjRXjN73fq3htcLAoYiXa+xF+I0GRbO2SB2zA8WMY6ep+vk79h
         9SUx9wdHxpaFPI/gHEaL/Y9Wqf+huj6/w/onDyqZETXNt8N0KKmgCU00b2rdG6zPRfiy
         V3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mzDtYNZ1NR2pqdWOT197eVDTZ65IUpVm7AAGTD7eHO4=;
        b=N2zNhHu9XYqVxvAZCoj4w5t/RkplL5QRb0BmJR2R2xquw11gwSm3OFCAIBSLqJfU7S
         UO5Xn74Zks1eN49mDrGuZkjVw9YnAbdnnxoqXp7njlcB/xfmc4VCsmagwCP509C1bYWr
         paywO/ASnaCkTenEQHiz99mV5hm7cFKC4Qnj5ynHLaJcN7XxmnTblXKod/nLx0M2sXdV
         HWHUGUvqMF5qVZZR+gPEExelTLFRm2kkBPyrJ/9EdDBhfiZdOBHeKskKSR6TPZIaXEGj
         ON9gvoXVQ6FjrI7JVqnKD4Lb3yoDmdfwU5/2j+4In3rwd25UZIaoGwhcHM3Iaxgkq9mS
         3MgA==
X-Gm-Message-State: APzg51CViGJjqoEAURy+50uioT0HpYinpRcqMWllkBVn9DerYEuStpJS
        SYknSrc5y7sQLSSj2t34Dz8Y9Q2qlWsDNFnsPaJi8A==
X-Google-Smtp-Source: ANB0VdY/cl384QZFnt6jHwC1S+vYWKxZbiqxLaOKdKbzTZ4RYSOZwynSiLKxVG7m+i+8fRaXSA+F3/4sIYx6xiEKvC4=
X-Received: by 2002:a5d:528f:: with SMTP id c15-v6mr9162012wrv.102.1536918489267;
 Fri, 14 Sep 2018 02:48:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:686:0:0:0:0:0 with HTTP; Fri, 14 Sep 2018 02:48:08 -0700 (PDT)
In-Reply-To: <20180911150938.3844-1-mjourdan@baylibre.com>
References: <20180911150938.3844-1-mjourdan@baylibre.com>
From:   Maxime Jourdan <mjourdan@baylibre.com>
Date:   Fri, 14 Sep 2018 11:48:08 +0200
Message-ID: <CAMO6naz46zu5qiN=9LCixMKOHbXLW6qYGqarHf9ciNUsMRQ6sQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add Amlogic video decoder driver
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please note: the canvas patches required for this series (and causing
the kbuild fail) were merged by Kevin Hilman with a tag.

Repo: https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git
Tag: amlogic-drivers-canvas

Regards,
Maxime
