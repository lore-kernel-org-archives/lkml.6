Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D06C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9A920652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbfAQQWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:22:08 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35647 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728747AbfAQQWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:22:07 -0500
Received: by mail-qt1-f196.google.com with SMTP id v11so11968208qtc.2;
        Thu, 17 Jan 2019 08:22:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BfPrNcYZP0i0LRrIhY6o20XIavlGcH3tB9XloDLeW18=;
        b=jvTFiblRj5Cf0ziiSHysc3piRoxcynep6+5DkXkZYZ6Gb6+adlkNs6us4sRDopre/a
         3RAOKdNcNjnzRSrMAp9H4z4wnZLbhRlx5/a+4rewHpLwkQqZJRZhLLCFsdToggYuXnTk
         ThUisgoy6lOKBbab9SY4N3t7GFsSMt4AFsdrVuozzQWpdbiI1HagZgTJ5ZfwGpwpVh/g
         nYvyQw/U6PQpHlKMP7NQxJePoUI6fol9Hb/TOvgrIjSgY0wKVizpeZwH4J159UBjlQth
         UmQuK1RZLtmbL6b2IeoamqkO47uNOPA1JA80DD8LSrvICsEjsO0DIjKfnLvWCc77CoHF
         EdXQ==
X-Gm-Message-State: AJcUukcG2RKS+6sOCxYOijLiaauZAhrzDsdwiz50wqE+e1GypZ4uB/2o
        JETmuPETUL99xRatXe2gtV8xzdMs6ni0TGtrA4v7yA==
X-Google-Smtp-Source: ALg8bN6iJyjLy+u58V6GX5QsbbZNrzSgjW8ORlgHPHIFXNYsAG9Q5od8R4iIxL5EPRGGMYamIQKKJU2VJjvsyvC1VWo=
X-Received: by 2002:ac8:4141:: with SMTP id e1mr11642121qtm.96.1547742126732;
 Thu, 17 Jan 2019 08:22:06 -0800 (PST)
MIME-Version: 1.0
References: <20190116131527.2071570-1-arnd@arndb.de> <20190117133619.GD18351@osiris>
In-Reply-To: <20190117133619.GD18351@osiris>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 17 Jan 2019 17:21:50 +0100
Message-ID: <CAK8P3a2KvCwAa5yp+f_cZOX4Osd_tvwfBto=aMEMW9TNbePQ9w@mail.gmail.com>
Subject: Re: [PATCH 0/5] s390: rework compat wrapper generation
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     linux-s390 <linux-s390@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 2:36 PM Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
>
> On Wed, Jan 16, 2019 at 02:15:18PM +0100, Arnd Bergmann wrote:

> > I did not test the changes at runtime, but I looked at the
> > generated object code, which seems fine here and includes
> > the same conversions as before.
>
> All looks good and seems to work fine. This is a very nice
> simplification of our compat code, even if it adds some dead code to
> the kernel image.
>
> I did some tests and it all looks good. Also the generated code looks
> fine. So, if nothing breaks, this will go upstream with next merge
> window via the s390 tree.
>
> Thanks again for your work!

Awesome, thanks for testing it so quickly and agreeing to merge it!

There is a dependency that I now have for my y2038 syscall series
of course, so I'd need to have those patches on top of the s390 series.

I think we can either have a shared git branch that gets merged both
into your s390 tree and my y2038 tree, or we merge it only through
my tree, with your Ack.

Does that work for you?

     Arnd
