Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6D0C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1570320869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PQIEfptf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1570320869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbeJPQ0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 12:26:36 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44792 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbeJPQ0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 12:26:36 -0400
Received: by mail-qk1-f194.google.com with SMTP id y8-v6so13569311qka.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 01:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ubyjo42R+HubJmEREUzTpsPrkU4zre0fUGpTagWB4sw=;
        b=PQIEfptf8M46zzD1bks1h1Pae9z2YUj3wesKEzX92MvbHjVJLAzBgRfC6/UF3RjE6Y
         PnL68nd47I5xNrAAYdhbaCqIojkfzZ6u6J4QOypxKegVzZXqAI3T8XnBIut3DZ+goXuk
         aARPKOpESn2XkGDjEBqttp+74wGRm/5WJ8DM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ubyjo42R+HubJmEREUzTpsPrkU4zre0fUGpTagWB4sw=;
        b=fgtVjYj9FzRYqJMGHLN5eITXWVvFuJjzxwbLMMVXR3bSXXGN4c7KmP+pha/Bx56Qh1
         bncOPjU5w5KmuB5rJLzmFOc0CQdvTs8dQSLRfpmBeX1Y2C824+nMBq3pn5XlcXH7298K
         Au+t96/l4/BBgzuhGo8vVXGrit2EJyCrYZ9HFi0Gt1jIwkRJc/EPwxOt5GEsSM2ov0xo
         7+ncS+vuu0Ay54VXC7kPbLCdC1CKdYBMK25gOW6EcQ6nqJ2b1JmGkgkucmvrlotQvLWd
         JkAUezdgpIN9GLkPqghBU/6Yfe61dG731RDSzkxJ30nSkRpl+bpmOM3NLH9zofgtHlyG
         HuNA==
X-Gm-Message-State: ABuFfoiDTAk6umNKeHphVHkafy4ckZA9mTq7kyuWpOf1qA/qlUjHaWtM
        31cxOeCqMRGdALf1Hm9iQLuLtD/XMKHUEzXu8M4kaA==
X-Google-Smtp-Source: ACcGV60PoKpJDS0snC52a5O60Ho2xfTletRBeD16hhV4IxNT6VGudEmxVJ9J6PgPstugAJd7pLQnl3xpoo3/kxp5O/o=
X-Received: by 2002:a37:7282:: with SMTP id n124-v6mr20009923qkc.78.1539679028406;
 Tue, 16 Oct 2018 01:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <20181008191411.32555-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20181008191411.32555-1-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 Oct 2018 10:36:56 +0200
Message-ID: <CACRpkdbOpfDMGhUFAwXUX=-fhGNfhvQq6NgtFtAoTsu8Vo+BQg@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add initial pinctrl support for MT6797 SoC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 9:14 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> This patchset adds initial pinctrl support for Mediatek MT6797 SoC.
> The pinctrl driver is based on the vendor binding as like MT6765 and
> implements only GPIO and pinmux functionalities.
>
> The devicetree binding doc is not added because it does not exist for
> MT6765 and I'm not sure about the structure of it.
>
> This patchset has been tested on 96Boards MediatekX20 development board.

I'd be delighted to merge the pin control bindings and driver
as soon as I have an OK from Sean Wang.

Yours,
Linus Walleij
