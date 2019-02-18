Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8921C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 03:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F925218C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 03:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfBRDdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 22:33:49 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46194 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728492AbfBRDdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 22:33:49 -0500
Received: by mail-ed1-f67.google.com with SMTP id f2so12576670edy.13
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 19:33:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=upPWHsXNCQRVXhsv1yEQQuASUcKOZFHzBMQcXvbZy1Q=;
        b=juV7gXeFQ+gCmsD0WiIxkj4xWOwt7gucZDRu4zINPR0ijkeCXe1f/XeayZ7Lvi6SpD
         yWta1LnAv3yGtBJvSN1QD3wNJfHBVXNzUNH/4DoKE4U4TIVIJYtBJt7C3zyLLn7+4Pj3
         rsw9q+wdThvliGYBGZyfs/LGxPIcKQiJ/Jqwi7LOyl+F2KDQ1miybBVm5WyjvJ1dA3HC
         JlGd634fMGpqUrY1vmlyCygJyjoNr1ibujDrbeC69/pdeTQw6O+9U1myFhNWBzZmQdGX
         sho7KnkVNf8bcvMxmNa2TXouG9tlcbhvS4xzCQ0prHiv9wy8LZijj66PckiQYbjMkdsy
         tneA==
X-Gm-Message-State: AHQUAuaOpN80n2g38e+KoyxIEPqypPkSgkz/C0wX/W99uVKmdqoElocg
        Z/LGAK9xq7m3OpOIPde3+RlfadHdb84=
X-Google-Smtp-Source: AHgI3IYf+R9ObccuVtUXGG/mBVNmrSj0YEOwKgOYDZPrNHOpSiCl7us221U5Uhr1RE4BTDlJ78xSHA==
X-Received: by 2002:aa7:c58c:: with SMTP id g12mr16976324edq.226.1550460827497;
        Sun, 17 Feb 2019 19:33:47 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id f10sm683492edb.60.2019.02.17.19.33.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 19:33:47 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id w2so2087377wrt.11
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 19:33:46 -0800 (PST)
X-Received: by 2002:a5d:66c1:: with SMTP id k1mr844782wrw.120.1550460826296;
 Sun, 17 Feb 2019 19:33:46 -0800 (PST)
MIME-Version: 1.0
References: <20190218010120.27958-1-megous@megous.com>
In-Reply-To: <20190218010120.27958-1-megous@megous.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 18 Feb 2019 11:33:36 +0800
X-Gmail-Original-Message-ID: <CAGb2v65W9NMJh-iFLr3p4=+VWYFi6j-cb2AeFLX9YSnce0Fiew@mail.gmail.com>
Message-ID: <CAGb2v65W9NMJh-iFLr3p4=+VWYFi6j-cb2AeFLX9YSnce0Fiew@mail.gmail.com>
Subject: Re: [PATCH] regulator: axp20x: fix DCDCB and BLDO2 definitions for AXP806
To:     =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>
Cc:     dev <dev@linux-sunxi.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "open list:VOLTAGE AND CURRENT REGULATOR FRAMEWORK" 
        <linux-kernel@vger.kernel.org>,
        Rask Ingemann Lambertsen <rask@formelder.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 9:01 AM <megous@megous.com> wrote:
>
> From: Ondrej Jirman <megous@megous.com>
>
> This fixes another set of errors from the refactoring of literals
> to mask preproccesor definitions.
>
> Found by debugging a broken voltage setup on Orange Pi One Plus.
>
> Fixes: db4a555f7c4cf ("regulator: axp20x: use defines for masks")
> Signed-off-by: Ondrej Jirman <megous@megous.com>

The first hunk is also covered by a patch from Rask Ingemann Lambertsen.

Acked-by: Chen-Yu Tsai <wens@csie.org>
