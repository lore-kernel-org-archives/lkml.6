Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C6BC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BFC218A4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549906610;
	bh=Aeh+UPf11LVYagBKRJC7CWnplRl//3ziClYm1RWbcBw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tLv0vKle5oMZ1hQO4S+lex+MvdbzVAfeRenA0CjHgYEuwnyVhi+klESiPGgx2ipkx
	 E8zcWhMvvhUSpBZWFH2AJoNT49IQld0GN7SllCvTR9qvhC5/tdWf8Tkq5KkFSCMSSM
	 VtCpaO6ijfr0suF+txOPKRWJanZxT3tOaS05Oi+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731838AbfBKRgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:36:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:49558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbfBKRgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:36:48 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAF6521B69;
        Mon, 11 Feb 2019 17:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549906608;
        bh=Aeh+UPf11LVYagBKRJC7CWnplRl//3ziClYm1RWbcBw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G4ijns8NrBMill6+v9DL9IxNBt/BJ6dr2FxNpBALw/A+9qVU9nZiBAQbTlALTJkEc
         rLuoI2wEdmQPszwFx7toJsC7s9oS5VrA0WG4HekXCo0XxaY3YuV8ZxO3WdUzDz70VS
         4JNOzs94t6utecYKwc/YaePtIQtWXYlrQvEI4czs=
Received: by mail-qt1-f178.google.com with SMTP id r9so13132684qtt.3;
        Mon, 11 Feb 2019 09:36:47 -0800 (PST)
X-Gm-Message-State: AHQUAuaesw4PL+RKEGazkKRTl1Z2alhpXZC90JYl+p76FNIXBc4nMB7o
        cqdJEsImYK0ajdAdh7VfiUJAFmZjfDIKlsnTXw==
X-Google-Smtp-Source: AHgI3IZzJ32FMkSftK8rEj+8liIKHXe+dqKfrtNDiAcky00dNNIfdMp3/dhx6lv3rnDtnSZIbTk7u/mNag7SkLdYnlM=
X-Received: by 2002:ac8:2f4e:: with SMTP id k14mr13221709qta.76.1549906607054;
 Mon, 11 Feb 2019 09:36:47 -0800 (PST)
MIME-Version: 1.0
References: <20190208140425.12917-1-johan@kernel.org>
In-Reply-To: <20190208140425.12917-1-johan@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 11 Feb 2019 11:36:34 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+rRYazOqtjNms0cTK0HpkxCkmZ4JXoLM7ZaPivATEO8A@mail.gmail.com>
Message-ID: <CAL_Jsq+rRYazOqtjNms0cTK0HpkxCkmZ4JXoLM7ZaPivATEO8A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: regulator: update fixed-regulator example
To:     Johan Hovold <johan@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 8:05 AM Johan Hovold <johan@kernel.org> wrote:
>
> Fixed regulators do not have associated bus addresses and are typically
> placed directly under the root node where their names must still be
> unique despite not having a unit address.
>
> Fix the malformed example node which had a unit address but no "reg"
> property by dropping the unit address.
>
> Also, try to make the example more useful by using the recommended
> generic node name "regulator", but with a suffix reflecting the
> regulator name in order to make it unique.
>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  .../devicetree/bindings/regulator/fixed-regulator.yaml        | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
