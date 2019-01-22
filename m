Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912B1C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6147120855
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeqPQ+v/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbfAVOjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:39:44 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44391 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbfAVOjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:39:44 -0500
Received: by mail-io1-f68.google.com with SMTP id r200so19223941iod.11;
        Tue, 22 Jan 2019 06:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vxYB3g5/4oraKF/gXBMeD/r14yJFVuTmmUjkEMS2ZSM=;
        b=DeqPQ+v/2yDxKWA4c49zIKhI6EMcTm5VsEkAWFEb1TtpchxgvMnTUystbDNUM7BEtb
         cthqouqa9gwRE5qfKei4UeCWljLNXlJslI84jyhrhwOZvEQ54W6tLSk6v+nZPpGVYVBv
         +A0rLG4FBpmN6Ecz8817DULhUcSaiLLkpxu/iprB1K1NthnNxj3ccndy/cK3Mp7loT65
         rxOwHyQ0vi3iBy1Am3clcAFJ6rh0dTSGBaoNWewtfNzQ+a9vQcRsOnZxDmSzIpMA8THT
         G5w83e+9Dqtnsf54ZAfNVoUbpjchHkJJ2zvQQrxxBIIxZiCwcTBWmawa0YUtht0khmP7
         YD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vxYB3g5/4oraKF/gXBMeD/r14yJFVuTmmUjkEMS2ZSM=;
        b=sGwb7FBMHAdW0Qe68SkY9iKMpsRzDQoWMEzJPMzD+vJmqjCMgL/+vzNfq+nfYL/N88
         8h56xWmumogbccLb5FKrfcHL5VmIn9bDGr9a91WTjXCsTkvux4PxS8/oBce1Et273QwL
         W0//Jr+Ub6uA9tm7AALH1hN+wSLwh+qWObzCKWS4ii09adc5PtNXfeWHHjaPaDwVcm2I
         qnyRVLKXIOI55uEOswdW95Ypuwby5eYPgMv8AvdyZw4ciGsmuW9Ed61X111V28piQMkU
         Uz9Za3PZy2oXgGWpLBm9zpkNnSo+s47GNRnNkDPKveoNxoAXtzgv8craF6AIV6SKNZM3
         Fk3A==
X-Gm-Message-State: AJcUukcqwoIlOhHtr+Nz47VLzlwzQUt95tbq8xOy+ukP4/275YB3ApvZ
        2BDBSDJtyp3a8+WYjB+QqmHg/CO+u8h8Q9tkpDs=
X-Google-Smtp-Source: ALg8bN6uBjdWoTQDTmzkCRbrqA1zqp+2QNpvu3h0q9SXQeQ4DNbpVVmQAKS0tuQfnf0U5TJfaOLmtYeUYgXO7IfQWzQ=
X-Received: by 2002:a5e:8b46:: with SMTP id z6mr9324008iom.7.1548167983287;
 Tue, 22 Jan 2019 06:39:43 -0800 (PST)
MIME-Version: 1.0
References: <20190122140644.25535-1-tiny.windzz@gmail.com>
In-Reply-To: <20190122140644.25535-1-tiny.windzz@gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Tue, 22 Jan 2019 22:39:26 +0800
Message-ID: <CAEExFWuMMZrsq_fuWXtXcQ8ToY4y4EGWREdzJ-jG+GBjKPghWw@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: fix description of exit latency in cpuidle.rst
To:     rjw@rjwysocki.net, Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Noise, I am wrong...
