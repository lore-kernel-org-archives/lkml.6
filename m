Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53804C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097C02086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VR/L8N2R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 097C02086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbeIDAky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 20:40:54 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:33103 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbeIDAky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 20:40:54 -0400
Received: by mail-it0-f44.google.com with SMTP id j198-v6so12101543ita.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 13:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xh8UY5h12cS5TGPhGboD1hYJlBe9eHNmB7RvBPSJ88k=;
        b=VR/L8N2R/1QRn5nB/Ph0quTZAuMtGHZXFaV8IanKq0ucxqza8s1fawMQ8Dp9HJRNAV
         I7zZJgHhP5nmdjOGFQBDfFACDE03GwJBPCuv2znMYDZze7rhfo+ZDaXH7bJnx98ITnqv
         zjl38aHQrVV2zPcY5d0jAYWwZl6x/M6HjUuvJNOC38/99Xiye0A7DVX8jTk7tK9mCDo8
         OXmedp5DTZCdWz6ANKaDNNvKIdAKHorXpGo4oRxbVRxt8AzY+qhAbxBeeJyfrs0okXb4
         2XBMHuvKa/0rzGiBD7Id27qP2FJbh8BWSKoK/7tcGfhZYOZvn49wafia+aXnkmd+dPkY
         1gSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xh8UY5h12cS5TGPhGboD1hYJlBe9eHNmB7RvBPSJ88k=;
        b=MdOd0vO0rV/1ha8XC9rzMsuv74L9aJ/aqgUL7EBLQNlq/avLyMmzBb2NY/fQAJPRP2
         YGS0YOpM5hmtJh2EP2L1K7oveVPimIwD3eNMBPi2+MRX7LJBxdsBCN+fZLzQ+eKpmWrV
         A7O/ciRXjg7GcvLJNbUWZMVY2RZ3Q7DgcWseg6SnBnZx8ox0OkzfHuk5diEHykMcYUi/
         AGuPGRFamYPkLv+0KyTg6ZXMH6GqowAZwnDAHMJ1Z9pcqS+ZlIAk91WjOLQ4SUWtQkvz
         OAgbAzJ/Ofboqwyg698rnSoycNErasCIak0spa1o5JNLMxZ2/jmQKmWMwO1Z3y5HGAob
         zS9g==
X-Gm-Message-State: APzg51B3C+w57KstqM+ctk+VRKGV+Vl3M1R35FIr1FB5dDKlt3RKRV4m
        DQVeT07NtcWb0At6qOqI0xzKvaeAe5sI+bCew18=
X-Google-Smtp-Source: ANB0VdbGNWJ5RynA0kxWbbLHZFMf9kP1dXJWYjGPMEmZpFU5lLl0rAcF99xogGIAsdLpWlaPeom6yefnIQEmryzhMIs=
X-Received: by 2002:a24:355:: with SMTP id e82-v6mr5564907ite.64.1536005946301;
 Mon, 03 Sep 2018 13:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180903133304.70362-1-mika.westerberg@linux.intel.com> <20180903133304.70362-4-mika.westerberg@linux.intel.com>
In-Reply-To: <20180903133304.70362-4-mika.westerberg@linux.intel.com>
From:   Yehezkel Bernat <yehezkelshb@gmail.com>
Date:   Mon, 3 Sep 2018 23:18:49 +0300
Message-ID: <CA+CmpXu6NENgWMM-PSge=vFp3OKV1rtWqycqdgY9bmQE2in4JA@mail.gmail.com>
Subject: Re: [PATCH 3/3] thunderbolt: Add Intel as copyright holder
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        michael.jamet@intel.com, lukas@wunner.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>   * Copyright (c) 2014 Andreas Noever <andreas.noever@gmail.com>
> + * Copyright (C) 2018, Intel Corporation

Nitpicking: (c) or (C)?
I can't find anything in the documentation and both are found in various files.
