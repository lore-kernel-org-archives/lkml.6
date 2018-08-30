Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6F5C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A8820673
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCYZUBPi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A8820673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbeH3FFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 01:05:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbeH3FFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 01:05:33 -0400
Received: from mail-qt0-f170.google.com (mail-qt0-f170.google.com [209.85.216.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD84B20684;
        Thu, 30 Aug 2018 01:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535591160;
        bh=p3pRx46qgCpnfJXndZx1Lwzvcex6UmU/qlyeKwtD2eM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DCYZUBPi2k3ZfqVKjjIidtb0HVxlPJhE7oMWKKDLOeCxueHYdEaiiyGy+bjNi63o9
         VZ/OYpKNggAzSu8RIxrr804mb/mmdnW60tGJxYVLv5mu++cs7CpEFTKkYpJ1cvnMnS
         1VOSeBOAeh6YNtH96SLlI+cDMCt+XDR2ZkEI5z8w=
Received: by mail-qt0-f170.google.com with SMTP id h4-v6so8029370qtj.7;
        Wed, 29 Aug 2018 18:05:59 -0700 (PDT)
X-Gm-Message-State: APzg51DrZnL9oZ+BP2OVyAoFgNY3iQ71na8qsOukQkOELRbALUlndqY0
        /BLAJqkzLdyHjh5EgZVSaWPwdn30bC81kaoCqA==
X-Google-Smtp-Source: ANB0Vda/nxnIHwHNGuhIm/8hoYZPj2FAH5V9Q+uVr/QH680JZCrqRZvNzErG+b480ei8PyB46HADRunZA7wuAhRKdm8=
X-Received: by 2002:a0c:95f7:: with SMTP id t52-v6mr9135590qvt.246.1535591158946;
 Wed, 29 Aug 2018 18:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <1520208889-3908-1-git-send-email-frowand.list@gmail.com>
 <1520208889-3908-2-git-send-email-frowand.list@gmail.com> <alpine.LNX.2.21.1808301025480.73@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1808301025480.73@nippy.intranet>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 29 Aug 2018 20:05:47 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLJ9QMHCMqGKpCouP1rTEO+cMGA1es94qAH+ukLsR31jg@mail.gmail.com>
Message-ID: <CAL_JsqLJ9QMHCMqGKpCouP1rTEO+cMGA1es94qAH+ukLsR31jg@mail.gmail.com>
Subject: Re: v4.17 regression: PowerMac G3 won't boot, was Re: [PATCH v5 1/3]
 of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
To:     fthain@telegraphics.com.au
Cc:     Frank Rowand <frank.rowand@sony.com>, userm57@yahoo.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 7:44 PM Finn Thain <fthain@telegraphics.com.au> wrote:
>
> Hi Frank,
>
> Linux v4.17 and later will no longer boot on a G3 PowerMac. The boot hangs
> very early, before any video driver loads.
>
> Stan and I were able to bisect the regression between v4.16 and v4.17 and
> arrived at commit 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of
> of_find_node_by_phandle()").
>
> I don't see any obvious bug in 0b3ce78e90fc or b9952b5218ad. But if you
> revert these from v4.18 (which is also affected) that certainly resolves
> the issue.

Perhaps a bad assumption on phandle values causing a problem. Can you
provide a dump of all the phandle or linux,phandle values from
/proc/device-tree.

Rob
