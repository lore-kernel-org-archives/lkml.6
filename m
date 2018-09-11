Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D62C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6CFF20854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6CFF20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbeIKNPt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:15:49 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33343 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbeIKNPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:15:48 -0400
Received: by mail-oi0-f65.google.com with SMTP id 8-v6so45566108oip.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 01:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ws+QIEGqXzlEF/7dLDwjleiu8qt6NKh/5eMaOjXVp9A=;
        b=hhoT1Z0dE3bz1nV+zA6fT+p34FqJEzTybp4RGID9amdoMhDmLGb27ryd9Ku7YDU/sd
         LO7K6HoY9Wu9wSzOCsSGNHJjAa2H2phHGznhtZsG7oeR29jb51tbimMIIaiOJ2ffosoN
         4ltvlhJEJIISJxZClTWWmN0D2jvKhboIIJx2vGBeMPDKglXbcybr+ebmVhnuDJ8qm34g
         gbB5fIwj+XxG+hubtWo7RxyQzAphVgroxs4Ttnsi9kZNBOKy/ZQJMqVa/UHnPFzNOyt+
         XIaUFxA3N2fPIpIeRn4tTxoAcQqmRUqxHFDSD4OGt8T5Bb951qd9Rj1XL1nH27rjeQei
         7EBw==
X-Gm-Message-State: APzg51AAZCn9qJ8J3LtgSdL61RAxko/qI5m3aRwbVQcTL62uSLeSbhZ+
        wFtQkk7UmSWRXA1rA01SEfa7e20udMV/A4te1QQ=
X-Google-Smtp-Source: ANB0VdbHXs7/ZMZsNUX7j8chP2o94WLBdKisXgxfEB8EXtFZdN9xnq7xmXFNSN1JEI7NwbNJG6vsrLOzWaMbzxNObK4=
X-Received: by 2002:aca:190d:: with SMTP id l13-v6mr26648638oii.216.1536653858811;
 Tue, 11 Sep 2018 01:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <CA+55aFyG0GbDfoghEhAmKBPcZCiPu6CCpPRz9GwjCzLuP_Vv5Q@mail.gmail.com>
 <20222492.cP35YpYkb6@merkaba>
In-Reply-To: <20222492.cP35YpYkb6@merkaba>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Sep 2018 10:17:27 +0200
Message-ID: <CAJZ5v0i3gH4H6Su5MPWA3DA_i4mvHEqfw3y=rr0XOpZi5bbqhA@mail.gmail.com>
Subject: Re: [REGRESSION 4.19-rc2] sometimes hangs with black screen when
 resuming from suspend or hibernation (was: Re: Linux 4.19-rc2)
To:     martin@lichtvoll.de
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 11, 2018 at 10:01 AM Martin Steigerwald <martin@lichtvoll.de> wrote:
>
> Hi.
>
> Linus Torvalds - 02.09.18, 23:45:
> > As usual, the rc2 release is pretty small. People are taking a
>
> With 4.19-rc2 this ThinkPad T520 with i5 Sandybrdige sometimes hangs
> with black screen when resuming from suspend or hibernation.  With
> 4.18.1 it did not. Of course there have been userspace related updates
> that could be related.
>
> I currently have no time to dig into this and on this production laptop
> I generally do not do bisects between major kernel releases. So
> currently I only answer questions that do not require much time to
> answer.
>
> For now I switched back to 4.18. If that is stable – and thus likely no
> userspace component is related –, I go with 4.19-rc3 or whatever is most
> recent version to see if the issue has been fixed already.

There were almost no general changes related to system-wide PM between
4.18 and current, so I would suspect one of the device drivers or the
x86 core.  It also may be something like CPU online/offline, however.

Thanks,
Rafael
