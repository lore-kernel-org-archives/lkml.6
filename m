Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B844C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5F62686D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wr+Fr9bi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D5F62686D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934712AbeF0BUv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 21:20:51 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33666 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933655AbeF0BUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 21:20:49 -0400
Received: by mail-oi0-f68.google.com with SMTP id c6-v6so340519oiy.0;
        Tue, 26 Jun 2018 18:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ixzjNlSxWCXoqImPEJo24Qf3pj++ES3Am9SqZlyzwuI=;
        b=Wr+Fr9biEQfG6ym0HqXX3wm51AthfHKSHqt6dTm27aMfn6n/hHLQqk9FYIe5rxJxe9
         E7Dg5V0CgjcwoGl4MmwWTyV0PCZtbzoiinTf+Q5qNFiBpt9EpNGuWAP/pkqY1FfNRgW2
         qOKhhpQ7UWi6pVpGFAnk8ow6ZM7e0ij6zE17/m/II5Vwyhu5JHqBZ0yehashD6U/Sgh9
         tWb20bGTbJ+Q+PahrIrzpN6sTV/jArGBPCw10zTbejmdapOYYgV/CsCOLt0SlzLJGLti
         eT+z3UJDN1ENUwlhjlass2MILgnGcgksD+ww6dtSDG2RFYrZxXpbIT/0bFHezAzkrSXt
         x3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ixzjNlSxWCXoqImPEJo24Qf3pj++ES3Am9SqZlyzwuI=;
        b=H0nhBj6gob7HAM2rt2sus6FZV35FLoZC6ZmSECXagflGe7HLmBSuiHnSgWlc9K/stC
         lNpNWatvHAKWuW3XQ+LRKI+zqNeC9km9EtUtx/k4aFD6/f2H77cG8k0/QTVry6qHEF05
         cut6Cw9L0NSzAa9Q+uBFN+g74eOfFN2HfqYnQ86wml2ekMxubpzRubYW4Ey9plFqG3ej
         ygnkValsubl7NsEfgy2iCVeBHWF+wLINsAwIZneTkoiNhEqzprqMPNsMT2soCNRxkUZX
         6khuoGBH+9TJYPaXnygtOVTpKSBHvL9rLot7eKMW8ECiTp6T4vTdgrGvSQJ2s9q2Lkie
         Zucw==
X-Gm-Message-State: APt69E1yn1IRkXa7Bc2cupxmJu4+Xh9rCF0DfmKM7G67sbZmgjY4GHV0
        vOHfMM8PX5AD+d0ygZyJEtrturoYgClx/b9gx14=
X-Google-Smtp-Source: AAOMgpeJ1KmcFFVoegov+VSK0myrAYTv68r+Cil5PiBRDPZ78OKtA68t+0rhvj4LAbrJJzvSz6gKo0OOY1K423/mozc=
X-Received: by 2002:aca:808:: with SMTP id 8-v6mr2239133oii.198.1530062449116;
 Tue, 26 Jun 2018 18:20:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 18:20:48
 -0700 (PDT)
In-Reply-To: <1529993283-32396-1-git-send-email-Anson.Huang@nxp.com>
References: <1529993283-32396-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 26 Jun 2018 22:20:48 -0300
Message-ID: <CAOMZO5C--fpkRLfwmySFJeO2hwPdz3paxW1WMiqcqraqmbL9Mg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: make pfuze switch always-on for imx platforms
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

On Tue, Jun 26, 2018 at 3:08 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> commit (5fe156f regulator: pfuze100: add enable/disable
> for switch) will cause those unreferenced switches being

Nit: The proper way to reference a commit is:

commit 5fe156f1cab4 ("regulator: pfuze100: add enable/disable for switch")

12 char for the commit ID and the commit name inside (" ").

> turned off if "regulator-always-on" is NOT present, as
> pfuze switches are normally used by critical modules which
> must be always ON or shared by many peripherals which
> do NOT implement power domain control, so just make sure
> all switches always ON to avoid any system issue caused
> by unexpectedly turning off switches.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
