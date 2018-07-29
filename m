Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B72C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF57320881
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J0jODnO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF57320881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbeG2W5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:57:42 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33545 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbeG2W5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:57:42 -0400
Received: by mail-io0-f194.google.com with SMTP id z20-v6so8278782iol.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 14:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+bDfOeIoWn2xiMhXJCWZLdTeeSciR4nbv3LPsboJCd8=;
        b=J0jODnO8pfFWDja9sKRyuEwYb8vjuxqI8QfN1ao2gzqxWDSdgWprRC44IDkg18rUtj
         UY7wxusfTzqQ90K3RO/1EiLeDiNG7++mW7jXeSb2FHSun24Z2KmK21pD0L0tn5GnTK13
         q5a2Ezymp1p2HLvjOAC3OunvrtCjEpEUiZUsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+bDfOeIoWn2xiMhXJCWZLdTeeSciR4nbv3LPsboJCd8=;
        b=pL/wolD66Uyq1bRg9hkucSVzu8+kZVzo3clr0czX6Y1YAc9SgczuD6+oJpUeFDKDTU
         6sIgCYBvQYtXg4wesMFsbuVhMsh1wC4V8fDZGr1av7rier81Fy5nqTKPUoaj5jj38gbe
         dIdM0CtTLteKKejVdZMKfl5eJ6xKS94w95J+k7NMuDrpTGjmlbG8TXLq7h3tubo5sZAS
         DxxUsMDvAOImGowvHQmNdtkV2MQ8wIgwPEiL0ms+LTTcmLGyh6ynID/O01HeAzljwNcj
         6IFejf8LyrtbmsriaS0sCAEBd4nhBaIlVEY+/zK3pKM1y7jbf16ngjTR9bZyatP1qOtq
         GgTQ==
X-Gm-Message-State: AOUpUlGJnb/7EgnQfjhv7txd2af4efxh4nGwyQt/a42Zctyj7hwJQVVs
        8OwfHiFe5qNydd0NQeU3J8qfefrp7ERxgpudBvx96A==
X-Google-Smtp-Source: AAOMgpf/re6I0W/wdg975Yr5g4QqOazQIKpgGugOf7lqoVTHNMF9/DidzmkCEBOzT0aHn1r2ozweOy17148aFH9B6+o=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr11531904iof.304.1532899548216;
 Sun, 29 Jul 2018 14:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180725122621.31713-1-quentin.schulz@bootlin.com>
In-Reply-To: <20180725122621.31713-1-quentin.schulz@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 29 Jul 2018 23:25:20 +0200
Message-ID: <CACRpkdbNAvoEagYwW0K7rQtnq6tsWnheiLuHQMhcUUBEs4FMrA@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: mscc: ocelot: add interrupt controller
 properties to GPIO controller
To:     quentin.schulz@bootlin.com
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>, paul.burton@mips.com,
        James Hogan <jhogan@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 2:27 PM Quentin Schulz
<quentin.schulz@bootlin.com> wrote:

> The GPIO controller also serves as an interrupt controller for events
> on the GPIO it handles.
>
> An interrupt occurs whenever a GPIO line has changed.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
