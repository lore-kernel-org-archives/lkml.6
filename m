Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F70C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C089F25EAA
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heIU/0AF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C089F25EAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965717AbeF0QOu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:14:50 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:36386 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965344AbeF0QOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:14:48 -0400
Received: by mail-vk0-f67.google.com with SMTP id o138-v6so1511584vkd.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 09:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eYu4fUfDPOPAOZJy3InJD5zLXTmkWb4+zZNpiVBpcuQ=;
        b=heIU/0AFgWS2LHcc5SrecPMIMFvCQSWrDU5CGUf1skIiaRwP2VDkmGc/sdMk2qG1VT
         V5q2QNICCyfiwDX0K7EJMmRe3mmaNCZaISkj0VOS7Uw9kVFpv28cWYLCaT8q16YUwM0S
         cBegKVRAL6NDNU24rR4CWax7xfpj5SXwEYag71N1uCFO3Fp9fXSs50Y+0oBXplIkbpNo
         6Q63ZMTn/gZZzqwGW8/sjQBCy4MBQnHDpX0LhrVnQacF3f74BH5KbEUOKPjwm9lwjuFU
         QrNlcIADVc93k5WkJVzCDrEFTH4OCp1EQhKbsMMIv6LsDCI6FBkDYG8LvQYImbgrMKb6
         ZO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eYu4fUfDPOPAOZJy3InJD5zLXTmkWb4+zZNpiVBpcuQ=;
        b=EuCkG2UMZ5y0ur3Na3E3+bmL3hZO5N0S7p+29qohHP98ysj1EV5ZXjl4pe+JrGzylP
         pyT8wbzTh1v84+uHMjs3/xbcBCWMSOLseezNjUVsfFqTgJWCy1NLHoDK7lezmmzMKSYa
         8WYagLXwdgzEtVv3b4UBSw2ApwNFCdFL4NqQ04bDpjBFxhMNcdfdc96Jzb6JD+IY3oOE
         8Hc6JKHCDHePFizxP4n1gpu7Ai3Yz6BjlGp38IpVKGFDA83BboiP92elu25MIRezfLUX
         1aYEGQ5AY+tnNK5lzkKz7+0RuuBaiaxpm568f6zksS9k1oTCaP5LsgWOfdCuOyoTAMO4
         ApRA==
X-Gm-Message-State: APt69E0bLM3MwVOOv6rpuPogJw2wjmI9hJxWF2dSBuvwtRKBFhI1nRWW
        Qt4UeGX7phuhrRkIXb3SOQjZKjbOi9bWfl/N2QbasAQM
X-Google-Smtp-Source: AAOMgpdd1WTdMt612gMMn7udLVx8d0irUt340pwxNobm1gBQpLl8TApvBTaguTyTaqVXefxsdmS3vUpPjyNOdvykvzA=
X-Received: by 2002:a1f:8e0f:: with SMTP id q15-v6mr4303103vkd.161.1530116088005;
 Wed, 27 Jun 2018 09:14:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 09:14:47
 -0700 (PDT)
In-Reply-To: <20180627131158.xttl27awxie2w6ia@mwanda>
References: <20180626081409.9518-1-straube.linux@gmail.com>
 <20180626081409.9518-3-straube.linux@gmail.com> <CAHp75Vc3gEyP+h_XtJV7zKZV0J++Nyr04au7Rtu3h5y0JJASXg@mail.gmail.com>
 <37cca7e4-3c1f-b1ab-14b3-fd3dbbae8b01@gmail.com> <96782a8bbc8d5a8a911447beda78ca4eed6b9f04.camel@perches.com>
 <2a49e8e7-15ef-af4f-1039-b15ae60df11b@gmail.com> <20180627083306.rk3niwazi332rqs5@mwanda>
 <6221958a-f817-e01b-7e0f-adbbba9acde4@gmail.com> <20180627131158.xttl27awxie2w6ia@mwanda>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 27 Jun 2018 19:14:47 +0300
Message-ID: <CAHp75VeEUFEn5zih+2hntU7GCxx7U5rW60DMjRBRNo2EXhSdpw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] staging: rtl8723bs: use ether_addr_copy() in rtw_macaddr_cfg()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Michael Straube <straube.linux@gmail.com>,
        Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 4:11 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Wed, Jun 27, 2018 at 02:56:00PM +0200, Michael Straube wrote:
>> Should I add a thanks line to the commit message:
>>
>>     Thanks to Dan Carpenter, Joe Perches and Andy Shevchenko.
>>
>> Or would that be considered as too much?
>
> You can write whatever the heck you want...  :P  No one cares.
>
> When it comes to credit, I do appreciate Reported-by tags because LWN
> and employers do count those sometimes.

In some cases Suggested-by fits better.

-- 
With Best Regards,
Andy Shevchenko
