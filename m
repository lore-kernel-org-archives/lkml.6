Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A668CC46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56EE02082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZoQcuN5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56EE02082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbeJXL2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:28:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36560 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeJXL2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:28:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id a8-v6so3738124wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 20:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Lk6BMOJ3w1heMIGq+ajRWxWoPd+go7EsUKWg4lZJkH4=;
        b=ZoQcuN5v2zFSuGi618MnhCqX5Fum5MhE5y65X6o04cEkreGX/n3hoR25z17SJwCJkF
         HAz1HiaV3A4Bv9ibrSQ0JRBl7Z6c6u99bhA8hpAXxy/UYPS1hTmUA9qSvLQxNMkV58MR
         Stur6XbPRPzqMjrpPyuD5Xd0tQCA79Pn4ILdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Lk6BMOJ3w1heMIGq+ajRWxWoPd+go7EsUKWg4lZJkH4=;
        b=guIPUu/Ro0r+NI93WM0iI0c5QPKbEZE//knH6F1lPFG83vEBItrxGm7FyONH56RdK7
         RcolOKSP6wP6KBEaYkO0e0ErXVfzpntcTz8po9QOPZx+Xgeiv8PuUWeBQ5aJ24Z6HsEY
         G9kYwkFPfjJF5Me4iMb/7boBOyikkupN0ax7bBBHfXUKMWttFS0Pna5A2Qq+xak1jAsk
         dyqDeDhb+pH6S5kx9HTaMp3Tq54F4mGjyDEcPfKnLaIGm7nmmY5whqzhudAEKkyuyssh
         FctNB11Mx4iS6Ye9M/ftUvPiz3tS7Q8iO/sa47coHaPa1BL3+GVoWgfrtUUYWpNiVwQc
         d08g==
X-Gm-Message-State: AGRZ1gLVlmx2iK6EZ80ux/vn//F0SGfNGG+1puf7nFC4XodBZnaB+MUN
        xLpxozN6jwLWl7y2tU8Kl748ZuUouWbjqiGCHNadLg==
X-Google-Smtp-Source: AJdET5f1DrlRBAMkakZ8Zzf7FoFk3420ShpDlCubIX7uxOFE/4lKwD1WkItqY+QWElEN+BwNgq+m+H35VsIN9aWj8cc=
X-Received: by 2002:a1c:1452:: with SMTP id 79-v6mr600814wmu.31.1540350156751;
 Tue, 23 Oct 2018 20:02:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b485:0:0:0:0:0 with HTTP; Tue, 23 Oct 2018 20:02:36
 -0700 (PDT)
In-Reply-To: <yq1d0s0f4cm.fsf@oracle.com>
References: <1540254710-26936-1-git-send-email-john.stultz@linaro.org> <yq1d0s0f4cm.fsf@oracle.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 23 Oct 2018 20:02:36 -0700
Message-ID: <CALAqxLX7d8adR6x14EbdhySE1SuoeFwxj6BFG=zitUKZEs75Tg@mail.gmail.com>
Subject: Re: [RFC][PATCH v2] scsi: ufs: Fix hynix ufs bug with quirk on hi36xx SoC
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     lkml <linux-kernel@vger.kernel.org>, Wei Li <liwei213@huawei.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, Dmitry Shmidt <dimitrysh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 7:47 PM, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
> John,
>
> Thanks for tweaking this.
>
>> Not sure if this is the preferred way of scoping the quirk to
>> the controller or not. Feedback would be greatly appreciated!
>
> I think my preference would be to add:
>
>        UFS_FIX(UFS_VENDOR_SKHYNIX, "hB8aL1",
>                 UFS_DEVICE_QUIRK_HOST_VS_DEBUG),
>
> to ufs_fixups[] and then key off of that in the driver. That's how we do
> it in SCSI but the UFS folks may have a different opinion.

Ok. Yea, I saw something similar in the qcom code, but I wasn't sure
if folks would want host specific quirks isolated to host code.

I appreciate the clarification, I'll rework and respin it here shortly.

Thanks again!
-john
