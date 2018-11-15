Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5EFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C272146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C272146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388635AbeKPB7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:59:47 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45864 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388019AbeKPB7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:59:47 -0500
Received: by mail-ed1-f67.google.com with SMTP id d39so13839878edb.12;
        Thu, 15 Nov 2018 07:51:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5zpbH4Yb2tTnV4ez0Ft4yAoZB0DDvh788w7IAt4lqJ4=;
        b=cDuM1jHl/hC97Z3OKlY1z36koLiR5c8KIbm3ajJ9QyrkvzZno1WWLAbqyoZNmPRHf7
         RzWYkFtHeMybzE3ibKDvcwwPVzvTMN4eRIVcGn/BpLdH1bOEnbwmUmmqdEZpIKFPFxbn
         g8GVRFnh75I/w7FS0niiDvxQyykJZ5Jyz6VvAZuSHGyZ0C1K6GJ6fd4mI2hdN15wt9wc
         m9Il+V3UjWrJYyi5OXkoWgs3LyHcroqoHwiMTUzwuq7ijcBN7wJavEorcLOHc2Itxvbh
         8MkadhkVPnY3HEg7wXxPqr0p88kVTgeKJfh/A9N05iM91w6F0BSUmvYfigqFL9OR8kU2
         ji7w==
X-Gm-Message-State: AGRZ1gLhTqBf7DqfV5xPRxrW8btP3NOZx7DZibCXWk6F1TDa0E/PkN3J
        Cxux16M/PWpbbZvJNh52kjJTNw5qD4Y=
X-Google-Smtp-Source: AJdET5ev8ckldGsF2MrdeaiUO1jRUmXxdIbdAAD0mFGBdmzcWDJDC2HfUNLpbQ5aMWBYn+OnPIPz9A==
X-Received: by 2002:a05:6402:1347:: with SMTP id y7mr6322216edw.114.1542297082614;
        Thu, 15 Nov 2018 07:51:22 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id c38sm4449128edb.15.2018.11.15.07.51.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 07:51:22 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id j26-v6so21743594wre.1;
        Thu, 15 Nov 2018 07:51:22 -0800 (PST)
X-Received: by 2002:adf:a599:: with SMTP id g25-v6mr6541029wrc.188.1542297081716;
 Thu, 15 Nov 2018 07:51:21 -0800 (PST)
MIME-Version: 1.0
References: <20181115145013.3378-1-paul.kocialkowski@bootlin.com> <20181115145013.3378-4-paul.kocialkowski@bootlin.com>
In-Reply-To: <20181115145013.3378-4-paul.kocialkowski@bootlin.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 15 Nov 2018 23:51:12 +0800
X-Gmail-Original-Message-ID: <CAGb2v66jEqqYA8-96GzguE_=PZribEDaMXxrYupTQdwjPkmBRQ@mail.gmail.com>
Message-ID: <CAGb2v66jEqqYA8-96GzguE_=PZribEDaMXxrYupTQdwjPkmBRQ@mail.gmail.com>
Subject: Re: [PATCH 03/15] ARM: dts: sun8i-h3: Fix the system-control register range
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devel@driverdev.osuosl.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-sunxi@googlegroups.com, Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 10:50 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Unlike in previous generations, the system-control register range is not
> limited to a size of 0x30 on the H3. In particular, the EMAC clock
> configuration register (accessed through syscon) is at offset 0x30 in
> that range.
>
> Extend the register size to its full range (0x1000) as a result.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Other than the subject format,

Acked-by: Chen-Yu Tsai <wens@csie.org>
