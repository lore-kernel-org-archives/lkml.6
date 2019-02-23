Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82C2C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B40D206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfBWAwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 19:52:32 -0500
Received: from smtprelay0016.hostedemail.com ([216.40.44.16]:51209 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725900AbfBWAwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 19:52:32 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id D5416100E86C0;
        Sat, 23 Feb 2019 00:52:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: dogs25_15d30c8999011
X-Filterd-Recvd-Size: 1544
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sat, 23 Feb 2019 00:52:29 +0000 (UTC)
Message-ID: <82b7d3bb2799468a715e280366401f732d83cfdf.camel@perches.com>
Subject: Re: [PATCH] checkpatch: don't complain about "undocumented" USB VID
From:   Joe Perches <joe@perches.com>
To:     Brian Norris <briannorris@chromium.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Date:   Fri, 22 Feb 2019 16:52:28 -0800
In-Reply-To: <20190222225545.78031-1-briannorris@chromium.org>
References: <20190222225545.78031-1-briannorris@chromium.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-02-22 at 14:55 -0800, Brian Norris wrote:
> Documentation/devicetree/bindings/usb/usb-device.txt describes the
> 'usbVID,...' compatible format, where VID is hexadecimal, with leading
> zeroes suppressed. Allow it here without complaining.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3012,6 +3012,8 @@ sub process {
>  				}
>  
>  				next if $compat !~ /^([a-zA-Z0-9\-]+)\,/;
> +				# USB VIDs don't need special vendor prefix documentation.
> +				next if $compat =~ /^usb[1-9a-f][0-9a-f]{0,3},/;

Maybe check the PID too?

				next if $compat =~ /^usb[1-9a-f][0-9a-f]{0,3},[1-9a-f][0-9a-f]{0,3}\b/;


Maybe add a test for uses of the leading 0?


