Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE706C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651CC215E5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeLn/ndh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651CC215E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbeI0RhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:37:24 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37570 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbeI0RhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:37:23 -0400
Received: by mail-ot1-f65.google.com with SMTP id o13-v6so2178501otl.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 04:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FIPQZIr/xsGU2+WiZx4etTD1leHQOjXLm/o8Q9VAquU=;
        b=KeLn/ndh+m1wFzaT8IB2pCGpkaa2gBM7dBzmne38DmeqxXa/3OraEn++rFxtgNEPUp
         WLnxa2kBcbqjHPVh6h0HfdIf/ZPybKxzOeFvu0xym2kGdbV8HTZhlNzEVt54bwEWyFQb
         66TUOjLBijHSNe+Kk9Cj9p38XI9QvV/g43fA/40yRdN//ddbmATa53UWnfcwtjNVJpXp
         kBnzLtZUGVQf3Uy7oW8CC4GO/4l2bJmrZM5lXY/tAXlTQeX6GJwE1g5S2MxeJkwYY3qb
         IwzMqCZjFDYuWPW4rZxBXFb0d2GsbDkCzAXa5QK/VnkaTBPYCR520OkrxFA1vrGNc+bZ
         wNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FIPQZIr/xsGU2+WiZx4etTD1leHQOjXLm/o8Q9VAquU=;
        b=Oknjv2wY8y1TxAwFTqyqEjk1ANF7bleI3Drev1WqOZbFdPV5MO4xiy2wFVBI5Ox0E1
         OFZ+EJbTJJmliJpp+noQ4j1C4IDyo84IDFYEcQFWaV8lDFYjemjhZNSZMQ0gJYS1AmnE
         0fEx782sWvthtV5Z/prU1ZhyD2eHri4HRnatnvHKZbZ50H1Po42N+OCYTuRIByDMtICN
         Y7mGwHtJ2kPk/gJxNkfLDodYsgdxVKN1CYxFIJ8D6H0Tv3UDo2aGO2lCouvkvVknP2z1
         Gjpr7BwXIg34plTSWqg5ShYhuWPaJgrUQUUgT4N3t8vVMMW64xjPFsusbNO+PmE81PSZ
         z5cA==
X-Gm-Message-State: ABuFfoitUaLKrTipNm4IehnBHE2eJgf5mtsSSbm8gaXVCz6l9gHtnqCJ
        0Gg5EXXuq9v4tykuU/mX0CA/lGc9muZFWexy+1SSrg==
X-Google-Smtp-Source: ACcGV63yq1b4A6fsJPj0sqh57ot5aC1R3rBJBMvGhU92ScWQTAkvuz9kUSRkgLuEgyQDkrdEBJr3EvS9AVH1UApEEWs=
X-Received: by 2002:a9d:e4:: with SMTP id 33-v6mr6404872otk.372.1538047176757;
 Thu, 27 Sep 2018 04:19:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:936e:0:0:0:0:0 with HTTP; Thu, 27 Sep 2018 04:19:36
 -0700 (PDT)
In-Reply-To: <19230260.Wfr244ejmm@daneel.sf-tec.de>
References: <20180927013956.GA8956@WindFlash> <19230260.Wfr244ejmm@daneel.sf-tec.de>
From:   Leonardo Bras <leobras.c@gmail.com>
Date:   Thu, 27 Sep 2018 08:19:36 -0300
Message-ID: <CADvQ+rEWU6hzd2aMvuC=7VQgQ=9xbqpCcG-=FDZtdu1-tMNwYA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] drivers: dio: Avoids building driver if CONFIG_DIO
 is disabled
To:     Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Rolf,

On Thu, Sep 27, 2018 at 3:35 AM, Rolf Eike Beer <eike-kernel@sf-tec.de> wro=
te:
> Am Donnerstag, 27. September 2018, 03:39:56 CEST schrieb Leonardo Br=C3=
=A1s:
>> Avoids building driver if 'make drivers/dio/' is called and
>> CONFIG_DIO is disabled.
>>
>> Signed-off-by: Leonardo Br=C3=A1s <leobras.c@gmail.com>
>> ---
>>  drivers/dio/Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/dio/Makefile b/drivers/dio/Makefile
>> index ae92d17083f2..f5cffe232448 100644
>> --- a/drivers/dio/Makefile
>> +++ b/drivers/dio/Makefile
>> @@ -2,4 +2,4 @@
>>  # Makefile for the linux kernel.
>>  #
>>
>> -obj-y :=3D dio.o dio-driver.o dio-sysfs.o
>> +obj-$(CONFIG_DIO) :=3D dio.o dio-driver.o dio-sysfs.o
>> \ No newline at end of file
>   ^^^^^^^^^^^^^^^^^^
>
> One more.

Thanks, I will fix this for v3.
