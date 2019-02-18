Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE9DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4135A2177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxhX698T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfBRTeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:34:14 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45988 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbfBRTeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:34:14 -0500
Received: by mail-ot1-f65.google.com with SMTP id 32so30119645ota.12;
        Mon, 18 Feb 2019 11:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qg9PYtmo75N3NLJ42O8oziK5/XtaVpNImZCvxXM0q1A=;
        b=MxhX698TRbIGqNGzJvtque3PV9g3urCEVbsYRpKMPIp+bn9qLSbN8dViZO8CjECtdK
         sojlOGXOm4UvB1oB3ePXf19sBPycFD5VFZTT6lShIdhyv+moJ0wE1xqtAfNxrIyQspME
         YLYUaNoqi6SWcCtzKLIZNLWTp9oyUeEDFtalvHO5KJrbrD3e1lr33M36lrkMcg017yNm
         Ao9XEs0Wi+1/C8Vnk57QCIeYw3zm7xnomR/XXMJGdElim2N8vwFwqVm/uXyP3/9vDiaS
         +CqbZ13DJpg0M0zNaTA1xXV/BmHXsfVmqE9ik+vOLHTg1xafy/AKD8o/dlpylhC9KsEZ
         fA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qg9PYtmo75N3NLJ42O8oziK5/XtaVpNImZCvxXM0q1A=;
        b=PQ6qEtcQGZhCpHk7wWu43iXgNlB9cKllVKDNwoSBesSNwBDKqwKuqBw2365B4c2SqT
         4URcLszSaENBGNwxpL46lVItrLztDIvBtD7Wflph6GqpWMOTELsL/Dfo17tIf7UswEj2
         7U0HPbium4FaXTld+5Xchm+fpANTDvySTNqB8JDYsSKlYAPmif1BU3FnLBqUI+uwuwM3
         F8wOTMuJJgZgD8XJmjApQhzsUdpFy/EBzXwp0NiecMpy6Cp44VQngsVNVRQDnx/h3Wn4
         TBHbvgCMjanRWCSLLHF1oOzbn2NxkD40UQJl3HQyYZr2fb11y7Pg7NhHu94cv9B4am6s
         isTA==
X-Gm-Message-State: AHQUAubCvKXSLhDxQWo1yIiPKSTUHd8x5UBykePmvYo6XpAL/V5S/Mjr
        J9+tkIoY+XboGhuTi38w7GybuJvzD12UF9jwAwVVHuOF
X-Google-Smtp-Source: AHgI3IYwMuxyNzeeWPVxFNNQhzJvDZ/zG9cNd9hhwNHDoUjNJEw3Zstdbj03DP3l4FUkW2RPe9eOYaBlvK4UFhgoDrY=
X-Received: by 2002:a9d:6f0e:: with SMTP id n14mr9890790otq.156.1550518453747;
 Mon, 18 Feb 2019 11:34:13 -0800 (PST)
MIME-Version: 1.0
References: <20190218133505.801423074@linuxfoundation.org> <20190218133506.144278426@linuxfoundation.org>
In-Reply-To: <20190218133506.144278426@linuxfoundation.org>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Mon, 18 Feb 2019 19:33:38 +0000
Message-ID: <CADVatmNFN8scfVrTnb4UFEUVxEc1CAGTHa=6YsRpaUcYBubLuQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 04/62] uapi/if_ether.h: prevent redefinition of
 struct ethhdr
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        "David S. Miller" <davem@davemloft.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Feb 18, 2019 at 1:56 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 4.14-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> commit 6926e041a8920c8ec27e4e155efa760aa01551fd upstream.

This has been fixed upstream by da360299b673 ("uapi/if_ether.h: move
__UAPI_DEF_ETHHDR libc define")

-- 
Regards
Sudip
