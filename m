Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E35C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F1320827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PhUsYLfa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F1320827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbeKIT0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:26:05 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37208 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbeKIT0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:26:05 -0500
Received: by mail-lf1-f66.google.com with SMTP id p17so870453lfh.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 01:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jMz56d4G5hIsOXccuG/Z+HtTjg1/tWvEQ4RM3n68Piw=;
        b=PhUsYLfauchoNSG7M++2EkbsKyB2hynOMTgX1DYYMk8gW+M+/A1vRBaJ8KlqhM4uYC
         p745zMkBuov8MEScIUq4Gm+x+qszwi+R2lZVegNVGHOIy14C3+6UCaWjjbWDcyCiDKHI
         fUYmSSNP9AHdbCH+2r6Dhb/2MFdXhqgljltrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jMz56d4G5hIsOXccuG/Z+HtTjg1/tWvEQ4RM3n68Piw=;
        b=CNRPKsjv1sPNnwLmKKLPYhIvEyRV3Oz6ZRALlJaYYQu3pmlX+QCCcW7Ouv0SHRpZZQ
         zFpjJJBBQkWOtoJPXEarezngh1h2CL0Zc/knDp7qVN6QDHSgMYIFfA6sBLE30eOzGy42
         OY9sJC4SwQ/geg/tBuIRvpWt7TLzDNgJiZdOTqtYQOnZ6e8UR+XTfhAEB91xKKPkK8x9
         W67BmyaAslstCYdFBqKU+9R7tHi89005WhBPY29p9GJzERK6I2JURGrw+hDtz63ozmVv
         iXkZuvE05KKZhyrJqrptV3fwNRtS/xOSsPLPEn7mgtX6eRN/lPREjj5QBCtrNwoCbCnf
         M8/g==
X-Gm-Message-State: AGRZ1gLdeNkrnfvh2V2grA+RN9V+EyTN9c9tpaECc/p1GVBL5/V8cFmp
        BBMC0a3BY1RQVmBcNYv/cAwHzXtPrQMQWaM4p62xXQ==
X-Google-Smtp-Source: AJdET5cNFPc4zrfEXyrWpQgyvoYHX8Y+2cOSuseL9M9iIomq2/vsruXlHGjX31fVwzqfzSZ8cZtP225F3raO0PRgBM0=
X-Received: by 2002:a19:5154:: with SMTP id f81mr5064978lfb.96.1541756777080;
 Fri, 09 Nov 2018 01:46:17 -0800 (PST)
MIME-Version: 1.0
References: <20181101154427.23110-1-tiny.windzz@gmail.com>
In-Reply-To: <20181101154427.23110-1-tiny.windzz@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Nov 2018 10:46:05 +0100
Message-ID: <CACRpkdZ4gDfK9TtAiiExo-PyYi8qcpPCf5_KHMV_dnoJ05ychw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mt7622: fix small typo
To:     tiny.windzz@gmail.com
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 4:44 PM Yangtao Li <tiny.windzz@gmail.com> wrote:

> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

This patch does not apply to v4.20-rc1, please check and
rebase of not already fixed, and resend.

Yours,
Linus Walleij
