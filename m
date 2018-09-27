Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EBEC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A905C21547
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoPAQb73"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A905C21547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbeI0RlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:41:10 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40852 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbeI0RlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:41:09 -0400
Received: by mail-oi1-f195.google.com with SMTP id j68-v6so1791907oib.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 04:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0x6rmDnXjvR45w01mmjZbVG0nsK+doTxVThgCeS24Ic=;
        b=WoPAQb73K9zoHfp9yPVBkNo233qVsqS5ChfzZsQgGlsvUgWdqbtkk0gD2YInHVNnrn
         Q6sB9Bnpxc8IjIwbI/BD/vL0aXqte2CZyR1jw1Fz5DtVu9sCxZsNV+5zrjZ6jB/YYKLY
         GsQMs5UNXgzTe/Xulf9ZeUNQznn4YMyPsodmA73mcnbRP86b4uccSfj/RqmYmfO4JFuk
         EobAxj9Ce4XOonqsGKm/NAFFnSp6eu/vJaMCmrz4T5C3Obdbzzjn3Eep1DQ+ghwiCVvV
         YzG/l6PqkBjga7vRDYaZ27xprBYJ3oqj6xHO/6RzQaZZBZS2/tFO9Z+8LWvtVXkGqK+O
         IZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0x6rmDnXjvR45w01mmjZbVG0nsK+doTxVThgCeS24Ic=;
        b=ZgdOk4dXPULWhgU/mNRePuvbFd9h8SlM4+4RFux1HBiFNKspCpIciJmdYIfJ369NYR
         Jr8i4MZVf+Ijq81xFIiolvtoOl0YynO2tVtdiY+0KdQV284RWbrX/DHi+mn22sbXS4H8
         27tpTGxYjOuguh59Qpr1o5z8jYQlQ3bfDZYXy24Y8+LThdAtixQ/lwcZuTNH26MRre5X
         +/Ptrc6+m3ogESB3XytWi04ih23PBN22eINi6bJ/sIatqhM5ldeqAG3uVeob5cculy3W
         iezuVlNPaD9HWmFJihnnb8QOI+TOfqVi++gu7V4TnwSrOI4IJ3IpkQRS5ttkqRsgovQI
         AdZw==
X-Gm-Message-State: ABuFfogQBMkAzzll62azTGR5eBdIZt62tnKRcUpvncF5OCHU2uoAj4Zk
        ACJAD1BPaxhNLOxF0nH9Br3iocJaEYdkINpx5ys=
X-Google-Smtp-Source: ACcGV63B3J8ZEfLbh9sy8Pf4L/NmbDELyTkg6vLZAhm+PzFWa4XRPb7hLoD8SQLWMtxz/oKvlO9IacP7SOLlr/a//4M=
X-Received: by 2002:aca:c00a:: with SMTP id q10-v6mr2742449oif.4.1538047401537;
 Thu, 27 Sep 2018 04:23:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:936e:0:0:0:0:0 with HTTP; Thu, 27 Sep 2018 04:23:21
 -0700 (PDT)
In-Reply-To: <5236278.7dVKUIXYaR@daneel.sf-tec.de>
References: <20180927014138.GA8988@WindFlash> <5236278.7dVKUIXYaR@daneel.sf-tec.de>
From:   Leonardo Bras <leobras.c@gmail.com>
Date:   Thu, 27 Sep 2018 08:23:21 -0300
Message-ID: <CADvQ+rFPiaGKLyzfSx4DmTnmgG15=Jk0RVy8xuYYyvLPJfDdkA@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] drivers: oprofile: Avoids building driver from
 direct make command
To:     Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rolf,

On Thu, Sep 27, 2018 at 3:34 AM, Rolf Eike Beer <eike-kernel@sf-tec.de> wro=
te:
> Am Donnerstag, 27. September 2018, 03:41:38 CEST schrieb Leonardo Br=C3=
=A1s:
>> Creates new Makefile to avoid building driver if
>> 'make drivers/oprofile/' is called directly.
>>
>> This driver is usually built from arch/$ARCH and seems to have
>> no meaning building alone.
>>
>> Signed-off-by: Leonardo Br=C3=A1s <leobras.c@gmail.com>
>> ---
>>  drivers/oprofile/Makefile | 2 ++
>>  1 file changed, 2 insertions(+)
>>  create mode 100644 drivers/oprofile/Makefile
>>
>> diff --git a/drivers/oprofile/Makefile b/drivers/oprofile/Makefile
>> new file mode 100644
>> index 000000000000..acaed2ad6eee
>> --- /dev/null
>> +++ b/drivers/oprofile/Makefile
>> @@ -0,0 +1,2 @@
>> +#Does nothing, since the source is called from arch/$ARCH/ tree.
>> +
>
> Now there is a blank line where it does not need to be.
>
> Eike

Oh, it's a Makefile, and as all text files, it have to end with newline.
If I am wrong, please let me know.

Thanks for your feedback,

Leonardo Bras,
