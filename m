Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67644C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BAFC20685
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhMbpfoV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BAFC20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731123AbeHFPrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:47:46 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41719 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbeHFPrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:47:46 -0400
Received: by mail-ed1-f67.google.com with SMTP id s24-v6so5166656edr.8;
        Mon, 06 Aug 2018 06:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TXTSpOFvRsXFoJ6XrilRXyqXEnGZJaJZOMrXq7Fwr5I=;
        b=fhMbpfoVxPHo2uOOjA1YPM0pcbaPIqfHpoAccyU5XLnlexjJ2TxqOiBiIWtvRX90lH
         EmIK6plJN63EdYW/vVYgZuAPrx0MMWkzGNVb59DV7EBcQUHBdq8KfrmfD850crVJg45a
         zAzc9FL3r7vPHcwP8smwooTAOuIIjvvKLYrkRlZbtYsU9UELLlX8karN4XyrSNVjmm2O
         A5IYZl0Nea0G2xD0sbEgEW1i3WMM4yZh5cDcN+pTBexyD6OxxIFneNNx8gN9BamZk5TF
         hoWCJvH4RUUf2Ub54LkzxHW88lC7Ui8PmjjekW1/MZdV0598N2dUyPRzSrBvNb0mu8Sd
         zyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TXTSpOFvRsXFoJ6XrilRXyqXEnGZJaJZOMrXq7Fwr5I=;
        b=lmqIipGcxgS+ntDQ0/qkWQSFyVxRSFce+m03LjZckRNb8ENLrB4iIcMP81yuBqQNzU
         lorw9qy3HiWlgXtTXuMWujFNdm10TxQ3V8fu9/LoO1fSi9beDnKxgWrRLW/hyKflIK7s
         AsyaLN1efek3HFtFszBZvA54N3IreoVnzMhqxOBENzuhaIx5U5dibfM1KBLt1PJq77KS
         1rEmwqYyFhuTd/fpMFIfieYSjZcZuOraXLw1OoX8Ou4zgqNtBRrZJ1cmV/2XMabqv0oX
         1Dvac0ZAHfJHFeX0ZdpQlLcc+yK+Ga77Y1c+NTwonIhP4+dgeNZ59Ko3wAG/DQQlwI1A
         E5YA==
X-Gm-Message-State: AOUpUlFD/PTYO+2NZByB0Gzf+luIngjn9w/cx7fYph7HK70fdNhKxx1U
        36eCuDlsFSCn/eS9yF+PkO0=
X-Google-Smtp-Source: AAOMgpfLRkZOO0l5tnVVDPO8hqI8T7YUeEq6oXTF0Ts4yZgTo6pEGeyXavfsWGlyHpJ9UG2HAKtEhQ==
X-Received: by 2002:aa7:c68b:: with SMTP id n11-v6mr18645590edq.122.1533562715719;
        Mon, 06 Aug 2018 06:38:35 -0700 (PDT)
Received: from dimapc.localnet (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id s23-v6sm7069256edm.74.2018.08.06.06.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 06:38:34 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     Linus Walleij <linus.walleij@linaro.org>, thierry.reding@gmail.com,
        Jon Hunter <jonathanh@nvidia.com>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        linux-tegra@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] pinctrl: tegra: Move drivers registration to arch_init level
Date:   Mon, 06 Aug 2018 16:38:22 +0300
Message-ID: <2282091.6Fec9mOu3z@dimapc>
In-Reply-To: <e60cd1f07f7c7515c117fa3446914c7f@agner.ch>
References: <20180802111144.12512-1-digetx@gmail.com> <2738202.Xfnp0pFbCN@dimapc> <e60cd1f07f7c7515c117fa3446914c7f@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 6 August 2018 16:03:01 MSK Stefan Agner wrote:
> On 04.08.2018 16:01, Dmitry Osipenko wrote:
> > On Friday, 3 August 2018 20:24:56 MSK Linus Walleij wrote:
> >> On Thu, Aug 2, 2018 at 1:31 PM Stefan Agner <stefan@agner.ch> wrote:
> >> > A while back at least using those init lists were not well received
> >> > even
> >> > for GPIO/pinctrl drivers:
> >> > 
> >> > https://lore.kernel.org/lkml/CACRpkdYk0zW12qNXgOstTLmdVDYacu0Un+8quTN+J
> >> > _az
> >> > Oic7AA@mail.gmail.com/T/#mf0596982324a6489b5537b0531ac5aed60a316ba
> >> 
> >> You shouldn't listen too much to that guy he's not trustworthy.
> 
> ;-)
> 
> >> > I still think we should make an exception for GPIO/pinctrl and use
> >> > earlier initcalls. Platform GPIO/pinctrl drivers provide basic
> >> > infrastructure often used by many other drivers, we want to have them
> >> > loaded early. It avoids unnecessary EPROBE_DEFER and hence probably
> >> > even
> >> > boots faster.
> >> 
> >> When we have the pin control and GPIO at different initlevels it makes me
> >> uneasy because I feel we have implicit init dependencies that seem more
> >> than a little fragile.
> > 
> > Yes, it is not very good.
> 
> Btw, just noticed this now:
> GPIO driver -> arch_initcall
> pinctrl driver -> subsys_initcall

I'm not sure what you're talking about, it's the other way around in the 
patches.


