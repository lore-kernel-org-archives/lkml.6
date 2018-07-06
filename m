Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E45C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A234B2142B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhBRfor8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A234B2142B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754225AbeGFUSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 16:18:36 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:37036 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754058AbeGFUSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 16:18:32 -0400
Received: by mail-lf0-f68.google.com with SMTP id j8-v6so10720576lfb.4;
        Fri, 06 Jul 2018 13:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=C0XkJJ7qEtcQsOcdLyb5PBXqP0C342Fz5aL5h29SSoI=;
        b=FhBRfor82xUhVqfdCY9PF6QZ3+NjGx5NPKdgPWQO4CquZjXX6DpYPn8R+CuKSs6p8X
         TUrl4vheCJ8vMCy4T9DK7mAq5/BvF8zkkJLK3qgcFBB262XClfyxTAKRCXaitsIxoRXx
         hYRJpET/psYctCK4oi2TKPzmkKtND1S7w04syLuz0Jkbnkcjue5/nwKnyo6y315ncWU4
         ygUv7/mtqyoNHzUpup++wEU392gHeVqNytghtnytsxPZHrOnjgwryXFzYnp5dLjERddC
         foZtFdcJvd06zd6beV3UxPWPWO3v96IWHRH8wT5LgAgWkjF4PLA302Sprd+Bjt49Z1YL
         +mhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=C0XkJJ7qEtcQsOcdLyb5PBXqP0C342Fz5aL5h29SSoI=;
        b=fHDCfDXRt8yLSz9Wz7+LWqcZC3dq/uLaL6PuNvwkuregSLDQRrDWcw4lzPfvsWkpAY
         IAnEOsOYkOkUs/o0qS5+qoSFLwnVz7gyZyCV9mtmc+UUOOFW0oSMEkfjhsRKLcVJrWSt
         cr4Z1CK5kJ7zDYmGXUb7NdM/OdkW5i6tgg2UR9JA1uJv0YMS9JQ7/5cr9QTqAw5ct42O
         eTEMTFCky8LxGV2GOQsDtILu5Xj27RH5rIbxcMXZW2Gg5LzvF3tYFV/we/CRhs0+2epj
         hVV7gb0OTMDdKGkDLb0wgDC9v0ZCiOANFDgJMztbVecmQn4lPYZ9eCRv+4peHVyAo3of
         9MYg==
X-Gm-Message-State: APt69E2zyPTOL9/Nd2MdY1ebZBfWQl3EJssLZXO3uzE5tADoWkMn+Czh
        EfDdMivyPw3gvzOAE1hqItObZyhSRToFRN+tV8U=
X-Google-Smtp-Source: AAOMgpe9kvsEPpflKaZjNh2oeIqTJRSJPUyzE5w4djrxNvFQ9SA39hYmCgbicBzcJwsptTnBW2iEAY1dG6Hd4hfMw68=
X-Received: by 2002:a19:9cca:: with SMTP id f193-v6mr8204335lfe.60.1530908311203;
 Fri, 06 Jul 2018 13:18:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Fri, 6 Jul 2018 13:18:30 -0700 (PDT)
In-Reply-To: <47d87d9ca498687344fcb18067ffe5e7bc313616.camel@wdc.com>
References: <20180706132407.4069001-1-arnd@arndb.de> <47d87d9ca498687344fcb18067ffe5e7bc313616.camel@wdc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 6 Jul 2018 22:18:30 +0200
X-Google-Sender-Auth: ZZdCRUra7upTwUJ8KEF8oQHJMh4
Message-ID: <CAK8P3a35Z1Wbn0VAF5rfzBfA9ruWnjZ5ZPkPhRYaQnaZv1ejtA@mail.gmail.com>
Subject: Re: [PATCH] sbitmap, scsi/target: add seq_file forward declaration
To:     Bart Van Assche <Bart.VanAssche@wdc.com>
Cc:     "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "osandov@fb.com" <osandov@fb.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 7:07 PM, Bart Van Assche <Bart.VanAssche@wdc.com> wrote:
> On Fri, 2018-07-06 at 15:23 +0200, Arnd Bergmann wrote:
>> The target core runs into a warning in the linux/sbitmap.h
>> file in some configurations:
>>
>> In file included from include/target/target_core_base.h:7,
>>                  from drivers/target/target_core_fabric_lib.c:41:
>> include/linux/sbitmap.h:331:46: error: 'struct seq_file' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
>>  void sbitmap_show(struct sbitmap *sb, struct seq_file *m);
>>                                               ^~~~~~~~
>>
>> In general, headers should not depend on others being included first,
>> so this fixes it with a forward declaration for that struct name, but
>> we probably want to merge the patch through the scsi tree to help
>> bisection.
>>
>> Fixes: 10e9cbb6b531 ("scsi: target: Convert target drivers to use sbitmap")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  include/linux/sbitmap.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
>> index e6539536dea9..cc54b9f7ff8b 100644
>> --- a/include/linux/sbitmap.h
>> +++ b/include/linux/sbitmap.h
>> @@ -321,6 +321,8 @@ static inline int sbitmap_test_bit(struct sbitmap *sb, unsigned int bitnr)
>>
>>  unsigned int sbitmap_weight(const struct sbitmap *sb);
>>
>> +struct seq_file;
>> +
>>  /**
>>   * sbitmap_show() - Dump &struct sbitmap information to a &struct seq_file.
>>   * @sb: Bitmap to show.
>
> In many Linux kernel header files all forward declarations are grouped near
> the start of the header file (after #includes and #defines and before structure
> definitions). Should we follow that pattern in <linux/sbitmap.h>?

I couldn't find any other such declaration in this header, so I just put it
close to where it's first used, which is the other common way to do it.
I checked all of include/linux and found that you are right, a clear
majority of the headers just pull all struct declarations in the front.

     Arnd
