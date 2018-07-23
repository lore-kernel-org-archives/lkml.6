Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8161CECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6D920854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QULyJg2R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6D920854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388453AbeGWRNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:13:08 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:36325 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388133AbeGWRNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:13:08 -0400
Received: by mail-oi0-f42.google.com with SMTP id n21-v6so2118408oig.3;
        Mon, 23 Jul 2018 09:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=/EYufqQ/I/P8f5wbXKbFYK5N25V97mlF3qS4IIFdvPI=;
        b=QULyJg2RBmK1xTHhK3hLxfQcI14Dm0wQ/3+eRbK4a9j1Tv5sLe5rSSVELkUNR4nWFG
         ep4GkXekTqE8+y6qBWPAcTMMjGtBALt/Yp3rSAyHCK5S61VDLygZyk9a37a1J0JFfts/
         hG6yv7TnBVV5LBHViNFBFrqIrNYQMtQqVdLOedJbs99T4zyGwNGqwWpLEYOl1I2WDtwC
         3au1eTdJfuVnRGEahr0L8Ndee6JlxDGnL5Hf2xA085WuXpiuU+pFGTZ3PZq7lggF/3Qb
         ugW7KV7HFcsBz6ucBrAVplNlym/Iiw0s+EoxuPAjvLM+3G9HzE/+wQnHG16iXiqN1Mq5
         1EfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=/EYufqQ/I/P8f5wbXKbFYK5N25V97mlF3qS4IIFdvPI=;
        b=UVi+eyGPuXBHwGA/aMR8RtqLhlpB69laflp8wLy3ytJ5WGbuMOo3LNaAzBaVJfCYgg
         mI4VKhzhdDu71pUv5yOyxp359SuJ12N2EemahTdHpfGggewfXsLuYLoRnre/KE8XzvEi
         vu//l8v2ZZH2s9V7KpT8Cxa2yYC5ZrJdTxy9pbVe9xs7S7RNA5GZfAApYvlOWaZTdFd/
         lYDcenD9LRQ63woZ702fblk3qQuM58pjlkTT15cTToycn/Pv9h0wqQgK04/Kok6grJj7
         Pk3j1x/R/EXbHZ3fk8rhJha6qYAf9ERNN/DOrJzWB133t2pcKMowX8V43h6srcSpyM+q
         hKpA==
X-Gm-Message-State: AOUpUlFISqiSWmVlX3ec81pzYsgvc/AqrXTcMjpEz5Vw/T1n8UodPVqx
        cXHGnzTf0jPuo93M7XRFK1N2IcDCABt9KJ6WWg0=
X-Google-Smtp-Source: AAOMgpeMb2hQWX6Nv/YSbtVOX11b20C73dzDG60hNg+KvMNPjeKeelehuAbtx9e8edZMKbE0FU6FxoqH/NvxmQnVCVY=
X-Received: by 2002:aca:eb0d:: with SMTP id j13-v6mr9881573oih.304.1532362273081;
 Mon, 23 Jul 2018 09:11:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:c712:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 09:11:12
 -0700 (PDT)
Reply-To: noloader@gmail.com
In-Reply-To: <20180723151608.GE3358@thunk.org>
References: <CANVEwpbaU5=wMT_iSh9XrkmbLvqKjx4+v6PDizamaY0gWvk-mg@mail.gmail.com>
 <20180723151608.GE3358@thunk.org>
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Mon, 23 Jul 2018 12:11:12 -0400
Message-ID: <CAH8yC8kT=OBjxX8ye9GYec5Hs2NORtPtf8e6DPxP8JiUH9BNyg@mail.gmail.com>
Subject: Re: Does /dev/urandom now block until initialised ?
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ken Moffat <zarniwhoop73@googlemail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 11:16 AM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Mon, Jul 23, 2018 at 04:43:01AM +0100, Ken Moffat wrote:
>> ...
> One of the reasons why I didn't see the problem when I was developing
> the remediation patch for CVE-2018-1108 is because I run Debian
> testing, which doesn't have this particular Red Hat patch.

Off-topic, I'm kind of surprised it took that long to fix it (if I am
parsing things correctly).

I believe Stephan Mueller wrote up the weakness a couple of years ago.
He's the one who explained the interactions to me. Mueller was even
cited at https://github.com/systemd/systemd/issues/4167.

It is too bad he Mueller not receive credit for it in the CVE database.

Jeff
