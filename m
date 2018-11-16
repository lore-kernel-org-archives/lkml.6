Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E70C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F7F2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TXZVvdY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F7F2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbeKQI1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 03:27:15 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41902 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKQI1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 03:27:15 -0500
Received: by mail-lf1-f65.google.com with SMTP id c16so17550555lfj.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 14:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ER7Q/ICr6bvtN+/2y2BJD4kd/upPnZviF5egk0fDVRY=;
        b=TXZVvdY587s8Lge6es5R/hRfFKupHOuZFA9IvmWJI7zqY5S81td3mwF/CFcQIeT0JS
         Uigxb+aWZ0o+anzM4Bd16KuqgJYolEKlOVZ7wPQywkx30Plz1rHMNjLvKBVyqf2BXywz
         gf5TuFeS1lBPMuGxegPvrZJW7uMFCsp8Cbucc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ER7Q/ICr6bvtN+/2y2BJD4kd/upPnZviF5egk0fDVRY=;
        b=sU+eHTWtIk3KcI3UfisKTVdqbo2beCKDvg0fQrjHcepeMS9aWQgPlmTGU+Ct3kid0b
         NXWNc+aYRueFGRJiHFeKdd0qr2ZvRPorMbp1cwhrRJh+P/53su/qZuIjdflAM+fSlDMR
         3dxSjTxGU6SO4BrpV2bpLLDGqBSm74HLGv71vGUbuN6/VFRy0zqPz6pAIPii8ZPsBhUr
         B505TNow0QvpK5tO8fJQEmoknkl4E2lboVHuhhL6oIJNEhYbsuQqY+SsTRMcSMPyRWoc
         Ju06ecK0jscrDVmyVL+AQtGoaIfl1uoLlfUC4aD5p3QEB5NZfQei/T7V1lIC+PgjsgfQ
         dWlA==
X-Gm-Message-State: AGRZ1gLsh7W6Zl1sciPCMprZFnAjc07/tQ6Cloz8Cz/uB/Rq09ZKssW+
        1dP8Q4yzTn0vUnB6CbERH70wHrpjxbd1L5Sq2CKnkA==
X-Google-Smtp-Source: AJdET5eci0QcEOHx//QMPLnKCryRPP4LmfutZhJVkvfPJKVB31dgl7ndWoUD8jdX6qpqQnAx7XoD64DgyX1Dfz8UtW8=
X-Received: by 2002:a19:4849:: with SMTP id v70mr4419603lfa.62.1542406383403;
 Fri, 16 Nov 2018 14:13:03 -0800 (PST)
MIME-Version: 1.0
References: <1541866511-7856-1-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1541866511-7856-1-git-send-email-stefan.wahren@i2se.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Nov 2018 23:12:51 +0100
Message-ID: <CACRpkdaXekcvO4ANtgn9iFLvgrxnY=KvcPzK9r-srWZZwhGVDA@mail.gmail.com>
Subject: Re: [PATCH 12/17] pinctrl: bcm2835: Switch to SPDX identifier
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        simon@arlott.org, Stephen Warren <swarren@wwwdotorg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 5:16 PM Stefan Wahren <stefan.wahren@i2se.com> wrote:

> Adopt the SPDX license identifier headers to ease license compliance
> management.
>
> Cc: Simon Arlott <simon@arlott.org>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Patch applied with Eric's review tag.

Yours,
Linus Walleij
