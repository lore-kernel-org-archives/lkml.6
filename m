Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5293C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853022478E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUBjx3Yg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853022478E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934360AbeFVTGB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 15:06:01 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:45380 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751345AbeFVTF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 15:05:57 -0400
Received: by mail-ua0-f195.google.com with SMTP id k14-v6so4922659uao.12;
        Fri, 22 Jun 2018 12:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nlO5I83twLO+Emceqld392FNpdsWCF7e5WpKWesagFQ=;
        b=YUBjx3YgfZCFo5R/wNkuY8I/UlAfjJP5T+jlTsl1kcoXfSinm8NskMn2Eh7FXT6g9J
         Bie6liy8P5GjrbLjUzTdCrOiYHGyyJyoSV9h7F9CtbNiYqDW7Ky21Jn7Yt2yGxlD/Dka
         9mrLit35B2P44HtFi9IaJuplBJ3PCR83GV0ev57KS9s28eDZKZSHQ1u9GypNo1fDKR80
         NWzlottRFxMGJOWCi8RE9+qtE0G5irnvGy8QWpQFc9JLG1QyD9Ia9d35j0vdZW0wHq6l
         LSqjXHFng+u4EEg94HbD66KD640VDAZDgzrQIDdCUfAnO2wa/mcUJ5QH3AOr6EKy3y3B
         EU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nlO5I83twLO+Emceqld392FNpdsWCF7e5WpKWesagFQ=;
        b=DE8y4UtySFYsQvQfOC3HRkoH7Zm0ICKkeXpzIpV1NlYGJMksqKYC7hxw/P6xyb8Bo3
         cK3RBBnBrQ/Db0SZeNUxzkxw4qoUkZvYSB7n/MoEUDY4JK8RfRnYuuksRzOOSB+w0CF2
         xWy9bEjP+I+mifriwOLLMgcAi7rCChTsEVvwymlOVeL/p68j2glHIbEWM6KyQgscq/3p
         UQdGpSVfXrVS42KQFK/zbc0p7zRhinzOvEUbTspGTPfbwAqoVQv7kKBwnNfEU5YT5rRC
         KrYRBboBM9QEEUf2KJUz48wlQaj7X7yCopWoAqfWtI067ZlmYPnI+rfxTfYyjFY774HS
         R/eg==
X-Gm-Message-State: APt69E2bDjDetKPSKoa1Bp25pbe6r9iX/vPEyVgpEsYbuWN6kxP44QdO
        WFS2A+Yu8+NV0iI9U6evD7c2giUe+swOT7/1oA==
X-Google-Smtp-Source: AAOMgpcipUv7GUs6p6O7/bIOwI6FZ2oXhR2d/tdw38Yk8XxkK72R6iNEW7sWv/FpFuXEvUrFs0rW4H1jeyoq72yYGWE=
X-Received: by 2002:a9f:3d21:: with SMTP id l33-v6mr1828972uai.135.1529694356446;
 Fri, 22 Jun 2018 12:05:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180621201427.4961-1-garrmcnu@gmail.com> <20180622.072056.1223319763674661318.davem@davemloft.net>
 <e4fb2883-1643-a921-a138-d1255831a9bd@cumulusnetworks.com>
In-Reply-To: <e4fb2883-1643-a921-a138-d1255831a9bd@cumulusnetworks.com>
From:   Garry McNulty <garrmcnu@gmail.com>
Date:   Fri, 22 Jun 2018 20:05:45 +0100
Message-ID: <CANysgeEFOnu6DxbpV2oA3=tvz+qJnfNy=TmG=cpRndcLmCNe1Q@mail.gmail.com>
Subject: Re: [PATCH] net: bridge: fix potential null pointer dereference on
 return from br_port_get_rtnl()
To:     nikolay@cumulusnetworks.com
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        stephen@networkplumber.org,
        =?UTF-8?B?SmnFmcOtIFDDrXJrbw==?= <jiri@resnulli.us>,
        bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018 at 00:35, Nikolay Aleksandrov
<nikolay@cumulusnetworks.com> wrote:
>
> On 06/22/2018 01:20 AM, David Miller wrote:
> > From: Garry McNulty <garrmcnu@gmail.com>
> > Date: Thu, 21 Jun 2018 21:14:27 +0100
> >
> >> br_port_get_rtnl() can return NULL if the network device is not a bridge
> >> port (IFF_BRIDGE_PORT flag not set). br_port_slave_changelink() and
> >> br_port_fill_slave_info() callbacks dereference this pointer without
> >> checking. Currently this is not a problem because slave devices always
> >> set this flag. Add null check in case these conditions ever changye.
> >>
> >> Detected by CoverityScan, CID 1339613 ("Dereference null return value")
> >>
> >> Signed-off-by: Garry McNulty <garrmcnu@gmail.com>
> >
> > I don't think this is reasonable.
> >
> > The bridge code will never, ever, install a slave that doesn't have
> > that bit set.  It's the most fundamental aspect of how these objects
> > are managed.
> >
> +1
>
> This keeps coming up, here's the previous one:
> https://patchwork.ozlabs.org/patch/896046/
>
> Please do a more thorough check if these conditions can actually occur.
> In this case, as Dave said, they cannot.
>
> To be explicit as with the patch I mentioned above:
> Nacked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
>
> You can find more info in my reply to the patch above.
>
> Thanks,
>  Nik

Thanks for reviewing and for the feedback.

Regards

Garry
