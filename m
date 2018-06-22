Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED81DC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0289240C7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1JNKWyZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0289240C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933487AbeFVK4a (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:56:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751301AbeFVK42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:56:28 -0400
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B77CC240C7;
        Fri, 22 Jun 2018 10:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529664988;
        bh=ag6SOwZlLB7gU8RbUAokzJnFkn87+FoaMApvhMmj0vM=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=1JNKWyZS5aDaI1VahJZeSySMoBed9RnReeMDUkF9Gx/PbYjZkwmpDKOn93hhurp4Z
         Vd6J9Qf3PEe0dtBPlFbwQIseV1Kmb4Fap4SUR2RN3roczVJ6QoggggeyEVo/1fMkoH
         Y3ue81DsBEx0Y6qgw9H4P7pUj7cfpmoODGaF2Pbw=
Received: by mail-wm0-f44.google.com with SMTP id r15-v6so1820051wmc.1;
        Fri, 22 Jun 2018 03:56:27 -0700 (PDT)
X-Gm-Message-State: APt69E3Z2D0A1nDxeMcM7GAKR7WyQj3gzvHuFDfirSLcd1N8mTfn9tGh
        trF4NzrV0a0yDYlZeBTwYlMnS6JKKF5BKoS48KM=
X-Google-Smtp-Source: ADUXVKLMi1miKp8PQm3mN5dascbH9xxLrSJ8pRxg2Didtsii3nh9Zl6JcS274mic9x/sqMWsjt8OoopMR6kr6X8IEME=
X-Received: by 2002:a1c:58d5:: with SMTP id m204-v6mr1263522wmb.118.1529664986307;
 Fri, 22 Jun 2018 03:56:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9166:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 03:56:25
 -0700 (PDT)
In-Reply-To: <20180622103910eucas1p239a4f8545b3ef340fe5d0a8b954c48ac~6dUIg5f5F1882718827eucas1p2e@eucas1p2.samsung.com>
References: <20180515121239.18192-1-a.hajda@samsung.com> <CGME20180515121251eucas1p160dd3dcff49f0dad845ed6be98f33bbe@eucas1p1.samsung.com>
 <20180515121239.18192-3-a.hajda@samsung.com> <20180620182844.5nmlj5djbjgwy3wn@kozik-lap>
 <20180622103910eucas1p239a4f8545b3ef340fe5d0a8b954c48ac~6dUIg5f5F1882718827eucas1p2e@eucas1p2.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 22 Jun 2018 12:56:25 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeyh=oGE90Uz9nMxd-JgNORmoG3xPcMSHUrbnjccu5U2g@mail.gmail.com>
Message-ID: <CAJKOXPeyh=oGE90Uz9nMxd-JgNORmoG3xPcMSHUrbnjccu5U2g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: exynos: add OF graph between USB-PHY
 and MUIC
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 June 2018 at 12:39, Andrzej Hajda <a.hajda@samsung.com> wrote:
> On 20.06.2018 20:28, Krzysztof Kozlowski wrote:
>> On Tue, May 15, 2018 at 02:12:39PM +0200, Andrzej Hajda wrote:
>>> OF graph describes USB data lanes between USB-PHY and respective MUIC.
>>> Since graph is present and DWC driver can use it to get extcon, obsolete
>>> extcon property can be removed.
>>>
>>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>>> ---
>>>  .../dts/exynos/exynos5433-tm2-common.dtsi     | 19 ++++++++++++++++++-
>>>  1 file changed, 18 insertions(+), 1 deletion(-)
>> dtc W=1 now complains with:
>> ===
>> Warning (graph_child_address):
>> /soc/hsi2c@14d90000/max77843@66/max77843-muic/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
>> ===
>>
>> Do you plan to add more ports soon?
>
> There could be a link between UART and MUIC, it could be beneficial for
> the platform - there is no point to feed UART with data when UART output
> is muxed-out by MUIC.
> So I plan to investigate it but this is not on my short list :)
> Alternatively one can create graphs without using it atm.

In that case could you remove here the address/size-cells to fix the
warning? I see that code uses -1 in of_graph_get_remote_node() so it
should not depend on the reg number.

Best regards,
Krzysztof
