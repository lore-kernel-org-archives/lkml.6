Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7505BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A84208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjXBo6e7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A84208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389631AbeHAQge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 12:36:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389498AbeHAQgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 12:36:33 -0400
Received: from mail-yb0-f173.google.com (mail-yb0-f173.google.com [209.85.213.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BD30208A5;
        Wed,  1 Aug 2018 14:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533135028;
        bh=F8A3mXzw6Hazsmx6c7yhvyUF4eG99B9aRheu1fE+UrI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=LjXBo6e7jkxLoGAR08ZNsSeC/qIvGgbdhGMZ7NdDQgtmQpstZsQtNdVTeAqiEglpv
         PKC4oWNxETKMbpTPKmz1ZPzMje3WJnbcvI/AkY2pR+thcwzLYnsEGAwTXZiwgx764T
         3RyhBpt1l/4fYDrI4twJNZDDYASFu+viTxs7Oywc=
Received: by mail-yb0-f173.google.com with SMTP id l16-v6so7630607ybk.11;
        Wed, 01 Aug 2018 07:50:28 -0700 (PDT)
X-Gm-Message-State: AOUpUlEzEPdRlGOVp74/+W4Um+vDRdfyi5utpxrenlPySrZFSdWNlkFh
        gIzRgLkW7t7vApnf/IF4SEl1r+OLT1A8/Pm7JK8=
X-Google-Smtp-Source: AAOMgpelf0EAmKnt5eZhGIcxuveKHFu5XuM6fqkGaX6vuvOgAWEmmIy1l+g6gF0SvXs341kdtdOchgyMogvEwdI9CJ4=
X-Received: by 2002:a25:d687:: with SMTP id n129-v6mr13724847ybg.113.1533135027473;
 Wed, 01 Aug 2018 07:50:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:81c5:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 07:49:46 -0700 (PDT)
In-Reply-To: <MWHPR0201MB3481D2A338A004B2FB17CA61C22D0@MWHPR0201MB3481.namprd02.prod.outlook.com>
References: <20180801100457.25614-1-nava.manne@xilinx.com> <20180801100457.25614-2-nava.manne@xilinx.com>
 <MWHPR0201MB34811402926886136673CE68C22E0@MWHPR0201MB3481.namprd02.prod.outlook.com>
 <CANk1AXQ-qrEKAm9zEs8sVaFNGGFkjCr+npTKUNDXz_bnpL=DQw@mail.gmail.com> <MWHPR0201MB3481D2A338A004B2FB17CA61C22D0@MWHPR0201MB3481.namprd02.prod.outlook.com>
From:   Alan Tull <atull@kernel.org>
Date:   Wed, 1 Aug 2018 09:49:46 -0500
X-Gmail-Original-Message-ID: <CANk1AXQci08TOVq7TeXXGfMWi8C8o4AGYDJK2Dr-mVgZPqU8bQ@mail.gmail.com>
Message-ID: <CANk1AXQci08TOVq7TeXXGfMWi8C8o4AGYDJK2Dr-mVgZPqU8bQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] fpga manager: Adding FPGA Manager support for
 Xilinx zynqmp
To:     Nava kishore Manne <navam@xilinx.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        Soren Brinkmann <sorenb@xilinx.com>,
        "atull@opensource.altera.com" <atull@opensource.altera.com>,
        "moritz.fischer@ettus.com" <moritz.fischer@ettus.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 12:49 AM, Nava kishore Manne <navam@xilinx.com> wrote:
> Hi Alan Tull,
>
> Thanks for the quick response.
> Please find my Comments inline...
>
>> -----Original Message-----
>> From: Alan Tull [mailto:atull@kernel.org]
>> Sent: Tuesday, July 31, 2018 8:52 PM
>> To: Nava kishore Manne <navam@xilinx.com>
>> Cc: robh+dt@kernel.org; mark.rutland@arm.com; Michal Simek
>> <michals@xilinx.com>; Soren Brinkmann <sorenb@xilinx.com>;
>> atull@opensource.altera.com; moritz.fischer@ettus.com;
>> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>> kernel@vger.kernel.org; Appana Durga Kedareswara Rao
>> <appanad@xilinx.com>; chinnikishore369@gmail.com; linux-
>> fpga@vger.kernel.org
>> Subject: Re: [RFC PATCH 2/2] fpga manager: Adding FPGA Manager support for
>> Xilinx zynqmp
>>
>> On Tue, Jul 31, 2018 at 8:08 AM, Nava kishore Manne <navam@xilinx.com>
>> wrote:
>> >
>> > +Alan Tull,
>>
>> + linux-fpga mailing list
>>
>> Hi Nava,
>>
>> Thanks for submitting.
>>
>> This should be on the linux-fpga mailing list.  The
>> linux/scripts/get_maintainer.pl script would tell you that.
>>
> I have Created this Patch On Master Branch there get_maintainer.pl Doesn't have linux-fpga mailing list.

The linux-fpga mailing list has been in MAINTAINERS since v4.9.

> https://git.kernel.org/pub/scm/linux/kernel/git/atull/linux-fpga.git/
> Please suggest a branch So will create a patch on top of it.

I understand now.  linux-fpga/master is v4.9ish.  I haven't updated
the master branch it since I cloned the repo, it doesn't have any
special FPGA development patches, it's just what Linus's master branch
was when I cloned.  I don't think you can count on any kernel.org's
master branch to be up to date with Linus other than Linus.  Probably
because it would be a waste of traffic on kernel.org and you can have
multiple remotes on your local git repo with Linus being the one that
contains the one true master branch.

Right now, Linus's master branch has the latest FPGA API, so it would
be a good one to develop on.

Generally speaking, sometimes there will be some API changes for FPGA
that are only on linux-next/master.  I spend most of my time
developing on linux-next/master.  Occasionally that's broken but most
of the time that works for me.  Or you could use a Linus release tag
from linus' repo.  Or Linus' master branch.  When submitting, if your
patches apply cleanly on linux-next/master, that is helpful and good.

Alan
