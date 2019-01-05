Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B2CC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 19:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63A222302
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 19:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Omya8saF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfAETqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 14:46:53 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:32925 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfAETqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 14:46:53 -0500
Received: by mail-lf1-f65.google.com with SMTP id i26so27628912lfc.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 11:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sfMKo7ATNMJUBNjbzn0K8OxXUEt33ltVZgJi38nELQs=;
        b=Omya8saF/W27WjohuXlwpfrj4/+p7Bksv9DohJlsBfsrJA7OY/3Q3YPW0wVln7VJnM
         cs3qJ46WDfuFVB/SShwQNUY8X0wsqohZWk4LpS04v6uCOqfWBSB730CAc8u48gBSynwd
         qBDKTkyJmnFF3QumYh9Hw5nxCpVz1LDsRIMvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sfMKo7ATNMJUBNjbzn0K8OxXUEt33ltVZgJi38nELQs=;
        b=dw15+Et2LOLPKvSeAoGbuPgcP25fuMeE3VIeZbnw5Av0HTSB4GIYCgxGbe+s7Z3V0v
         U7ZxgYcaIsqpp+Ku4CJd9htZai0pDR3SB+32aNH/p/jT3+aQLcaeYBKQW6nG+wVvXIOX
         V4J0L4qnRdMPTZ1GXaHospFTKB7lxHxwJvyexSY35W9gllSsdNbh+jsWf6KmlwyO0LwU
         6wSWyId16fYFlcbqds/spwBOZPpgMsOp2pmtu2TTwdoRhSOUTYbtrTEgKAxnW904L+sR
         T1c8Cpe1zg8W+8Yj6q0ciCSznodi2mB5veV5tJIQ4geJ+wSSyjPZLjWC+92uKBbVsn3u
         5QAw==
X-Gm-Message-State: AA+aEWYQmVQ+Krf2COPBHPfLWBRqTNIzD4ecWLvoiEPUF0dGTMxWt4M9
        LYHIOspwIvpYgy6pmyC0dn0CF0OeeGE=
X-Google-Smtp-Source: AFSGD/Uvos0NX6rwrTmfIpxpcVTyt5enQFpPM/7l/9dhtl86ct0e4KYqq4mvv8C+ES18hjaK/dqYDQ==
X-Received: by 2002:a19:c18d:: with SMTP id r135mr25783561lff.59.1546717610878;
        Sat, 05 Jan 2019 11:46:50 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id b25-v6sm13235326lji.94.2019.01.05.11.46.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 11:46:50 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id i26so27628882lfc.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 11:46:49 -0800 (PST)
X-Received: by 2002:a19:3fcf:: with SMTP id m198mr26611229lfa.106.1546717609589;
 Sat, 05 Jan 2019 11:46:49 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Jan 2019 11:46:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wicks2BEwm1BhdvEj_P3yawmvQuG3NOnjhdrUDEtTGizw@mail.gmail.com>
Message-ID: <CAHk-=wicks2BEwm1BhdvEj_P3yawmvQuG3NOnjhdrUDEtTGizw@mail.gmail.com>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 5, 2019 at 9:27 AM Jiri Kosina <jikos@kernel.org> wrote:
>
> From: Jiri Kosina <jkosina@suse.cz>
>
> There are possibilities [1] how mincore() could be used as a converyor of
> a sidechannel information about pagecache metadata.

Can we please just limit it to vma's that are either anonymous, or map
a file that the user actually owns?

Then the capability check could be for "override the file owner check"
instead, which makes tons of sense.

No new sysctl's for something like this, please.

             Linus
