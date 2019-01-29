Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2950C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802E62054F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbfA2W26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 17:28:58 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45328 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfA2W26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 17:28:58 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gobs6-0007vz-42; Tue, 29 Jan 2019 23:28:46 +0100
Date:   Tue, 29 Jan 2019 23:28:45 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     =?ISO-8859-15?Q?Jan_H=2E_Sch=F6nherr?= <jan@schnhrr.de>
cc:     bp@alien8.de, mingo@redhat.com, x86@kernel.org,
        pmenzel@molgen.mpg.de, Thomas.Lendacky@amd.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/tsc: Allow quick PIT calibration despite
 interruptions
In-Reply-To: <5C50558B.8060405@schnhrr.de>
Message-ID: <alpine.DEB.2.21.1901292327090.1950@nanos.tec.linutronix.de>
References: <20190129102329.27610-1-jan@schnhrr.de> <20190129102329.27610-2-jan@schnhrr.de> <5C50558B.8060405@schnhrr.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1617812140-1548800926=:1950"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1617812140-1548800926=:1950
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Tue, 29 Jan 2019, Jan H. Schönherr wrote:

> Am 29.01.2019 um 11:23 schrieb Jan H. Schönherr:
> > +calibrate:
> > +	/*
> > +	 * Extrapolate the error and fail fast if the error will
> > +	 * never be below 500 ppm.
> > +	 */
> > +	if (d1 + d1 >= (delta * MAX_QUICK_PIT_ITERATIONS) >> 11) {
> > +		pr_info("Fast TSC calibration failed (wouldn't work)\n");
> > +		return 0;
> > +	}
> 
> I messed this check up. "delta" is not the actual tsc delta between the
> first two successful reads at this point.
> 
> (If it were, it might also correspond to more than one iteration; not
> sure if we care about that aspect, though.)

I rather go for correct and if only for the reason that me/you/whoelse
doesn't have to scratch the head for an hour when looking at this half a
year from now.

Thanks,

	tglx
--8323329-1617812140-1548800926=:1950--
