Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FCAC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 16:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80722085A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 16:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="DqOhg5H3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfAFQi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 11:38:26 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35199 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbfAFQi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 11:38:26 -0500
Received: by mail-it1-f193.google.com with SMTP id p197so7323543itp.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 08:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9fKOXZmZaAuNdkRVPkkdhPP3kg3nSrVStKK7Eq51V24=;
        b=DqOhg5H3elUIYHrr6JeTwXBXnKNOCmqqLKG/4SEknweujSlRllofnEz4nA6eYdMWCM
         tA35VDHdD61G8LS82Ty8sIUOx2FtSXD5yw+Tjphq7QT19spKUP8B+bDNsnZcfDhFBvif
         NbnKxPs+rEnbSaNk6tSYQjTsyQ+FzM1XDKpgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9fKOXZmZaAuNdkRVPkkdhPP3kg3nSrVStKK7Eq51V24=;
        b=oJL/mdoE/cJkkXiPT+wF+3OIULw5QuwQ0tLcPIEGYMvpqhnh/f7ADZih+xcedZ/xVL
         KmuKF5PpNIONwFGXaD2bWIj7XneFy/ccQcWhZJdHNNE7eY0A7sVAu+hr7sY8iJDvySeC
         iP/7/eGwn9rjfaXoAMdmCwk+gQ9ak1Zhstq6uC45rNsi8itK4QagkV1IZ3KELvyqRwgD
         CG51DnjVme0EBBfi1DicDrEhJItgsuCGM+LGGOKLgb6qMWkms05fHBb5AVDWhkO1FS2P
         D1wG9wn9FYC7AV7TZDGqGh5pOpvZQOY9DE08MT5RmJwE5xVpcF0hYemTSAxdoJMJEczC
         T1Aw==
X-Gm-Message-State: AA+aEWbLFadMnkuBIBXGyyLUApLKk/IfOCQ1bpOsYYpmBIX0E83Xyayd
        pgLl4cbJRE0NgC0mjHz7yMP8FyN09s960cyw7yljUA==
X-Google-Smtp-Source: AFSGD/X6AkCdKzRpx6IMzyB1HuiN6N4hzCfPIxzAzb42HpVRUMmhl2iX1bPac17w1slhzby1FvyXOlpB21jbTuMXcgM=
X-Received: by 2002:a02:4d99:: with SMTP id t25mr40927139jad.58.1546792705377;
 Sun, 06 Jan 2019 08:38:25 -0800 (PST)
MIME-Version: 1.0
References: <20181215151802.18592-1-jagan@amarulasolutions.com>
In-Reply-To: <20181215151802.18592-1-jagan@amarulasolutions.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Sun, 6 Jan 2019 22:08:14 +0530
Message-ID: <CAMty3ZBcXOm5VOU5WqrhdfgH=i6x4rUP4zbTsiv9BjoccJUzwg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] input: touchscreen: Add goodix GT5553 CTP support
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2018 at 8:48 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> This patchset support goodix GT5553 CTP.
>
> Changes for v3:
> - add cover-letter
> - s/ADVV28/AVDD28 on commit head
> - fix few typo
> Changes for v2:
> - Rename vcc-supply with AVDD28-supply
> - disable regulator in remove
> - fix to setup regulator in probe code
> - add chipdata
> - drop example node in dt-bindings

Any comments?
