Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7A7C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 01:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E685820844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 01:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E685820844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388540AbeGYCbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 22:31:40 -0400
Received: from smtprelay0006.hostedemail.com ([216.40.44.6]:39839 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388468AbeGYCbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 22:31:40 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 09BC8837F243;
        Wed, 25 Jul 2018 01:22:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: slope50_6cd6465b85032
X-Filterd-Recvd-Size: 2580
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Wed, 25 Jul 2018 01:22:27 +0000 (UTC)
Message-ID: <ab673e7f3e552fb88c91ebf5259970c80094f9d9.camel@perches.com>
Subject: Re: [PATCH 2/4] Staging: octeon-usb: Applying coding style for
 column width.
From:   Joe Perches <joe@perches.com>
To:     Georgios Tsotsos <tsotsos@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        James Hogan <jhogan@kernel.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 24 Jul 2018 18:22:26 -0700
In-Reply-To: <20180724222212.8742-3-tsotsos@gmail.com>
References: <20180724222212.8742-1-tsotsos@gmail.com>
         <20180724222212.8742-3-tsotsos@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-25 at 01:22 +0300, Georgios Tsotsos wrote:
> This patch resolves the warnings as its refereed to TODO list.
> There are also a code style issues that could be resolved via breaking
> down cvmx_usb_poll_channel().

It was better before this change.

If checkpatch caused you to produce this, please
know that checkpatch messages are not dicta and
do not need to be followed if the resultant code
is worse to read.

More likely, it could be nicer to use a separate
function for this block instead.

> Signed-off-by: Georgios Tsotsos <tsotsos@gmail.com>
> ---
>  drivers/staging/octeon-usb/octeon-hcd.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
> index cff5e790b196..0d3ec12788fc 100644
> --- a/drivers/staging/octeon-usb/octeon-hcd.c
> +++ b/drivers/staging/octeon-usb/octeon-hcd.c
> @@ -2637,12 +2637,14 @@ static int cvmx_usb_poll_channel(struct octeon_hcd *usb, int channel)
>  				hcintmsk.u32 = 0;
>  				hcintmsk.s.chhltdmsk = 1;
>  				cvmx_usb_write_csr32(usb,
> -						     CVMX_USBCX_HCINTMSKX(channel, usb->index),
> -						     hcintmsk.u32);
> +						CVMX_USBCX_HCINTMSKX(channel,
> +							usb->index),
> +							hcintmsk.u32);
>  				usbc_hcchar.s.chdis = 1;
>  				cvmx_usb_write_csr32(usb,
> -						     CVMX_USBCX_HCCHARX(channel, usb->index),
> -						     usbc_hcchar.u32);
> +						CVMX_USBCX_HCCHARX(channel,
> +							usb->index),
> +							usbc_hcchar.u32);
>  				return 0;
>  			} else if (usbc_hcint.s.xfercompl) {
>  				/*
