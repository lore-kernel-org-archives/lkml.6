Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DAEC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D25208EB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="MAafkxJJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wx4HdIgT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D25208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934135AbeGJPVS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:21:18 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:42899 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933475AbeGJPVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:21:15 -0400
Received: by mail-vk0-f67.google.com with SMTP id t4-v6so12559860vke.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 08:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=jWFopfJDv+mdr2UdeP4kIAxu78/2eVmy3vV1Q5wpTiE=;
        b=MAafkxJJ4cvjg53Zj2Q4Kk8+Gm2OzqdgtaFh5/9LuNP6DT3VitPHQnalEdphfwIT0F
         OsRXTUnwvxgJ7LPoJR1v1YgcjDYAI0SydeXH8fdZtYmYP7sD771OcJlEB9OalbdD8vfM
         nMZOLhXoalcoecOjd2EonJ0BQkdHzdC2mkLSXDa6WRa87gvecAUmoCRu3cR96R54Dfmw
         Nlu5M2cUwZIKaYNOWLR7hVPzmacgtfgLv3omu6rfFVQTKEpOkuo6nf+AfbcV1m6OdRAX
         oEnBB2s+Jxvufnfuy/vDr4A0/FIxsL7YqSiNuAYaCldnBKZFDYbmbEbjTURxoAtfGqIq
         p2/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=jWFopfJDv+mdr2UdeP4kIAxu78/2eVmy3vV1Q5wpTiE=;
        b=Wx4HdIgTr6kEdIsWXpnubX73XrCKEwWAXJA6MWKKqI3Hgf64fwBKWL3nr2AlC8uBmw
         N7tBTd5XpM5ZE9cDFMqmKOb3bxBlJT6cVQYqdRdRbuD7aFFrfx2Rm933nXaiE+P+/GzF
         a7lYeEA3ZBBHF9kNsFayUiJaIojXQGutUrMqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=jWFopfJDv+mdr2UdeP4kIAxu78/2eVmy3vV1Q5wpTiE=;
        b=kb64nlxpsGdk+y3Zr+RfkQwxq85pzLkyUzBnvaLLM8MeM3An0NDSRUrhli4aQ3/IwA
         u91jeXapCjMrxcLBPboZcq7/CcVDUFcT57MuX72uTDBtnN1+mWfGfYICfB4uFQTYXh9b
         C6flhlT5TKqiU2l+MwXo1waz7M/oWkX0JgZunmGkMDr504j1rYpLeeZqM3PaL3AUUUVj
         zckI5vyTb0vbfXOk7tboIFl3QEIVDENROlsLURuWvQgNP7hHLqtc1v240oaGgz02jHJb
         mEoy93BafnCcgJJhktmTFGiPX4tjUVjBCknZpUU/VY5tM6Nua10ymhNc4gfvcAfRjlWT
         Yh3w==
X-Gm-Message-State: APt69E1erzvbr6bSCBOB43SXgieNUbJmDRpQTz29jI36oZrwf6AbbWXX
        Y7bpIMK34K/6MDd3KEdzUtNv9fomItae3xMzwwfBYg==
X-Google-Smtp-Source: AAOMgpcnqWLVwqR8faQjGqIwfu7kxYMYFL7vpAZx3Xr7pAZM3uuICRkcvG0LiqkdfB8LejVg+8QXq9Q1LHFIh5b/xAc=
X-Received: by 2002:a1f:7c4:: with SMTP id 187-v6mr14293922vkh.60.1531236073566;
 Tue, 10 Jul 2018 08:21:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 08:21:12
 -0700 (PDT)
In-Reply-To: <9a64fc45-7722-8650-99cc-a939132e252b@i2se.com>
References: <9a64fc45-7722-8650-99cc-a939132e252b@i2se.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 10 Jul 2018 08:21:12 -0700
X-Google-Sender-Auth: F9Deh8ALSsXLl5sCRAfJBmRYjrw
Message-ID: <CAD=FV=WL5-faArU=1MAbLHGCNUw5Fd_A_QZC6BTwEr=mO6EmMw@mail.gmail.com>
Subject: Re: [RFT PATCH 0/4] usb: dwc2: Turn on uframe sched everywhere
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Bruno Herrera <bruherrera@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 10, 2018 at 6:57 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> Hi Doug,
>
> since Stephen isn't BCM2835 maintainer anymore, please keep me in the loop.

Sorry for missing you.  :(  I wonder if you should add yourself to the
MAINTAINERS file as a reviewer for dwc2 so you can get CCed always?


> I'm not sure how to test this. Is there some kind of test scenario (don't
> have a USB analyzer)?

I guess it'll depend on what USB devices you have sitting around.  The
more USB devices you have plugged in then the more likely the dumb
scheduler will get things wrong and a device won't like you.  You
should also see significant compatibility improvements when you have
low/full speed devices plugged into high speed USB hubs.

IIRC when testing I did things like:
- In general, try to have lots of things plugged in.
- Plug many different keyboards / mice in.  See if keys are dropped /
mouse is jerky.
- Try USB audio (ideally full speed, not high speed).  How is the audio?
- If you're brave, try a USB webcam.  How is the video?


If you're trying a USB webcam w/ dwc2, maybe add in patches mentioned
in <https://bugs.chromium.org/p/chromium/issues/detail?id=820961>


-Doug
