Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904C3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBF820836
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyzkOV3X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387779AbfAKQRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 11:17:09 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37445 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbfAKQRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 11:17:08 -0500
Received: by mail-oi1-f196.google.com with SMTP id y23so12626283oia.4;
        Fri, 11 Jan 2019 08:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bWNIUmVkQq9RqCOAhq6V7vBzdtgOZN3aim6OqBC9ISw=;
        b=qyzkOV3XpP2QSnQcYovZSZ/p9yP6u1dFCjziL1iPRXVsZ9NHVu0rg2qAjMvxc8WIqb
         X30fz4ESX+mqReTDbBiMlumG0bO5yFMLMSazEayxK4CcsZwUbo2ehSDRuKNoOQUwbE0U
         Dl0g9plrBaDDJ29E0NGBgqZZLupZw3HUuKZFe+xIral4slgQjf0LhUIWQBrEdrTUQY4x
         Iiw8AA999b1WFHBpzJR8SDRkMjU4YNh0Ay13KyiRWOQlIxr2OiSDkiIEmVYZus2qRrpl
         nZsHHq4gagublhLh5X1unExoZJUwrzrm9t403SGP8dnFInxZB2no+gDQPhIqI+ycBgJw
         ZYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bWNIUmVkQq9RqCOAhq6V7vBzdtgOZN3aim6OqBC9ISw=;
        b=Lvf3y2rqDdiRLp2bQT8Tvq8+LRgY36VzYjNznV4DvKY3+Oc5xEzv3b+tWbmmSkN2a9
         imhW8ldzraYhvzj7k5KKuMNLNPamhok811dDxEyyDu2Zl44wc9K8K18IVxaAmRwroZTr
         w3kmQZ+IWl1Q4X8US6kJSNwxzzTTEXV1B+m0m/VeRw0EAYVBoFoGqhEEgvr2zvKV2nEM
         0TXG5+9rwg8LH9ftbwLWB8ryk2+E2bYpYJZJyzwc4ObQMMcamfQFLF7lKqaQOwdTzUqb
         I/c1Q1IcxfqJvpF6brdUG2V0ZKH7duxjxayiifxg5NqQdCXuPY7IQ7+4GGozOd3/7ja0
         6MJQ==
X-Gm-Message-State: AJcUukdVncB7pBkV23c57+JsZySiDGwIPJ6sHvixorFZHPtH3CtWREr4
        6LF/4UIwCJiFXyB377/9gNApODzgg/C7Eschvo0=
X-Google-Smtp-Source: ALg8bN7yzKlmiVp0aUaPqAYAlcqGrt+sXHqjwCj/dwiD7FfIOJFw5yrBwyDp24QeSfHEB8dykoZaNONHyhR/qx8kRMM=
X-Received: by 2002:aca:5b88:: with SMTP id p130mr9138692oib.96.1547223428215;
 Fri, 11 Jan 2019 08:17:08 -0800 (PST)
MIME-Version: 1.0
References: <20190111092235.28161-1-linux.amoon@gmail.com> <772bd70c-2cd9-a1be-d18f-7824a9ea0556@baylibre.com>
In-Reply-To: <772bd70c-2cd9-a1be-d18f-7824a9ea0556@baylibre.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Fri, 11 Jan 2019 21:46:56 +0530
Message-ID: <CANAwSgTX4Rs7xXzjpNi-zizRyyO0FiFF0baOuQZ0fx9WEM9NCA@mail.gmail.com>
Subject: Re: [PATCH] ARM64: dts: meson-gxbb-odroidc2: Fix usb phy regulator warning
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Fri, 11 Jan 2019 at 19:10, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi Anand,
>
> On 11/01/2019 10:22, Anand Moon wrote:
> > Add missing vin-supply 5V regulator node on usb_phy nodes needed
> > to power usb bus ports. Override the dr_mode from "host" to "peripheral"
> > for initialization of dwc2 usb0 phy node,changes fix the below
> > warning for usb initialization.
>
> I would have switch the dr_mode to peripheral in another patch,
> fix the regulator issue in this patch only.
>
> Neil
>
[snip]

Ok will split this into two patches and send after next dts updates.

Best Regards
-Anand
