Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D63C6786F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 00:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455EC20666
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 00:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANGRrndC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455EC20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbeKBJc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 05:32:57 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]:46647 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbeKBJc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 05:32:57 -0400
Received: by mail-qk1-f175.google.com with SMTP id q1so435860qkf.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 17:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5Yqc2DE/Vr6hLYt2nXt1XTb+plskyFIXNXSMSKpGnsI=;
        b=ANGRrndCThLyfPrfrGI4PdeaO6rh3Cxa8rNwfCZeENJDTHVJg4MzPi4peF2Uh9SwYo
         KOpo2dGy31UCON8hajnitM688R267qTn/RKbWrFH+XsHvCSwhNxoTu0aJdJAwb2rfKbo
         lJ+w8zQiARWKkPVLrNxKUWHez7TQMmiZInr6nY4W6HIsGfhMzwu6QWO5lKyRyg/r8CfJ
         rlb2dKCyWKU1m8hJoWFtXgd8PYI/3hYsewTzbfEdlqB1nQEPmtXo4OnL5lScPB5eVj8n
         y9UXli4XxtudsTvu3szD9mUw7rUekbvDw81Cu1YzVHC7Vy4a201V0hexIYaOlVsfUsR/
         gNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5Yqc2DE/Vr6hLYt2nXt1XTb+plskyFIXNXSMSKpGnsI=;
        b=RLYwgAPzYOf+nsJ9A23d0fl2e9/rqg5x4i/uzMuHxsgM0O5EJZCaWC3lJLItHPuJqb
         +CKVThbIfUCWsOj38p7OEGw3IrrsSXJW5JbfWaau5tbWHzj2iAbDQleKU+PUd86V/Q35
         MrrLzjnuumA+NHE5FirwDnDS0PLgwBxbywP6lvgDm1TkGtPa+NkDizXF4YKOJsASl6uj
         adpzJu/oYR1xQbj/xCzjaeVijJccS51ybbFSGxAiT8VfJ29EJW1WQpRVvfta0VzmfSSU
         E8ugvqpzcpFnGzSryaRqAjVr4kIHe/wExzfM1XWm98tJHyDlrfnLIEodpUHqv19hb14n
         mo+w==
X-Gm-Message-State: AGRZ1gJnuBE0VIprSym3K0n0dBC5xLgI7jdRiBEbjMn6Xp41Xa2eky0d
        yZ1sQHHOKrT7hxF7zVqF8Pa40Okg31b9Ipb2HcA=
X-Google-Smtp-Source: AJdET5egrDdSF4BmxOuBqEDF+s3t33+OYMZQJamDs4nvXv+XtbtUBo7mzkAKyPpmgEu8TA141zCJ6kYIMbjvA9Mx5I8=
X-Received: by 2002:aed:34a6:: with SMTP id x35-v6mr8265718qtd.93.1541118465470;
 Thu, 01 Nov 2018 17:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <20181101164222.43015-1-smuchun@gmail.com> <20181101165227.GF3178@hirez.programming.kicks-ass.net>
In-Reply-To: <20181101165227.GF3178@hirez.programming.kicks-ass.net>
From:   Muchun Song <smuchun@gmail.com>
Date:   Fri, 2 Nov 2018 08:27:37 +0800
Message-ID: <CAPSr9jFitZv-phf48Hdd5SbXqgex4xdHrzAN7FREXJBMg_WCPA@mail.gmail.com>
Subject: Re: [PATCH v2] sched/core: Introduce set_next_task() helper for
 better code readability
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peter

Thanks for your review.

Just update commit message. So there is no difference between them on the c=
ode.

Yours,
Muchun Song

Peter Zijlstra <peterz@infradead.org> =E4=BA=8E2018=E5=B9=B411=E6=9C=882=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=8812:52=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> What if anything is the difference with v1 (which I found yesterday and
> have pending testing).
