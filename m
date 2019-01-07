Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E00C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 00:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BC220838
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 00:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoZ0V5zj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfAGAi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 19:38:59 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34763 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfAGAi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 19:38:59 -0500
Received: by mail-lf1-f68.google.com with SMTP id p6so28988899lfc.1;
        Sun, 06 Jan 2019 16:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nZa/Nvho85XbA/ZmZSLG5tEI6qr0WuT3LvQi/6tqzsk=;
        b=QoZ0V5zjPcOc4KbEJUrPw8CZdgMeqYiqiiy2mpSGqWO2FoyB2c2hjqT4KqR6RKRc+I
         L/zr/xuvm3TfPEan6DgRysgUZvFpor78dbGyzBjwaPH6zT3Nvzgn4DSkVFf0kfdlvKPr
         ImHy76EP+cyfnSajd+ju77h++fEZElLnBwZRTxCQLkmWMgkvLG8BojkTKgnf2bCy7FeB
         XDwQ8+i3WlyeQffuDNU0Zp03NupDYxk9dW3WGbmufGlDKJHdxxERm+tkDhWz+KBnovlv
         2P/GnIEnhp68WF5Ysgrftx58wH7m7kr+7YipcflgLQN4JQ/vYt7oACfMIA69gO9mbiFh
         iL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nZa/Nvho85XbA/ZmZSLG5tEI6qr0WuT3LvQi/6tqzsk=;
        b=ZIen8D2rnohNE4eCPLrULBDNispuInBQWeKROBVVjaJJyNeOvUcF1wAoX43cy5qwhk
         nOcXTgt1M/fITAB7QF9YiazzLpdPkQe/mfDB8lrQ2psBZVzGtZg9U7rUoly9itiY40gh
         gcJvKN2kNrHTVvS4+KfUfgXXSrfhb2JKk2v4R4kfhGyTbJ46DREJCwj9C1pEkbDdgBg5
         Qs6DSFpZ8DKwOMzH13GTW0TbqUW1xKG9cbYXnjYPw+VDX4tbj2tO4Nxifi7IB7TsVf/O
         mr66qskOC3f574rbbtfsNZShA13Neo7gXeo2m9zta7/AUSZN285tU1zdqg9laA1NZqoe
         ijIg==
X-Gm-Message-State: AA+aEWajf2rkC+nORDc99J0mnFJyHt5li1fQyNGsRjymWFV1Qkb/umCR
        WvjweRKleNBh+aOSm23nF3oilcHeNOgQT+nxdog=
X-Google-Smtp-Source: AFSGD/Vabmp71s/C2QwdpD2bJGpv3R1Mkmf7OAvTmKysaS5qJwvXFFUXJlSUjb7cmmhYO2z/iv9w074oXvWmRrpsgcU=
X-Received: by 2002:a19:945b:: with SMTP id w88mr27957209lfd.15.1546821536551;
 Sun, 06 Jan 2019 16:38:56 -0800 (PST)
MIME-Version: 1.0
References: <20190105202659.20198-1-nazgul33@gmail.com> <20190105202659.20198-2-nazgul33@gmail.com>
 <CAKdAkRQKnH++VuL37EGBaFSMmFPvbpCkVkZLwuMU9eWo+KsaXA@mail.gmail.com> <CAEo1Rizj_HC5f+TWMP8ogrsXVhMDrxA+Nyo2h4KJJ4admtmanQ@mail.gmail.com>
In-Reply-To: <CAEo1Rizj_HC5f+TWMP8ogrsXVhMDrxA+Nyo2h4KJJ4admtmanQ@mail.gmail.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Sun, 6 Jan 2019 18:38:44 -0600
Message-ID: <CAKdAkRTL0dBMxAk7uUEexF8uXba+cr+POU5ysLv5830SMPjHzQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Input: rotary_encoder - Support key events
To:     nazgul33 <nazgul33@gmail.com>
Cc:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Daniel Mack <daniel@caiaq.de>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 5, 2019 at 9:36 PM nazgul33 <nazgul33@gmail.com> wrote:
>
> input_sync() is there, at the end of the function.

I know. Nonetheless, you need another one between sending distinct key
events. Userspace is allowed to accumulate device state until
EV_SYN/SYN_REPORT is received, which can result in your key events
being a noop.

Thanks.

-- 
Dmitry
