Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=BODY_SINGLE_WORD,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0B5C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7728204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxkvChGu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7728204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeLJQfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:35:37 -0500
Received: from mail-it1-f173.google.com ([209.85.166.173]:52401 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbeLJQfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:35:37 -0500
Received: by mail-it1-f173.google.com with SMTP id g76so18257711itg.2;
        Mon, 10 Dec 2018 08:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WASiI+LGr+j54QgtHqz/Mb0c0vmWaC6GIOI+FQCQgEU=;
        b=kxkvChGu2Aa6vfGw4HJvvp6zTyflCwAqjvhF6wwpOw6/JW8yY6WlK5oFE9bGm9U1A+
         fI7vl4jWTnqAB/QqRaQnq/bKOsZCEZ29cokg9LV+FjIEIiEkfBbbVsQRRfHbMyOSWzPX
         +cRU8c3nVaMKvHgA5FhmUHiw4UGGnT78XBKmOMqKpt2AwvPymF0kJDKr1GkBobYcilW4
         8Tdjli9JlznjftkaZpda8fz5CAwTcCb/+el/xwPKQVMbMvopjboU29o4BcyaiYujNMm/
         OKkIPdDFX74TYehAMwPuAzV/yCQ0JjNQth2+8tlEXSmnv9kzrcfqxEtrD2yZnyYToDBj
         Mzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WASiI+LGr+j54QgtHqz/Mb0c0vmWaC6GIOI+FQCQgEU=;
        b=gjcYWohWYOJp7ppDiLwyqo/jV1HegNTeItOaynNGn0v88Qoz3r9loVEVWQYIQYHK3+
         vvGwPmiX255lLKa9LfZyiKbcgqrnZsDrOTstP04mq0lK5jhYE+tZW5QfJakzSjhVcDIy
         H7oqhxBekdXz7m/LuO1QXxqyy4p5j2/uFaWFOHQ1BEEJ3TSSOTtdmH7TDZsf5TvVMFQG
         0mnBF8FKmE61aNYf4E3vUKSgp+fP6CmkY+GFS3GFHAb7ORTGE4tQ9MoKFufUUzU7Usbo
         xEwVxWEOJgMbgrDtdYmhm/dG4KsLuCBY1LBqlURKs2CXhWpWil8e+GG7ADfZU9wMeJ45
         RfjA==
X-Gm-Message-State: AA+aEWbW3x0MZVys31StE6eCAanFQTfRmCM0v6u0si9tJ51lITihrAgN
        RVFTpL9BkaOBqLhL9uvCggJZvNSkfbaiQt9Mst4=
X-Google-Smtp-Source: AFSGD/X7bZD0Qh6SURlHuPH2ln+cCafGj7e468wEoHMRMUGHYM9sPPPgOQET6IiEpN+5IioDR/fdWqLUC/YDWE5ySlY=
X-Received: by 2002:a24:648f:: with SMTP id t137mr11220288itc.95.1544459736033;
 Mon, 10 Dec 2018 08:35:36 -0800 (PST)
MIME-Version: 1.0
References: <20181105145619.6395-1-tiny.windzz@gmail.com>
In-Reply-To: <20181105145619.6395-1-tiny.windzz@gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Tue, 11 Dec 2018 00:35:26 +0800
Message-ID: <CAEExFWs0h_fxgJsJCDJdY7uCo3gWvNFSvuozMA0M617+=mULOw@mail.gmail.com>
Subject: Re: [PATCH] net/bluetooth: Change to use DEFINE_SHOW_ATTRIBUTE macro
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>, davem@davemloft.net,
        Kees Cook <keescook@chromium.org>, gustavo@embeddedor.com,
        dvlasenk@redhat.com
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping......
