Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA839C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 22:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BED2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 22:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeyGWAWj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbfASW05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 17:26:57 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35818 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729618AbfASW05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 17:26:57 -0500
Received: by mail-oi1-f195.google.com with SMTP id v6so11829413oif.2;
        Sat, 19 Jan 2019 14:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sC2lgsRG/6Y/xz61JsT9wpZ3ebWqOk7wzNKMpksxNQE=;
        b=LeyGWAWjo/gXv38ht3V+sWmNj1rRPoH20zj/9wZhZWYsJODYQH2xKCBa6ngsE27z93
         B8odi1qqKm2asdQLvETObu6mD2Dbbxh83dkUfT9ShL9J9wJ4eKmnF5Ht2+OmTROK5emb
         QBYgqrkptcBf7O7+oLF/+NXOgD9Gr3OD5+AJGSikKsrNh9vDi683SRMJyoICbnOwmDUP
         8gSaSqZ8ARxkWIgrlSv7djGesw0NmpUY9F0JC78AO5JQ05RAfwCGdloxgpGz6aQBmHIQ
         cHWp3S1KPGyqreFOS2eZuJ7Ld5LacPo7Aa75/acOA7PD7PioQg7bFAmsj5T0QBqJXimH
         rtgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sC2lgsRG/6Y/xz61JsT9wpZ3ebWqOk7wzNKMpksxNQE=;
        b=qU61BL2P0Z5GSJKPKJDYMDgXb2cXMOA5Rt3lk4meQYgc5Jrjt6X11Xsnhb0+q1KzaT
         WxeFh6L4UKOh7JJ7ZsVlx7Mdf9IqkYOpzo/7DKS+7XRyOJK1YkWKPj2onbqXFQDr8Bpx
         qNnBmNfGRyPVzSK5b9hkj7E+ONUIgPMDVBGuGVbxBwSTGZVGzZ72/6yDWfizM1KSnXsu
         zGXB88fJSC5xNXQOAohY/Fy8fjl5LpKctxVqE2dKmFAiXZtEMNSKlYP52l1FWlWiqHRN
         tSEJ37N9Qh67p5zWtxvSCGY8j6FC1MAsnxrU1HKb5NHE7c6EVg8qOR3FtspxYvDp8ztZ
         dBcA==
X-Gm-Message-State: AJcUukdiK52u63KhgkiKM0disX5EZsrEd5K3YZFu+meGOoJR8Dygs4JP
        5yyb9hIaSpkk/Jwu+5WBCcrgfgpwTSm7sRxA0Es=
X-Google-Smtp-Source: ALg8bN4SmOr6F1zffT8J2Dh+dxyPK7N4+e3wU8p9BXncSwOAEkvdGPagZmL/OzepcyDWGXxohn5mIIivFzYD4TOWiUw=
X-Received: by 2002:aca:ab53:: with SMTP id u80mr1969833oie.261.1547936816216;
 Sat, 19 Jan 2019 14:26:56 -0800 (PST)
MIME-Version: 1.0
References: <20190119211815.25101-1-slongerbeam@gmail.com> <20190119211815.25101-2-slongerbeam@gmail.com>
In-Reply-To: <20190119211815.25101-2-slongerbeam@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 19 Jan 2019 20:26:47 -0200
Message-ID: <CAOMZO5D-2ygYBj3OuYF4pj7=HyO=aodpY2g+AjCt1EEpX5rk7g@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: imx53: Add capture-subsystem device
To:     Steve Longerbeam <slongerbeam@gmail.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Sat, Jan 19, 2019 at 7:18 PM Steve Longerbeam <slongerbeam@gmail.com> wrote:
>
> Add video capture_subsystem device node, and include both CSI ports.
> Prepare for adding sensors by adding the parallel sensor anchor endpoints
> to the CSI ports.
>
> Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>

Looks good, thanks:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
