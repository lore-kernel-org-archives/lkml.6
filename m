Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A124CC04AB8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428552086C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHVt+pAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 428552086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeINCiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 22:38:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727728AbeINCiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 22:38:21 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C99820881;
        Thu, 13 Sep 2018 21:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536874025;
        bh=p+tdWCD3+qCv3ttWpFfo/4tC6Elg4VqkvmXH9UYiS/E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gHVt+pAOo1iLrEMPsZDfH8RuSYH5q355+X8fQrvIpIXoG2joNpfFSMhZXGvjwuRqn
         f1rMn0DqAOvTZm45dT5KbIMj7yO0ID6p5PPkVZ/7TuCAZ43UJyyu5tXGzI5pu0G3od
         l1ojm1GN4e0boHnjgOFM+WDlzjb5SlzhAOYyHhqY=
Received: by mail-qk1-f181.google.com with SMTP id z125-v6so4054759qkb.12;
        Thu, 13 Sep 2018 14:27:05 -0700 (PDT)
X-Gm-Message-State: APzg51AMlme5Fu/xuTvxzhLKT6z7IwNpfvxcC+RTKM/x+qOcCWn3INUX
        Q+o3ARjfWgIeun7w4cH83pVs5qL1iapGtbrCpg==
X-Google-Smtp-Source: ANB0VdZinhYzjvTO+KwvAxOdZSnOWxx+Rs4MaDYI/D0tajNT2huELLORFET4iRmkhxR5/mKrewxlQk/qMZJ403FmuS8=
X-Received: by 2002:a37:bec4:: with SMTP id o187-v6mr6427539qkf.326.1536874024761;
 Thu, 13 Sep 2018 14:27:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180828154433.5693-1-robh@kernel.org> <20180828154433.5693-7-robh@kernel.org>
 <20180912121705.010a999d@coco.lan> <CAL_JsqK8B46x8bm_aYggJSPAWrMGZ1rZ58uWCmyiSqA2KZpiFg@mail.gmail.com>
 <c7a3263ac94a6c31bd58c06683d55015be2e8be4.camel@perches.com>
In-Reply-To: <c7a3263ac94a6c31bd58c06683d55015be2e8be4.camel@perches.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 13 Sep 2018 16:26:53 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL=+O=G-0uVdKGcq4T8pSzkdGV1sd_p682-6SFXuNt2mA@mail.gmail.com>
Message-ID: <CAL_JsqL=+O=G-0uVdKGcq4T8pSzkdGV1sd_p682-6SFXuNt2mA@mail.gmail.com>
Subject: Re: [PATCH v2] staging: Convert to using %pOFn instead of device_node.name
To:     Joe Perches <joe@perches.com>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ian Arkver <ian.arkver.dev@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devel@driverdev.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 3:45 PM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2018-09-12 at 15:26 -0500, Rob Herring wrote:
> > A problem with MAINTAINERS is there is no way to tell who applies
> > patches for a given path vs. anyone else listed.
>
> try the --scm option

That kind of helps if the maintainer has listed a tree, but gives
wrong results if not. And you still have to figure out who owns which
tree. That's not hard, but it's not scriptable.

IMO, we should reserve 'M:' for maintainers with trees and use 'R:'
driver maintainers. That's redefining M as "maintainer" rather than
"mail patches to". You could still have both for a entry so you can
know who to go bug when your patch hasn't been applied.

Rob
