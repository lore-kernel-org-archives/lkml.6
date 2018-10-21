Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70261ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 12:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B86B20843
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 12:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w8BDZ7km"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B86B20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbeJUUlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 16:41:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727379AbeJUUlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 16:41:02 -0400
Received: from archlinux (unknown [176.12.107.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DD2220869;
        Sun, 21 Oct 2018 12:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540124813;
        bh=Blsc+pBmCjQJO4FsimaXEyBe7lE3eHnIemORN55XpdU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=w8BDZ7kmJ+HETXYXnUGQjNhdioJXlZ1M/rx5fA/4OWmjRxH+focKCZjVuCBJ/018Z
         X/yOlQR4Cxd/HHduwVn7y+U9y8pJ2UDNE1Zr+WCvkYizgQjbek2wCPx++etQZgpiZY
         dMrAH8L/CSST3mIgfs5Ic/6UPBecZgVVmny/Axzs=
Date:   Sun, 21 Oct 2018 13:26:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Herton R. Krzesinski" <herton@redhat.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 09/10] tools iio: Override CFLAGS assignments
Message-ID: <20181021132616.34e3bc95@archlinux>
In-Reply-To: <20181016150614.21260-10-jolsa@kernel.org>
References: <20181016150614.21260-1-jolsa@kernel.org>
        <20181016150614.21260-10-jolsa@kernel.org>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018 17:06:14 +0200
Jiri Olsa <jolsa@kernel.org> wrote:

> So user could specify outside CFLAGS values.
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to poke at them.

Thanks

Jonathan

> 
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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

