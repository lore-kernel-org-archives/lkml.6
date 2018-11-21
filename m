Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A208C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B4121479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADjFgsMg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B4121479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731491AbeKVCR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:17:58 -0500
Received: from mail-it1-f174.google.com ([209.85.166.174]:53684 "EHLO
        mail-it1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730072AbeKVCR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 21:17:58 -0500
Received: by mail-it1-f174.google.com with SMTP id g85so9472914ita.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 07:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bLsQBfC4pfKISWF4T1GdkUZew4N7rTIcNd4BAu9dYEQ=;
        b=ADjFgsMgp/q/zQFIVr0l1WXZQ0Pv0c4sEx0uO1zpS1SRhb1x8o4avdNzpuo7kHT8/W
         KkMZeSxFnqclQGR7jYOOaRzErl/ngtXwsxJuW2zbn1yXhE9cNz2RQo9byRTNeV3nyt4q
         WdT7S+LAQkU4UrllS5/9kLI4oBSCtGR3tuuVDA/MUD5TKLKx8etkdpBn3lsdRpZROn1l
         cwxSx8e+jxgTgu2fk+am/Z1i8IR4HkwJTeADEXtQ1Wh5cZa+Yy25a2z+GUPKlKJ/8n3W
         0sE+7hyjX8TF2FhIjjdbtMaRUnRgvoeuLk+QRfQ7XwH7ZAnaSQWTdFWMen2jH95Tx3lS
         aiyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bLsQBfC4pfKISWF4T1GdkUZew4N7rTIcNd4BAu9dYEQ=;
        b=M4OGNp71j+yLbWqxXEUuSTi4Xol/yjvrDh3/cSd7vCO0oopNLMRaiUtlgqtxUA9ZJ4
         /rxE5Myirm13T4uArVQhea6wZ/AIluUpcTs4f3TKN0ycbKQCJeHMtrh9x0IW6waHYbyk
         enG5BVphQZy+rD2PlVxmlyFuaQmQCfcgDDcwdvX0DTBHqkf9n3ZVlTsKd3lFdecLym+J
         8Jjj7b7z6hfIBzziavLwVJXiVDYQhhIWpWPOIASZOaRjC0ni2Vw6iy/9YnjcWPRDt0vH
         xrcoIFaeq33uo5LtZpapQjjL7r6YyVcYXY8nvt6qNpJY3x0L1yZinTn0m5wrIrCdzuMM
         jaPw==
X-Gm-Message-State: AA+aEWbZfu/M5KnhOLK0nSaRluN5SfFRufJgTHVOye/1wKQxV+yaRxuz
        TSvxGyzHbV/2x/iabgwMcvQqnjqxjJ0Gfxg0gII=
X-Google-Smtp-Source: AJdET5fJvBYOE0NUl14oP0LnY/Ewvt8z/whI+1fAE2pDLG19NL7tZjWGU6xwql6lqpgsiFnCPB8RqIKgxbMEPQhgGE0=
X-Received: by 2002:a02:9b74:: with SMTP id g49mr5964199jal.76.1542814980791;
 Wed, 21 Nov 2018 07:43:00 -0800 (PST)
MIME-Version: 1.0
References: <CAEAjamud-6uX8EmOZy7s6ubWNg=0E1YQZSGK2-SnfsomK8VnGw@mail.gmail.com>
 <CAK8P3a2SnRF9198W4W81WwzEX6yCKFjBLTtTo+97Qcym=99Akg@mail.gmail.com>
 <CAEAjamsAOJC_EqdX8nTddhN4Xis3d_D1L54Ry3sBdC8L84EdVg@mail.gmail.com> <CACT4Y+Yih790PN6UMOLcZdL930TA2Xmnr82DULo0xWbu7SUpww@mail.gmail.com>
In-Reply-To: <CACT4Y+Yih790PN6UMOLcZdL930TA2Xmnr82DULo0xWbu7SUpww@mail.gmail.com>
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Wed, 21 Nov 2018 10:42:49 -0500
Message-ID: <CAEAjamt78J_ei=X2v7837ce1sWiK2trDGKJ+9dSLFg+wfusHbw@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in write_port
To:     dvyukov@google.com
Cc:     Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org,
        Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        syzkaller@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ah, I got that. Thanks.

Kyungtae
