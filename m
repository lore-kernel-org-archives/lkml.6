Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05377C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A608220856
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYXEtDLw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A608220856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeJZTbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 15:31:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbeJZTbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 15:31:03 -0400
Received: from localhost (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75DB320856;
        Fri, 26 Oct 2018 10:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540551267;
        bh=e//LAJaZghKqSVlrCds9VukDoggKLJsIpZZOInwbncY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VYXEtDLwbKE56zBUoPdtYswz7CL64QdbTaRXDWXkTAIVjanQOPizG8ugvaOzdulPb
         vmHNQazuZoNOWaDqHI1IJA5daiqjARr27dyTc+5F/1xx7JDkazfUEC4kN8v/BPP52W
         vsnpoC5ZA2+iHeyu/AKhLoNA3wZFqD81BBCp7v3I=
Date:   Fri, 26 Oct 2018 06:54:23 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH AUTOSEL 3.18 36/98] usb: serial: handle -ENODEV quietly
 in generic_submit_read_urb
Message-ID: <20181026105423.GB2015@sasha-vm>
References: <20181025141853.214051-1-sashal@kernel.org>
 <20181025141853.214051-36-sashal@kernel.org>
 <20181026083929.GA27852@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181026083929.GA27852@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 10:39:29AM +0200, Johan Hovold wrote:
>Hi Sasha,
>
>On Thu, Oct 25, 2018 at 10:17:51AM -0400, Sasha Levin wrote:
>> From: Jeremiah Mahler <jmmahler@gmail.com>
>>
>> [ Upstream commit 04f9c6e6d17584340fb6c8a9469a0e6df28876d2 ]
>>
>> If a USB serial device (e.g. /dev/ttyUSB0) with an active program is
>> unplugged, an -ENODEV (19) error will be produced after it gives up
>> trying to resubmit a read.
>>
>>   usb_serial_generic_submit_read_urb - usb_submit_urb failed: -19
>>
>> Add -ENODEV as one of the permanent errors along with -EPERM that
>> usb_serial_generic_submit_read_urb() handles quietly without an error.
>>
>> Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
>> Signed-off-by: Johan Hovold <johan@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>This isn't a bug fix, but more of a clean up patch and hence does not
>qualify for stable. So specifically the stable tag was left out on
>purpose.
>
>I never got a chance to talk to you in Edinburgh, but Greg mentioned you
>had an opt-out list for your autosel work which I'd like to be added to.
>
>I always mark bug fixes that qualify for stable as such so anything else
>that your process picks up would already have been considered and
>rejected by me.

I'll drop it, thanks Johan!

--
Thanks,
Sasha
