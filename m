Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 65B44C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8F22086E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ng2WAp8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8F22086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934462AbeFLUXc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:23:32 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39081 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933517AbeFLUX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:23:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id p11-v6so1177722wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 13:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DmWSjQBU9Sq7rzyStZnHWzPWeA2nzkfCL13VjG2sYTI=;
        b=ng2WAp8T6eRP+l3f2c7u7SXbBY4lhVvqzmR9PQIgzh9dPaC5O7HTmdWPmOX3xv9Xuh
         mQYDByb8PDq08OLNj8nIQQiKE1X1xA8S87HXNwqARe+IiMQ2H/k1tiXR0pFWH81VVskq
         J8ZIbB6d1ekfKrvFlzltT8SxfU1xFOWUEh0VU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DmWSjQBU9Sq7rzyStZnHWzPWeA2nzkfCL13VjG2sYTI=;
        b=U9KBrNnNuzvheEZ3ymW0DqHwhnPWb8aSi7pe+Dj26fzeswoUi12sBBVPIYBHK8Va/f
         e2T/du+w76oSkFi2te+xBdSdjCEScYSQ12l0lVLPRDhei0fLTIgZHmp14SjTtu9VYG7S
         lrW2WWN8LgawS2Lie4F7YEMb8ipBfcWsv/wRRVatLfYce2XYUm6rDefxrBweN8/SrtL2
         lo4699nIF87o18j71dfnTOjzou/FRxJlwDALFwRDFgNoFzYtYhkqWqwMfco0DldHWl5U
         B8N2J2L0SXbs8WjVSsJjSJ30YZvll71IXrWb5S2nleey6jX4nfgMGvFJ55RlGmD6EFuk
         1OFw==
X-Gm-Message-State: APt69E3lOWlV9I9XXCmIk4v8Wd3Ga/YbxJ+sD+zURJlt5ngIquGBASLs
        pHaQbqvfKp0l7U85pfsHTyQzu1attSI=
X-Google-Smtp-Source: ADUXVKIimSnkWRb6M3dRpOpGfzVto3kDSD60EIvwwk96BpDABVDwmY0Sjfm0lSMFz0/UbLicVGMRSA==
X-Received: by 2002:a1c:3448:: with SMTP id b69-v6mr1654675wma.0.1528835008079;
        Tue, 12 Jun 2018 13:23:28 -0700 (PDT)
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com. [74.125.82.44])
        by smtp.gmail.com with ESMTPSA id r15-v6sm492073edp.92.2018.06.12.13.23.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 13:23:26 -0700 (PDT)
Received: by mail-wm0-f44.google.com with SMTP id z6-v6so20888567wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 13:23:26 -0700 (PDT)
X-Received: by 2002:a1c:d11:: with SMTP id 17-v6mr1451654wmn.81.1528835006124;
 Tue, 12 Jun 2018 13:23:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:cc45:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 13:23:25
 -0700 (PDT)
In-Reply-To: <20180612202042.107603-1-briannorris@chromium.org>
References: <20180612202042.107603-1-briannorris@chromium.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 12 Jun 2018 13:23:25 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMuohDxvAXdnea8xAZyq6Nn4JThQFGTPPtxTzvf-2dJ0Q@mail.gmail.com>
Message-ID: <CA+ASDXMuohDxvAXdnea8xAZyq6Nn4JThQFGTPPtxTzvf-2dJ0Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] power: supply: sbs-battery: don't assume
 MANUFACTURER_DATA formats
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Rhyland Klein <rklein@nvidia.com>,
        Alexandru Stan <amstan@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Doug Anderson <dianders@chromium.org>,
        Phil Reid <preid@electromag.com.au>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eek, sorry this series should have subjects "[PATCH v5 X/2] ...". I
can resend if really needed, but hopefully by now this is ready to
go...

Brian

On Tue, Jun 12, 2018 at 1:20 PM, Brian Norris <briannorris@chromium.org> wrote:
> This driver was originally submitted for the TI BQ20Z75 battery IC
> (commit a7640bfa10c5 ("power_supply: Add driver for TI BQ20Z75 gas gauge
> IC")) and later renamed to express generic SBS support. While it's
> mostly true that this driver implemented a standard SBS command set, it
> takes liberties with the REG_MANUFACTURER_DATA register. This register
> is specified in the SBS spec, but it doesn't make any mention of what
> its actual contents are.

...

> ---
> v2:
>  * don't stub out POWER_SUPPLY_PROP_PRESENT from sbs_data[]
>  * use if/else instead of switch/case
>
> v3:
>  * pull 'return 0' out of if/else, to satisfy braindead tooling
>
> v4:
>  * make ManufacturerAccess non-optional for TI parts again
>
> v5: no change
> ---
>  drivers/power/supply/sbs-battery.c | 67 ++++++++++++++++++++++++------
>  1 file changed, 54 insertions(+), 13 deletions(-)
