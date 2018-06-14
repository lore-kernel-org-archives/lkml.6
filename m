Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 11428C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 09:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADE7208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 09:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idBTBfYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AADE7208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754834AbeFNJjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 05:39:41 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:41642 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754571AbeFNJjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 05:39:39 -0400
Received: by mail-ua0-f193.google.com with SMTP id a5-v6so3668952uao.8;
        Thu, 14 Jun 2018 02:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SynObiqS5YLv2KIqaqiENDnVws1Gvk/JzSHGiwNG0Ro=;
        b=idBTBfYjUMCUa1RfDrJT+cKMa8hiQnNCuE9bCJGl8KFCrK3OVe88GpBYhPHo/J04Cy
         nHBK5QkGNlIMFPT+WWElJRVD+Iaqs0cJdAFd/mtu7SMaBr5wjpIKDZiZrKAYkAN8phWR
         QYfuOIgXfSbobhOtilU7XZU/NkyHkLSVe+cg/W9urgQDHPOYDwzjJkNfFAqL+LQp3tP4
         43+e4TyL+UI3v9nWf0ormPqfxqjwdFbmZjDeX8BGo6y4gUExcKsYrTWERDWz/PqVLpPR
         0j4ovr6/DJbVObdq3PMWKwtT6oOZvucdTffylP1wsJh1eGJR36Y2W294qW0sFQYM1MbS
         31GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SynObiqS5YLv2KIqaqiENDnVws1Gvk/JzSHGiwNG0Ro=;
        b=KZJmlKIpIwjSikUAEKQirXrz9E534n+KaUywN3TnGgHbsizjcHp6bqh1bC5ldWguVW
         /J0uNjnl3DccTp09bdTQ2Xluyfu9yBk0HghGJwjy51wDCDw3TppGLdZlJObPWN17/jfg
         YEA3cM+NzMlgvK6ZpEsWlOV6c4rOAoOIPMa0ag2ZLW82O3g+3wkxHaKn9D1/MdvCpCCJ
         VMJIw4Rh44KWVnuMWzHaGyGhyAAmcEmeC/Y7/+r34olBInSwgGTb+eGZICkQLiCYKr8J
         Jv179ijT8q1wA0YuwVuY+MH3Tj1M4nD5iWxipjDN1s2nCO/efUADcUUss+2DZj3Qm/v6
         3sEw==
X-Gm-Message-State: APt69E3Qp0EuCwz/wfvITMhXlLjgy+s9FuhVrlaerY0bnzETlGpP4RTH
        /+LV3fys5VnvB3U3K5p3MxfUwYb/mSZbCB7AXIM=
X-Google-Smtp-Source: ADUXVKLxkS4it1jy1kg2mJB1rYmJbMcI7WJdiZnHhdvxZ1xpIIWK4GqQGVjiwiT8fnCSacLHWcp0dok5taK+34EloMM=
X-Received: by 2002:ab0:7089:: with SMTP id m9-v6mr1127834ual.141.1528969178553;
 Thu, 14 Jun 2018 02:39:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 02:39:37
 -0700 (PDT)
In-Reply-To: <1528968207-48671-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528694152-31724-1-git-send-email-jiazhouyang09@gmail.com> <1528968207-48671-1-git-send-email-jiazhouyang09@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 14 Jun 2018 12:39:37 +0300
Message-ID: <CAHp75Vf7tbfR5eN4JN2Dph_2qzA=eU2r3S5BfRLH6=vN1+U6ng@mail.gmail.com>
Subject: Re: [PATCH v2] pcmcia: add error handling for pcmcia_enable_device
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 12:23 PM, Zhouyang Jia <jiazhouyang09@gmail.com> wrote:
> When pcmcia_enable_device fails, the lack of error-handling code may
> cause unexpected results.

What results?
You need to elaborate this.,

> This patch adds error-handling code after calling pcmcia_enable_device.

> +       int ret;
> +
> +       ret = pcmcia_enable_device(link);
> +       if (ret)
> +               return -ENODEV;

And why not to return ret?

-- 
With Best Regards,
Andy Shevchenko
