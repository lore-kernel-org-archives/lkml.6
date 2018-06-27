Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9261C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DB922B67
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxTlYsaI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37DB922B67
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934655AbeF0BT7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 21:19:59 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:42731 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752350AbeF0BT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 21:19:57 -0400
Received: by mail-ot0-f196.google.com with SMTP id n24-v6so381936otl.9;
        Tue, 26 Jun 2018 18:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=x2DH+1GZrwdQdSiP1SgCWfCwYlxwadyMaYDgApxjBzA=;
        b=YxTlYsaIShxyw/AaqvtOi/1f+/XnSQv7lLQ8RdfAbx19AmyeZ1lFK/0C16RZvgfF9/
         mIOg6Bm29n+WmSRHJLfq2V0437D8BWTeqb97fnmgUESgDzyic+9qguzMgl9AYvC/46ER
         8Wn400iiWvQBy4PRp6jjZ/gHb0oPrNijutGhpGftmqjMtFEYMVfTsrVaky0uwWi4JyVv
         oIOJUHuoXV/sSI0SBnlwr/5XL8K6mSBcpuzPv0Bp1Zfw75mVhw4o2uGB0r5rgX+doOg7
         b2FJggxld+gAQmLXbV34ciKzVzAkj/3c60MsBm9bRLM79xhkUPmUZkmUQrveML++ulfV
         sVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=x2DH+1GZrwdQdSiP1SgCWfCwYlxwadyMaYDgApxjBzA=;
        b=m/2U3Rq2oX4yd9m7PKEiAbi2IfB0N+80v5qBypWitod04bsWQlVfdQb9V8WuaoZbSK
         3y2F8oasn7bowO1Ai5DtYjqt2mOSxReTwObePTd9sCSoqP7Km++vhzpn9Qqnk1uQce7k
         YihQRUIPRVdzWjJ4+36ictL1CqE4dPyIJtoIyPl1osJiWmWM2RrtSKIhzg/YvNaLnO+T
         /educCHy/e+ezwWw3i810mbs8bBXmvslEzkXmNrvAbDl9Kf3y/lAlLqW6eceKeLbEjKu
         52sz4C4s8UoL4QSSTmeGHCQ/HlQP86ifLFla1izfrgVt4L/yqMgjkyG5+PZDlSO5KHZ4
         opog==
X-Gm-Message-State: APt69E1yyRX5AryZwkxrr7P7atoNlPBBwQsqlSmRPWWWqUMBW1a7ZTg5
        l4TnguGKEPX45SIIGmCC9LObN4u8R+Mun03MA/o=
X-Google-Smtp-Source: AAOMgpeTyOpf+0DB0SpAPozTzCWL1vZRcsCiNAbht2BJMmiSpTirGgGc/w7yz/OA7jNnPlUWh9W9D8Xr8/p2I4EVHyk=
X-Received: by 2002:a9d:2da3:: with SMTP id g32-v6mr2111325otb.61.1530062396566;
 Tue, 26 Jun 2018 18:19:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 18:19:56
 -0700 (PDT)
In-Reply-To: <1529974900-28865-1-git-send-email-Anson.Huang@nxp.com>
References: <1529974900-28865-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 26 Jun 2018 22:19:56 -0300
Message-ID: <CAOMZO5CfmYvE0hLfeni6wQfE6j7C2qa9teQbo3zOWCnq33zhBw@mail.gmail.com>
Subject: Re: [PATCH V2] ARM: dts: imx6sll-evk: make pfuze100 sw4 always on
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <Linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Mon, Jun 25, 2018 at 10:01 PM, Anson Huang <Anson.Huang@nxp.com> wrote:
> On i.MX6SLL EVK board, PFuze100's SW4 is supplying
> LPDDR3, it needs to be always on. This patch fixes
> Linux kernel boot up hang caused by commit
> (5fe156f regulator: pfuze100: add enable/disable for switch),
> because SW4 is turned off unexpectedly:

Nit: The proper way to reference a commit is:

commit 5fe156f1cab4 ("regulator: pfuze100: add enable/disable for switch")

12 char for the commit ID and the commit name inside (" ").

> [    1.693613] cfg80211: failed to load regulatory.db
> [    1.700063] SW4: disabling
> [    1.703973] SWBST: disabling

Probably worth adding the Fixes tag so that it can fix the boot
regression in 4.18-rc:

Fixes: 5fe156f1cab4 ("regulator: pfuze100: add enable/disable for switch")

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
