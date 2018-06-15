Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 95F2FC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422F520896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JhDYDfx0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422F520896
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756193AbeFONBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 09:01:42 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:37805 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756169AbeFONBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 09:01:40 -0400
Received: by mail-yb0-f193.google.com with SMTP id h141-v6so3472818ybg.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 06:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/8TymKpWUm8HoiP8HNlLUHf26HtjrIGbne74sZjYArU=;
        b=JhDYDfx0mduU1cuk8bFIGS5N/V7Rrqj8w52VNrZfq62sd4ABEPbvU9JYAp7uH5GQV3
         /MuVivINgLWcrMeVvKlMwBbwHHyQbg4S9KYsxdKOuW5pblem4H1z9GtV4ALWfgXYnMJm
         YOtgmcWOIw7mjIxktsx8OdJwMqAif9BTaXw0F6tJD0dds9cMTehhOGK/TA+pNay0sX1j
         d8OCkKFNIr570nzktaJPBecIg0UXNldiFakLtytTnbrCf8LdbnyJ2+Akp8Aa+oY5Clqd
         Wb6HWhjXa09fuySMYsbx6vaCKINg3X2VtZLgMNsE3bZHl5ADpmHstB4yklS2gFTPXDF4
         Pdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/8TymKpWUm8HoiP8HNlLUHf26HtjrIGbne74sZjYArU=;
        b=GgX04qQ/CjsxIlnnsuw12v9BQoiq9iHhtnTp9OBXpR2jdxPFY0dqgEd6pOyP92Iecd
         osioKI9JU7Esc7P+UXPMLOMjSf0LGO27YQ4VcwBrGDCs3qmWq3sDxA23rstT2iOMdEiR
         T5K+wrhq5nSYfOEkskoECk0Ij9mS9YA1tBYuiLY5ZXbhMuwPy6UxUxOH2Z4KOWTHymAb
         OxMq+XMsQS8Fk7VxyusAp+vHkEiaPN5K0eHLQtnL6F7pJx9e39nyxtSryrkvRyQDXgU4
         O8Jj8epN2tnj/4bPVlMG+ruo/7OZpWFiAUjnwOHf3HdjxgF9ZeX8sAONXS9xBE0zlvV+
         OYGw==
X-Gm-Message-State: APt69E1TfjbfIHIJ6NPeSL+c69yPFUCWQOvn35/Prezw9sTDRI6Pmnx+
        K0vy+x1tMv41LYkkWzGS6E/e4N285Zo8e2YVh6Ma1g==
X-Google-Smtp-Source: ADUXVKIiXY7b2NN+atJBxUJAJniRVnifeaj2jB1HHRyRfS0mXV6i+nFKUkQmRicX8qxoJviffW3ng9hIWEgXfScsQLU=
X-Received: by 2002:a25:ae98:: with SMTP id b24-v6mr738694ybj.347.1529067699579;
 Fri, 15 Jun 2018 06:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180613140714.1686-1-maxime.ripard@bootlin.com>
 <20180613140714.1686-2-maxime.ripard@bootlin.com> <9c80de4e-c070-1051-2089-2d53826c6fc7@xs4all.nl>
In-Reply-To: <9c80de4e-c070-1051-2089-2d53826c6fc7@xs4all.nl>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 15 Jun 2018 06:01:28 -0700
Message-ID: <CABXOdTdrXiseyjS_aWwbiAWW9F4gcQbRsK-KCkUVub82dBtZvA@mail.gmail.com>
Subject: Re: [PATCH 1/9] CHROMIUM: v4l: Add H264 low-level decoder API
 compound controls.
To:     hverkuil@xs4all.nl
Cc:     maxime.ripard@bootlin.com, hans.verkuil@cisco.com,
        acourbot@chromium.org, sakari.ailus@linux.intel.com,
        laurent.pinchart@ideasonboard.com,
        Tomasz Figa <tfiga@chromium.org>, posciak@chromium.org,
        paul.kocialkowski@bootlin.com, wens@csie.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        nicolas.dufresne@collabora.com, jenskuske@gmail.com,
        linux-sunxi@googlegroups.com, thomas.petazzoni@bootlin.com,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 5:00 AM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 13/06/18 16:07, Maxime Ripard wrote:
> > From: Pawel Osciak <posciak@chromium.org>
>
> Obviously this needs a proper commit message.
>
> >
> > Signed-off-by: Pawel Osciak <posciak@chromium.org>
> > Reviewed-by: Wu-cheng Li <wuchengli@chromium.org>
> > Tested-by: Tomasz Figa <tfiga@chromium.org>
> > [rebase44(groeck): include linux/types.h in v4l2-controls.h]

That internal note should go away.

Guenter
