Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355AFC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C4F20869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C4F20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbeJPL5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 07:57:32 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40470 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeJPL5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 07:57:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id r1-v6so19906439edd.7;
        Mon, 15 Oct 2018 21:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EGxl35StO1h0y+es6r540zNgDaNfnY36lD10FnQ14U0=;
        b=g/yzPcR8GAXlRgD/2b+OyWTxfmaCLYZlAkIUmcx3aqz2S7y3g88qn8TRkKGhBIEMj9
         KII9MMXlxprmjlttQm067y8YbRUB7shbv6gi5mURU72Y89duZoIZ6ERKozcc99CZlGmL
         sVa06fCMLRZmAYi0As2pFis2gjdM7zwals94CQBsc5x3siDh+AP+ToMqm28LQHLdzwTF
         r6EMTx33Q0TYK3od8NDadbcxk+ipFs0llv7+Ld+PBO01robbphdjT/VMbk0ExM+M62OC
         kRRT4Y3KKCaZG8e7p2CQHmNM5zT83xnw6HXjjfWytlEPvVLUdIF43Rc6FkB+nmIVFsrV
         PKWA==
X-Gm-Message-State: ABuFfoiusJzkvh377DsPlDJPUCpEBXxZJTHZdqKTEtHqDFHwLOaAbpsp
        V0W8hR3lPlkGlMGSLAjJs3+VdyK7bDs=
X-Google-Smtp-Source: ACcGV63nQ/Jrx9v3nuqZxf918+G89kR3sTGE9MdOa5tXR5cdafwcdTkuOkSTFxeucapL8N1QdIthjg==
X-Received: by 2002:a17:906:b857:: with SMTP id ga23-v6mr21970205ejb.222.1539662949590;
        Mon, 15 Oct 2018 21:09:09 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id g48-v6sm4983448edc.93.2018.10.15.21.09.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 21:09:08 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id e4-v6so23706625wrs.0;
        Mon, 15 Oct 2018 21:09:08 -0700 (PDT)
X-Received: by 2002:a5d:5649:: with SMTP id j9-v6mr15819630wrw.41.1539662947977;
 Mon, 15 Oct 2018 21:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <20181013080848.29894-1-oskari@lemmela.net> <20181013080848.29894-2-oskari@lemmela.net>
In-Reply-To: <20181013080848.29894-2-oskari@lemmela.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 16 Oct 2018 12:08:55 +0800
X-Gmail-Original-Message-ID: <CAGb2v64JbDOobhcaVsAgL5xQ_oZpkOK-t6ngDwMoYPPE=o3k1g@mail.gmail.com>
Message-ID: <CAGb2v64JbDOobhcaVsAgL5xQ_oZpkOK-t6ngDwMoYPPE=o3k1g@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] dt-bindings: power: supply: axp20x: add AXP813 AC
 power DT binding
To:     oskari@lemmela.net
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 4:09 PM Oskari Lemmela <oskari@lemmela.net> wrote:
>
> The AXP803/AXP813 AC power supply can limit input current and voltage.
>
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
