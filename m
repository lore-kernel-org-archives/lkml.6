Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713C8ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D6B21526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="em9qSurk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27D6B21526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeJQW2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:28:22 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38819 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbeJQW2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:28:21 -0400
Received: by mail-ed1-f68.google.com with SMTP id c1-v6so25093651ede.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 07:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=DMgQ/maA/W01C2Qk1lwRzEfq7E6Udy0JoWiBnxbLTa0=;
        b=em9qSurk0Lqyw4kT0zt8OoIioI2A4A7e4ELIrOAJpTPbyxLvBQdkrmWSIlXWFIVQli
         RsAiWtErqmA+Hpg4mRWAuUNBRgBoqWu9wDJduR4zkuUk+e1Hdxz3iTeAudqLyoJVcl+O
         3KWUdPtLmeLJd3/Ctj90xobVhajbL9kVF4aESE9hOii+keFS4thnQzaJRdWA0Hc/+7KV
         rUOvuMGqKq3Hqt4niX2NHidGi9852+LGn646wA1/32xFFvpb13Kxm3l4VQq1S94knwLq
         jmNzFjFuM/dQQt+l6rwoykUN8Ncq0lhq0oPx7h/8Zg9xpvGv6ri1kniE9bHLooNbfqJI
         lx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=DMgQ/maA/W01C2Qk1lwRzEfq7E6Udy0JoWiBnxbLTa0=;
        b=YmutVgfrHVDhfV05PD6Il9KAVl/rjALf60gPAkF3jyb8R2OMeawt80+Yc+/JKH7cL+
         /2U3CqxQI/Nq78z2sJiasMq8rTlJ2aQg9EloBU8hmxbaHHtWl1GlTbHvzYP/JCJKnE8i
         QeY6lrcQvcXEZQ3sW3ruab0ZREOVaZ3kVm0X6Iw2gYQciDayX/mpJ26/cmodrcKyczMl
         ewSaGZyBdkOcA4uzPgMZpE2qVbQnAdz2E1Hb2+C8kBVAS4qHGCXnEiOUSFuexgl5/XPH
         +uUM9M8vsi6dK47X9/pE2siTdVnj1BEd4xeqjm9NxaVNzD+cmjulRLhTsslMnxe+CzaH
         r7lQ==
X-Gm-Message-State: ABuFfoh5I6aqzwbd7S7+nE0AlQj/luQKql4PsQMAR7yq2Y2J4aO5PHTm
        /ckVadeo91ki+gjrCEfqUZwpxIAuiGkQGmvxq7c=
X-Google-Smtp-Source: ACcGV63kD80DZLkausKjdxXnsSEBHi3oo7+BZIAgM+uVtZwlWQIwMkFYsgG9/D6mBBixc8DoAcQoei2Eocfgkmy4G7g=
X-Received: by 2002:a17:906:40cd:: with SMTP id a13-v6mr27162087ejk.14.1539786741514;
 Wed, 17 Oct 2018 07:32:21 -0700 (PDT)
MIME-Version: 1.0
From:   Ramon Fried <ramon.fried@gmail.com>
Date:   Wed, 17 Oct 2018 17:32:10 +0300
Message-ID: <CA+Kvs9=CbQC7RydJo+arGFRmQ8j5hXambj9MCKJzA=tcy-3Cnw@mail.gmail.com>
Subject: RFC: completion: support poll()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        pombredanne@nexb.com, byungchul.park@lge.com, mingo@kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
If what I'm suggesting makes no sense please tell me. :)

In a char driver I'm writing I'm using completion to wait for transmit
operation to complete.
The drivers also exposes poll() functionality to wait for transmission
to complete.

poll_wait() requires a wait queue, is there a reason why can't I use
the wait queue that is hidden inside the completion struct ?

I'm suggesting to add an API to get the wait_queue so it can be used
for the above scenario.

Appreciate your comments.
Thanks,
Ramon.
