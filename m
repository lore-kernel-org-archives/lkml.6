Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902C7C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585EF2087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 585EF2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbeH1WlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 18:41:11 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:34794 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeH1WlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 18:41:11 -0400
Received: by mail-it0-f68.google.com with SMTP id x79-v6so2925367ita.1;
        Tue, 28 Aug 2018 11:48:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JL6NS+C9/Fo0KKPb6JpN2JmqMSrKY2AHY2hL1gu+Mt8=;
        b=rSMAxUV6aT25H7vlEY4dRf0DR8//GgVP7pI4o1HqcR+exViv+zr2xG7kyyMSKcxv5e
         VYz2IsfVdMpkVaCTako2PS8yt7fQ8CVu0ATwXLOzKAkskO8MW2Ntdq7uGRwxwZG2KvUp
         Nmbf4LA7rYjseQ3Rx0Df735ha6U+LpOUJvUVtcVZ/qMyCjgldt1hr81fUnftEFuzdRRt
         PNlHpVUT03aRmgkxN5+h+CTwNs2klYhYnB2vvWcili09DJbHQMR8/F0MOfGfrTB9QX7v
         bQlrJq44HhfdoXd6Ox/5/mjEyniYMNLnh/Jvtg2nnVmyQbPIFfIJDjM9xhtVMEHRis4K
         IzvA==
X-Gm-Message-State: APzg51Bg7VfLDUFQM7CaY48KW9ZSyZt0Tds3oqOkRHkGQ924zih3NCb/
        m/Uag0XVOnB4Z/coki0OWtKZzA7m1jc=
X-Google-Smtp-Source: ANB0VdbovSox7tYFPX3nVwG1leQzgO+tfeO1ilfcAFekC9goNgB2qpcxdr6bRWo4CmHhU/8T1wLLMQ==
X-Received: by 2002:a24:f68c:: with SMTP id u134-v6mr2760481ith.17.1535482093779;
        Tue, 28 Aug 2018 11:48:13 -0700 (PDT)
Received: from mail-io0-f181.google.com (mail-io0-f181.google.com. [209.85.223.181])
        by smtp.gmail.com with ESMTPSA id z26-v6sm781263ioc.41.2018.08.28.11.48.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 11:48:13 -0700 (PDT)
Received: by mail-io0-f181.google.com with SMTP id y12-v6so2326332ioj.13;
        Tue, 28 Aug 2018 11:48:12 -0700 (PDT)
X-Received: by 2002:a5e:8408:: with SMTP id h8-v6mr2511057ioj.171.1535482092554;
 Tue, 28 Aug 2018 11:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-43-robh@kernel.org>
In-Reply-To: <20180828015252.28511-43-robh@kernel.org>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 28 Aug 2018 13:48:01 -0500
X-Gmail-Original-Message-ID: <CADRPPNRvRKEuV=ZzH6yq6_7COvFSWy2ibAKoEt4YrzES2m9x2Q@mail.gmail.com>
Message-ID: <CADRPPNRvRKEuV=ZzH6yq6_7COvFSWy2ibAKoEt4YrzES2m9x2Q@mail.gmail.com>
Subject: Re: [PATCH] soc: Convert to using %pOFn instead of device_node.name
To:     Rob Herring <robh@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Zhao Qiang <qiang.zhao@nxp.com>, andy.gross@linaro.org,
        david.brown@linaro.org, Heiko Stuebner <heiko@sntech.de>,
        thierry.reding@gmail.com, Jon Hunter <jonathanh@nvidia.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, linux-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 8:57 PM Rob Herring <robh@kernel.org> wrote:
>
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.

Please forgive my ignorance, but what is this format specifier do
exactly?   I cannot find anything listed in the printf specification
matching this.  Is this something newly introduced?

Leo
