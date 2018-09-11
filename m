Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01BCC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5BC2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKpt3FYw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B5BC2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeIKV2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:28:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40020 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKV2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:28:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id n2-v6so26713803wrw.7;
        Tue, 11 Sep 2018 09:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CCgydftaR4XjlClpTQn0RBdTuie9cytq07YqoIV030M=;
        b=tKpt3FYw3DuCCcTy67gespSSVVwzq/rsirmjwsDu5c5SpE9lGt0v0JSSI0Jz29ymLk
         pRy2OgLGguYYusXbiQGAdM9EaN7xP9Z4ru5v+AO74tcj+XkEVzM3gmSBv+QPF5NyRSzI
         LiWXDG6rnwHdpp8pmVLJo7TTJRsA1TI2Q7kPtlXtqiLIE+OeiG3Fkb9woSModiftdg+j
         4WFjwpML8B08oxBz7GARGwhUsjuUk1P4YMf1fShQsINyEDv4cgsmOZOj/WmgoQ5q2ujQ
         6g7+K3wCkPG9OrFOV8V69PYT4s5nRAp2TuCmatOhG3qs+C4MBzHbWL6KE6TO8gfFfK4q
         Z7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CCgydftaR4XjlClpTQn0RBdTuie9cytq07YqoIV030M=;
        b=g1eqp0hyVQyhRVYtD0zaRmrkT5eEFwC4RKmj2OwfA+qd8qFFhxm+Iw6mL1Br7+y23A
         BGYtkVQ7EDlC94g1T3n7u8DRl7/tOKrGhRbOqsA0dKahpfPw5pqh/FTpECORMRP7L0ER
         +0LNFpUWP5GN+67Aoev26TkNuxlEGFrmTz76UOnMpXxyAIwPDC8MXN+Th+PmMnhkwO4p
         ht//nGvrV4G5C4YHqiQ4jOVyYzipHd/PYQGra6petcuIaMArWKw9oW7LIXjKn7xmFnO+
         r+if1pWXncmIwFKOryaP1IuMjWE5RDqLife95UUo90AIw7MtKvT0v0CL1n3gC0CArZm0
         ibKg==
X-Gm-Message-State: APzg51CEzELCVR/a3+ft4r/xYK+oabPejgRcNBtUG6IPtznNvLOsyU19
        C9vaK0nqSSNDYN1nUbLF+u1goUMlCeQoznRQ7OE=
X-Google-Smtp-Source: ANB0VdYZvN4mozAEmQkGtQug1Sd1i5l/q+VivQmq2z943+0dxpZ7iTJlJPzBm9uGl804fxI/B+PI9ljyR29FP8TF+K0=
X-Received: by 2002:adf:b1db:: with SMTP id r27-v6mr20555771wra.95.1536683297041;
 Tue, 11 Sep 2018 09:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <1536078525-31534-1-git-send-email-sunil.kovvuri@gmail.com>
 <CA+sq2CdNRkbGrk4rHOQX1qHrRc2+=DXBscw7cD9UKrX4G5OaVg@mail.gmail.com> <CAK8P3a32gpNX42NuzmbW1PbsHpq7v7LoQ6WDeKtt=QiYbuyM7w@mail.gmail.com>
In-Reply-To: <CAK8P3a32gpNX42NuzmbW1PbsHpq7v7LoQ6WDeKtt=QiYbuyM7w@mail.gmail.com>
From:   Sunil Kovvuri <sunil.kovvuri@gmail.com>
Date:   Tue, 11 Sep 2018 21:58:05 +0530
Message-ID: <CA+sq2CeOSY9VLEY6ruGceo+NkwtfDuivy9joMkx9P3JTPyZxZQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] soc: octeontx2: Add RVU admin function driver
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, olof@lixom.net,
        LAKML <linux-arm-kernel@lists.infradead.org>,
        linux-soc@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Sunil Goutham <sgoutham@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 7:07 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Sep 11, 2018 at 2:37 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> >
> > Didn't receive any feedback for the v3 patch series over a week's time.
> > Can you please pick up these patches to merge into arm-soc ?
>
> I would still prefer to see the whole thing as part of drivers/net/
> instead of drivers/soc,
> and reviewed in full on the netdev side, including the parts that are
> not ethernet specific.
>
>        Arnd

Hmm.. I agree that there are many networking terms used in the driver
but it's not a
networking driver, it's just a HW configuration driver which includes
how HW should
parse the packet. This driver doesn't fit into drivers/net.

Let's say if netdev driver in drivers/net/ethernet doesn't make use of
crypto feature
then i guess netdev maintainers would reject any patches which configure crypto
block. Also as i have been saying there are other scenarios as well.
Future silicons may add support for other features into this resource
virtualization unit's domain.
An example would be compression. Any patches which do compression
related HW configuration
might be rejected by netdev maintainers, cause they are no way related
to networking.

I will keep netdev mailing list in all the patch submissions but
moving this driver into drivers/net
doesn't sound right, from it's functionality perspective.

Thanks,
Sunil.
