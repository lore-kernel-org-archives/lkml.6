Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656E9C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 07:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B9E62070D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 07:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgvgMdWk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfADHJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 02:09:08 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42161 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfADHJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 02:09:07 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so17094629pga.9;
        Thu, 03 Jan 2019 23:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HRv0iUk5pR3joIxtkVjpdH5C92C9WNAtwQYxciO341U=;
        b=YgvgMdWk29NU28m855i27IeSo4MM5z07hzYxQ6QgrGLKqeitTFHLvKlXv0ETsaglkC
         ADU2DQ3UIbDMf4iazF0QMihHzNIFw/5Ix0JLq3e/QqFwMe++nllxNdOl4dmjODKIF78Q
         jr2IF+R9O9e14QjG5ZW/H8U2Qxb/PIVIMzO8qphwcqRPDNnrq+bjMmF7Z6WXd+RxT689
         7V3MiJDkW7WY8lr1akZUcr7u1UFCBvMYyHqLcB7cK8LEJHOXwmmGSt/QB4GjV5fZV6AM
         zAU7h08l7sLE+O7cvV+qvVcS6SIL8ZRsRz0YGvNVCUqlKM7vYuh9vk6f0gJvxpdCUZ/Q
         VvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=HRv0iUk5pR3joIxtkVjpdH5C92C9WNAtwQYxciO341U=;
        b=gMBsRQ2tY8gOjLTBaQf+zP2HIXN0Oxj5C/zMGHMygIFOWh6FQUVLTb12LMTwbYqob5
         jSo6pM4+9wY+Gsq9HBvbYRylzADpSYUMjEcCNYg5SC+neUOHtwv77c51f2P9dTyCqJxI
         xyoywk3yEoL6CIhfn1Qrl0nPjNVK52/SwrYsMECdRe6vpEncusxHQyKx+/M9GUOeSL/X
         31QOM20Mg+PaGajczuJeKq2voQaO0jzwsRDVqTeeHFmlqPV0Y/ihzwNRBxArifgT8MuH
         hUlhg2dV6xd2FzO/+7Bz36Amb8eFUKA4Wxs3XH4PG+q1pRNu4LstfhWTvR+y0JO0Uwh8
         SZvg==
X-Gm-Message-State: AJcUukeXELTTWIz1sWypBBUiEu9wdP0jdKjjkHJhy50L8LNmAqzSD04S
        lnp8ZizuwH4UKyDUOWRxMBw=
X-Google-Smtp-Source: ALg8bN6+h97sMhtZIuDGRXmuVGldQqWvaHw6td4Twp/MI9mxsgxas6NM+Ia5A5fPb5EQ9Un97+MYlQ==
X-Received: by 2002:a63:8043:: with SMTP id j64mr670893pgd.405.1546585746575;
        Thu, 03 Jan 2019 23:09:06 -0800 (PST)
Received: from localhost (FL1-119-238-83-125.tky.mesh.ad.jp. [119.238.83.125])
        by smtp.gmail.com with ESMTPSA id b5sm136599648pfc.150.2019.01.03.23.09.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 23:09:05 -0800 (PST)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Christoffer Dall <christoffer.dall@arm.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org,
        anshuman.khandual@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 0/8] kvm: arm64: Support PUD hugepage at stage 2
References: <1544548241-6417-1-git-send-email-suzuki.poulose@arm.com>
        <20181218113712.GA25383@e113682-lin.lund.arm.com>
Date:   Fri, 04 Jan 2019 16:09:03 +0900
In-Reply-To: <20181218113712.GA25383@e113682-lin.lund.arm.com> (Christoffer
        Dall's message of "Tue, 18 Dec 2018 12:37:12 +0100")
Message-ID: <87ef9s292o.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoffer Dall <christoffer.dall@arm.com> writes:

> On Tue, Dec 11, 2018 at 05:10:33PM +0000, Suzuki K Poulose wrote:
>> This series is an update to the PUD hugepage support previously posted
>> at [0]. This patchset adds support for PUD hugepages at stage 2 a
>> feature that is useful on cores that have support for large sized TLB
>> mappings (e.g., 1GB for 4K granule).
>> 
>> The patches are based on v4.20-rc4
>> 
>> The patches have been tested on AMD Seattle system with the following
>> hugepage sizes - 2M and 1G.
>> 
>> Right now the PUD hugepage for stage2 is only supported if the stage2
>> has 4 levels. i.e, with an IPA size of minimum 44bits with 4K pages.
>> This could be relaxed to stage2 with 3 levels, with the stage1 PUD huge
>> page mapped in the entry level of the stage2 (i.e, pgd). I have not
>> added the change here to keep this version stable w.r.t the previous
>> version. I could post a patch later after further discussions in the
>> list.
>> 
>
> For the series:
>
> Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>

Thanks a lot for reviewing the patches and the tag. And to Suzuki for
picking up the patchset.

(I was happy to see this while catching up with the lists after an
extended break!)
