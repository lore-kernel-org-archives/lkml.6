Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 43DBAC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED828208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+LOF59M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED828208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935749AbeFMN6K (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 09:58:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934436AbeFMN6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 09:58:09 -0400
Received: from mail-io0-f176.google.com (mail-io0-f176.google.com [209.85.223.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C75DE208B3;
        Wed, 13 Jun 2018 13:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528898288;
        bh=PJ57rxERzs3hoeIPMgQytwpjJ9jXcXSvbyYYzW9j4UU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=t+LOF59MEbCTiiluDJTW27l/XkKaaQHlnRQu8pmgnpHLzomaI5g7bRjhLxvHmiifQ
         jDkgPzu1psCyxcSJBQDGGv5oflR6uW2ru2k68/m3TiTOoEHCPKYpfvd7dxkg6te9we
         XF4VZMSde6cUuQ4TaceoBYbcIJDO/zRceaFSqB7s=
Received: by mail-io0-f176.google.com with SMTP id d185-v6so3542501ioe.0;
        Wed, 13 Jun 2018 06:58:08 -0700 (PDT)
X-Gm-Message-State: APt69E1rIHRnkUd+2Ipn2TjdJd7/u1KpW0A0Z0+zsnDMufX36rBb9FdO
        7oES43Z5b0fySnzYv9xwjWBZRB4bagnwoUtB/A==
X-Google-Smtp-Source: ADUXVKKyhobKjL+TWJ9BX8+3IU3oTyGOLBn0PeY0yGILDSR57thUgdo5pdvS6bOPI5fcNWMnyYGZq3ouANaYHvwbVaE=
X-Received: by 2002:a6b:bd47:: with SMTP id n68-v6mr5075912iof.111.1528898288170;
 Wed, 13 Jun 2018 06:58:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:6403:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 06:57:47
 -0700 (PDT)
In-Reply-To: <c0d531ec-9201-bfd8-e6c3-9140698b0697@arm.com>
References: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
 <1527858967-16047-7-git-send-email-suzuki.poulose@arm.com>
 <20180612204802.GA15817@rob-hp-laptop> <a1c0749b-9c97-b45f-716f-a62ae07af278@arm.com>
 <5448BBB7-93FE-400F-9D87-FABF5DE0539C@arm.com> <c0d531ec-9201-bfd8-e6c3-9140698b0697@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 13 Jun 2018 07:57:47 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL1xWCEYG1knOfUjmw7Y59Sx1ss5o2RyRm-fxoYXbDrJA@mail.gmail.com>
Message-ID: <CAL_JsqL1xWCEYG1knOfUjmw7Y59Sx1ss5o2RyRm-fxoYXbDrJA@mail.gmail.com>
Subject: Re: [RFC PATCH 6/8] dts: coresight: Clean up the device tree graph bindings
To:     Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc:     Matt Sealey <Matt.Sealey@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>,
        John Horley <John.Horley@arm.com>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 7:35 AM, Suzuki K Poulose
<Suzuki.Poulose@arm.com> wrote:
> Hi Matt,
>
> Thanks for your comments, responses inline.
>
> On 13/06/18 13:49, Matt Sealey wrote:
>>
>> Suzuki,
>>
>> Why not use =E2=80=9Cunit=E2=80=9D?
>>
>> I believe we had this discussion years ago about numbering serial ports
>> and sdhci (i.e. how do you know it=E2=80=99s UART0 or UART1 from just th=
e address?
>> Some SoC=E2=80=99s don=E2=80=99t address sequentially *or* in a forward =
direction) - I
>> believe it=E2=80=99s not exactly codified in ePAPR, not am I sure where =
it may be
>> otherwise, but it exists.
>
>
> We have different situation here. We need to know *the port number* as
> understood by the
> hardware, so that we can enable *the specific* port for a given path.
>
>>
>> I agree with Rob on the slave-mode nonsense, this is an SPI controller
>> concept weirdly stuffed into a directed graph which implicitly tells you=
 the
>> data direction - it=E2=80=99s a rooted tree (just like DT!).

OF graph is not directional. All links must be bi-directional and in
fact dtc checks that now. The parent node should know the numbering
and direction of each port.

> Btw, the "slave-mode" is not a standard DT graph binding. It is not part =
of
> the
> generic DT graph binding. In fact the generic bindings stay away from the
> direction
> aspect and explicitly mentions the same.

I really don't like slave-mode nor coresight,hwid.

I would prefer to see getting rid of both and splitting ports into
"in-ports" and "out-ports" nodes instead of a single "ports" node.
Then you don't need any of these properties and reg can be used as the
hwid.

Rob
