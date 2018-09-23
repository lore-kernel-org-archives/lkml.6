Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83251ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 21:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5DA20989
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 21:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=comcast.net header.i=@comcast.net header.b="lzH6WLl3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E5DA20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=comcast.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeIXDx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 23:53:27 -0400
Received: from resqmta-ch2-03v.sys.comcast.net ([69.252.207.35]:33322 "EHLO
        resqmta-ch2-03v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726520AbeIXDx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 23:53:27 -0400
Received: from resomta-ch2-12v.sys.comcast.net ([69.252.207.108])
        by resqmta-ch2-03v.sys.comcast.net with ESMTP
        id 4CHUgdJUBPUIw4CKdgeazY; Sun, 23 Sep 2018 21:54:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20161114; t=1537739663;
        bh=ozBS/3YtQT+ZEMp6NCYGolIle4BnTZ3kBc+HJ8/2gug=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=lzH6WLl31/7ThxyEmBN7Dl6HO6UQ4d71SYRcCC8Cia56qQwpQfy7qo2BT80wVSDK4
         /ztWMvQUWHD1DQb2XjXv+MSRFCKsj5gzGaH3siwEgYi0gSrEfmEWeLhXHzPqF7zPAA
         FISvhUGSgWnGasSPr3fFkFyegLcq5pX4PiFn3yk21yCXtK7ueOYVdRA1Z+4pK91U/q
         GY6Ca1AlpOCKhxiPuQkFpnpC4XQZXN76Zc0pzMV0LcHYU2UWLOwZJu/5uf6qNd/rdV
         tEM+Pmcq2Y9iWb2YAEHVGrZ9qfvfrAnggl4zFHjJouX+SJcYdTUE4vCBOHTKbgEmF7
         A5wVM43VANtRw==
Received: from [10.1.10.100] ([73.214.254.59])
        by resomta-ch2-12v.sys.comcast.net with ESMTPSA
        id 4CKcgRnarT2X34CKdg2faP; Sun, 23 Sep 2018 21:54:23 +0000
Subject: Re: AMD Athlon bogus performance value causing RCU stalls?
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
References: <6243f7cc-1a80-db0b-4765-fa12bda9b06a@comcast.net>
 <alpine.DEB.2.21.1809232314460.1398@nanos.tec.linutronix.de>
From:   Rob Prowel <rprowel@comcast.net>
Message-ID: <de33e029-2be3-85de-4777-64dd8803fe1e@comcast.net>
Date:   Sun, 23 Sep 2018 17:54:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1809232314460.1398@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKtHwqGCZ1miu1CggW6UdpVF+aXHvL8GoboKMA3pDEPUaz0mC2dq6lAr+DDX0sAzgRW2pXiJ7oS7mfVKew1+o8g2I9goIBRgmM0Otv38M9DwABKUs/Ph
 NJqyp+BigYI6aqYZkqtU+gKjteTSLxNdzRbRCQtRm9YVMk00ZuDSZNak0wRJhGlN5UeiyuVnMEIUENv9AihkyManhCMTg1BxPiI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/23/18 17:19, Thomas Gleixner wrote:


>>
>> What is that value for the second Athlon core (seems extremely bogus), and
>> would/could that be the reason for the schedule_timeouts?  This bogus value
>> also shows up in the bootup log when the second core is activated.  Seems to
>> be AMD specific, as the values are correct on my Xeon machines.
> 
> That's a 32bit machine I assume.

No.  Actually it is a 64 bit AMD Athlon.  Might need to check the math being a
problem in the 64 bit domain as well.


> 
> Yes. This was decoded recently as an issue on 32bit due to a calculation
> which is based on 'unsigned long' but requires to be 64bit wide.
> 
> It's in the 4.18.8 stable kernel, which should be available from your
> fedora repo anytime soon.
> 

Will check with the newer kernel when it's available but please do double check if this
problem might exist on 64 bit architectures as well...and of course I'm interested to
know whether it is the likely cuprit of my RCU problem.


