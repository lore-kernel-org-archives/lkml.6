Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D05CECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB9392133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GKnjkVNV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9392133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbeISBXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 21:23:07 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55207 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbeISBXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 21:23:06 -0400
Received: by mail-it0-f68.google.com with SMTP id f14-v6so5034746ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 12:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jyDjJSbx/OA6FhmZuu/pyGA7xOGtD18uNabNeKmTz7Q=;
        b=GKnjkVNVmjS38eclWRR5n37W92/dBym1E6q/750QRI9beWC+gWOWPKqRMSC97lO8yB
         rYZq+GThvhE6SmbgIUA0YjczeHjKK5Kt+DTpyOIiIEYYdSPZwTUQgp2JvYTmsurfBM8g
         oKZC1tClbWjc/SGgcjGDOu5WwIAU99hxA/PAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jyDjJSbx/OA6FhmZuu/pyGA7xOGtD18uNabNeKmTz7Q=;
        b=iUdN3eETtq8FauLUX7YWrjJ7w08hFhOHNN7Vds+3lmZsTKyqlrHh9GZikb5tZFcHl6
         Y5uRQvUN6YkXvPhlTtkv3LjtShlaQF9pZwT5CN60S4fKMFa1Ft6LiT6fqFsIdIiUwPMw
         9YOEQ0+fNHxkrCcCMaBd6DCMDAzoYe1BL0WNHP8jLp/lDSSgFGGmi0KWspais6p2d9/K
         iBGLUexBcM6I9jeFse4OuNR8oSrUsZdYvxhO2ehoFyf3DDK2ZHLIzcohJVd3txnkMdY8
         AGToohnHKJA2tTLhRO5CO9a9Sa7HR67VsdIK59hhJA6IK87k+3kf2H3z4uZ4GDv20e1u
         UdAQ==
X-Gm-Message-State: APzg51DKaeq13SKFf2xBCMSfc3BSqDetvjps+pzbraqh1+u7o300w9xn
        PlGjGVp5pCeq0ThfsNEnHsEbv7J4wgsUUeMM5o7nwg==
X-Google-Smtp-Source: ANB0VdbBQQJs1w9ni6jqUVPvgy07FTUK1wOOB5zbtOgwb7aeEJ4EPLaZVVi392qBJ7sOiYh9+LTHS6iBRuHAY0JJKiM=
X-Received: by 2002:a24:9d84:: with SMTP id f126-v6mr18593562itd.130.1537300140052;
 Tue, 18 Sep 2018 12:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536404280.git.sean.wang@mediatek.com> <f5324a24d1a70c37a5e011f859ce90867e9ad3fb.1536404280.git.sean.wang@mediatek.com>
In-Reply-To: <f5324a24d1a70c37a5e011f859ce90867e9ad3fb.1536404280.git.sean.wang@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Sep 2018 12:48:47 -0700
Message-ID: <CACRpkdYOPkmbYV994yobY0V9JkqKm+1AyXyK24x2Siy=_L4RTw@mail.gmail.com>
Subject: Re: [PATCH v2 08/22] pinctrl: mediatek: add pull related support to pinctrl-mtk-common-v2.c
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 8, 2018 at 4:07 AM <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> Put pull control support related functions to pinctrl-mtk-common-v2.c
> as these operations might be different by chips and allow different
> type of driver to reuse them.
>
> Signed-off-by: Ryder.Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
