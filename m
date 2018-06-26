Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96C7C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8674426480
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8674426480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965333AbeFZDRz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 23:17:55 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46741 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965269AbeFZDRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 23:17:54 -0400
Received: by mail-ed1-f68.google.com with SMTP id r17-v6so50014edo.13;
        Mon, 25 Jun 2018 20:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=z16nCfrlTZN96zyvLY5oGJPLyuwpTht79ERmdLQtPcA=;
        b=doIeV8fTvSkpls/Q8hciDx63alocSXa3ywZFlD3TFyOTMWaQPkWJusIAcTmkdJx1+r
         dZS40B7aswNNKuVLZKkrFmRQCH8ggVU6jJVKuyitjR8rbrsXzsyOoxTiqHTM0o5NT9U0
         0dDZtbfEBXmLZxoRuqSJzTvIGcEy72d6eN1uR8ngc34jqecqrU1SKwhgEMTxK2waiEIu
         OCXpFsriyVSC0JLpJjCtzAnhyYjQ6/ilu4mLbMGd6dTMWWkV3+v6/kBcnXk0dwUNXWEM
         hf3OGZbWMa4Of56ZSgJQmmmVMrmmlM6dn6q1gng5q9ndA6pUXQ1kJc+Rm6hdm4IG+zfU
         M+5A==
X-Gm-Message-State: APt69E0iBImxr/pOcIfEtmLTZxJopmUzTMOG1eU9/b7nv3xxdWB9107J
        bcEXgvGk3X80KST0uJVLKRqDZssA
X-Google-Smtp-Source: AAOMgpcf49o2CStupX3XE6oatLDmuyp5vmdVQLkGFP5y0HU+u1/E+VQRBGc7yC5DyVdSUFZZ+a2dOg==
X-Received: by 2002:a50:bb6d:: with SMTP id y100-v6mr98603ede.10.1529983072643;
        Mon, 25 Jun 2018 20:17:52 -0700 (PDT)
Received: from mail-wr0-f179.google.com (mail-wr0-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id f11-v6sm338204edq.28.2018.06.25.20.17.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 20:17:51 -0700 (PDT)
Received: by mail-wr0-f179.google.com with SMTP id h10-v6so15584841wrq.8;
        Mon, 25 Jun 2018 20:17:50 -0700 (PDT)
X-Received: by 2002:adf:e94a:: with SMTP id m10-v6mr10578021wrn.126.1529983070700;
 Mon, 25 Jun 2018 20:17:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 20:17:30
 -0700 (PDT)
In-Reply-To: <20180625170913.p335obgr3rfa4skt@flea>
References: <20180622160631.8578-1-icenowy@aosc.io> <20180622160631.8578-2-icenowy@aosc.io>
 <20180625170913.p335obgr3rfa4skt@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 26 Jun 2018 11:17:30 +0800
X-Gmail-Original-Message-ID: <CAGb2v65HJKm3UhA1bPZxg7+KL_FAHO+LDx4ijzXasS-K0UGUXQ@mail.gmail.com>
Message-ID: <CAGb2v65HJKm3UhA1bPZxg7+KL_FAHO+LDx4ijzXasS-K0UGUXQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: allwinner: a64: allow laptops to wake up from lid
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 1:09 AM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Sat, Jun 23, 2018 at 12:06:31AM +0800, Icenowy Zheng wrote:
>> Currently all ARM kernels will have s2idle enabled if CONFIG_SUSPEND is
>> present. In this case if the lid is closed, systemd-logind will enter
>> s2idle mode by default; however there's no possible wakeup source
>> defined, so the system will enter a forever idle.
>>
>> Add the lid itself as a wakeup source, thus the system can wakeup when
>> the lid is opened.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>
> Applied both, thanks!
> Maxime

Icenowy, could you also look into having the power button as a wakeup source?
It has no device node, so you might have to look at how to implement it in
the driver.

ChenYu
