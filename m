Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0E6C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B62721872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dd+ZxGO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfAWWSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 17:18:00 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37494 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfAWWSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 17:18:00 -0500
Received: by mail-lf1-f67.google.com with SMTP id y11so2809610lfj.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 14:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nJe7NZAW3aLxEeXJdyLXIXXc64Usi/TiOB7qd0/C1Mo=;
        b=Dd+ZxGO0H3jaYp4B/DDL7DBdG5VZrtFTzXwGTQvtfDkD99UXqZHXfZXVmkOe3IxozC
         cN2Ntvrfzb8eylZLplQqbJen/Tf6WWmb3J8zp+YZCHCFqgAeRPcgTcW2iitAlFtvHP7X
         vNwKlOviePkKKsg38L5KFsBjmmOGGExA9BAJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nJe7NZAW3aLxEeXJdyLXIXXc64Usi/TiOB7qd0/C1Mo=;
        b=sffTWOdwWMRQHpV3gmiUbzw3R+BFrvLE9C9jXdx5hLEDH6Ealsp3XTUqTKvMerVkF5
         St/wVgIPnhKl9NzfW3zXwbT7Hx/NJ893zaFFHSm7/csZT+/o67izZmTdiTtDyCFh5Cn1
         krevL2rX5yBe4q1CZFNp7vL/urwxGYW/EFlZEnrFKsRLDLDmotkg8l+szkHxmiWdEIQa
         fUSLsRsvttUO5tBuY7wwihrru4/Xd3M69mafJ561zV4YFd0Kdg81f4uE4NYHCR4kbHt1
         57Mrd3ERMuXnwU0S8x0SmQARuIPyRVye9jNchehcuibh2nIE/3yhmE/bVfunVIMRAFyc
         oRFQ==
X-Gm-Message-State: AJcUukcTsutKxUUIbbbezXDyHmNaKd+nszDxypgOHjIA0W95MwZta6Ao
        0/EWEGGRgB36RJ0Wg4EKaMHj4Fd6R6o=
X-Google-Smtp-Source: ALg8bN4gj67WZtEzsyKHldvID3F1mEdOuXb93GJUCwnZ97py/H6oecsiFpUKejCIwJWyhNOkjCBJHw==
X-Received: by 2002:a19:9b50:: with SMTP id d77mr3134986lfe.137.1548281878033;
        Wed, 23 Jan 2019 14:17:58 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id u30sm728120lfc.90.2019.01.23.14.17.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 14:17:56 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id n18-v6so3411892lji.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 14:17:55 -0800 (PST)
X-Received: by 2002:a2e:3a10:: with SMTP id h16-v6mr3496014lja.184.1548281875489;
 Wed, 23 Jan 2019 14:17:55 -0800 (PST)
MIME-Version: 1.0
References: <20181012213926.253765-1-dianders@chromium.org>
 <CAFp+6iFy8V34cs6pEOie_tBX5wJqM7teUnH_XLLZ7cioPrX_hA@mail.gmail.com>
 <CAD=FV=WYM5OOigy+81cVzPtAJXhvrhB1znr9zHzMf3q5iFOtFw@mail.gmail.com>
 <CAFp+6iGxvDoptnjM18ggnHqX6MV0+HFqsnCMi61b8gquBxaYmw@mail.gmail.com>
 <CAD=FV=XWC8q4Cx4GF0yXCgj2APwd5ZfccVBC_ORwnJg0vRsS7A@mail.gmail.com>
 <1ce7b24c-b154-4ce6-2b4c-9eb0fd0d71cb@codeaurora.org> <CAD=FV=XSjfRSHP6B6GtiTqrQuUZaoA=hZNW_L1=71MU9fEXpDQ@mail.gmail.com>
 <20cf6f02-ff3c-0904-2edc-a1b72c135866@codeaurora.org>
In-Reply-To: <20cf6f02-ff3c-0904-2edc-a1b72c135866@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 23 Jan 2019 14:17:17 -0800
X-Gmail-Original-Message-ID: <CAE=gft74tm8+zbg3NF2v3C=0_8yG9R7bs3VvLqyea2Z=yvsawQ@mail.gmail.com>
Message-ID: <CAE=gft74tm8+zbg3NF2v3C=0_8yG9R7bs3VvLqyea2Z=yvsawQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: ufs: Fix the compatible string definition
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Can Guo <cang@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        sayali <sayalil@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        devicetree@vger.kernel.org, liwei213@huawei.com,
        LKML <linux-kernel@vger.kernel.org>,
        Mathieu Malaterre <malat@debian.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 12:52 AM Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
>
...
>
> Yes, this patch is good to go.
>

I don't think this patch ever got picked up, despite being reviewed
and good to go. Can it be applied somewhere?
-Evan
