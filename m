Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757A6C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308B520839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLPsCO3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308B520839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeIKRgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 13:36:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45647 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbeIKRgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 13:36:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id 20-v6so25852899wrb.12;
        Tue, 11 Sep 2018 05:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BTfTdTFADooU4IkNsOTnWsUZeL0zc4qzcPZG6IRmSes=;
        b=kLPsCO3ij6XCef/pp5nmv238Z5wW5Xi7iQxGsMtClBNqJMP7XYFQaGZjtEsu1TRVYg
         baz2qpFsitXH353dfl+L22ofEPqQfODGXY1rIcvdxUpjZh5ty9/LDafT4JDPdIxK/Q/S
         qwak7nHuVWaRcd8tN2sGFezvBPWcj8UeKI7MieO1TJHd8xyW1SItrGrNMqmbZy807NNS
         rZgPQE5xYkGzPFhRVhQnMjXMqY90V+1MDW2nKVYyv+kEcxrFPcLzAUuE23zlsyGr37kk
         ES2Wb0/4nNoAxWxYBcim/wbvahFZgRRyGkyLB4OLDQz60NwieIZOWLENGcqlf0zGfXrQ
         ftRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BTfTdTFADooU4IkNsOTnWsUZeL0zc4qzcPZG6IRmSes=;
        b=Zi0bTjqIBCwU9qg3sQWYyvfK3CNDkO1q6ebrAKJqywevG6YqDZOj2nyl2V0Otz5k8E
         HQ15LcddoFRB3i4dNyLMVqiS0TM67Dqo7bCXtBubNli85iBiB+kckovBkkhjICNoNmXi
         S8hPgmN/M9nHXQycWKoNRYQOwxKiscqrm41hgclUfytEM9yei2/Wk+tLyFl0vjT+8TRx
         bZVcUXkw1s/qPBa5BwKu8Nct64zv208HbJxRNLtrGim5nOGMWru0QdVjwPYQvRTdDJYk
         HPxe+cEVM52mSKcStbCOav9FQh+VzR0haxe2Xi98ZBqvYrowN55IjZH7TYpLpYLaOcLx
         EpJQ==
X-Gm-Message-State: APzg51BcNY24x+bmhEBsHfrIKRVQYGMgNnrC8YKQ7ynlH/C8BBUrg+ia
        uRYEBZxuMqa3NJobsM5N1D9edv0Jwnr0gpwoIzT+YQ==
X-Google-Smtp-Source: ANB0VdbNp0UbvJMiggfVlLxtG3u7sAZYYSdDVrHMW9JIbVvH4INBQ7kMwK/qVCmY5SQB57aE/1AIJfM8hzkNfZ7wmEM=
X-Received: by 2002:adf:9051:: with SMTP id h75-v6mr19891416wrh.65.1536669441808;
 Tue, 11 Sep 2018 05:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <1536078525-31534-1-git-send-email-sunil.kovvuri@gmail.com>
In-Reply-To: <1536078525-31534-1-git-send-email-sunil.kovvuri@gmail.com>
From:   Sunil Kovvuri <sunil.kovvuri@gmail.com>
Date:   Tue, 11 Sep 2018 18:07:10 +0530
Message-ID: <CA+sq2CdNRkbGrk4rHOQX1qHrRc2+=DXBscw7cD9UKrX4G5OaVg@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] soc: octeontx2: Add RVU admin function driver
To:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        olof@lixom.net
Cc:     LAKML <linux-arm-kernel@lists.infradead.org>,
        linux-soc@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Sunil Goutham <sgoutham@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 9:58 PM <sunil.kovvuri@gmail.com> wrote:
>
> From: Sunil Goutham <sgoutham@marvell.com>
>
> Resource virtualization unit (RVU) on Marvell's OcteonTX2 SOC supports
> multiple PCIe SRIOV physical functions (PFs) and virtual functions (VFs).
> PF0 is called administrative / admin function (AF) and has privilege access
> to registers to provision different RVU functional blocks to each of
> PF/VF.
>
> This admin function (AF) driver acts as a configuration / administrative
> software which provisions functional blocks to a PF/VF on demand for them
> to work as one of the following
>  - A basic network controller (i.e NIC).
>  - NIC with packet filtering, shaping and scheduling capabilities.
>  - A crypto device.
>  - A combination of above etc.
>
> PF/VFs communicate with admin function via a shared memory region.
> This patch series adds logic for the following
>  - RVU AF driver with functional blocks provisioning support
>  - Mailbox infrastructure for communication between AF and PFs.
>  - CGX driver which provides information about physcial network
>    interfaces which AF processes and forwards required info to
>    PF/VF drivers.
>
> This is the first set of patches out of 70 odd patches.
>
> Note: This driver neither receives any data nor processes it i.e no I/O,
>       just does the hardware configuration.
>
> Changes from v2:
>  No changes, submitted again with netdev mailing list in loop.
>    - Suggested by Arnd Bergmann and Andrew Lunn
>
> Changes from v1:
>  1 Merged RVU admin function and CGX drivers into a single module
>    - Suggested by Arnd Bergmann
>  2 Pulled mbox communication APIs into a separate module to remove
>    admin function driver dependency in a VM where AF is not attached.
>    - Suggested by Arnd Bergmann
>

Hi Arnd,

Didn't receive any feedback for the v3 patch series over a week's time.
Can you please pick up these patches to merge into arm-soc ?

Thanks,
Sunil.
