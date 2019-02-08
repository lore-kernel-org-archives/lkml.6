Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C9DC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B08218D9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1CkdT3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfBHLFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 06:05:55 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42999 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfBHLFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 06:05:54 -0500
Received: by mail-ot1-f68.google.com with SMTP id v23so5123632otk.9;
        Fri, 08 Feb 2019 03:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zXHJqO5kYdjQIh175jjIQKAv0+RlFrvNTrEMg/QvCfA=;
        b=q1CkdT3GUZ3b7Z3nwBJDE1alMUot9pL3oER2gLKbm82fHG2DwfvlGc+V4LIzcsyKXv
         iYUexP6/wb8/qGLE5nLDriylW2y+LLsMTAuUffB3qjNj4efdT/Z8CUqV+EP5TAtNRcJN
         H4Vo9hTnylDzQm30dzhiX1i+sQHG2r0mlCVvmuqPNVfJKficuN9bab6UyF45QJNduEwM
         Y+lVE6d8fjcAZ6WUuuqYANbJbGWMHArecOryxV44RUvVCfw+IKKVDq207M5JYjPoBCfX
         tngzEUzhf9j9T3x7CDOc/IsGSwgecykDcORQ9Kehqoq2ac5JrTpsNVPUsjmoD5Jy611M
         CMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zXHJqO5kYdjQIh175jjIQKAv0+RlFrvNTrEMg/QvCfA=;
        b=RG8qV35HazEh1jzmzdJJnc6eGyIDy4ssYnEBSbm+Q8bLalPSY86QZ7KPvVk+mPXxaa
         nJ3nOYA+v53iEVbp95JWIMF2FkT5zTtLuluLUQuoC8fB9jFPUqzKOM9TqBArfbQFzIAE
         vybQc8oilG/C5hx5U9Ff6d8V01/rQrxwQzQtUkvXErGBfcuLilMmMmXhkOGQB46Caq01
         IBscnywND5ubSskiwECA/OV2RlsRRZ/GdyuuvppOPEMZZQc2940XLyY8uSGx0yD29C2B
         q2zmzlavh9exDqwgs7GYQXK4mV6pHAk9Zz8jmt3A9miSoPRosJfMdqaTJMYtEnNrbz48
         XmZA==
X-Gm-Message-State: AHQUAuZMFuEQVDWTg0KQLfon3FuExYl1XB/IoLKvB7jueiKrVSJt++cZ
        +wTdb+k16sHMe77ToQTOS1Gk86IjuU67hcs+IppW3g==
X-Google-Smtp-Source: AHgI3Ia9qL3KOe3SISQ66koUXPs1BVWTTqbSzgJXW7LTCPQN8faM9lnsr5b0/ksOa7VREPRL4x4ZI8vntzNVtXFb5m0=
X-Received: by 2002:a9d:3bc7:: with SMTP id k65mr12612365otc.11.1549623953921;
 Fri, 08 Feb 2019 03:05:53 -0800 (PST)
MIME-Version: 1.0
References: <20190208024110.8021-1-allen.lkml@gmail.com> <20190208083808.GB2803@osiris>
In-Reply-To: <20190208083808.GB2803@osiris>
From:   Allen <allen.lkml@gmail.com>
Date:   Fri, 8 Feb 2019 16:35:42 +0530
Message-ID: <CAOMdWSK=JOQkS+nce+1YXZQFoYE5OgJTb2QuoWN_iP8tHvE3Pw@mail.gmail.com>
Subject: Re: [PATCH] Use ARRAY_SIZE instead of dividing sizeof array with
 sizeof an element.
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > diff --git a/arch/s390/tools/gen_opcode_table.c b/arch/s390/tools/gen_opcode_table.c
> > index a1bc02b29c81..468b70c85f62 100644
> > --- a/arch/s390/tools/gen_opcode_table.c
> > +++ b/arch/s390/tools/gen_opcode_table.c
> > @@ -138,7 +138,7 @@ static struct insn_type *insn_format_to_type(char *format)
> >       strcpy(tmp, format);
> >       base_format = tmp;
> >       base_format = strsep(&base_format, "_");
> > -     for (i = 0; i < sizeof(insn_type_table) / sizeof(insn_type_table[0]); i++) {
> > +     for (i = 0; i < ARRAY_SIZE(insn_type_table); i++) {
>
> This does not compile.
>
   Surprising. I try it out again.

Thanks.

-- 
       - Allen
