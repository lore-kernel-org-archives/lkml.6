Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D57C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0DB20855
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=adirat-com.20150623.gappssmtp.com header.i=@adirat-com.20150623.gappssmtp.com header.b="JZgfw99C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfA1Sbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:31:52 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53920 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfA1Sbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:31:51 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so15106477wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=adirat-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=pcLlj7db3/i5EOmcIA+Dc4h4tzldBlLv0/7W946hox4=;
        b=JZgfw99C0Gprjx12dcpDzxGlod7FAPBm454SEH57QXdfHwIuvJV3VOfFfmEZozcIeF
         qGVymBbqWcHMX2Hn5YKEC64QUb2VIcIQuTkrnKdxHJCpysT5W7RXrjo0phRyLfzPCAM1
         h4SHh6asY5/ukrAkS4239zVvHulWEKFkBIwVBSWbKOnstMyWcbEdPspZddu9UsX3jWvR
         s/BbisUG4iySzzeRUGJJVbVlJnbEujhzzN9LupyoC91bRDZJDzyfD/+DJ9aHSlNrCBjs
         vZNQE55y8RV8Q3u/PwjFaKT0XPQqHVYUGpiktqVNMd2L6uXcOnr3upMIYlg9MTsUhkUl
         YJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=pcLlj7db3/i5EOmcIA+Dc4h4tzldBlLv0/7W946hox4=;
        b=g1Iju1jpXYrJH6r9GrWSM4c4MHcojdmlWWDU0ILcuevApyfNpraKYj5Arx/OBNPOrc
         5XS7+0//GNhudTf2HqWUjZ4C0vUWag0D48MWhf9SdibtM73m6HDCsbr/X0KMcb7IfkOE
         RV2f2XCUhXuIKbEOX3RfkKksK36GaO6KBRFD8IT0onEOt3MU56jW/ZPdS7KmVTg5vYP2
         WYrAZhfrxmqEpXg7BuemMQG81W5CVJI26WPQoy8wkUbN/kBVItXvTPZJcDND1T6laqod
         2utLq5XdZoXsLwtBaQAN3UfqA4iIB3nD+X3WD1Zi7vk4g5kg2WyR+15dkUrkEZKEt3a+
         WExg==
X-Gm-Message-State: AJcUukcornjrJ+4grcMFdLJ2wBrAFNDojQg22j9p4k/OteNK0Rluuf+/
        qGQR0icDqPvgz7M8EtPnzEmNEZ0ENY0Nrg==
X-Google-Smtp-Source: ALg8bN4uSiCrSXI2Si8J2KquiG4qmWZ5pkTqmUyrjJbWUk+SNsTTZY9VPUppS/gK54Ci8a+3S2lblw==
X-Received: by 2002:a1c:9d57:: with SMTP id g84mr18448343wme.16.1548700309307;
        Mon, 28 Jan 2019 10:31:49 -0800 (PST)
Received: from iwork ([188.24.59.111])
        by smtp.gmail.com with ESMTPSA id g188sm199838wmf.32.2019.01.28.10.31.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 10:31:48 -0800 (PST)
From:   Ioan-Adrian Ratiu <adi@adirat.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [RFC][PATCH] Revert "ARM: dts: bcm2837: Fix polarity of wifi reset GPIOs"
In-Reply-To: <1658074547.62977.1548624393424@email.ionos.de>
References: <20190127202813.29493-1-adi@adirat.com> <1658074547.62977.1548624393424@email.ionos.de>
Date:   Mon, 28 Jan 2019 20:31:48 +0200
Message-ID: <87tvhs8wh7.fsf@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan and thank you for looking into this,

On Sun, 27 Jan 2019, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> Hi Ioan-Adrian, 
> 
>> Ioan-Adrian Ratiu <adi@adirat.com> hat am 27. Januar 2019 um 
>> 21:28 geschrieben:   This reverts commit 
>> bea8a160c621d19f7f78b13e14e03f4b8e44cd4b.   Contrary to what 
>> the commit message says, on my rpi 3 b v1.2 changing the 
>> polarity causes the exact behaviour this commit intends to fix, 
>> as described at the referenced link below (wlan0 disapears). 
>> With reset-gpios = ... GPIO_ACTIVE_HIGH, brcmfmac errors in 
>> dmesg:  [    7.977512] brcmfmac: brcmf_sdio_bus_sleep: error 
>> while changing bus sleep state -110 [    7.977623] brcmfmac: 
>> brcmf_sdio_txfail: sdio error, abort command and terminate 
>> frame [    7.978007] brcmfmac: brcmf_sdio_txfail: sdio error, 
>> abort command and terminate frame [    7.978377] brcmfmac: 
>> brcmf_sdio_txfail: sdio error, abort command and terminate 
>> frame [    7.978724] brcmfmac: brcmf_sdio_dpc: failed backplane 
>> access over SDIO, halting operation [    7.978734] brcmfmac: 
>> brcmf_proto_bcdc_query_dcmd: brcmf_proto_bcdc_msg failed 
>> w/status -110 [    7.978747] brcmfmac: 
>> brcmf_cfg80211_get_channel: chanspec failed (-110) [ 
>> 7.982817] brcmfmac: brcmf_sdio_bus_sleep: error while changing 
>> bus sleep state -110 [    7.982880] brcmfmac: 
>> brcmf_sdio_txfail: sdio error, abort command and terminate 
>> frame [    7.983255] brcmfmac: brcmf_sdio_txfail: sdio error, 
>> abort command and terminate frame  The only solution I 
>> currently have is to revert and everything works as expected 
>> and as before changing the polarity.   Link: 
>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=911443 
>> Signed-off-by: Ioan-Adrian Ratiu <adi@adirat.com> --- 
> 
> reverting this commit will only workaround the real issue. It 
> lies in the sdhci-iproc driver. 
> 
> Could please try this instead patch [1]? 

Yes, the patch fixes the bug and it's also in Linus' master branch 
in v5.0-rc3 as commit 2bd44da ("mmc: sdhci-iproc: handle 
mmc_of_parse() errors during prob").

There was just a minor conflict cherry-picking it to 4.19.y 
(sdhci_get_property -> sdhci_get_of_property).

I would really like to have 2bd44da backported to the 4.19 stable 
tree to have wifi working again. Please?

Tested-by: Ioan-Adrian Ratiu <adi@adirat.com> #4.19.18

>
> [1] - https://patchwork.kernel.org/patch/10741809/
