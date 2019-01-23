Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082ECC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C83902133D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548250913;
	bh=bhNsrBIzjCKhWx6dzhuEerxRchlI2MV0/XhG9VyGdSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I+A2YTW6PMZHZ6Y001HUjVNtBi5lLFD2gmbvbOBKKjO8UuxmaE4sLtobmE/xghO8q
	 2wOuknaElrVeMmOhElb7dAplTzzZf+ztFejWrlu/so+ePTi4v2J3YHof1NEjEAUK/i
	 53gGdZsQInghmbY8sXZR+d1tzdBSKfYpj7Tv7Py4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfAWNlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 08:41:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:56082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfAWNlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 08:41:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E28BD20870;
        Wed, 23 Jan 2019 13:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548250910;
        bh=bhNsrBIzjCKhWx6dzhuEerxRchlI2MV0/XhG9VyGdSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a+SdaKaYT4B/rVemnsJPr85fmEkwRvBtNZnq4vq0T5LvH0EH9ikcA2zub9em5RVTE
         ALCsv2Iml5jxscNoUaqOSicH9n7rfjYymUoaguY+MJSS7Gyx7mIuiXtFB+sH4tA3e1
         kmoCBg6Pj2PrlY7A2aELGnjhKZY03pi0XO45wBCc=
Date:   Wed, 23 Jan 2019 14:41:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH -next] usb: ftdi-elan: Fix if == else warnings in
 ftdi_elan_respond_engine
Message-ID: <20190123134147.GC24700@kroah.com>
References: <20190123123442.5256-1-yuehaibing@huawei.com>
 <20190123124319.GB19703@kroah.com>
 <10d0f378-03ab-1855-1476-a39cf6b816ab@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10d0f378-03ab-1855-1476-a39cf6b816ab@huawei.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 09:17:38PM +0800, YueHaibing wrote:
> On 2019/1/23 20:43, Greg KH wrote:
> > On Wed, Jan 23, 2019 at 08:34:42PM +0800, YueHaibing wrote:
> >> ./drivers/usb/misc/ftdi-elan.c:972:10-12: WARNING: possible condition with no effect (if == else)
> >> ./drivers/usb/misc/ftdi-elan.c:983:9-11: WARNING: possible condition with no effect (if == else)
> >> ./drivers/usb/misc/ftdi-elan.c:2052:11-13: WARNING: possible condition with no effect (if == else)
> >>
> >> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > 
> > You can not just provide the output of a tool as a changelog text,
> > sorry.
> > 
> > Please explain what those lines mean, and why you are making the change
> > that you are.
> 
> ok, will do that.
> 
> > 
> >> ---
> >>  drivers/usb/misc/ftdi-elan.c | 26 --------------------------
> >>  1 file changed, 26 deletions(-)
> >>
> >> diff --git a/drivers/usb/misc/ftdi-elan.c b/drivers/usb/misc/ftdi-elan.c
> >> index 76c718a..257efac 100644
> >> --- a/drivers/usb/misc/ftdi-elan.c
> >> +++ b/drivers/usb/misc/ftdi-elan.c
> >> @@ -915,7 +915,6 @@ static int ftdi_elan_respond_engine(struct usb_ftdi *ftdi)
> >>  	int bytes_read = 0;
> >>  	int retry_on_empty = 1;
> >>  	int retry_on_timeout = 3;
> >> -	int empty_packets = 0;
> >>  read:{
> >>  		int packet_bytes = 0;
> >>  		int retval = usb_bulk_msg(ftdi->udev,
> >> @@ -960,31 +959,6 @@ read:{
> >>  			dev_err(&ftdi->udev->dev, "error = %d with packet_bytes = %d with total %d bytes%s\n",
> >>  				retval, packet_bytes, bytes_read, diag);
> >>  			return retval;
> >> -		} else if (packet_bytes == 2) {
> >> -			unsigned char s0 = ftdi->bulk_in_buffer[0];
> >> -			unsigned char s1 = ftdi->bulk_in_buffer[1];
> >> -			empty_packets += 1;
> >> -			if (s0 == 0x31 && s1 == 0x60) {
> >> -				if (retry_on_empty-- > 0) {
> >> -					goto more;
> >> -				} else
> >> -					return 0;
> >> -			} else if (s0 == 0x31 && s1 == 0x00) {
> >> -				if (retry_on_empty-- > 0) {
> >> -					goto more;
> >> -				} else
> >> -					return 0;
> >> -			} else {
> >> -				if (retry_on_empty-- > 0) {
> >> -					goto more;
> >> -				} else
> >> -					return 0;
> >> -			}
> >> -		} else if (packet_bytes == 1) {
> >> -			if (retry_on_empty-- > 0) {
> >> -				goto more;
> >> -			} else
> >> -				return 0;
> > 
> > Are you _sure_ that these lines are not needed and that the compiler is
> > not really seeing them?  As it doesn't look that way to me, what am I
> > missing?
> 
> I checked and make sure that All these if/else if branch just do the same thing:
> 
> 	if (retry_on_empty-- > 0) {
> 		goto more;
> 	} else
> 		return 0;
> 
> so it can be merged into the last else branch.
> 
> Also the variable 'empty_packets' doesn't use in any place, except for self increment

Don't do two different things in the same patch :)

