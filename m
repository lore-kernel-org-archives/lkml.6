Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C23ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290E320834
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZC2LVjuM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 290E320834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbeGQSyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 14:54:45 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:40444 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729759AbeGQSyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 14:54:44 -0400
Received: by mail-yb0-f195.google.com with SMTP id y11-v6so794046ybm.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 11:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QekXu42nSzxgtYHw+g9xnFU/DZRFNb6TCl9z8dMDjxQ=;
        b=ZC2LVjuMeqQEuUz97R/XGJdiCuXtxXQlK1NoP1u6UgFpNvQdGp1fXZJUO3ySvWIp7T
         B+SB5Lk3oPBPF+NQGQYMtts6fzuwtyLHKpxgJeUWFKCz9i5jQQl/31ZP2st5A2t7qFbF
         g2V01Z2kZDDrDBR2u2aqZ88iIfmKs+FpgyUKoQWWRUqDzd3z8PdLpwWsmHeJmX7XCLPF
         k+z+4GGmEQLBL12RdICFWBOBt+byE/uiY8nl8pQNfRfkonPSX/+b0LLhQVgrGc2JV0Yt
         7p+mBYY+450fZzd8klh9lJtlLB+B3XKJf2uMaJEc4dyr/WJjrQumw41Jg0Tf0mbDc8vw
         DA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QekXu42nSzxgtYHw+g9xnFU/DZRFNb6TCl9z8dMDjxQ=;
        b=rC/Z/IZH0nbbHbWm4U0u308Tp5HPWzPkhtq3k+GKxD1jvkShokrKyS2S7YYckHI32H
         qdJol9sG3/W2GlF/wpeLIbs2Lxer1caW+nZkCGFnRJtLpY0pIPy7JZ9qojJUdGK/h+/W
         KGGtsDLCLjjSiUS7RYYLufvJmoedTSVk5GkaujP+/xyJSlmdbqQOcyMaXDzQZwdt88dt
         QxwqppwAj3sg2h1Jj+Hms6SGvBjbEq0SAmUOf8IgETiaeAF2WVTMlT1v2KNkJxAuQsIP
         /sddQlzijUlOUvhyW23hcnJqv+OMli4Jd/V7b+HDYsVR51WorbMMnReov5LZLHPv7kxr
         ydVA==
X-Gm-Message-State: AOUpUlGBLyyhJckcaELPO/p4jCHkePaI7ADvMsYc1BpHqEF3c+u4n1Vz
        QJHUkr4jAhDJw+W3mtEKUKoG7ueOoKVCHfYMSn8=
X-Google-Smtp-Source: AAOMgpd/omPL7SzO4voU+FzGaiafflitazxr+SD4PGJBMInFGJKgAWvIWIXAFgEPj8acDby4aycWznblQPQJTo64xbM=
X-Received: by 2002:a25:844f:: with SMTP id r15-v6mr1492088ybm.345.1531851653950;
 Tue, 17 Jul 2018 11:20:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5e42:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 11:20:53
 -0700 (PDT)
In-Reply-To: <20180717102634.rmywmcjzoelok3b7@mwanda>
References: <20180717020926.176408-1-toddpoynor@gmail.com> <20180717020926.176408-18-toddpoynor@gmail.com>
 <20180717102634.rmywmcjzoelok3b7@mwanda>
From:   Todd Poynor <toddpoynor@gmail.com>
Date:   Tue, 17 Jul 2018 11:20:53 -0700
Message-ID: <CAO3upoYCS7yQAKTXQmjgjOBr3T9jff4KhpwTqPZLHJ3Miv=8Ug@mail.gmail.com>
Subject: Re: [PATCH 17/32] staging: gasket: annotate ioctl arg with __user
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Zhongze Hu <frankhu@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Simon Que <sque@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Todd Poynor <toddpoynor@google.com>,
        Dmitry Torokhov <dtor@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 3:26 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Mon, Jul 16, 2018 at 07:09:11PM -0700, Todd Poynor wrote:
>> @@ -629,7 +630,6 @@ static bool is_gcb_in_reset(struct gasket_dev *gasket_dev)
>>   */
>>  static uint apex_ioctl_check_permissions(struct file *filp, uint cmd)
>>  {
>> -     struct gasket_dev *gasket_dev = filp->private_data;
>>       fmode_t write;
>>
>>       write = filp->f_mode & FMODE_WRITE;
>
> This should have gone in the earlier patch.  When you spot something
> like that then create a separate patch for it and use `git rebase -i` to
> fold it back into the original.

Oopsie, thanks.

>
> regards,
> dan carpenter
>



-- 
Todd
