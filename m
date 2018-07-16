Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29554ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5F120856
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+wwP1Xa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5F120856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbeGPPYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 11:24:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:43086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727374AbeGPPYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 11:24:19 -0400
Received: from mail-yw0-f171.google.com (mail-yw0-f171.google.com [209.85.161.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80A1520856;
        Mon, 16 Jul 2018 14:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531752991;
        bh=LoHWfp9s1C/PTb0A/j9h9YSYJTTuibJJkPBduH+Nit0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=B+wwP1Xax95wNrrmvbn342STq7DsaJiFJI0xwnsaxzCVJ19mprQoEwjukFc6boBKW
         M74La0g0aGf7DH3FLtnzBr8pERO7DmsftFtqe1ukrMCj9YhReuUVzpSdfTbK9hh01N
         a2LxB0DzsGgS0m4CPtsG5TkGRhCOyd4lJTNfb2Xo=
Received: by mail-yw0-f171.google.com with SMTP id t18-v6so14280681ywg.2;
        Mon, 16 Jul 2018 07:56:31 -0700 (PDT)
X-Gm-Message-State: AOUpUlEHEzgIlzShzJXk2ICSDrprAsGOaLhDArC1va8UCirOHhSe9UJJ
        9QrlnjOvD92neBR7WUqzxGhoKUtN9r6OtvAP8+k=
X-Google-Smtp-Source: AAOMgpfhSBlu6E68FPZk4vegCXF72Ib4QGjyJaR20iX/Sa81sgaHFhBeQo13L1fLCHvAFOJxLKaT9T6Cn4z2C7+h4xE=
X-Received: by 2002:a81:8047:: with SMTP id q68-v6mr8262666ywf.196.1531752990778;
 Mon, 16 Jul 2018 07:56:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:8182:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 07:55:50
 -0700 (PDT)
In-Reply-To: <20180715120130.GA20467@kroah.com>
References: <1530320016-24712-1-git-send-email-hao.wu@intel.com>
 <CANk1AXQ0crNX2u_=XLEakhhfO8dcTED0OO6fHU10uAx0yOJewg@mail.gmail.com> <20180715120130.GA20467@kroah.com>
From:   Alan Tull <atull@kernel.org>
Date:   Mon, 16 Jul 2018 09:55:50 -0500
X-Gmail-Original-Message-ID: <CANk1AXSBY+vwFCNPjXGAzjx_0rGzYmFnOVkx_6maPetuXAqmXQ@mail.gmail.com>
Message-ID: <CANk1AXSBY+vwFCNPjXGAzjx_0rGzYmFnOVkx_6maPetuXAqmXQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/29] FPGA Device Feature List (DFL) Device Drivers
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 7:01 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, Jul 09, 2018 at 11:34:20AM -0500, Alan Tull wrote:
>> On Fri, Jun 29, 2018 at 7:53 PM, Wu Hao <hao.wu@intel.com> wrote:
>> > Hi All,
>> >
>> > Here is v7 patch-series adding drivers for FPGA DFL devices.
>>
>> Hi Greg,
>>
>> Could you please take this v7 patchset for 4.19?
>
> All now queued up, thanks.
>
> greg k-h

Thanks!

Alan
