Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C631ECDFBB
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 00:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3311A2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 00:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXj0WlDe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3311A2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbeGSBdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 21:33:13 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:38675 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729972AbeGSBdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 21:33:13 -0400
Received: by mail-oi0-f66.google.com with SMTP id v8-v6so12357056oie.5;
        Wed, 18 Jul 2018 17:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QzdBLnkCV5n9c4FYGprZBKgvC4tjKMskRK1wFf0PJ18=;
        b=MXj0WlDeq2DgavKTU+hv8j010EVBKZNrJajJkVUmhoEFoInAuxSOW9iLXgfjyltbxx
         7/2VEfiWZgBS33w0wa6kOOK4JmU2KWGlk160GTwn1e/D2piA2CICV3iMfYmjkDxDPTLS
         rlntbPsA68+U0vBE4w0eeADOKKgIB7K2DZpplAtJFYCVKA4fdOML+bs6CX+i+foFxkOC
         x6x11DTUH7fv9O8rRPAe6gMUvSdcpq4ofcFodF4Yfuk84cA2PwZ4MAgv0DR/yvjbCDKf
         V6HWL2ck/4jpgTZomMJw9lHNe36QDf2Calxh6PqYqNyPpZKAxsogHe46ECzUJg5hMdp6
         IjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QzdBLnkCV5n9c4FYGprZBKgvC4tjKMskRK1wFf0PJ18=;
        b=eqlJaSwB0uIk+W5/+QZz/3H+CFis6fVR/turnowAvNILbiPQ+6TXpcKU5wjvlFGTWy
         5lFaed2Sg3JSDiaTWMfNER1WM/vcCRSGYl4ZMDsN3iEGuXzfDbrKHHKgJihXvPL3VKQI
         BqWdoblFAE3YKXXpqId75v5jcqmXhKjnr7JpPsVjW1X+wn/eIiXOP76RMuiIYfhVlZ3l
         svX+ggfDoAKrC7cTjYF/P/P485JRrsX04ijgvk+6WQh9h9lbbRjpwexVxUI60+9ZEe5v
         vnGdxknrJmNIkbxXh1pXNdj3PX/fXn2NQVk/CKzVtXrhkycOHnZqdcKqn+pB1FRbTGWY
         ha2A==
X-Gm-Message-State: AOUpUlFhqxlveNBx9r88/VKSvAsj7cylxQorJ6eWjshEGc7Z4Ynm3M/N
        Br48hxs2y2+AAfncy9KPkwLmsMItO1IxvDnj5sw=
X-Google-Smtp-Source: AAOMgpfcns5Qw1sMKdPnxfF56AJt9aA8yf8rQb25Qm33zIibW268oslPh17KsczKvo080d3KPEdjPj0BNQi2AMEqj44=
X-Received: by 2002:aca:e510:: with SMTP id c16-v6mr9370619oih.44.1531961564241;
 Wed, 18 Jul 2018 17:52:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6285:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 17:52:43
 -0700 (PDT)
In-Reply-To: <CAHQ1cqG+-7sxJjqs86HG3iOdqDWNQZRpTDTev8XYi2jH=BVFOg@mail.gmail.com>
References: <20180717040651.641-1-andrew.smirnov@gmail.com>
 <CAOMZO5Dp5aTZF0drkD+QSRyX6qGxAe0yeYGUS8-v=FtJwA7=SA@mail.gmail.com> <CAHQ1cqG+-7sxJjqs86HG3iOdqDWNQZRpTDTev8XYi2jH=BVFOg@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 18 Jul 2018 21:52:43 -0300
Message-ID: <CAOMZO5BW8HK1Vbg9Z+mjCk_AZ5aR_q86HOZHY7F-wZQer7H9yQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: vf610: Add ZII SSMB SPU3 board
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Wed, Jul 18, 2018 at 9:51 PM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:

> It's not used in Linux, but I do rely on it in Barebox here:
>
> https://git.pengutronix.de/cgit/barebox/tree/arch/arm/boards/zii-vf610-dev/board.c#n94
>
> and here:
>
> https://git.pengutronix.de/cgit/barebox/tree/arch/arm/boards/zii-vf610-dev/board.c#n137
>
> so it's pretty handy to have. I can remove it if it is too much of an eyesore.

Thanks for the clarification. If you use it in Barebox, then it's fine
to keep it.
