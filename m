Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A32ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B69620827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2dvMqqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B69620827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeKIDfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:35:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:42226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbeKIDfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:35:38 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A98EC20684;
        Thu,  8 Nov 2018 17:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541699940;
        bh=/UQ5kXSREVXmmDR4mcxngH5b6he6OImqJSc0kMNEIRU=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=X2dvMqqx3k4kjXjzDOmUdU83PG3Go/q1zgKKRZFxGkdo1qCWBT2fHK+Sun5RAS4aL
         zecOsaV7hD//uJbiJ7FqRtwE+tyRCftU8fPJOhyJcIOPBpYE61EcpXKJ8R8Ylb/xqo
         Rg+p0K8dszT9JfULFUE/Vv4vhPZc53ADCm5sBROA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <efa13e0b-0daf-3bf3-27ba-ed90f15c7dfe@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
References: <20181106183609.207702-1-sboyd@kernel.org>
 <20181106183609.207702-2-sboyd@kernel.org>
 <efa13e0b-0daf-3bf3-27ba-ed90f15c7dfe@gmail.com>
Message-ID: <154169993998.88331.10494065577891939152@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/4] of/device: Add a way to probe drivers by match data
Date:   Thu, 08 Nov 2018 09:58:59 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Brugger (2018-11-08 00:29:46)
> On 06/11/2018 19:36, Stephen Boyd wrote:
> > +int platform_driver_probe_by_of_match_data(struct platform_device *pde=
v)
> > +{
> > +     int (*probe_func)(struct platform_device *pdev);
> > +
> > +     probe_func =3D of_device_get_match_data(&pdev->dev);
> =

> Shouldn't we check if probe_func is not NULL?

Is the oops from the NULL pointer deref insufficient?

