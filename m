Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6218C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5504A21471
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OW8rW2ZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5504A21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbeJQGku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 02:40:50 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:37689 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbeJQGku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 02:40:50 -0400
Received: by mail-wr1-f41.google.com with SMTP id y11-v6so27386778wrd.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 15:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=t+Q6eT27WtfGUH7pM0A7N4d4g04+vT/bPNbY2TXcbDo=;
        b=OW8rW2ZQ6dkShXaiijteIn7bFHfnTgoQL4mPnTjQDackaDlZ+ufC8/9jvklwLe4NR5
         vMCOLb3eH28PPtEeuk371bKy1EEq/celWoLCNM+lhXpIfqXScsnc+YJ13lFPxOPRQ0AO
         +HyidlQBU73ChWbgx3qJA1euU5b1L8epZVpow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=t+Q6eT27WtfGUH7pM0A7N4d4g04+vT/bPNbY2TXcbDo=;
        b=d6WNiWwyAhy4ddxiryiufb3NJfQMvTCYIJ5xMWjyVoalzTvTXjTi/0vtDvg0qQBFry
         AjpR2AWsfbTckk3zswIFsXp/uBW9lN61oeZ4e5vem1NaRhIdrpcE3P4WzcPI9bTe8CNV
         SikpRhZa7ENargkVdwdnJAS3X1omVZrOy0SkgkTDs4LHCwip1PGWj2IXyKsOj6T9RU6D
         pMGVzK1wSL3cdfo2uCR1fkKoSNkosTvfIFCvYlK9daBnv1TJebGHi2pkW/3T5Ba+LFTW
         TuQCC2zmGDGTyi43kSJNpGyn9RUVMvpG/cNPW5FtWzQ9Oh0XG35v9l3AjP+E15E/tZiF
         WDew==
X-Gm-Message-State: ABuFfoi9OgO8Kmuu7twlYQTYbbnD+e/qszJZuPKI2FROMtcAXLyRJSKX
        SHRbxkJPIdMf5oqaqphrsH+w+DzBUlHxpCkHzb+IAw==
X-Google-Smtp-Source: ACcGV62Bb4dxxJd1aLUzm50C08rhQvLnueordHil3vg1RmKBNJubZuL3TUwwRwhnHI4Sb36JcwuwS++hrptGUCbU/Gk=
X-Received: by 2002:adf:e28d:: with SMTP id v13-v6mr19809140wri.139.1539730093364;
 Tue, 16 Oct 2018 15:48:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b485:0:0:0:0:0 with HTTP; Tue, 16 Oct 2018 15:48:12
 -0700 (PDT)
In-Reply-To: <yq17eiiwobx.fsf@oracle.com>
References: <1538434698-1042-1-git-send-email-john.stultz@linaro.org> <yq17eiiwobx.fsf@oracle.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 16 Oct 2018 15:48:12 -0700
Message-ID: <CALAqxLXYTZZ12haKHGwnTBqPgkv_JF8=fiiJrD9OWRFdcXf0Sw@mail.gmail.com>
Subject: Re: [RESEND][PATCH] scsi: ufs: Fix hynix ufs bug with quirk on hi36xx SoC
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     lkml <linux-kernel@vger.kernel.org>, Wei Li <liwei213@huawei.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, Dmitry Shmidt <dimitrysh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 8:41 PM, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
> John,
>
>> Hynix ufs has deviations on hi36xx platform which will result in ufs
>> bursts transfer failures.
>
> Is this specific to the particular implementation on hi36xx or all SK
> Hynix implementations?

I'd have to defer to Wei Li on that question.

Wei Li?


>> +     UFS_FIX(UFS_VENDOR_SKHYNIX, UFS_ANY_MODEL,
>> +             UFS_DEVICE_QUIRK_HOST_VS_DEBUGSAVECONFIGTIME),
>
> I am not so keen on matching on all current and future models.

I'll see if I can narrow down the affected model version on the board
I have. Hopefully it doesn't vary too much.

Really appreciate the review and the feedback!

thanks
-john
