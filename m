Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11FDECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AAF3204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AAF3204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731994AbeGTObZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:31:25 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35841 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbeGTObZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:31:25 -0400
Received: by mail-io0-f193.google.com with SMTP id r15-v6so3744336ioa.3;
        Fri, 20 Jul 2018 06:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z1kRYtdpqkQjFC5FBO2mGtXSjdUYXFq8UuNwoEXdGSA=;
        b=iFRPhe2y0t/irjvJkhZ3vnQagC9siDL1YDifaupm7d+ZIa9pg9uK0eRmB41I2wkeui
         49Bb5rfKmVq7499x4DM8xEXXHuJBK0A0pPCNzixQ6kn+lKunk2Ja50Iuf39BQI7ww68h
         3b9+CWznJ1XpoeJZg0fQvjYTY97p4bf47fI/Ef/P3PD+HEr4zTtVAs0VjpNFVJrAcH8v
         SNRqZBKwUSZZI6yDTckPChRJ+1mvh4R73i5/l9FNTuEA+knmJO6Wr4+9e+IHfN4kGtni
         5r2jIiGrbMhmS83ImgLHPFGDUOMHseMSO1dyPcErZCQuA74mYzqeJEw/ikFj1/MHiJpT
         b8Sg==
X-Gm-Message-State: AOUpUlG4zCoLUbgPYGYPxX/ZYTTCMuZOGGs4FF/kQwk5+Hn8GGq4VEO2
        nuhHKqh34G6SS/3dS0v2Aw==
X-Google-Smtp-Source: AAOMgpeyg5OFoc216z8+vXWlqk0CV+YOHGCvSFHL0ApfhLYP2to5dCPo7/f41R8u9Hp5lT88k6o4KA==
X-Received: by 2002:a6b:dd5:: with SMTP id 204-v6mr1598327ion.172.1532094182662;
        Fri, 20 Jul 2018 06:43:02 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id u125-v6sm2807140ita.4.2018.07.20.06.43.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 06:43:01 -0700 (PDT)
Date:   Fri, 20 Jul 2018 07:43:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 2/4] rtc: ds1307: support m41t11 variant
Message-ID: <20180720134301.GA23613@rob-hp-laptop>
References: <CAHp75VcaALb8fYJExnZ=Ye=GcNHc3aPXgFihVK+rAu_a1A01Sg@mail.gmail.com>
 <20180718140946.115093-1-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718140946.115093-1-giulio.benetti@micronovasrl.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 04:09:43PM +0200, Giulio Benetti wrote:
> The m41t11 variant is very similar to the already supported m41t00 and
> m41t0, but it has also 56 bytes of NVRAM.
> 
> Add it to driver taking into account NVRAM section.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  .../devicetree/bindings/rtc/rtc-ds1307.txt         |  1 +

Please add acks when posting new versions.

>  drivers/rtc/rtc-ds1307.c                           | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
