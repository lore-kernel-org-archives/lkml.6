Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C591C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3732075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qs1BaRq4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3732075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbeJYWIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:08:48 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33948 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbeJYWIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:08:48 -0400
Received: by mail-yw1-f66.google.com with SMTP id v199-v6so3604277ywg.1;
        Thu, 25 Oct 2018 06:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mpq87yEn2sSwaHy6aAXJROgtcKjKyEWtuX91nRHJ/ME=;
        b=Qs1BaRq4xoYa648E9eacTKM/lpMw6F2JgbMPMiAo0KNX6g0jibQkbdnI195Rpx3kiM
         Fybb5s61uAje3DB1UhkKzOrhfmfyKU6e2L6Tn92WN+90Km51XYI3kzI9o61n6D3ZF1S3
         3aim1nJSusDCEvkXnD+BKoUrI5aKMZSZt29+8S3V+oaCyPUCqZ5UqUJOEYm9qn1V/cpP
         urX+4XTVRS4E+eD0Z3erkBoTqJycAK47FeROEvX2HyzOFbtKOhcapAaO3mcatgPKzZNI
         Oo8fmymgJ53h0LPUPnGkl4K87kpYWJJYbk+wxS4gpjPMEwQrljCiLYdN8yW4jCWeg0S/
         FrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mpq87yEn2sSwaHy6aAXJROgtcKjKyEWtuX91nRHJ/ME=;
        b=iOg8Cut0oH9tF+E7m8oUQ7Bm3lo8dpidRlQudn18S3jIBQYvRuBXaNwfE3YihkSAD7
         omnr1Fz6lfjM9BQNl/j+pQolqjYu4LiqI1XsftOEogG6He58Lfl3Y9kA0jWpfm9j0GUS
         xEmDFI9U9URKKHKB7RI8asnJ6Xq/a1P/1dPeyaW6vwYRdj7e8bfA9lVimuyqY9n+xovO
         FKK3nLy6GdxGIR+chLKmXcXOjIazaYXVHiprG5nHnoD95pI3uiBU9KWzDvvbjojtXhx4
         KKEaCB1odFAng7W0uXhS+cajM1Di6i+429bOd2wQtEU/QZ+LpnLJbff90vdFlscbVmq0
         DsKg==
X-Gm-Message-State: AGRZ1gJxJnDSws206aE8booqnXLsgjZ75RbolBwb9khSxo9fqPwOYAK4
        I12IvOHKE1irTvEThhUFcPE=
X-Google-Smtp-Source: AJdET5cNutJBLxd4tW9imqEpJgtiqDvbs7FOCzKBbymQ6Cdz09aqpr+k9CpnvHj0iifvrCJ/IVoaHQ==
X-Received: by 2002:a81:7a07:: with SMTP id v7-v6mr1354055ywc.429.1540474560268;
        Thu, 25 Oct 2018 06:36:00 -0700 (PDT)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id v34-v6sm3487982ywh.45.2018.10.25.06.35.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 06:35:59 -0700 (PDT)
From:   thesven73@gmail.com
X-Google-Original-From: TheSven73@googlemail.com
To:     svendev@arcx.com, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, afaerber@suse.de, treding@nvidia.com,
        david@lechnology.com, noralf@tronnes.org, johan@kernel.org,
        monstr@monstr.eu, michal.vokac@ysoft.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        yuanzhichang@hisilicon.com, stuyoder@gmail.com,
        linus.walleij@linaro.org, maxime.ripard@bootlin.com,
        bogdan.purcareata@nxp.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH anybus v1 2/4] dt-bindings: anybus-bridge: document devicetree binding.
Date:   Thu, 25 Oct 2018 09:35:54 -0400
Message-Id: <20181025133554.8050-1-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob, thank you so much for taking a look at this patch !

>> +This chip communicates with the SoC over the WEIM bus. It is
>> +expected that its Device Tree node is specified as the child of a node
>> +corresponding to the WEIM bus used for communication.
>
>By WEIM you are referring to i.MX external parallel bus? Presumably this 
>can work on any parallel bus, not just i.MX.

That's right, in theory this hardware could work with any parallel bus, if
timed correctly. The driver also has no code dependencies on the WEIM driver.
You'll only find it in the field on top of the i.MX's WEIM bus, however.

Do you think it would be 'nicer' to drop references to i.MX and WEIM? Can do.

>> +  - compatible : The following chip-specific string:
>> +        "arcx,anybus-bridge"
>
>No version or part number?

We have id and capability registers in the chip for that. This driver is
generic, both forwards and backwards compatible. Is it ok to leave out
version/part number in this case?

The rest of your feedback will go into v2. Thanks :)
