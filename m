Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A4CC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 01:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6015218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 01:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rVGbyG54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbeL2BdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 20:33:13 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:47019 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728967AbeL2BdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 20:33:11 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so10642200pgp.13;
        Fri, 28 Dec 2018 17:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=0g+71U+dX+QF2iiDoSz5x+9PmsICHaGBbrjNqL+fqJA=;
        b=rVGbyG54LViWSoyiHppDMoeyktkoVpAJAdeBYdHLR/LVmuJR5JfG9XKWydst2M8Hzx
         tvVUYcMyNMjqu9r0Uic3yOU9XVJb6lz9xUTtVxtQ8nrWltZB5JgZAUzwahCvb+hMutdz
         0d+R2JGf9xFxt8xD5iXfVs/CYvmq1dXe4/08pV749JJ+ao3gnvBzXMJS7Wl3t0Tt3pTq
         NhisMXY7XnEAldBrc9LILyvpSxloWoTj5y0hbyPB3YsfnmlMxWqo+sLTkwM8m7YAdnRN
         JDmW+PkJsDc5usAwFxu4BzrhBLq0r0R4QWJ5ah4AywrW1lmm1kz2p/9Ubu5TZt5vdyPB
         rDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=0g+71U+dX+QF2iiDoSz5x+9PmsICHaGBbrjNqL+fqJA=;
        b=hHqXTCBZr4rggQy+5yeOgC+Zx8edsFe3DUVwlEmJQm6sdrUM97CePgLKfRQZLYc8Jh
         H7A4umXQ6HuNJTRBleZw9uk7EkTkl1Xvuyt5/Dtj6yPPi1KEeHZ8+HfX9QS3M6fiWIDR
         OQyKJplyhInAqzHQom8MCImC4kVXcEqVCWehLgMcPYKBAUoRdXPjDZqAQq5XtJ6O+/Bp
         rtBg3g4W/lmi8d+OmO1CnZ5DvNQmtry4rIBaYwS6SUP9TxeF9S8L7FOvocAmGE+m+9LY
         IaUg8U4QKTJiZ/oSWUCV3dpk3aCjG7DeVBxYd6aHjlroXOGu9t9jkvFeO73SeKtjXMnb
         TVQw==
X-Gm-Message-State: AA+aEWYYu/O+vUGf9laFTSfcjiJyRKSFvB/vzW3ZSx46pd9V04SHuTFJ
        ZBsTDX+CeCpFgOS409sUzNA=
X-Google-Smtp-Source: AFSGD/UI2ut7bgxj+fbDqA2EcIn3+I9kKcAMx9YyKFdhMGHVnrNJx8ywdu1VT4koUsbcows91O6FYw==
X-Received: by 2002:a62:442:: with SMTP id 63mr29667407pfe.156.1546047190014;
        Fri, 28 Dec 2018 17:33:10 -0800 (PST)
Received: from [192.168.1.101] (122-58-176-92-adsl.sparkbb.co.nz. [122.58.176.92])
        by smtp.gmail.com with ESMTPSA id i62sm48795899pge.44.2018.12.28.17.33.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 17:33:09 -0800 (PST)
Subject: Re: [PATCH v8 01/25] scsi/atari_scsi: Don't select CONFIG_NVRAM
To:     Finn Thain <fthain@telegraphics.com.au>,
        LEROY Christophe <christophe.leroy@c-s.fr>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <e68fcc3ec0a6cd4e14f763366d4d9445890b9b82.1545784679.git.fthain@telegraphics.com.au>
 <20181228173846.Horde.z_zDEJN0rVd8tkt3HjYzmg2@messagerie.si.c-s.fr>
 <alpine.LNX.2.21.1812291050330.152@nippy.intranet>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-m68k@lists.linux-m68k.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <a170720a-fe17-744d-790b-e258465bd75e@gmail.com>
Date:   Sat, 29 Dec 2018 14:33:00 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1812291050330.152@nippy.intranet>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

Am 29.12.2018 um 14:06 schrieb Finn Thain:
> On Fri, 28 Dec 2018, LEROY Christophe wrote:
>>> diff --git a/drivers/scsi/atari_scsi.c b/drivers/scsi/atari_scsi.c
>>> index 89f5154c40b6..99e5729d910d 100644
>>> --- a/drivers/scsi/atari_scsi.c
>>> +++ b/drivers/scsi/atari_scsi.c
>>> @@ -755,9 +755,10 @@ static int __init atari_scsi_probe(struct
>>> platform_device *pdev)
>>>  	if (ATARIHW_PRESENT(TT_SCSI) && setup_sg_tablesize >= 0)
>>>  		atari_scsi_template.sg_tablesize = setup_sg_tablesize;
>>>
>>> -	if (setup_hostid >= 0) {
>>> +	if (setup_hostid >= 0)
>>>  		atari_scsi_template.this_id = setup_hostid & 7;
>>> -	} else {
>>> +#ifdef CONFIG_NVRAM
>>> +	else
>>
>> Such ifdefs should be avoided in C files.
>> It would be better to use
>>
>> } else if (IS_ENABLED(CONFIG_NVRAM)) {
>>
>
> I don't like #ifdefs either. However, as the maintainer of this file, I am
> okay with this one.
>
> The old #ifdef CONFIG_NVRAM conditional compilation convention that gets
> used here and under drivers/video/fbdev could probably be improved upon
> but I consider this to be out-of-scope for this series, which is
> complicated enough.
>
> And as explained in the commit log, CONFIG_NVRAM=y and CONFIG_NVRAM=m are
> treaded differently by drivers. Therefore, IS_ENABLED would be incorrect.

IS_BUILTIN(CONFIG_NVRAM) is probably what Christophe really meant to 
suggest.

Or (really going out on a limb here):

IS_BUILTIN(CONFIG_NVRAM) ||
( IS_MODULE(CONFIG_ATARI_SCSI) && IS_ENABLED(CONFIG_NVRAM) )

Not that I'd advocate that, for this series.

Cheers,

	Michael



