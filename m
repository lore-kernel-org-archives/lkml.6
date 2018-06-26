Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04181C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3EAD258B0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spogcpW3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3EAD258B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754702AbeFZTo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:44:29 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42065 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752109AbeFZTo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:44:28 -0400
Received: by mail-wr0-f194.google.com with SMTP id p1-v6so2801860wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 12:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YHEVmIl1h6ieTLWgDYcgH9mnUN9xL6k+pvUhmmEAG38=;
        b=spogcpW3z5NoueaIoWxsHm3MS2dvKR+GEAzeUbbBOUeHHhR/tsk+MFlij3XkQ1lr2E
         9PwsG/mVkgswNyX7HTUJXNvz0+yM1rVpJsY3EHj+SEj0Nky6aU1ZoPXUUAwPMja9YGK3
         5B5Y4UFIkxlTMMnmQV1GHthBqkeLzglpK/r/Yw7HALJ1OAu/X8YA1p5QvctpxqDCxQmE
         +H6VoCdG6kBeIfByOXo/erxhn0sgecwB4DKQYtcUdLWB5hdQeKu1HpS3aEygyNY8eL6L
         VUPiDTIhKG7VRIKBYvIS0kgJcjr2YiSo+02A3ad/X+3tttmb9qIQAtxJOmr9ChtcZ6ee
         X8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YHEVmIl1h6ieTLWgDYcgH9mnUN9xL6k+pvUhmmEAG38=;
        b=dCOVzfFdpTi5K5x5z5NfGRrU7Oo35Cwi0/WiJB7roZP+pMrN4JYglMuCn+VBWpxhXU
         0d3Dn0cBFH423R71RG6VV/l0mfuAV8WgEaNSkLSeBIDmgaSxqrdsRLwKG3Em26gSWMvI
         3RyP9SGXHX3JcgENkVm8S9bCgfYvwvdtiDs/Xs9ti+1hY/7SsBzMSB4ghJOeN088dCyO
         2AjCA1XeiLtlZ43Po9TAIALjL4NS7Cn1yY922w/UEFpcBAB20GC/3IATcgouGbEC07Vi
         nqlqhe0HxVQCJ0inO56v7CFLFXAIxNr9UtCnvvjT8889YhhzcyzJRkhu+DgJuy3Axu0+
         wHcQ==
X-Gm-Message-State: APt69E1kgX1j6Gk9I8ZK+UclKF4cdMr6UX47bdTCl3iSGVl4tkR6Wwgg
        VVFvnK0uWAyj7mywhKBvUXY=
X-Google-Smtp-Source: AAOMgpd1K9Y/eFTs13wAE4qdOkv0pmwP50cow96lDaOn5YRewpd5/wqNveo7ejOE3PnBT8RnQhDP3Q==
X-Received: by 2002:adf:fc8c:: with SMTP id g12-v6mr2604213wrr.216.1530042267449;
        Tue, 26 Jun 2018 12:44:27 -0700 (PDT)
Received: from [192.168.1.4] (x590c812a.dyn.telefonica.de. [89.12.129.42])
        by smtp.gmail.com with ESMTPSA id k17-v6sm2467018wrp.19.2018.06.26.12.44.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 12:44:26 -0700 (PDT)
Subject: Re: [PATCH v3 3/4] staging: rtl8723bs: use ether_addr_copy() in
 rtw_macaddr_cfg()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20180626081409.9518-1-straube.linux@gmail.com>
 <20180626081409.9518-3-straube.linux@gmail.com>
 <CAHp75Vc3gEyP+h_XtJV7zKZV0J++Nyr04au7Rtu3h5y0JJASXg@mail.gmail.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <37cca7e4-3c1f-b1ab-14b3-fd3dbbae8b01@gmail.com>
Date:   Tue, 26 Jun 2018 21:44:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vc3gEyP+h_XtJV7zKZV0J++Nyr04au7Rtu3h5y0JJASXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/26/18 19:32, Andy Shevchenko wrote:
> On Tue, Jun 26, 2018 at 11:14 AM, Michael Straube
> <straube.linux@gmail.com> wrote:
>> Use ether_addr_copy() instead of memcpy() to copy the mac address.
>>
> 
> Suggested-by ?
> 

I'll add it. Sorry, I was not aware of the Suggested-by tag.

> Btw, ensure that the source and destination buffers are aligned to u16
> as required by API.

To be honest I'm not sure how to do that excactly.

Use __align(2) in the array declarations? e.g.:

         u8 mac[ETH_ALEN] __align(2);


Thanks for your help.
Michael
