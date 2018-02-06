Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752837AbeBFMQZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 07:16:25 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:52528 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752475AbeBFMQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 07:16:18 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name 68ACC2E5B47
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Tue, 06 Feb 2018 13:16:16 +0100
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Mike Galbraith <efault@gmx.de>
Cc: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "'Paolo Valente' via bfq-iosched"
        <bfq-iosched@googlegroups.com>,
        Alban Browaeys <alban.browaeys@gmail.com>, ming.lei@redhat.com,
        ivan@ludios.org, 169364@studenti.unimore.it,
        Serena Ziviani <ziviani.serena@gmail.com>
Subject: Re: [PATCH BUGFIX 1/1] block, bfq: add requeue-request hook
In-Reply-To: <1517918234.25841.31.camel@gmx.de>
References: <20180205190510.5499-1-paolo.valente@linaro.org>
 <20180205190510.5499-2-paolo.valente@linaro.org>
 <ee76e49c0d1ceab07c20e9d27e2fdc46@natalenko.name>
 <1517903761.9843.12.camel@gmx.de>
 <899B68CC-5955-4418-8BFF-DC55A743A61B@linaro.org>
 <1517918234.25841.31.camel@gmx.de>
Message-ID: <77124223e6116350a5184a5199850304@natalenko.name>
User-Agent: Roundcube Webmail/1.3.3
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1517919376;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
        bh=oLoH42cZvTFblyd4Wkf8grsXI08IMJ4l6mJLkEZZrAg=;
        b=LT4KNDLSDY1KopLSnLfdMmMYsf/mPGFmgFBJO2KfQPz/e31IaBbHh30GLhMSQOAvl3uSjw
        0bNAsUA+y/CKpWGGDHe+sPsJkDiiHvFn846eYyEDAeDtzUIGrZ0P9WgBJ11UVT2Bt/I9Y2
        kCi6CtQToxpv5avljwAvU6WK0GPiZ2I=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1517919376; a=rsa-sha256;
        cv=none;
        b=S29LtDtrvuL746fI9wvKovTBKcqHBOlBDAetgxryTJIE5bfuddRY/HWBTO8Od/4j4OhNhbO87rJN1vepqPrxAL1Rj5AzlgYcyX3jEstknaPdTzAB3qweZIEZ0p0TsSate5/CaIT29mbfbzGTIfZjPk6F7KUmKNOO6mzDQaUF3KM=
ARC-Authentication-Results: i=1; auth=pass smtp.auth=oleksandr@natalenko.name
        smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

06.02.2018 12:57, Mike Galbraith wrote:
> Not me.  Box seems to be fairly sure that it is bfq.  Twice again box
> went belly up on me in fairly short order with bfq, but seemed fine
> with deadline.  I'm currently running deadline again, and box again
> seems solid, thought I won't say _is_ solid until it's been happily
> trundling along with deadline for a quite a bit longer.

Sorry for the noise, but just to make it clear, are we talking about 
"deadline" or "mq-deadline" now?
