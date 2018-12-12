Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B5FC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D8420870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544640632;
	bh=xRbf4d1FIG0dn7y2KUwut6DSvMsE1u6WhMeuHxIqb+U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=LUSIUZSUJAKYUy6oGYs3zSiFxou9NH1DkoRvUXjlTIKOYI/bQNztPJUCWKndQe2aK
	 pZX0EsxLyMXM9lhqU10w1sUzl2+ZO9Tm5lFttVakdlLgS4xqYSkXL5gS//EvtTJ9Xq
	 v0DpPkbzHqklKYuBIl5GVR2VBpn0B22VWEBipxdM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D8420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbeLLSub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:50:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:45132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727897AbeLLSua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:50:30 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5ABA20811;
        Wed, 12 Dec 2018 18:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544640630;
        bh=xRbf4d1FIG0dn7y2KUwut6DSvMsE1u6WhMeuHxIqb+U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hmohRVnVf06WyzA2gz1e4+MqZeTvYm/d6kFKlW6h8hDdWzUC3mZ6Xv4QMwrrteUdq
         eoFDZIlVFzz4dplWYmxRPRvHU6u6nYt7LPu/Oa3n+xLTdHqm6t9yQRTU0tURFvur+B
         PY+5VZXyvmDvPltzi/5B+Rd6MhqyeofNihCTueQ0=
Date:   Wed, 12 Dec 2018 18:50:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Herton R. Krzesinski" <herton@redhat.com>
Subject: Re: [PATCH 5/6] tools iio: Override CFLAGS assignments
Message-ID: <20181212185025.2d771573@archlinux>
In-Reply-To: <20181212102537.25902-6-jolsa@kernel.org>
References: <20181212102537.25902-1-jolsa@kernel.org>
        <20181212102537.25902-6-jolsa@kernel.org>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018 11:25:36 +0100
Jiri Olsa <jolsa@kernel.org> wrote:

> So user could specify outside CFLAGS values.
> 
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Sorry. I must have failed to reply.  I applied this from previous
version. It's in Linux next - I just checked. 

Jonathan

> ---
>  tools/iio/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/iio/Makefile b/tools/iio/Makefile
> index 332ed2f6c2c2..e22378dba244 100644
> --- a/tools/iio/Makefile
> +++ b/tools/iio/Makefile
> @@ -12,7 +12,7 @@ endif
>  # (this improves performance and avoids hard-to-debug behaviour);
>  MAKEFLAGS += -r
>  
> -CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
> +override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
>  
>  ALL_TARGETS := iio_event_monitor lsiio iio_generic_buffer
>  ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))

