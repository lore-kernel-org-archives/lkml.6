Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2120C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 04:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6639C205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 04:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUQXAkth"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6639C205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeKANyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 09:54:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37259 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbeKANyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 09:54:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id c10-v6so8439152pgq.4;
        Wed, 31 Oct 2018 21:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ww0O+AcOeNOBOHZdMlUwe1HH5TmUn6dgOE0DezgBwtg=;
        b=jUQXAkthl2DjKGX9Elld6De2C2z9HdLw1DzcU6VNN3nDhbP+y71NOKlfsAY/BNoIZe
         zdwX7758/oXr030NF8qPsaLjoEOMhmTAel6FMMo3v8l2Pwh2uGFc/5kXcWr3qpj8SFbh
         Pun8NmN1f9jCKCqX6q7tUT88hZOF6FGvaBM1TDXKwI+3GrDk6AkCpE5Q7q0dPb/26CPx
         3D7nLxdtbkF4i0f5hDyN7TFi889zn/NuyQMgm5F6sPWIpn5VDEMS22bghD8vD7KxYIHe
         g+nOsCeDQYXKvst5FY1DTiBox59QXEh/Ys2dER8vnM86gu+0gqCC7zkFVkrrXQsLmnzg
         puRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ww0O+AcOeNOBOHZdMlUwe1HH5TmUn6dgOE0DezgBwtg=;
        b=Dn+sp0qi7vLGXUwh9rbz1pJiVSghNnxwSJ8qe18KApWNdfOoJpm3YDzQqawJ7lknMV
         NUDsSk+8bFROfvbL3e3eoOEsU3y9y7epMBLMQd3G3+T5XUQjbbEgm6eBKwwGTUc5/z5z
         R6xHUpEappoz4FebQbxz9xPeMTksM2jRB5cPmvN6q0hNDP8Iq84zsIfCRsCpE3STRk16
         9d/OKzJQ4Yre48JIlOBcHJ7wt4VPowXGYq05tNtRmUHTiA/Mn4KLjLSlMCBFveUbgcPQ
         F3l8eUzn/RAPjQdtTLK33WSQM3Gt7XsgRJYpxzVnWpB3nJa0DI3Qpbifp3zZT5wO4+DE
         0u+Q==
X-Gm-Message-State: AGRZ1gLNyXOBLOtg4qV3ZQAH22Aa2hTvSywuvtP7FQpmRAXrteP2hYvP
        RoPGDrbWQ+oAic/MSD9+DGUsXAFa
X-Google-Smtp-Source: AJdET5e1KwC6YUp76pLVXkXvjubjARthfZ7d9CgsJtwRDQfHTKANFoR7JS96lFPwTNqdxsQBeBo7jQ==
X-Received: by 2002:a62:5547:: with SMTP id j68-v6mr6284546pfb.166.1541048005203;
        Wed, 31 Oct 2018 21:53:25 -0700 (PDT)
Received: from [192.168.1.101] (122-58-176-92-adsl.sparkbb.co.nz. [122.58.176.92])
        by smtp.gmail.com with ESMTPSA id v18-v6sm10073014pgh.84.2018.10.31.21.53.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 21:53:24 -0700 (PDT)
Subject: Re: [PATCH] ata: add Buddha PATA controller driver
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <CGME20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457@eucas1p2.samsung.com>
 <20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457~es8dn4Tg90035600356eucas1p2H@eucas1p2.samsung.com>
 <f881dd9d-b41f-9993-44fe-71db55fb679d@physik.fu-berlin.de>
 <eb6a751b-8df3-d35c-a744-19d017778c74@physik.fu-berlin.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <9b38c21f-5eab-3d12-ee83-2b9ae1289ea1@gmail.com>
Date:   Thu, 1 Nov 2018 17:53:11 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <eb6a751b-8df3-d35c-a744-19d017778c74@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

my fix is evidently incomplete - I just crashed elgar trying to remove 
the pata_buddha module, sorry. Must've done something silly.

So no, can't post a patch to add module_exit just yet.

Cheers,

	Michael


Am 31.10.2018 um 23:06 schrieb John Paul Adrian Glaubitz:
> Hi!
>
> On 10/25/18 9:38 PM, John Paul Adrian Glaubitz wrote:
>> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>>
>> Michael wants to make some changes to the driver though, I think. He has access
>> to the Amiga 4000, in any case, so he can also test them.
>
> @Michael: Can you post an updated version of the driver, rebased for 4.19
>           and with your patch?
>
> Adrian
>
