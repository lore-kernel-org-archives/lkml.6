Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6686EC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192652081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdfNrMr1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 192652081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbeKCFGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 01:06:04 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41487 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeKCFGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 01:06:04 -0400
Received: by mail-oi1-f194.google.com with SMTP id y192-v6so2541545oie.8;
        Fri, 02 Nov 2018 12:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q/oiJDzjc73HE5m/eO6pRn11+u6W5M9OljoGnOiaDZY=;
        b=OdfNrMr1K0aybrLY83j6yFvDHRr1P8i4RXkzfLwJwC01V2g1/RoPXm6dUj75twjnGc
         BVFaEQcvhoje+XcPR947DRtd09WWeamgjRG22OA+K3NcJ9HQHOd1xqUN5hhFYSZ0+6EY
         I7au8cfTwaVT3Rjjd4ZY2azGV1QucHy8AJFFUEURpYpLsNycTmKVqmbNwN5/1dTGeOph
         1s1YLzFJUESBVzpn43BE9XSo5grDeDXNU9IVk770LG2dpEhKp1VH394eWHyDiE1IYtBi
         oCb3y/tFjo63ZQzB7fbu9sZFQsU7WOSY98JatqljctI82ZuVNkH+Ak4tQMlaP2LbyqO0
         GHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q/oiJDzjc73HE5m/eO6pRn11+u6W5M9OljoGnOiaDZY=;
        b=OjjvvCNJYASXFlvorVozMEbxNQux/aGbPBD8yJIlFoSFHobSs2Es1l7uxihMwvUsaK
         g9jK6Rvtf9JftPthu4WxE+EtIo3Y8qnMFu6xk+I/xJ+jNytGpsZNlTw2VFy7up/FEtLP
         GlLnWGAzXAlEZOxkbApOfBOehbuPTqxa3hIsZMXjS9Tbay01z4/yv0xNKktwOB262PEx
         BI7tnNAN0HN3fsTqkRW6OgyNZzva/Epuh/nLZjTjDGHGTTDbCPKnJtMKtP4gunwj9rIc
         x9soifvd57r1xVQ7Iv9+TKhixlf5v/HgR0DCkLrBHETdkk3HWxSAEWpGGPocHXWOvxq7
         DsoA==
X-Gm-Message-State: AGRZ1gK0vRHtGZoPYZzPD2p2xpkFVMPyrlEN0MZ174uqbW4X8Q//pHKY
        oeEp1WjM+kiVEA4mJ+OYuRKE7eqrUrLMyIXc8wM=
X-Google-Smtp-Source: AJdET5cz6vCtFDYr+MLNG9UW27/OKBwX6KZ6NhwcApEo06FUNUOWtmBeRrDTL0EgcWR9G1pKaA7kTDfgKyNj4XeGT8s=
X-Received: by 2002:aca:a655:: with SMTP id p82-v6mr7788038oie.282.1541188653336;
 Fri, 02 Nov 2018 12:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <20181102182857.064326086@linuxfoundation.org> <20181102182902.797148907@linuxfoundation.org>
In-Reply-To: <20181102182902.797148907@linuxfoundation.org>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Fri, 2 Nov 2018 19:56:57 +0000
Message-ID: <CADVatmOX9FfVGZhFgAZ1sVvnigucFD9DuUu+K8444mTN=Qr+6w@mail.gmail.com>
Subject: Re: [PATCH 4.14 069/143] ARM: tegra: Fix ULPI regression on Tegra20
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>, marcel.ziswiler@toradex.com,
        digetx@gmail.com, Rob Herring <robh@kernel.org>,
        Thierry Reding <treding@nvidia.com>, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri, Nov 2, 2018 at 6:53 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 4.14-stable review patch.  If anyone has any objections, please let me know.

It seems this has already been reverted upstream:
9bf4e370048d ("ARM: dts: tegra20: Revert "Fix ULPI regression on Tegra20"")


-- 
Regards
Sudip
