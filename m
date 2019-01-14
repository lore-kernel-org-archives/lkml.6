Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789B0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 05:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8BB2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 05:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="kP5Y/vz4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfANFp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 00:45:58 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33026 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfANFp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 00:45:58 -0500
Received: by mail-qk1-f194.google.com with SMTP id d15so9929207qkj.0;
        Sun, 13 Jan 2019 21:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z0fx6AzA/vL6vJhv4Ht1507IbdeUyvVzq1bXlczbybU=;
        b=kP5Y/vz4yfnAr4+HN/qB45Z0gE2CcjSLPvH1nJ37wCRc5AVb8PljFo2jQAhQiaJR9u
         ipWORVZA+s5oPtuVTWiE8BngU7xotmKrgi67JUwCAYVusCxYu3CEZxTpvdynyIe+BVC8
         LYz8+Ol4QO/P2nPzMzY03wPNwC+eurxrIvFmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z0fx6AzA/vL6vJhv4Ht1507IbdeUyvVzq1bXlczbybU=;
        b=rNBazZcgFu7W15RKPCXb6TY+ROywxmVKAnR71ou5VNxGJPm9RC16r1NLSkV9x0qG8T
         tL7tq3NyNhuuHvyKBy1/tqysQWWN4M6fSoWgjHtJ+uvAuAkcZDDMv0cBtA0NwKBec4H6
         TV0GdoMVeX0KzIPUF22Gy6QO2VPu9+hImAnHZ0kBdY5R14teW74UAwrHP/U/zcj+F8q7
         baVfy3dnvlmqmlTcKhY15ykSp/AQ2IIdKditXuHxa0If/YmW1kncKIrhSkaxYoelqjUl
         WA3eTlO474UtXaOL88NhE7yqHV48fitm87+LNoA1eg5zdLtXAmyaw2cGpltjCHhg3wNO
         X/Mg==
X-Gm-Message-State: AJcUuke6cLsd742i7fU8DEv30gHaTc74bBbRI42hWDtGrTQUpsVmzgfn
        GWLuereW42wPoK7upeEOC370IkVBVfl+YK6ewrY=
X-Google-Smtp-Source: ALg8bN5oYxyzSdOHSx7TVvTVsh7kSgUdtRG+bpH0CrYAuYJQ55xWvso9NjO1x4axv655lvvcwTQtncFvjUAcrt2HVIk=
X-Received: by 2002:a37:bc06:: with SMTP id m6mr22053004qkf.336.1547444757427;
 Sun, 13 Jan 2019 21:45:57 -0800 (PST)
MIME-Version: 1.0
References: <20190107214136.5256-1-jae.hyun.yoo@linux.intel.com> <20190107214136.5256-6-jae.hyun.yoo@linux.intel.com>
In-Reply-To: <20190107214136.5256-6-jae.hyun.yoo@linux.intel.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 14 Jan 2019 16:15:46 +1030
Message-ID: <CACPK8Xf-54Q7s_z8J=ZBoYqiFuy7_QAvsDqgT2CO0LFOvx8tqg@mail.gmail.com>
Subject: Re: [PATCH v10 05/12] ARM: dts: aspeed: peci: Add PECI node
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        Haiyue Wang <haiyue.wang@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jae,

On Tue, 8 Jan 2019 at 08:11, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>
> This commit adds PECI bus/adapter node of AST24xx/AST25xx into
> aspeed-g4 and aspeed-g5.

This looks good, aside from the alias.

It will go via my aspeed tree once the bindings are merged. Send them
to linux-aspeed@lists.ozlabs.org at that time.

In the future I suggest leaving the changes to arch/arm/boot/dts until
after the bindings and driver patches have landed. They will rarely go
in before hand as the bindings need to be agreed on.


>                 serial3 = &uart4;
>                 serial4 = &uart5;
>                 serial5 = &vuart;
> +               peci0 = &peci0;

I don't think this is necessary. Can you explain why you think you need it?

Cheers,

Joel
