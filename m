Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E71C04EBC
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 12:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B6F20869
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 12:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lUpGZwsl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B6F20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbeKRXJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 18:09:02 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33137 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbeKRXJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 18:09:02 -0500
Received: by mail-ot1-f65.google.com with SMTP id i20so18883396otl.0;
        Sun, 18 Nov 2018 04:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ns+w7vPsQF/7Gjc0K/zh7OiyvZkiW2ry6BSvr0gAWIg=;
        b=lUpGZwslwu3v68JPkowwTsHjOLcSNUKBG+pVg8rgBIVTQL9/BWQbAB2MBm2T1mImV3
         ojnG9nwmVLyXJvMUjJBeLDaEhBFaF8Nu8aIX6lCp8/WjfnBucy+r3CDU4HknbguoUaOh
         sUxIoosqaLaftpZJKff80WuhtM24/UOzw2gaYb3UwRLfumx6MKEuNcrt7Os1oV35u9MB
         zvbEZ1WoMrZOE4XIkjvFFq4ZHkCmKyhCcpKBhMYlzRmseXB3E8qTWNS6cMwdoHKJK/ns
         D3OuNbM1HbLXm2Q7aBicTcpV/rfuYUVUUlgFfTGECg9/FaksacNZPg4a/NSBkREN+vbv
         7vuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ns+w7vPsQF/7Gjc0K/zh7OiyvZkiW2ry6BSvr0gAWIg=;
        b=tu/7oNpC1UmtMPY/iqzeCgcEopnOJq9Sh2JRoCAurVgGkKZcHh8dn62i9sBrJzRk2n
         2bVzqneW+vc00fe4AWqELjnVLPFU7eY4eEj/35GY+QdSyAhVeDxfbthzRwM0/VkHmh6c
         cxfeOVeEEYjO6HMVY9povYkIPtKHooi0okkEWbIjOajUANElb80r5IGMtrR5Q9B3+ov8
         AO8I2Ak11iyx5gh3nVXOax9hdtmEXCqyP4L9HnRVsy9caaIlgHCgcrbaxY7knWnyduwi
         D/q8As9y0kLJdoKLoVBiXM+3vja5SzV8x+Q5aWHaIAa4efFUHXYXkWgsOUY2ZlBwbQxf
         gt/w==
X-Gm-Message-State: AGRZ1gKfdZuYiccoV/MDc88qAFDrCWsm/4mQ6KCeMr8Wcvtmv1Hc3W0G
        YcXbN+Iov+oWz2C1lVkZZSi93qQnHrDKx7SIQMo=
X-Google-Smtp-Source: AJdET5fNR65uQ1n8xXqxF+WALChR/ORnIyy8aPV2n9PbVFQAwJWdIPAqeTl7TqwZWTAMsQ5FZsLG0b6zYY6eu4jL/kQ=
X-Received: by 2002:a9d:3408:: with SMTP id v8mr11429291otb.237.1542545327911;
 Sun, 18 Nov 2018 04:48:47 -0800 (PST)
MIME-Version: 1.0
References: <1541516257-16157-1-git-send-email-narmstrong@baylibre.com> <1541516257-16157-3-git-send-email-narmstrong@baylibre.com>
In-Reply-To: <1541516257-16157-3-git-send-email-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 18 Nov 2018 13:48:37 +0100
Message-ID: <CAFBinCDQ0G-yt8a6rwpVDa6FJHr1f=VEkAX3LT95ZR+9bWAekw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] clk: meson-gxbb: Fix HDMI PLL for GXL SoCs
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Tue, Nov 6, 2018 at 3:59 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> In an attempt to better describe the HDMI PLL, a single DCO clock was
> left for GXBB and GXL, but the GXL DCO does not have a pre-multiplier.
>
> This patch adds back a GXL specific HDMI PLL DCO with xtal as parent.
according to the public S905X datasheet (from Khadas)
HHI_HDMI_PLL_CNTL2[31:30] describe the OD_FB
the 32-bit SoCs probably have an OD_FB as well and it seems that the
formula for the PLL with OD_FB is:
  in * m / n >> od << od_fb
(however, I must admit that I'm not sure where od_fb fits in best:
before the PLL DCO - like OD is after the PLL DCO, or part of the PLL
DCO)

so this is more of a question than a suggestion/feedback:
do you know whether the datasheet is correct and there's really a
programmable multiplier (called OD_FB)?
do you have more details on that topic?


Regards
Martin
