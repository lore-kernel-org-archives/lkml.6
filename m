Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A927C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B310520851
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYB+cv/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B310520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbeLBUVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 15:21:48 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50995 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbeLBUVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 15:21:47 -0500
Received: by mail-wm1-f67.google.com with SMTP id n190so1240683wmd.0;
        Sun, 02 Dec 2018 12:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w/Tn2YECOYLdfMEiBr4ujWavCmFM5oRmXmwoa0b1SGM=;
        b=GYB+cv/PCNHI+RJass0Fq8uX6z8pBcuoKIl4J3w9EvZBmnT++5mvIXpRwjaRUsdcF+
         tjUVwt8VxRm3boA62U7XvzxZCl6sHJl+13yN40QUFPH/qbONxBSffFHXLIStauXV/kTR
         g7B0wkUgru7PpD2J5iU8Eipp+pkiH2UjTPZFmL8SlgLHKXbA9cYAOPcSF9oRTqdBUbjV
         C4FNXIoaoJ7+QZV8QyfuQ9+40TZDAplQW2eBJelKTwqus/W+zcBwokAuSPshKsXUAkwE
         pt7LxC7dN4rhMQPRkqqInTPtbg1j7NZjadRWxKIHAQyv9pn05rM+HhH6XcrXqEZ3C6om
         Rxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w/Tn2YECOYLdfMEiBr4ujWavCmFM5oRmXmwoa0b1SGM=;
        b=kyWFJrWketirwsLE1RdoQGFXLlGIh+/EQxYmYfHmjHmUzSSKduBCXs6I5em6O1NWl8
         swyITeW1yLf6NIn0tubmNSEtkVjmUblGfyfzN7/30bhXgpnPagO4uZ8I0DbrpMi7UYEE
         qp3d/IwSbXfv4svDKDtlNIHHbVe3SJA0UfODWS/cB8cDS/4vH+Tgsqy3HJurdfaPS3y9
         5+9Jc4bidh50ubmjMhRW0Gtb4gIhuMUusiBEIl2GfEVAQCyjhW2WIjY1lnhbwjbVILWz
         rPEoPuhI4UR4lLbK96ODneO+XV7uZ06awBtzJlaHU9uJFizIaSBL43wYvRYjIUW/pNyz
         8NUw==
X-Gm-Message-State: AA+aEWa2t+s9lpB/dyzcorgCbOYaw09Y87MLZlvck2ugsLYg7XGWEihG
        mGDR9YfD9NRAvaJ0cwMQewcXQDVv0eZdlaMyzWlOaNk8
X-Google-Smtp-Source: AFSGD/ULQpV21E/caSObsqz0pcfn//yNn5s44mrSGzXqHQTEci9yYCThF6VII/+bBEZnvLkIk6krKQWAFidHHYHZeSI=
X-Received: by 2002:a1c:934b:: with SMTP id v72mr2441158wmd.5.1543782101602;
 Sun, 02 Dec 2018 12:21:41 -0800 (PST)
MIME-Version: 1.0
References: <20181129135921.231283053@linuxfoundation.org> <20181129135922.602882966@linuxfoundation.org>
 <CAK+_RLmVyVzL3G6++xOxfyEqEHL=bfZZx_Yj-TFNf5a7_oUoXw@mail.gmail.com>
 <20181129160722.GA31919@kroah.com> <CAK+_RLnbpu+nYsr8sVpHBVUcATDbqQoeH=+tu=tK1EKTHk6L9A@mail.gmail.com>
 <20181129171038.GA4651@kroah.com> <CAK+_RLk4cxamNasZyvLRunR23CTR-fASvF3=Ryt9WGeFoBVtqQ@mail.gmail.com>
 <CAK+_RLmt0ba_ARo+SrOGJph-SPn3kBRybRqncki=Oqz1TcF21Q@mail.gmail.com> <20181202201335.GB4314@kroah.com>
In-Reply-To: <20181202201335.GB4314@kroah.com>
From:   Tigran Aivazian <aivazian.tigran@gmail.com>
Date:   Sun, 2 Dec 2018 20:21:30 +0000
Message-ID: <CAK+_RLnaPCXoBBpmCajui_U4_R6zMTNHFC3nLMsGCkY4hrHdkA@mail.gmail.com>
Subject: Re: [PATCH 4.19.6] BFS: static inode bitmap and extra sanity checking
To:     gregkh@linuxfoundation.org
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+71c6b5d68e91149fc8a4@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Dec 2018 at 20:13, Greg KH <gregkh@linuxfoundation.org> wrote:
> What is the git commit id of this patch in Linus's tree?

In linux-next the commit id is
d2e6681167c634cfc3558991b59a6f614a31d226 , but it is not in Linus'
tree (i.e. at github.com/torvalds/linux) yet. It went into Andrew
Morton's "-mm" tree and then into "linux-next" tree.

I am happy to split it into multiple logical patches and send them to
Linus, of course.

Kind regards,
Tigran
