Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE47C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 23:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BFF52174D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 23:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gxZmYd5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BFF52174D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbeHUCwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 22:52:09 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:36087 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbeHUCwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 22:52:09 -0400
Received: by mail-it0-f51.google.com with SMTP id p81-v6so1803641itp.1;
        Mon, 20 Aug 2018 16:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jlWauHcZljJhDCg9RgVn9Mvfo2b0CXvZ4cRA7jgr9VI=;
        b=gxZmYd5nMwmxdfkA9AmISKEngvxYtD0doCb+A36ECsQrgSen+arVPmlFEN+8Ss9pZ4
         L8/ns9x4txmXEmtfd8W5HfsaasR383/XPssf50MKax58wx9kjDtBFsxrQndDnw9/beQc
         KwvmH5Toj8DSMoKbmeTJd3T/EDlel8NYaA9d0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jlWauHcZljJhDCg9RgVn9Mvfo2b0CXvZ4cRA7jgr9VI=;
        b=bUxZaWzi4cx3eqKN9B4wxDjs6TWZEAwUNI+fA98Vxum8KC7JPrcF4v5hc8MZ7ouTQc
         Y4Ls0oq66vSKEgKfibrwMUJOZ4s6exPEjn3JiBInedhOz9cHaVHckNYivAsQY12SWQtQ
         ihsjAyj/aiqK1aYcE1RORa7Hsz3RZvPzKMFjRPEB48mJS6xW8ZBBY+NyBYvFXnzK8Npj
         MZ8qaPYwt3LTQESfj7MH0rsvKy0Ib4xSrT43mVaYZwrodmHCuLZOg9hU2iG2WKLBDC4s
         5ZMrWnm1R655HCKaTwqNPJjhm4tv/1f0WRHgqmYyZfhtEgf/4dNPCGI8wGocLw/O8Kbu
         kTNw==
X-Gm-Message-State: APzg51C5vDxAqFhHE9SOljNyJnFr8v9OHitlftyuLqnIkJMGjkBp6WWa
        wB8A9jTnNj2KwSrVjP+x4YnGqUlz+lME6gcAzqdOcBCR
X-Google-Smtp-Source: AA+uWPw0g07wIm2Eb2Ce5IQlzdCAtWr/0sU3jF0cAI3CVhFp6WhNymLpdZb5ygVw3dHMnBCA71QR9qHplfOGsiB2KU8=
X-Received: by 2002:a24:61d2:: with SMTP id s201-v6mr1973260itc.22.1534808069376;
 Mon, 20 Aug 2018 16:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180820212157.GA20956@piout.net>
In-Reply-To: <20180820212157.GA20956@piout.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Aug 2018 16:34:18 -0700
Message-ID: <CA+55aFwgmjY-RRRsSZTHnzceuYy0ouAishVe934WOjVQ5kdKmw@mail.gmail.com>
Subject: Re: [GIT PULL] RTC for 4.19
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 2:22 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Subsystem:
>  - struct rtc_task removal along with rtc_irq_register/rtc_irq_unregister

You can still find stale mentions of it by grepping for it:

 * @task: currently registered with rtc_irq_register()

which should presumably be fixed up too.

That's not holding me from doing the pull, but I thought I'd mention it.

               Linus
