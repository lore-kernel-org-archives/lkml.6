Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630D6C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D953258FE
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dmh1YtZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D953258FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933157AbeFYMWu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:22:50 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:40225 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752324AbeFYMWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:22:48 -0400
Received: by mail-ot0-f194.google.com with SMTP id w9-v6so14796514otj.7;
        Mon, 25 Jun 2018 05:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RckOVZ3btwYA7Wa5DZaY7VXI1fHEGFfKh2PMutHgbJE=;
        b=Dmh1YtZUW1+PIzEaWAGToH+gqLrk/TEVt/jtm2DMh7M/MdD7sYbes5QVXdYrmYWCQP
         WWv+gCZobOL6P7wzuRKFh15S6IUmam8pYtWg2mEf9+Lefw/vk3CCPtOBvytc+npWfTIk
         eocpJiUyqlPTJU7DD+M0AOIJR7rz9rdE+YXTJjCC7oMc/0w7G35hCTP8f6tcaHl4LLoS
         XNAdwdGBQiY6hzSjT3zZcKppZXTl45IX+0pR8uJaU449ESJdWSMvmfuxdOhvk4YOo9po
         dZtb3xssbjlt/vPpCG0shvp0McVHoewiqY52Mu6vZiWHmFB6j1Im4lmli0L2yIqqFkHH
         ccJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RckOVZ3btwYA7Wa5DZaY7VXI1fHEGFfKh2PMutHgbJE=;
        b=XBSHl2BHQ1ErcJcYb4+c/LWrwaPpgCNCzAW0p1iq+nl32vCGJd6a/ML3CYb6bqyPo0
         Bwuens9V43L3fVVIkx+8xbzeDJOUlii3A4nBan2G6z+SEh4zvEHF6xLAIuvcKn1PRl9m
         hsSHHUyUVIGNbgzKmNPQEi3mKv6eealc70WHcRq8tqHE0ggPdX8C5QKqIvbMOFmY08C0
         psoBWkeLtP7MfQNwdLkUiAzEOjIvRGwwP1DspRhh9Hu4hH9tv7RLoqOr8eqL44YFew9B
         o36AVb4BATwYm8hFMstgbx5lwf5VGyTaQz3ZNLRRvmvG3nm/kBgMgSFRH8sCMhslPWX/
         c1YA==
X-Gm-Message-State: APt69E2u1XwZaGSKHl1PShOS8cf237zGbUB8xMO+5CKNSVFK2tzoPM3F
        Nxs2RYpaWuSebpIBCpTAxi9a974/s9hK5WjUiJ0=
X-Google-Smtp-Source: ADUXVKIrhtKZtjEb2y4SAiMzx6gtnA6j4DGOHgjUa528wThelLvzcb+ujAx0eJKtSkyxSY5HHc2AAQfcurOxpLfHTic=
X-Received: by 2002:a9d:30c2:: with SMTP id r2-v6mr7628825otg.25.1529929368270;
 Mon, 25 Jun 2018 05:22:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 05:22:47
 -0700 (PDT)
In-Reply-To: <1529648932-4832-1-git-send-email-Anson.Huang@nxp.com>
References: <1529648932-4832-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 25 Jun 2018 09:22:47 -0300
Message-ID: <CAOMZO5Coi-LRXG8vepnm-eSSx75LLEtsZ90WrtK6rEy76u+OBQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6sll-evk: make pfuze100 sw4 always on
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, NXP Linux Team <Linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Fri, Jun 22, 2018 at 3:28 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> On i.MX6SLL EVK board, PFuze100's SW4 is supplying
> LPDDR3, it needs to be always on. This patch fixes
> Linux kernel boot up hang caused by SW4 being turned
> off:
>
> [    1.693613] cfg80211: failed to load regulatory.db
> [    1.700063] SW4: disabling
> [    1.703973] SWBST: disabling

It would be nice to mention in the commit log what was the patch that
caused the breakage, just like Robin did for imx6sl-evk.

Thanks,
