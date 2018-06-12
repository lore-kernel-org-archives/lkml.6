Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 07419C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0F02089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ABvVMV+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F0F02089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934885AbeFLWsm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 18:48:42 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37295 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934368AbeFLWsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 18:48:41 -0400
Received: by mail-it0-f66.google.com with SMTP id l6-v6so1462139iti.2;
        Tue, 12 Jun 2018 15:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g7Stczy5Gcff3q8nIf1LVYJf6RG8YLT9T1VkCj/0TlE=;
        b=ABvVMV+UU5n2Cyh9RWxAqSg72LQjLt4RwqKJFHrFcC3khUXoXd4Tt3bQLMWUjaCXXF
         +M5NFGI7pfTKXG25w+88beqoZnzimTAkW34E4lBVk7qG/0wzs/P9Cp3zOTR2OO62iq3n
         nk3CnMspPYZ1MsqP/6pKdWH987RDQpBZv8vZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g7Stczy5Gcff3q8nIf1LVYJf6RG8YLT9T1VkCj/0TlE=;
        b=ODVNUznwZ0xNsB7wG4cH6GSHqLrF0mgjceLyW5uz+CcQf4LQ9uKrBwKaIjMBzLKdxD
         LzZg1Hm97oPINwU2qcT8try4/s4ZGiFwbbdOvloC6IkzDQ4d2v4spEsDgC0p+XxkrDvi
         aoy81LpcgtnODMq7Mo8itqUCCyqPTPLXaOmw2riVcG76WKjDkh1YyTGJzegFrehfqm05
         RU0QdgokTmwdYjt4MGqyws6JQzB376Nc2VuydzqAAOVQcfiIMmSn58OjDpG3kRJsOdRb
         hkFu0yuoPEAWEpIGEJipPfV8vZn6cD2Q5iV3tnC/LRgITJmV7Bfl+75QCbFZz3Dg+tvI
         8yxw==
X-Gm-Message-State: APt69E2rukQBXRnWhaD66dNj+ZaMp2r6xsibS2M5tuNpE2MdiTwoFJJ/
        3kwarVXUcK9NlSkoT7Z8+trhT4x6XPDTf4mm+88=
X-Google-Smtp-Source: ADUXVKLDyI38IDathaQ16UUjpBKQKmbeoUukAzupfm5/0umyjiB8k1G27clagwYIaq8SjQ7vs7bxx6gQfYfWqrswJ6s=
X-Received: by 2002:a24:3cd7:: with SMTP id m206-v6mr2323275ita.113.1528843720383;
 Tue, 12 Jun 2018 15:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180612210820.GA70310@bhelgaas-glaptop.roam.corp.google.com>
 <CA+55aFyo-NmP_zkyjnMXxJEq-93ha4akLDpF8biiFQ-hhWnZmg@mail.gmail.com> <20180612222718.GA96078@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180612222718.GA96078@bhelgaas-glaptop.roam.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Jun 2018 15:48:29 -0700
Message-ID: <CA+55aFxVxKjr7uba2ngNu4g7kWpnt0gDpZmrRi_JsiFUbdyqVw@mail.gmail.com>
Subject: Re: [GIT PULL] PCI changes for v4.18, part 2
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        shawn.lin@rock-chips.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 3:27 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Sure, I'll update that branch and send a new pull request.

I already took the branch, it was more of a "please don't do this again".

Although even a post factum explanation might be a good idea.

              Linus
