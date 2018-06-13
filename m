Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A9A9BC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50AA4208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTG/jt6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50AA4208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935113AbeFMBU0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 21:20:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935007AbeFMBUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 21:20:24 -0400
Received: from mail-it0-f49.google.com (mail-it0-f49.google.com [209.85.214.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43786208B3;
        Wed, 13 Jun 2018 01:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528852824;
        bh=Xj1HkZfmAHAtaMx5PntjsIgP2wCX40gvB3d87p27/H8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=WTG/jt6zo3GeyVCW8LP48M6I2tOr9h8eLSAFcLDgEY7A9F+0ARpTaWrsJ5BbEVFdi
         14oB2s6f2Ev+zljeFzEhSL7LdZC04APKMIoFHzfYrBYNawliAfU8euOt2bhRDxPhvL
         GeLl1rtextZvWNcOZjH3+swWcVSFPcUeUQp5RPmc=
Received: by mail-it0-f49.google.com with SMTP id p185-v6so1778736itp.4;
        Tue, 12 Jun 2018 18:20:24 -0700 (PDT)
X-Gm-Message-State: APt69E2Q9FA3t7f4Poh9gfF+biZtHjAqcSzpUM3ATMiNYAi+ug0+rkS6
        /80U0kjoWANYfbq0jI2Sa4KSm8v069pINmQfDQ==
X-Google-Smtp-Source: ADUXVKKFF1nQdXq5HOsK5je2TBu4mdOBu4BrHh+OGmc3gObppCQk+m2p3QkItO3b3ZDZI6QCwKDPy2xiwCYk+5S0ahw=
X-Received: by 2002:a24:798f:: with SMTP id z137-v6mr2647852itc.19.1528852823684;
 Tue, 12 Jun 2018 18:20:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:6403:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 18:20:03
 -0700 (PDT)
In-Reply-To: <20180611115240.32606-19-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com> <20180611115240.32606-19-ricardo.ribalda@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 12 Jun 2018 19:20:03 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLhRSbhmpaiqgG_TRRXQEsRKG5UK0HWw0tu9Eymn8cNcA@mail.gmail.com>
Message-ID: <CAL_JsqLhRSbhmpaiqgG_TRRXQEsRKG5UK0HWw0tu9Eymn8cNcA@mail.gmail.com>
Subject: Re: [PATCH v2 18/24] serdev: ttydev: Serdev driver that creates an
 standard TTY port
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 5:52 AM, Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
> Standard TTY port that can be loaded/unloaded via serdev sysfs. This
> serdev driver can only be used by serdev controllers that are compatible
> with ttyport.

I'm hesitant to expose a tty device on top of serdev to userspace that
we then have to support forever unless that's the only way tty devices
(for serial ports) are created.

I did a similar patch which just registered both serdev and a tty
allowing them to coexist. It suffered from warnings about open counts
though and felt hacky.

Rob
