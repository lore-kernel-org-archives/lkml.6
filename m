Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0BEC282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 02:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C822184E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 02:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRXu8Biv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfBFC4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 21:56:02 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:44029 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfBFC4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 21:56:02 -0500
Received: by mail-vk1-f194.google.com with SMTP id o130so1299767vke.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 18:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jyYa+dnct96MCe0p8mnyg6Kxz97EvONG5+L2aZOQX80=;
        b=sRXu8BivgCfLOj+nH50X6ZXGL8LeOmWOzM9GI2gJFv57gpomJITjcl8tcw26fhsY5u
         g7iCMDjiVdFvhgcjYSxORlIOtoDdqCRngCVK2elHE9x8xg2HIiuNZv3DoiCMqBmday5q
         601upOIHJhg7C87s8Ri0zTZCULHaIqNZPI/KD2y91M70Sf+R5R9/foHd9pYFstAtOVtZ
         nVjR7Ho9AX66WuBDFGgj+Y4MYCOHOF/sC6EzC0eJ2eqEGjYlSw1XZYg0EivRe5W+5oLB
         n4/FixRv+1MozVrC2ZeTwZ5trTIuIR4w5B114rd9ktqLNH46ZZGAXqlxUmCYQTln2fLO
         Ecfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jyYa+dnct96MCe0p8mnyg6Kxz97EvONG5+L2aZOQX80=;
        b=ERejGP2Z2dePqROEhm2Y8v62MTAx1OAl1pihiekwjnYVtj7EzwO9hRd8eHQDKuWj1i
         /nl7n6yN97tBjG9bB9m0DOHqbOLI75Kbg5pwGokOYOzYy+BpgPYa1Q+ye/w7hKyV+cRd
         q7LMaAuJSJUdKAUOAdcEPIcUaOXTaBzawo8INNXryWaBTFs5Yi0sWdPpKeIzZogKHQMO
         aOvDwGk7RBA6PeBmUNl4BFQan23di+8NjW0tEZ7p/ODxYp0N/ig4NgXzSxRMEd+AKVaw
         SUS3sJggkvWC056fPqpbBATWLEQNbPpOwXZpTYZBAOLLfJr/+xvCX1WfHe+r3MD8BYaP
         okKA==
X-Gm-Message-State: AHQUAuYru1Gz7TZLfFnyhJEL/RHsxgMZzMIp9KvofL3NrtZvO902VQJb
        CMf0PC4KHSLkiUj86kst8tNJdIexiIC8ztr6KBQ=
X-Google-Smtp-Source: AHgI3IZOOpT6eO8jFMiJDNa9569DVkpgsIvE1qPHHPeNZ3H2QBUt+hsjUZLigDfkJu6flyrKXmdgAfcsxp1Sb2dCP7o=
X-Received: by 2002:a1f:8784:: with SMTP id j126mr2325579vkd.84.1549421761186;
 Tue, 05 Feb 2019 18:56:01 -0800 (PST)
MIME-Version: 1.0
References: <20190131103022.10218-1-peterx@redhat.com> <20190131171106.GD19324@redhat.com>
 <3013350.qntrAZtlsQ@townsend>
In-Reply-To: <3013350.qntrAZtlsQ@townsend>
From:   Balbir Singh <bsingharora@gmail.com>
Date:   Wed, 6 Feb 2019 13:55:49 +1100
Message-ID: <CAKTCnzmC74fQ_NCGvvXY3sv--hp-C094jVy8JfCUYqwp_wcBAg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/powernv/npu: Remove redundant change_pte() hook
To:     Alistair Popple <alistair@popple.id.au>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Jerome Glisse <jglisse@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 5, 2019 at 2:52 PM Alistair Popple <alistair@popple.id.au> wrote:
>
> On Thursday, 31 January 2019 12:11:06 PM AEDT Andrea Arcangeli wrote:
> > On Thu, Jan 31, 2019 at 06:30:22PM +0800, Peter Xu wrote:
> > > The change_pte() notifier was designed to use as a quick path to
> > > update secondary MMU PTEs on write permission changes or PFN changes.
> > > For KVM, it could reduce the vm-exits when vcpu faults on the pages
> > > that was touched up by KSM.  It's not used to do cache invalidations,
> > > for example, if we see the notifier will be called before the real PTE
> > > update after all (please see set_pte_at_notify that set_pte_at was
> > > called later).
>
> Thanks for the fixup. I didn't realise that invalidate_range() always gets
> called but I now see that is the case so this change looks good to me as well.
>
> Reviewed-by: Alistair Popple <alistair@popple.id.au>
>
I checked the three callers of set_pte_at_notify and the assumption
seems correct

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
