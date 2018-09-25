Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891B6C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9112086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxNbrpeJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9112086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbeIZBqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:46:11 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:39514 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbeIZBqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:46:11 -0400
Received: by mail-lf1-f45.google.com with SMTP id w21-v6so7094341lff.6;
        Tue, 25 Sep 2018 12:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=foqvTCNPPkgzU4i5dX2uQicuHk4TPkT5PIa7C0neMI8=;
        b=FxNbrpeJuxXwhplhPJ/gFdwttc+hBmQ5QNW/T5duq8pxwnvcbmICEt3XveUvJO1xlO
         deMChPDEaEvdY2qSKU/6Y+DCxxsmZikUdqTaU0k5H/0leNpSbV7V38vvH0kKztAfKruK
         JyfQENIRadGVLerSgXgsFysLU73C1gOKgc293vQM4Rbj/+ooDKVjXhsnlEj+sJ1Ydo9w
         BALJZKtP3UcLfNIOoRcgtysaQGDtkLDSKFCkY7d9GUIF+YWGTRiE4A5V154sYl3tYOWX
         M5IiSQSErTj8/rW4naLziYyeBtkwcRsHXyun2v81TaWS+1IG/NIuORSwqLa8jrOBfgQi
         wMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=foqvTCNPPkgzU4i5dX2uQicuHk4TPkT5PIa7C0neMI8=;
        b=PB7vyJcO9NIigqfEZhGDOd2dGjP7z0oBBcSm5KFhhcS7RBfrSbcsWIZd45KXinFlve
         Ea5dHeC1S5rwtGReUjwA1EREvUsS/Qgb+psOVZtlofr1n1Wg+d4ulXcFpompo6peO+ql
         DPaOgt3TcXHSh8Ez9SKeSsial1HDi81QNOL+QpIbI9/PlTx+wL+aor+HFu0iIZ6QKZ0S
         8CqPKMLnC07s1Z7LvQQRtM/K09tNt7XFyOeWRR9CQwMrUi/HPYpBJ6RKr/wHiQbK9eJD
         6GRCn2I5IQwAeoHs6xSA5An/hvyivMh39fHqHtYk+i5cv7OICJydbjga9yfQ/9Zkt12e
         V3SA==
X-Gm-Message-State: ABuFfojArnps7aBwSKj8QD/iNHkqCBWr65jFLXubI+GEwIqTlHN1S7UC
        cCmSff+q6UmWs230m+cyrdmIT3my/w10vXkHjmCWoVQ=
X-Google-Smtp-Source: ACcGV62S9j4GxjCyb3F/marjk4enLmjtp0jZFzZuHd+JAL+yVpXLS4sBHEFk6bk8ef+AagPQGaFxQ4Q/O9faw7ipf/g=
X-Received: by 2002:a19:dd8a:: with SMTP id w10-v6mr1850212lfi.97.1537904223729;
 Tue, 25 Sep 2018 12:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <332fecce-3fab-1c92-1558-67a1d90d6372@odi.ch> <680acec6-f610-7f9d-5aa2-a03e878354d1@gmail.com>
 <4584fb8e-32f8-7375-8481-fe35c3cf693e@odi.ch> <9fb89abb-917a-44b6-5dff-9c4a0ed1fd6b@gmail.com>
In-Reply-To: <9fb89abb-917a-44b6-5dff-9c4a0ed1fd6b@gmail.com>
From:   Gabriel C <nix.or.die@gmail.com>
Date:   Tue, 25 Sep 2018 21:37:16 +0200
Message-ID: <CAEJqkghQQhv0vy-fNdM815CPu2CQ-giE26ewNkfoT6Jjv31nnA@mail.gmail.com>
Subject: Re: r8169 hang on 4.18
To:     hkallweit1@gmail.com
Cc:     odi@odi.ch, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di., 25. Sep. 2018 um 20:44 Uhr schrieb Heiner Kallweit
<hkallweit1@gmail.com>:

> As I said, you could try running 4.18.4 instead of 4.18.8 for a while (if you have this option).
> You faced the hang roughly once per day, so after a few days you should be sure.

I don't think this will fix anything.

See: https://lkml.org/lkml/2018/9/4/174
Probably all broken by  4fd48c4ac0a0 ("r8169: move common
initializations to tp->hw_start").

BR
