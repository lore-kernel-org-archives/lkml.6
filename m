Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4478BC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18662084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544477284;
	bh=lZviD4PUdzrhBrZMWeI+haJWBfYChjA8SOhGaFmyfUs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=LpR+uyXP/ZT7SaC7F8EgXWQKSIHBepl1ChRVUFj/0HaQPCDN7b1tqMNcQhCb+Li3r
	 1EkKcwECGNbXgiBtMW4sfy0vddf1vUOtUkT221YnSBtE0PiuxJGCH7nCic4SFRv9Jb
	 ePwPrqh9EVSEvNEi9fJSut8CspJMVeSawmEN5uSw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F18662084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbeLJV2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:28:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:35362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729862AbeLJV2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:28:02 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48D7B20821;
        Mon, 10 Dec 2018 21:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544477281;
        bh=lZviD4PUdzrhBrZMWeI+haJWBfYChjA8SOhGaFmyfUs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q2zFGCc69UNbPCC1WAO9yOlWKbh33xEd8gfdmkES/XIz34Azm5GunUZ5G0+46lsxd
         uiwATbgKI7zGhAgI3Cgln6MyxVwlWBrLLJdCzgKtcerqea5VO4ZGb/LnHyTSTw91XH
         zBRUJHfTnLI0nG9ST2Fq0yISNH3LerrSDGIhcurI=
Date:   Mon, 10 Dec 2018 21:27:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        Dragos Bogdan <dragos.bogdan@analog.com>
Subject: Re: [PATCH 0/3] Add devicetree support for ad5933
Message-ID: <20181210212756.7e444b4f@archlinux>
In-Reply-To: <20181208211043.GA25188@kroah.com>
References: <cover.1544292845.git.marcelo.schmitt1@gmail.com>
        <CAAX=9sVrbu2U9go_d1G5=rGRa9AYT+betx9gyKWNXXU4adg4Bg@mail.gmail.com>
        <20181208211043.GA25188@kroah.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Dec 2018 22:10:43 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Sat, Dec 08, 2018 at 04:56:45PM -0200, Marcelo Schmitt wrote:
> > Parts of this work came from contributions of Alexandru Ardelean and
> > Dragos Bogdan, I and Gabriel would like to thank for the insights
> > provided by their previous patches. Maybe it would be the case to add
> > them as co-authors of this patch set.  
> 
> That's what the Co-developed-by: tag is for, please use it :)
> 
Alexandru, Dragos.  No idea how involved you were in the actual
patch...

Work amongst amongst the 4 of you what you would like to do and
let us know!

Patches look fine, though we need to let the DT maintainers have a few
days at least to get around to looking if they want to (they don't always
on simple bindings like these).

Jonathan
 
