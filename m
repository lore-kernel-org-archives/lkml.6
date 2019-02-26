Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F362C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C784E2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eIy1fJq/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbfBZT1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 14:27:52 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46114 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728673AbfBZT1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 14:27:51 -0500
Received: by mail-lf1-f66.google.com with SMTP id g12so10505360lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 11:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kxqmNmB3vPxLiIOD/Vp/eA6xu4IV9Wmk6Kx9vpGJNQg=;
        b=eIy1fJq/TkcoYGKwOqOWNV2Oqs5Za8rH61I+zD2huHLiBD7XNSLYSW050QFR3I+qkd
         kyDnvyP6py9eyeyWZi+Wne8NA0n4tLFoHynrfaSEYh/IILLnhXlofWxdR5DiaoSfG0Vn
         VnwBH6+t+rVnr6PEsnv87WvtPBZeHnhU0blxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kxqmNmB3vPxLiIOD/Vp/eA6xu4IV9Wmk6Kx9vpGJNQg=;
        b=EucagCIhIe8qp31TGneGykvqQoxi5CHgNv2DdODLLc9JwuPfzH2uNpSQ6hmSA1PBeh
         6E/0qbSCC4/L7q18i2DPJIxBY+bPXDRg+9noaWDt3qJE87y43kpvfTN25ZeL+vhfN8Vz
         9tKTS5wyL7foiVgb8ndvKmhFmxgn2riTIM1rKJ1kWKsM1uCaR5ni8HdUevaflxQA49GN
         W5KLMBBqvmIGz6kXAEkHdwtJE+o27NkK5XG1pHwrJYc0PJ6nbtd8LzgpC8YGnT31JGAK
         q3HUHWxnFlsXwTXv00CrA2q7+T7i6/zUvnd7qsOfgoGqFrbdKesIxq+7Osc7KI09COIr
         YmqQ==
X-Gm-Message-State: AHQUAuYuRAMiBJnvQTZ1sn/kVamdHyteKT8b68Xb1uBVxtmyyk8QAZi9
        77r69taxSLnNnqL3f2KPd5Il5WR4+kg=
X-Google-Smtp-Source: AHgI3IZttgo6zzIBOImdUr85sei0vQhdotdSHmiA6uiUnetJWpQDb7TJvhbEAK1ph5QHWKD409JMPw==
X-Received: by 2002:a19:cbc6:: with SMTP id b189mr11536874lfg.34.1551209269628;
        Tue, 26 Feb 2019 11:27:49 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id u15sm2147116lja.73.2019.02.26.11.27.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 11:27:47 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id r123so2160977lff.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 11:27:47 -0800 (PST)
X-Received: by 2002:a19:f607:: with SMTP id x7mr14526026lfe.47.1551209267220;
 Tue, 26 Feb 2019 11:27:47 -0800 (PST)
MIME-Version: 1.0
References: <20190207205730.199332-1-evgreen@chromium.org> <20190207205730.199332-2-evgreen@chromium.org>
 <yq1h8d7qew5.fsf@oracle.com>
In-Reply-To: <yq1h8d7qew5.fsf@oracle.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 26 Feb 2019 11:27:10 -0800
X-Gmail-Original-Message-ID: <CAE=gft4UXAZqorCfA-F2O8b__ZM-iM2zn6+1KQevU7UL1tceTQ@mail.gmail.com>
Message-ID: <CAE=gft4UXAZqorCfA-F2O8b__ZM-iM2zn6+1KQevU7UL1tceTQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] loop: Report EOPNOTSUPP properly
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Alexis Savery <asavery@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 6:32 PM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Evan,
>
> > Properly plumb out EOPNOTSUPP from loop driver operations, which may
> > get returned when for instance a discard operation is attempted but
> > not supported by the underlying block device. Before this change,
> > everything was reported in the log as an I/O error, which is scary and
> > not helpful in debugging.
>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
>

Hi Jens,
I think this one at least is ready to go.
-Evan
