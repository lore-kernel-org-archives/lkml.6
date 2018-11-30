Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E893FC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7AF20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBNwdJd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E7AF20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbeLAGGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:06:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:46962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbeLAGGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:06:33 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C0A420834;
        Fri, 30 Nov 2018 18:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543604179;
        bh=K19Xjk7f9IEGEDOflwz+oVXkD9rmsrOyNMO7USCgagI=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=BBNwdJd5J4qTYPc1+c+OX873FE2fdeJ7cOlfHMp9y01OX86rhDdBx4hI1Y52+mm6S
         DoY5QPSxRlv55i9THNhUtlW8YzEnZ87+samCycOoh1qinV5lK/RA4McwKN6QouFGJt
         vkr8p01a/QoEhPNDfs+4Wm+O8kJW9e228tN4hVQY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Janek Kotas <jank@cadence.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <63A29785-D1AC-4B7C-952E-3A2E5799A21D@global.cadence.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <D3711617-229C-4FA5-9E73-A7A3C025893B@global.cadence.com>
 <154223394933.88331.14659021245427374668@swboyd.mtv.corp.google.com>
 <CAE55F09-516A-4737-8F74-07BBA3AF5737@global.cadence.com>
 <154353057449.88331.10017415440005548379@swboyd.mtv.corp.google.com>
 <76BDCB72-CC05-41D1-93A0-6D71CBD97651@global.cadence.com>
 <154356831048.88331.9290972200429107619@swboyd.mtv.corp.google.com>
 <63A29785-D1AC-4B7C-952E-3A2E5799A21D@global.cadence.com>
Message-ID: <154360417873.88331.512675786310551936@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] clk: Add Fixed MMIO clock driver
Date:   Fri, 30 Nov 2018 10:56:18 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Janek Kotas (2018-11-30 01:57:09)
> =

> I tried it. io_remap doesn=E2=80=99t allow RAM to be mapped,
> even if it=E2=80=99s marked as a reserved memory.
> I got an error, the address couldn=E2=80=99t be mapped.
> =

> ARM64=E2=80=99s memory management has an explicit check for this here:
> https://elixir.bootlin.com/linux/latest/source/arch/arm64/mm/ioremap.c#L55
> =


Ok. Thanks!

