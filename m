Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E3DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 22:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2D9213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 22:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2D9213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbeHQBCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 21:02:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43109 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeHQBCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 21:02:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id v66-v6so1325076pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 15:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vY2vAjXXpKGhI+EAjkttBWanAVSOhrzsn8CK9ogg6Fc=;
        b=Hh0xCsL+32INMNxqdpoSjPkEbBXbiYIJf+6jw/1F9Pv6vim/Uhgn7v+n58BXhLHJkr
         o+j9ycEHPIkc+IL4jmzfzMUWYgnwyPjJvDmcodOYx+4Eq1xiBTQ2JFX3PGOD/RdCr8fz
         VsP8JGvOkorwspvSd0/7gaIKBDvEH3tNE22M2UJFX4rlHRbwkgMbzto+YXPrwLBvCVZ1
         tLA2TrDGpTt5MWxkn8KVGIkktQJzXBCciWrVhLlteh0VVEl+od7jMb7FhX2miwtziEau
         njAb4CvYR+KipNxXk0MViG/NldJS+8BPu1/5GDwc2/HOawfja7SqTZZ1koBPvgpAKLer
         zfIw==
X-Gm-Message-State: AOUpUlG7Cgg9SsPg1UTU0/nzgIn6LRaDjI7iOZDykKXpsMk/zc3Yt3ZG
        pUJwJmh12zyZgf0IOneAYHwLeA==
X-Google-Smtp-Source: AA+uWPxcz2N2iqh9yDdWNMvyLyRAfKlHJs1tENDtPhPv+nOpPX0yB4noViXpgWaFGyvF5ZLJhZ4e7A==
X-Received: by 2002:a63:4d06:: with SMTP id a6-v6mr30215848pgb.408.1534456887173;
        Thu, 16 Aug 2018 15:01:27 -0700 (PDT)
Received: from localhost ([207.114.172.147])
        by smtp.gmail.com with ESMTPSA id x7-v6sm274306pgk.9.2018.08.16.15.01.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 15:01:26 -0700 (PDT)
Date:   Thu, 16 Aug 2018 15:01:23 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Alan Tull <atull@kernel.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 7/8] docs: fpga: document fpga manager flags
Message-ID: <20180816220123.GB4431@archbook>
References: <20180814191526.3247-1-atull@kernel.org>
 <20180814191526.3247-8-atull@kernel.org>
 <20180816190252.GB3932@archbook>
 <CANk1AXR3gAc6YiC-WARrgnFbJWQVWv2Nuz49u7qyobJdKdNotg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXR3gAc6YiC-WARrgnFbJWQVWv2Nuz49u7qyobJdKdNotg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 03:20:12PM -0500, Alan Tull wrote:
> On Thu, Aug 16, 2018 at 2:02 PM, Moritz Fischer <mdf@kernel.org> wrote:
> Hi Moritz,
> 
> > Hi Alan,
> >
> > On Tue, Aug 14, 2018 at 02:15:25PM -0500, Alan Tull wrote:
> >> Add flags #defines to kerneldoc documentation in a
> >> useful place.
> >>
> >> Signed-off-by: Alan Tull <atull@kernel.org>
> >> ---
> >>  Documentation/driver-api/fpga/fpga-mgr.rst |  5 +++++
> >>  include/linux/fpga/fpga-mgr.h              | 18 ++++++++++++------
> >>  2 files changed, 17 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst b/Documentation/driver-api/fpga/fpga-mgr.rst
> >> index 431556d..db8885e 100644
> >> --- a/Documentation/driver-api/fpga/fpga-mgr.rst
> >> +++ b/Documentation/driver-api/fpga/fpga-mgr.rst
> >> @@ -183,6 +183,11 @@ API for implementing a new FPGA Manager driver
> >>  API for programming an FPGA
> >>  ---------------------------
> >>
> >> +FPGA Manager flags
> >> +
> >> +.. kernel-doc:: include/linux/fpga/fpga-mgr.h
> >> +   :doc: FPGA Manager flags
> >> +
> >>  .. kernel-doc:: include/linux/fpga/fpga-mgr.h
> >>     :functions: fpga_image_info
> >>
> >> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> >> index 1ca02ce..777c502 100644
> >> --- a/include/linux/fpga/fpga-mgr.h
> >> +++ b/include/linux/fpga/fpga-mgr.h
> >> @@ -53,12 +53,18 @@ enum fpga_mgr_states {
> >>       FPGA_MGR_STATE_OPERATING,
> >>  };
> >>
> >> -/*
> >> - * FPGA Manager flags
> >> - * FPGA_MGR_PARTIAL_RECONFIG: do partial reconfiguration if supported
> >> - * FPGA_MGR_EXTERNAL_CONFIG: FPGA has been configured prior to Linux booting
> >> - * FPGA_MGR_BITSTREAM_LSB_FIRST: SPI bitstream bit order is LSB first
> >
> > We are actually missing the ENCRYPTED flag here, can you add that while
> > we're at it? I must've forgotten to add that back then ... derp.
> 
> Sure!
> 
> >
> >> - * FPGA_MGR_COMPRESSED_BITSTREAM: FPGA bitstream is compressed
> >> +/**
> >> + * DOC: FPGA Manager flags
> >> + *
> >> + * Flags used in the &fpga_image_info->flags field
> >> + *
> >> + * %FPGA_MGR_PARTIAL_RECONFIG: do partial reconfiguration if supported
> >> + *
> >> + * %FPGA_MGR_EXTERNAL_CONFIG: FPGA has been configured prior to Linux booting
> 
> How about this description?
> 
> + *
> + * %FPGA_MGR_ENCRYPTED_BITSTREAM: indicates bitstream is encrypted

Works for me :)
> 
> >> + *
> >> + * %FPGA_MGR_BITSTREAM_LSB_FIRST: SPI bitstream bit order is LSB first
> >> + *
> >> + * %FPGA_MGR_COMPRESSED_BITSTREAM: FPGA bitstream is compressed
> >>   */
> >>  #define FPGA_MGR_PARTIAL_RECONFIG    BIT(0)
> >>  #define FPGA_MGR_EXTERNAL_CONFIG     BIT(1)
> >> --
> >> 2.7.4
> >>
> >
> > Thanks,
> > Moritz
> 
> Thanks,
> Alan
