Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3F978C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85F8208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W21F6JoG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E85F8208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755296AbeFNN74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:59:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754927AbeFNN7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:59:55 -0400
Received: from mail-it0-f49.google.com (mail-it0-f49.google.com [209.85.214.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94711208DB;
        Thu, 14 Jun 2018 13:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528984794;
        bh=5HaCoyv1C5J4BLHikyGnwvqZt54e6BV1nnL/SzwQg8E=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=W21F6JoGPZqJyQqzXhCb8sTeglibOOj7MiMJ7SefBLp48gn0iJH2CYaiIViD73fp5
         q+PF78F9P3kwjDMZBXCZTp5zYUQJX4e3VSSina2nBodxCfhTh58WZHPBYWX/uaJhtE
         YPxQOalhB/h7omyHRjgKipPrdv4/iQ/M3OUdEotM=
Received: by mail-it0-f49.google.com with SMTP id v83-v6so8822804itc.3;
        Thu, 14 Jun 2018 06:59:54 -0700 (PDT)
X-Gm-Message-State: APt69E3jBS7ufeNjy5M52yQ4NsCvSxO64FevtYSahBJYE3NENJzsmV50
        2drB2UnwL8kJ7MGYdHooqhRhuiFgmAUXonStMA==
X-Google-Smtp-Source: ADUXVKKOQmov6AmoSHfzqDGMwYpWXOFFRXnGSyk/z+J/lbOzkBa6V77jw/372S0CjE6D10loM5a6VFh2N+xLFi/nN/0=
X-Received: by 2002:a02:6902:: with SMTP id e2-v6mr1286557jac.46.1528984794013;
 Thu, 14 Jun 2018 06:59:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:6403:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 06:59:33
 -0700 (PDT)
In-Reply-To: <5e013d65-9931-6b8d-ce7c-4333309d4ada@arm.com>
References: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
 <1527858967-16047-7-git-send-email-suzuki.poulose@arm.com>
 <20180612204802.GA15817@rob-hp-laptop> <a1c0749b-9c97-b45f-716f-a62ae07af278@arm.com>
 <5448BBB7-93FE-400F-9D87-FABF5DE0539C@arm.com> <c0d531ec-9201-bfd8-e6c3-9140698b0697@arm.com>
 <HE1PR0802MB24127EC935B9AF6F82AB3B6EEE7E0@HE1PR0802MB2412.eurprd08.prod.outlook.com>
 <075b99a1-2a29-f6dc-e9f2-99f895c27d35@arm.com> <CANLsYkx9cjV-bWg7aLg-kJT7x7DtwTHdsYzzM8A3+cFFnu_mNg@mail.gmail.com>
 <HE1PR0802MB24121F0EEF8D7D643BC391A1EE7E0@HE1PR0802MB2412.eurprd08.prod.outlook.com>
 <5e013d65-9931-6b8d-ce7c-4333309d4ada@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 14 Jun 2018 07:59:33 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+0kExVY33kdDoR6bAxbr2VzRUzW2j0k+2wmv4CSNVnpQ@mail.gmail.com>
Message-ID: <CAL_Jsq+0kExVY33kdDoR6bAxbr2VzRUzW2j0k+2wmv4CSNVnpQ@mail.gmail.com>
Subject: Re: [RFC PATCH 6/8] dts: coresight: Clean up the device tree graph bindings
To:     Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc:     Matt Sealey <Matt.Sealey@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 2:53 AM, Suzuki K Poulose
<Suzuki.Poulose@arm.com> wrote:
> On 13/06/18 22:07, Matt Sealey wrote:
>>
>>
>>
>>> -----Original Message-----
>>> From: Mathieu Poirier <mathieu.poirier@linaro.org>
>>>
>>>> So, if the suggestion is to use an existing property "unit", I am fine
>>>> with it, if people agree to it.
>>>
>>>
>>> If we're going to have something sharply different than ACPI I prefer
>>> Rob's idea.
>
>
> No, the above comment is about using "unit" ( if it is a standard property
> for specifying something specific to hardware) instead of "coresight,hwid".
> I would prefer to stick to the DT graph bindings, because :

"unit" is not a standard property and I don't like it either.

>
> 1) The connections are bi-directional => Well, not necessarily
> bi-directional
> in terms of the data flow. But the connection information is critical. i.e,
> we need information about both the end-points of a connection, which the DT
> graph bindings solves.
>
> All we are missing is a way for specifying the "hardware port" number and
> the
> direction of flow. I don't see why do we need to create something new just
> for
> these two properties for something that exists today and works reasonably
> well
> for the usecase.

If you have "in-ports" and "out-ports" nodes, then that gives you
direction and you can use reg for the "hardware port".

in-ports {
  port@0 {
    reg = <0>;
    endpoint {...};
  };
  port@1 {
    reg = <1>;
    endpoint {...};
  };
};
out-ports {
  port@0 {
    reg = <0>;
    endpoint {...};
  };
};

I'll need to check, but dtc may need an update to not warn about this.

>
>>
>> What are you trying to say about being sharply different than ACPI?
>
>
> The proposed Coresight ACPI draft bindings are based on the ACPI Graph
> bindings
> (just like the DT graph bindings and is compatible with it, in terms of the
> APIs.
> i.e, fwnode_graph_* operations work for both ACPI and DT  alike).
>
> So, what Mathieu, in turn means is, if we depart from the DT Graph bindings,
> which
> I personally don't see any benefit in.

If DT bindings can be reused for ACPI, that's fine, but don't expect
any DT bindings to be accepted simply because they match ACPI
bindings.

Rob
