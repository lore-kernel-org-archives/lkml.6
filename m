Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B131C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 07:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A632195D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 07:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZc+YWiZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbfBQHHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 02:07:10 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44667 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfBQHHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 02:07:09 -0500
Received: by mail-pl1-f193.google.com with SMTP id c4so2110017pls.11;
        Sat, 16 Feb 2019 23:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=It5OEgJ4iYIMPI81go7NiHuDVjtSj5HVzsbxnYSlOe0=;
        b=aZc+YWiZzUUe0tTPkDcAUfqJ63RPBIhmPpH78AnM7ubdbgLf4TxT0FIapEealbMdIA
         8/F0Teqbas+ATEy3A1lS8KE8ui3UMKo3bnLgUPMAwNXJ9jEPn+OBZBOmFFfyrqW3pDTa
         p54YaZ6rAT/yLr7q/CX5lPmnxLTozqOK1vYJNSaCLB5AdFE3nqFOfw59/35KwGvvciAj
         1fWcR/XEUm6kz9ZGKqaIRprkM4vuDdZvVG9w7qxz5qkpa89e9uaYqGF9j8k666/uNg35
         SRzqoP7xQJcfSjC08epHN88GnNiCjGO0RE+0PGSfBSIUpUgJH3O2v2TZQnEH6epXSbnz
         76PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=It5OEgJ4iYIMPI81go7NiHuDVjtSj5HVzsbxnYSlOe0=;
        b=AJzbnHT0Eqo7xkANmfowlq7rprEMklEveyHP7Jl4l+i7LfQk9pey4eymWsgWSZLBLA
         uh7BDWNU5cW5uG1da5w7JcDwgFKW6MrJPslVtNz2yBBHOL6cJ0YKSczG2Nu9qCbv/GCQ
         9kMTzaWPTchgAP2MF8XoM8fFVezqK6D7Qb5rRLuw7L5IA78BEzAtb4dO97ZsDcMoNxVU
         iwmTvIRQdsxHnKy8aV4sd9qi8w3XfUAmMZcUElM9T2C+n9A5sLhOL1HfdfT4Gdx7Ttco
         KkgXZjOwqrxfORA+bgGgE9ejkJS4BomP21lSPvXkKGE+9Niz7ttLiwfSxv+qbDiLw7/J
         RyxA==
X-Gm-Message-State: AHQUAuaaZWz0OLio2IHIQ08I6i+iUPWNp0Ot7vqN6zxqHxKMGOZcM9Tm
        yGjWS6g9y3CRKZWC/7Sv7XQ=
X-Google-Smtp-Source: AHgI3IYr6DW5xEyBkZoA2bWxKRmAM6CS+vmr/dyrrPkIUVkEW2uJNmmrx58yLGTrEraZZTLgdLxJTw==
X-Received: by 2002:a17:902:8e8a:: with SMTP id bg10mr18866625plb.192.1550387228616;
        Sat, 16 Feb 2019 23:07:08 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id u13sm2947298pfa.169.2019.02.16.23.07.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Feb 2019 23:07:07 -0800 (PST)
Date:   Sat, 16 Feb 2019 23:07:06 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bastien Nocera <hadess@hadess.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 0/3] input: goodix - support Goodix gt5688
Message-ID: <20190217070527.GC148958@dtor-ws>
References: <cover.1550239328.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1550239328.git.agx@sigxcpu.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 03:11:50PM +0100, Guido Günther wrote:
> Besides the support for gt5688 two more minimal changes piled up so I'm
> folding these in here. One is a doc update for the goodix bindings, the
> other one makes it a bit simpler to figure out configuration problems
> (like lack of touchscreen-size-{x,y} in the device tree.
> 
> I've kept the original subject to (hopefully) not break the series for
> patchwork. All patches can be applied independently. Series is based on
> next-20190208.
> 
> Changes from v2
> * Add 'dt-bindings: input: Refer to touchscreen.txt for goodix ts'
> * Add 'input: goodix: Print values in case of inconsistencies'
>   (sent out separtely before, no comments so far)
> * Collect 'Reviewed-By' on 'input: goodix - support Goodix gt5688'

Applied the lot, thank you.

-- 
Dmitry
