Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C217C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F7320684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeA1no7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F7320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbeGSN24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 09:28:56 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:41371 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbeGSN24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 09:28:56 -0400
Received: by mail-oi0-f65.google.com with SMTP id k12-v6so15244404oiw.8;
        Thu, 19 Jul 2018 05:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=06enoYX0xAOA6xwbh8Mjz/k0dAPQ8c0MQ6LmZGwcedY=;
        b=IeA1no7JncS1/NNTA+IWBKJMrM5ZbyDunSobrWWs1jT8W24DcUYAbrbQH8NaXUh62Z
         HL01meJPKZP9GZ0AA5PrDI2aDvyIE9ht/oMcPONOnJZdYpARYXpxdTtBxoXc3LHhHrzA
         +0Gzi1iUv7hS2JXVmfIQQCFg6dzbei4aQHhSKqKTogm+cyfXrBDISF9DjYdglibC3NqY
         tDYWlTShwJbc1WKTAuOTFb7km8cVbY2PKcBpKTs2A2ina3IbXYYJC6nRSFL9FBWf/yQ4
         gBmzdesQkGmPCxZRvlrqtvxmjYOshv1K+fHHzM0rlpxD5k29b6kS6BCQP+Ew/OvhvsAu
         UoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=06enoYX0xAOA6xwbh8Mjz/k0dAPQ8c0MQ6LmZGwcedY=;
        b=oG80J01D3W0LKxQ7wtGw7dPm34ua/VFQS2g6pv+8lJaxHHmxSEOYnEpNRnx5QqeIzc
         gXSSRjBAShG911L5pEqC+30TJeTul8cL2oCxiyAeailLXQW9K8JJ4hYW2KIhQwevwqLD
         6bal8wXSWZcyl9q8tHo3UqjJSxKOHetW2t51C3OA4Y/8kzJcGQxxE/9lpdI3Y7VJCcek
         MrZXqBjls+zC6fcqhQ5Kwz7Lep0c/pbYmPpq/UK47BRpTEXQ3Ut8s2L+rhulm4qEs9XS
         lLFMVSxBKB/vMCMp1xexruhSBzCZUR4tvoJ07KVb8AdKwGsh7XKnIMzeqSoLz02Ntf0E
         Macg==
X-Gm-Message-State: AOUpUlEIH16O1ezYRUbFAkHgcUF3QaQL/YkZPIwFAq3cQEIYnCFq52NS
        rNoNjrTZ03oCOBZnpyuG9Gx8Bs2OJLwAH7daPgE=
X-Google-Smtp-Source: AAOMgpeuL8Ue7F2x8qriViabwYzL98dKRvQ3AS4I8NRdClzLJ0nf7LEGj0LUKT7/CJdSmWNajJM/4Zkc7unOlkMIYxM=
X-Received: by 2002:aca:b641:: with SMTP id g62-v6mr11740023oif.71.1532004356856;
 Thu, 19 Jul 2018 05:45:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6285:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 05:45:56
 -0700 (PDT)
In-Reply-To: <20180719005941.10458-1-andrew.smirnov@gmail.com>
References: <20180719005941.10458-1-andrew.smirnov@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 19 Jul 2018 09:45:56 -0300
Message-ID: <CAOMZO5D1rKH+_wuJrhD6Cr4psQwnk7CHVWm6qi0Jv7vnTiazUQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: vf610: Add ZII CFU1 board
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Wed, Jul 18, 2018 at 9:59 PM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:

> +/ {
> +       model = "ZII VF610 CFU1 Board";
> +       compatible = "zii,vf610cfu1", "zii,vf610dev", "fsl,vf610";
> +
> +       chosen {
> +               stdout-path = &uart0;
> +       };
> +
> +       memory {

memory@80000000 to avoid dtc warnings with W=1, please.

Please make sure that this patch does not introduce any W=1 warning.

With this fixed:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
