Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644B5C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FAA921725
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FAA921725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbeHNXQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 19:16:15 -0400
Received: from mail-pl0-f52.google.com ([209.85.160.52]:42655 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbeHNXQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 19:16:15 -0400
Received: by mail-pl0-f52.google.com with SMTP id g6-v6so8763811plq.9;
        Tue, 14 Aug 2018 13:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1NfZBWI5tH2sZprHouPh7mwAwhT6001VDTBSRWtlnuQ=;
        b=Ok1NM7kW7JfgCO6EgYj4NKMfWd0sasjZt+VB8bWhjpvjHepNazu2V4ysJWYZwGDQp+
         VgDslblC0lZ7Zo6GiLVXtVLhiqQDrN2BgHS1zpHk0vw81Nc1pienNI/3vN9Revn1lEEY
         EyfGC5XyQPvVUcCsKo9Yz8kJzS049HqNVydbP1/etUKTcaeUrT9afYItUmspb5UqWNFg
         8Os5TnQ58kpmkfiAhzy6Z8rlF3fHHr+jN3p6UmRrzazPAaNal9XRBtaLcxhG6h2aRg/7
         m72d/DomOPXY80nqqVEbShAsArIIwh/Lr8brStnyvfR1/XCRINiNygWHtacNfHF2Wbgw
         +/bQ==
X-Gm-Message-State: AOUpUlGtkl2dbm3ZtSMwxzRBRpzC3h74GhTedunwqnFK7yLRRElf2+EA
        dv6JzrhARCEFvd3qBWH9JQ==
X-Google-Smtp-Source: AA+uWPz2rigwXLBF2U5NU9ghM2u7KwZetFgr5sQtGwXc197nv55dW/bAze9gTfPNA+AVrojw5RIUSA==
X-Received: by 2002:a17:902:bc8b:: with SMTP id bb11-v6mr21369644plb.112.1534278442834;
        Tue, 14 Aug 2018 13:27:22 -0700 (PDT)
Received: from localhost ([74.118.88.158])
        by smtp.gmail.com with ESMTPSA id a17-v6sm32131965pfg.106.2018.08.14.13.27.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 13:27:22 -0700 (PDT)
Date:   Tue, 14 Aug 2018 14:27:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Trent Piepho <tpiepho@impinj.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "lanqing.liu@spreadtrum.com" <lanqing.liu@spreadtrum.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add Spreadtrum SPI controller
 documentation
Message-ID: <20180814202720.GB26606@rob-hp-laptop>
References: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
 <20180807134121.GA7958@sirena.org.uk>
 <CAMz4kuJsyKv_fvrqRR3pdfKsLVy53Uj0KX+m_9jLxpcVcMvs9g@mail.gmail.com>
 <20180808095025.GB9346@sirena.org.uk>
 <CAMz4kuKZHxYiJaMHnqdAGth8XkfGnq3-Tsfc59cGjsHQHZaY7A@mail.gmail.com>
 <20180808105451.GE9346@sirena.org.uk>
 <1533754621.2283.270.camel@impinj.com>
 <CAMz4kuKwfBB8-8o5s8FQadFSFiD8KU=qNZYQjCWOfc-QpuVRSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMz4kuKwfBB8-8o5s8FQadFSFiD8KU=qNZYQjCWOfc-QpuVRSw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 11:03:11AM +0800, Baolin Wang wrote:
> Hi Trent,
> 
> On 9 August 2018 at 02:57, Trent Piepho <tpiepho@impinj.com> wrote:
> > On Wed, 2018-08-08 at 11:54 +0100, Mark Brown wrote:
> >> On Wed, Aug 08, 2018 at 06:35:28PM +0800, Baolin Wang wrote:
> >> > On 8 August 2018 at 17:50, Mark Brown <broonie@kernel.org> wrote:
> >> > > Right, I don't think we added this yet (if we did I can't see
> >> > > it).  I'd
> >> > > add a new field to spi_transfer for this, then other controllers
> >> > > with
> >> > > the same support can implement it as well and drivers can start
> >> > > using
> >> > > it too.
> >> > OK. So I will name the new filed as 'word_delay', is it OK for you?
> >>
> >> Sounds good, yes.
> >
> > Should it be in µs like the existing iter-transfer delay?  I think
> > perhaps units of cycles of the SPI clock make more sense?
> 
> Since some SPI controllers just want some interval values (neither µs
> unit nor cycles unit ) set into hardware, and the hardware will
> convert to the correct delay time automatically. So I did not force
> 'word_delay' unit as µs or cycle, and just let the slave devices
> decide the unit which depends on the SPI hardware requirement.

This needs to be defined units in DT, not decided by each controller.

The controller capabilities just affect what are valid values (or what 
the resolution is).

Rob
