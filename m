Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B166C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 02:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 116BE20664
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 02:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 116BE20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeKALyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 07:54:46 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39075 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbeKALyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 07:54:46 -0400
Received: by mail-ed1-f68.google.com with SMTP id e5-v6so15377159eds.6;
        Wed, 31 Oct 2018 19:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vjzBshxFfsN5y9c0hPf6nfW+Nrg+m7erH7TR339QNjM=;
        b=VsGXN2rBlIexpzmSzRLKFAaIOAAjs1IjXNK0JOQreb4UWOBB+itpA9JYijGnRUxAKm
         CHXHBlwno+s8oGDSSmbH05j0kTR+DAlDDfY3AUmz7WOepDQUCIEfSxglNSFudN76Q05F
         s0qrQv9AjAegg3zxiTWWBPpBGkLhIGDDCcWFUfFuZ5X0OTB7uRSam5Wb6Qnk5Qa2R6bB
         KRnUuybdNHlSCEi4BiHbnjb0Z0reqmwfVbGvOL2PZ5jRUImprmevD0GNW/fTyT1Kvz2n
         t7h3EnzYR4ZcwgK1ih9LP2KsbdybwbMBnM5N7/IcOda0tQJbccMaBsrVS1xzfBh9BJqp
         ec2w==
X-Gm-Message-State: AGRZ1gLYiOOayMebIlwC+ZVkWFNXZU5xQJkC77QTt43muk9/mpAShnXN
        OxCBFl9ukTqecgyzWwyxxscMtfdrXJM=
X-Google-Smtp-Source: AJdET5dRDTbl06FAgaY6V6bk6WWhd5ao8GO1gNaCNtyj+2MpWj6jEuW6LOyfole/yi5/XcjtiRL7cw==
X-Received: by 2002:a50:f4c3:: with SMTP id v3-v6mr3725485edm.223.1541040825671;
        Wed, 31 Oct 2018 19:53:45 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id z36-v6sm3517551edb.57.2018.10.31.19.53.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 19:53:45 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id f1-v6so858664wmg.1;
        Wed, 31 Oct 2018 19:53:44 -0700 (PDT)
X-Received: by 2002:a1c:f010:: with SMTP id a16-v6mr4001033wmb.5.1541040824445;
 Wed, 31 Oct 2018 19:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <20181031183634.29640-1-jagan@amarulasolutions.com> <20181031183634.29640-2-jagan@amarulasolutions.com>
In-Reply-To: <20181031183634.29640-2-jagan@amarulasolutions.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 1 Nov 2018 10:53:30 +0800
X-Gmail-Original-Message-ID: <CAGb2v66ALW1EL5+buporX8cPjkfpNdwGJEVUrC9Xpcmt3-NX7g@mail.gmail.com>
Message-ID: <CAGb2v66ALW1EL5+buporX8cPjkfpNdwGJEVUrC9Xpcmt3-NX7g@mail.gmail.com>
Subject: Re: [PATCH 2/7] arm64: allwinner: h6: Add common orangepi nodes into dtsi
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 2:37 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Orangepi H6 boards, One Plus and Lite2 shares common
> nodes like axp805, uart, mmc0 etc and the common differences
> between them is Ethernet is available in One Plus where
> as Wifi, USB3, CSI port is available in Lite2.

You can claim this for pretty much all Allwinner boards, because they mostly
derive from the reference designs Allwinner's design houses put out. Yet we
don't do this for all of them. We do this for boards that are clearly derived
or extended from one another. One example would be the Orange Pi PC and PC Plus.

Do you have any evidence to suggest so? This is not about common device nodes,
but a common hardware design.

ChenYu

> So, add common orangepi nodes into sun50i-h6-orangepi.dtsi
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
