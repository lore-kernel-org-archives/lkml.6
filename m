Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E34C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD5B20881
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbfA3XDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:03:25 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48382 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfA3XDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:03:20 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1goxui-0006Zr-VX; Wed, 30 Jan 2019 23:00:57 +0100
Date:   Wed, 30 Jan 2019 23:00:56 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Colascione <dancol@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [patch 0/2] genirq, proc: Speedup /proc/stat interrupt
 statistics
In-Reply-To: <20190130135845.406c51b7f565232a7fed0de6@linux-foundation.org>
Message-ID: <alpine.DEB.2.21.1901302300270.8200@nanos.tec.linutronix.de>
References: <20190130123130.785636313@linutronix.de> <20190130135845.406c51b7f565232a7fed0de6@linux-foundation.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019, Andrew Morton wrote:
> On Wed, 30 Jan 2019 13:31:30 +0100 Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > Waiman reported that on large systems with a large amount of interrupts the
> > readout of /proc/stat takes a long time to sum up the interrupt
> > statistics. In principle this is not a problem. but for unknown reasons
> > some enterprise quality software reads /proc/stat with a high frequency.
> > 
> > The reason for this is that interrupt statistics are accounted per cpu. So
> > the /proc/stat logic has to sum up the interrupt stats for each interrupt.
> > 
> > The following series addresses this by making the interrupt statitics code
> > in the core generate the sum directly and by making the loop in the
> > /proc/stat read function smarter.
> > 
> 
> Has the speedup been quantified?

Waiman should be able to provide numbers


