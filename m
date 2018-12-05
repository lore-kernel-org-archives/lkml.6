Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEF1C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328A320878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZCZLClJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 328A320878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbeLEPzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:55:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:58206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbeLEPzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:55:17 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA11D20878;
        Wed,  5 Dec 2018 15:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544025316;
        bh=xO3ryb4ucDr2LG/Kgn7s6nGZ8zA5isbpsqcSxrK5mCQ=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=kZCZLClJ8395pUWy0XC6CoEjrEptWcwVzqrXjzgRtqx4TZD/+0eZ2GcnXPr5kjFnj
         pPb0o49vfg12hiyoQempfLABviSczuxcbiE/cdvSErkGqsO61vAcnidhWu5NkWIqRL
         iQ3NcD0WUnP0GzW13qTYvJnicclIHJS31wcMlnxo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <266a0a5d-5dfe-0e1c-276f-65163f1cef1b@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <20181204163257.32085-1-jbrunet@baylibre.com>
 <20181204193416.24661-1-sboyd@kernel.org>
 <154399427706.88331.4744072908182655454@swboyd.mtv.corp.google.com>
 <266a0a5d-5dfe-0e1c-276f-65163f1cef1b@kernel.org>
Message-ID: <154402531604.88331.12202256691796911096@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: socfpga: Don't have get_parent for single parent ops
Date:   Wed, 05 Dec 2018 07:55:16 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dinh Nguyen (2018-12-05 07:17:41)
> Hi Stephen,
> =

> On 12/5/18 1:17 AM, Stephen Boyd wrote:
> > (Adding Dinh's korg email)
> > =

> > I also wonder if this driver is even used anymore or maybe we can delete
> > it?
> > =

> =

> The armv7 SoCFPGA platforms are using this driver.
> =


Ok and those platforms are booting in kernelci.org as
https://kernelci.org/boot/socfpga_cyclone5_de0_sockit/ perhaps?

