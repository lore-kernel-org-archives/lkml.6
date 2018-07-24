Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C0EC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADCC20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVHX7P/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ADCC20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbeGXNu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:50:58 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44561 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbeGXNu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:50:57 -0400
Received: by mail-lj1-f196.google.com with SMTP id q127-v6so3449050ljq.11;
        Tue, 24 Jul 2018 05:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z2YuT3WSac+TXsGcGdJHgZsKLCLA7LdSkFzQ/c9X/yI=;
        b=hVHX7P/tvYPeeTFCWiQZPYLWnCl3+wHf2QY2bAWdO9kZ16af091G1QHY/RMehcTxW0
         o/KAllqRjnVOWLi6LkqU5TDOyPwjbHSyJYEcx5gbw4LHfv87AvcKCs8Yp1hVE+2Oxpiz
         Pe9Te0HpuMAXSZOeORReJ1Pf0Hz8+MiQXHIhDBaBSYqrM5az1CkFw+xOBqwRcaxozCtj
         MW67jBxGyD2AqFmE8nTZGLywE0aY69NSXw53vOW9Q9wp9m4De2CkkKKi/H49IXGanOHE
         dEQrf4qvO3+TSM2EORR2PTbpx2mxHHkvmajHQUTxVD2+H+AgqbWJade9w8TGoq7m/LNc
         msig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z2YuT3WSac+TXsGcGdJHgZsKLCLA7LdSkFzQ/c9X/yI=;
        b=CplYnWXAdiLdiapTjsCAIwEnoC97qv5IbDXHAzxOf6pupIkJ5fC01VxmHMHhzBJNrj
         ZxX3ayEdOsLmLBcURUL5+gw/9DYvXh7iJqVly9mQhcsihMjQxgKAdM6lWULtZ0YTcKlv
         E7LbxiIWvWeBIGfXHDkqB203jmZ1nCdQsKbGL9SfXzJ0inGnKBPTnpfIKBdQeAkMj6xh
         JalvD/E2u/QT0Jv/BvEo5yQRzLkDcMrpGtuFiYvBBCMWjnCKLwBdpu7Py+BPkAYH4wv3
         1CiOcohBVYawdtOeafKxCHP2TJvZSCvzWE10rke5evaJQH08bAuxl4EMiiLN9EDwlFTw
         tgPg==
X-Gm-Message-State: AOUpUlG4s5BoWFiq7GV0IhZo5HrRUmjRNHZ630+WtAX1vMYGn++nDCVL
        tjdPkUBItEfKBWX94skDT9w=
X-Google-Smtp-Source: AAOMgpeZ+10JJCyblUVLiluQej/98OhGdcjLassYJIzt4zt4xbJaDFPm+O0NKGDqNHYquy2CpqJZ7Q==
X-Received: by 2002:a2e:9ec9:: with SMTP id h9-v6mr3639109ljk.133.1532436276959;
        Tue, 24 Jul 2018 05:44:36 -0700 (PDT)
Received: from dimapc.localnet (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id x23-v6sm2288933ljj.86.2018.07.24.05.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 05:44:36 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mperttunen@nvidia.com" <mperttunen@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 00/15] ARM: dts: tegra: apalis-tk1: major revamp
Date:   Tue, 24 Jul 2018 15:44:35 +0300
Message-ID: <2532956.xKQ6NZiSWF@dimapc>
In-Reply-To: <1532435072.6124.1.camel@toradex.com>
References: <20180724104309.21741-1-marcel@ziswiler.com> <1532435072.6124.1.camel@toradex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 24 July 2018 15:24:34 MSK Marcel Ziswiler wrote:
> Sorry, I meant to write "minor revamp" in the subject line here as
> Apalis TK1 was already in quite good a shape but this are still some
> worthy improvements (;-p).
> 
> On Tue, 2018-07-24 at 12:42 +0200, Marcel Ziswiler wrote:
> 

Marcel,

All your emails that are sent from "toradex.com" are treated as spam by Gmail 
because "This message has a from address in toradex.com but has failed 
toradex.com's required tests for authentication.", is there anything you could 
do to fix that?



