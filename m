Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEA4C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 19:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE4D208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 19:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p88KXs0R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE4D208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbeHVWyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 18:54:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46420 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbeHVWyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 18:54:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id b129-v6so1351933pga.13;
        Wed, 22 Aug 2018 12:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Va8rQ0O2lOpquPX7X/RHnelm/ieZaNkrPKr2NNwybRM=;
        b=p88KXs0RelXcPO9xPrXs6mWAr5tiF1bS6JL4Zn6hhHUxOvcUnOsbCBNIY8WMVCB1Wf
         Nzw418Z/unGCL6iHdnjXGHJBarcMT7aIm7ld2Y4W/q7k5gwf9dpCKaigGtkzyvkuw/PS
         ydP4z1yGNfBYh0gjT4lwlJ3KVUFWWxcaTcnRmrcv2sD6tCYrfP0ns8yRUagtOdm7YhI2
         ccPXHobel03icBV62Aqb4OjIm5TxF1IvtXMghTvexKOO/DX44p6mUKV9OMCfl/tRfVLD
         CdnT+hdsEto2sso9QsgYpyCfcsxe6gMNCp52YnUlYk5xmFzO4CiMLZzpQIwXTlugxwbZ
         DnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Va8rQ0O2lOpquPX7X/RHnelm/ieZaNkrPKr2NNwybRM=;
        b=cJruF1QP8YiOLgf+zg7YSLvBj1Rb4u/QjI2p8gfHTdp9Y3MiPJW0Ch9Sf/jVNb8UXI
         F+1wmDZJsva60P7hQLEu2x4xy0EvBA0C8huZFkl4hfjXJgFVL+0K3EWhYS50YctbYoP3
         fLXPxJObrIdt3dwk7dJZ9X4ryn9R5f2Urq2LPcWl0s3cnIHDfPOMa3pgkod8qJD+Fi6W
         7ZHeQ8D9E5851gjljS+yTYlKWK0bKbhliZqtkGWjq75esy/GR7gypfMeK2Uqg+nzIMPe
         AN3C3ApVXC4xpT5I+39pPO8w3ziY509oc6S9O0hl3yYlsMeKlqJIkq42Inww7X7ohOhb
         TwMw==
X-Gm-Message-State: AOUpUlG5lpDkxEK6y3wsLajZ1CA1LyhugNz5FxXTqFtzgLABfc1dBbIS
        JtI0WVhEKBTVs6Rhfgo8kcTzGczBSFCvms59ELZClg==
X-Google-Smtp-Source: AA+uWPyh85TtXqbl9Nr9dcIw8qr0G/Yu60kxsvjim7zLNn1tgAdUumrXWg05UeM5ey8ZEIfCrjIGpTIGizm9/HVZXRg=
X-Received: by 2002:a65:52cc:: with SMTP id z12-v6mr52817127pgp.69.1534966093184;
 Wed, 22 Aug 2018 12:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mtO6545itRxAV0KW7NSt7ucvxgHOtg8wUZZ0DMHO-V8XQ@mail.gmail.com>
In-Reply-To: <CAH2r5mtO6545itRxAV0KW7NSt7ucvxgHOtg8wUZZ0DMHO-V8XQ@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 22 Aug 2018 14:28:01 -0500
Message-ID: <CAH2r5mt4Xd7Z86MSxFXNS___sJQjN5KJTH+XLXJcqT0=97wE9A@mail.gmail.com>
Subject: Re: Overview of performance improvements of recent SMB3 compounding patches
To:     CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        ronnie sahlberg <ronniesahlberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Continuing the experiments with Ronnie's patches show additional
promising performance results from other common scenarios:

Very good news that the number of roundtrips (request/response pairs
to the server) has dropped so substantially.  Reducing latency, and
allowing the server to more efficiently process the requests leads to
much better performance for these common operations:

- rename goes from 9 request/response pairs to 5 ("mv /mnt/file /mnt/file1")
- hardlink goes from 8 to only 3 (!)  ("ln /mnt/file1 /mnt/file2")
- symlink (with mfsymlinks enabled) goes from 11 to 9 ("ln -s
/mnt/file1 /mnt/file3")
- touch (existing file) 6 down to 4

In current kernel we benefit from compounding now on stafs ("stat -f
/mnt"), and in the earlier note I described the improvements in
create, unlink, mkdir and rmdir which were also awesome.

This is very exciting.

On Tue, Aug 21, 2018 at 1:24 PM Steve French <smfrench@gmail.com> wrote:
>
> In experiments today with Ronnie's most recent compounding patches I
> see the expected significant improvements in create/mkdir/unlink/rmdir
> operations over SMB3 mounts (tests were to Samba but would be similar
> to all modern servers).  See below:
>
> "touch /mnt/file"  goes from 6 request/response pairs to 4 with
> Ronnie's compounding patches
> "rm /mnt/file" from 5 to 2 request/response pairs
> "mkdir /mnt/newdir" 6 pairs to 3 pairs
> "rmdir /mnt/newdir" 6 pairs down to 2 pairs
>
> Good job Ronnie!
> --
> Thanks,
>
> Steve



-- 
Thanks,

Steve
