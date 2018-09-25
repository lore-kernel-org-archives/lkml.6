Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C84AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9DD42086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TURFSwQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9DD42086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbeIYT0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 15:26:16 -0400
Received: from mail-yw1-f46.google.com ([209.85.161.46]:37759 "EHLO
        mail-yw1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbeIYT0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 15:26:15 -0400
Received: by mail-yw1-f46.google.com with SMTP id y14-v6so2033139ywa.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 06:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=lQmHbvvvQmbq8VE45ooOeGjmscSjfLtfq65PuUJ4Xqw=;
        b=TURFSwQq36UwqwjNz8lvkoECJUcMxJrZOqJUZK3rkiocYv00p+IWUpwSinaaoO0FI2
         6APqNo22jX0dYItPBzIVXVmv5ncQ3L4WDKk5e1nNY1zMZSh7TUTftnVwl2RpaSwC/ra1
         k3B9JqVWOOiQrCmujJp6+DvkN2TNodt6RiBaPH6I6L4UdNNSnMjG6Qc+fC9ednNss5db
         mdEaxCzZJBzvdZ3ochUpLdX0w87gR46xZeuXdU4gLi+N3ubsDeG6GqP4rQ9yrvOCG5C+
         Fa5FkAfUdugieFk32fcNACmiMlJsl3fE7iKOUiWmqyS0H12h7H7CWtujq+osHYjpDrkd
         PoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=lQmHbvvvQmbq8VE45ooOeGjmscSjfLtfq65PuUJ4Xqw=;
        b=eCCCTrQfnfBOYdNinCkPxapeMuYdG8EksY/rG3lzPn6T5r3kFO6UaelT+jAuMLs74d
         BZzKsjjfv4p5r6I78WmqkSuspoq0rrKWC7v/KlqftAMMgqmv2dtA+34O0wrr6VKS6eoY
         vFL0NvNIlCq0Bi8sqibeA4gAoknHaBRef3uGuMJj/JMATpNtSX/wcScvZk3m44CSFdwE
         YPhzKmRAXWVkHikdlegrS2M3eaqaVeIQxrAWrEgjN2XFCNuCqPvppnNeeV1xPIMiZaqt
         XebhNfe3nNQNGlfiXVa8GMCX3suqyL1WwrW394RD/7pnZVSkGCft7xERBh3erg+UFd/s
         1APg==
X-Gm-Message-State: ABuFfojoQDZdUuagLWPv7f2g1Ayi9/DOT6057BBTl62p8LJaf+1Px3z8
        4z1WLp0957NzaiFStIJzWJoyzarf48+qO87PDx7jhw==
X-Google-Smtp-Source: ACcGV62pF6nsOdN+uIAlnaMR7Wz0wNkws6nPS2DpdFuSOrNyLdNEQKfcs3ollB2cXTDG14s1DHg6fe4v8NPZ/ikSMx0=
X-Received: by 2002:a81:9e44:: with SMTP id v65-v6mr480383ywg.481.1537881522962;
 Tue, 25 Sep 2018 06:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAJUuSvGOMjjua_nNDp_cYXKLf3_7-U=3nvpuqT9bTMjKe8uM=g@mail.gmail.com>
In-Reply-To: <CAJUuSvGOMjjua_nNDp_cYXKLf3_7-U=3nvpuqT9bTMjKe8uM=g@mail.gmail.com>
From:   Ilan Schwarts <ilan84@gmail.com>
Date:   Tue, 25 Sep 2018 16:18:31 +0300
Message-ID: <CAJUuSvFurAMf29uACB3OeF6mY+VhWU1bQy_WgNLgZO8mHz4XjQ@mail.gmail.com>
Subject: Fwd: Where MAX_NR_ZONES defined in Suse 12.3 4.4.131-94.
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I maintain kernel module, till today, when compiling the kernel
module, I use to download kernel sources (headers are not enough since
i had to include btrfs code), and compile it.

In suse 12.3 (4.4.131-94.29-default), I downloaded the source package
(kernel-source-4.4.131-94.29.1.src.rpm), extract linux-4.4.tar.xz out
of it, copy to /usr/src/4.4.131-94.29 and update symbolic link from
/lib/modules/4.4.131-94.29-default/source to source ->
/usr/src/linux-4.4.131-94.29

When compiling I get the following exception:
/usr/src/linux-4.4.131-94.29/include/linux/page-flags-layout.h:21:2:
error: #error ZONES_SHIFT -- too many zones configured adjust
calculation
 #error ZONES_SHIFT -- too many zones configured adjust calculation

I assume MAX_NR_ZONES is not defined.
How could that be ?

The code for page-flags-layout.h line 21 is:
#if MAX_NR_ZONES < 2
#define ZONES_SHIFT 0
#elif MAX_NR_ZONES <= 2
#define ZONES_SHIFT 1
#elif MAX_NR_ZONES <= 4
#define ZONES_SHIFT 2
#else
#error ZONES_SHIFT -- too many zones configured adjust calculation
#endif
