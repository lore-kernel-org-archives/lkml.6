Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D799ECDFBD
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 05:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4051120858
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 05:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4051120858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbeGVGgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 02:36:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55764 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbeGVGgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 02:36:45 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B065041C;
        Sun, 22 Jul 2018 05:41:19 +0000 (UTC)
Date:   Sat, 21 Jul 2018 22:41:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     gregkh@linuxfoundation.org, jic23@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        fabrice.gasnier@st.com, benjamin.gaignard@st.com,
        robh+dt@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com
Subject: Re: [PATCH v7 01/10] counter: Introduce the Generic Counter
 interface
Message-Id: <20180721224118.ff26734be0f5db552afcbe7c@linux-foundation.org>
In-Reply-To: <20180721162610.GA15622@sophia>
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
        <51b75b2b4495d4ad7ed173d91a726379bdae2353.1529607879.git.vilhelm.gray@gmail.com>
        <20180717204954.4b5e371603d0b40b2aaabbb8@linux-foundation.org>
        <20180721162610.GA15622@sophia>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Jul 2018 12:26:10 -0400 William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> >Also, many many drivers deal with signals-as-an-electrical-thing - is
> >it appropriate for this particular driver to take that namespace?
> 
> In the context of the Generic Counter paradigm, a "Signal" is an
> abstraction for the stream of data that is fed to the counter device for
> evaluation (triggering updates for the readable "Count"). In many cases
> a "Signal" correlates with a physical electrical line (for example the A
> and B electrical lines for a quadrature encoder), but this isn't a hard
> requirement as the paradigm permits more abstract data streams.
> 
> I decided on "Signal" to match the naming convention that appears in the
> datasheets of many counter devices, but "Line" may be a decent
> alternative name we could use to indicate a counter device input data
> stream.
> 
> I'd like to get some other opinions as well before I make a naming
> change to "Signal" -- whether to stay with "Signal," switch to "Line," or
> rename to something else. For what it's worth, I think it's unlikely for
> a counter device driver author to confuse a Counter Signal with the
> Linux OS signal within the context of the Generic Counter paradigm and
> their respective counter device datasheet.

gc_signal_* would be better.  That retains "signal", but makes
it clear that the symbols belong to generic counter.
