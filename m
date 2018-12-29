Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6E1C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 18:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5845E20873
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 18:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/4twUS6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbeL2Syh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 13:54:37 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37975 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbeL2Syh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 13:54:37 -0500
Received: by mail-pg1-f196.google.com with SMTP id g189so11302032pgc.5;
        Sat, 29 Dec 2018 10:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=GbTXTG3fTjjT0j2bl1UC5cYq6voZf08wx/Uq2Iez900=;
        b=p/4twUS6baZ4btZZMrTxl4N2PJrH0sNPYZMwbbNcylXpXzmnSSzNkyXtyHx5fIu8nl
         Pf2LCZ+ecFESmMGSXROG/sN4aXo01Y3VyUw4yCP9idN9xkC59nsxuJ4WtTVPOH4653MB
         R6G10obPANMw9NR23O9ncRzZoMEaSlthOgYChdVkSNeN0k8nvPrtQVZnopOV20MYqivO
         G/X+jhRq6ZiH1g70WAryxIKkxYninGJ1XkXFoCMm1HgBqvHRajQo1G3h4bpq9DFKEsVQ
         eXq556GAYeAQ3Pejtkh2SzRLb2vUb0L0TTxbIabfq9NiCanDZMbyCRFiAMLyAOupZQlT
         YjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=GbTXTG3fTjjT0j2bl1UC5cYq6voZf08wx/Uq2Iez900=;
        b=bitC4jvY20+qj7mR12rkPYTMWP6qqgNGMDngX5/Q0IxXGJIDhX/TmstFbFrVLJBqQn
         luUaBR0TvgVz4/6L0Di+ERm5JqiGXXfspvnTYEnTnxvQt4rQ3eysdKWQ+uPvA9AfB799
         jrMPUgJm2RatzCs2R10m0/kJzBw6YWwyLAw7G5T56O75V5SYU+QbS12kWP9T43emS9JF
         PFb+q+d2FbPgJUkrZEVw3Q0jgjU0it0skrGfnZAt5MEoh+XDiXC63bU1aCF2r9GXyQLH
         xHw2C9yjWghuVqZHQqRWQvZhNkU3i8+tqFncDs9MDyMoPiXwEWiWKaZOctsyCQdln+me
         ygqg==
X-Gm-Message-State: AA+aEWY+5ehi/3FFQxx2SUGP5K39C8cRJ+7mkc9b8E0EFlmBwN4tK6Ea
        SbUJFpPxxwtP1fyag15EHJ8=
X-Google-Smtp-Source: ALg8bN64u1GO0SOpRioLk9AUlNfvpu+YJitkVXkgRILNo4E3FZ/OQinzyDQNOHttQ3DDHw4vfeXsxw==
X-Received: by 2002:a62:2292:: with SMTP id p18mr33519493pfj.9.1546109674949;
        Sat, 29 Dec 2018 10:54:34 -0800 (PST)
Received: from [192.168.1.101] (122-58-176-92-adsl.sparkbb.co.nz. [122.58.176.92])
        by smtp.gmail.com with ESMTPSA id d3sm56222328pgl.64.2018.12.29.10.54.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 10:54:33 -0800 (PST)
Subject: Re: [PATCH v8 01/25] scsi/atari_scsi: Don't select CONFIG_NVRAM
To:     LEROY Christophe <christophe.leroy@c-s.fr>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <e68fcc3ec0a6cd4e14f763366d4d9445890b9b82.1545784679.git.fthain@telegraphics.com.au>
 <20181228173846.Horde.z_zDEJN0rVd8tkt3HjYzmg2@messagerie.si.c-s.fr>
 <alpine.LNX.2.21.1812291050330.152@nippy.intranet>
 <a170720a-fe17-744d-790b-e258465bd75e@gmail.com>
 <20181229175502.Horde.OaGr035vfDpvlvNGdmoaOQ2@messagerie.si.c-s.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Finn Thain <fthain@telegraphics.com.au>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <c50e2aa2-85d5-4eba-f74b-a3f9c0963c97@gmail.com>
Date:   Sun, 30 Dec 2018 07:54:24 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <20181229175502.Horde.OaGr035vfDpvlvNGdmoaOQ2@messagerie.si.c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe,

Am 30.12.2018 um 05:55 schrieb LEROY Christophe:
> Michael Schmitz <schmitzmic@gmail.com> a écrit :
>
>> Hi Finn,
>>
>> Am 29.12.2018 um 14:06 schrieb Finn Thain:
>>> On Fri, 28 Dec 2018, LEROY Christophe wrote:
>>>>> diff --git a/drivers/scsi/atari_scsi.c b/drivers/scsi/atari_scsi.c
>>>>> index 89f5154c40b6..99e5729d910d 100644
>>>>> --- a/drivers/scsi/atari_scsi.c
>>>>> +++ b/drivers/scsi/atari_scsi.c
>>>>> @@ -755,9 +755,10 @@ static int __init atari_scsi_probe(struct
>>>>> platform_device *pdev)
>>>>>     if (ATARIHW_PRESENT(TT_SCSI) && setup_sg_tablesize >= 0)
>>>>>         atari_scsi_template.sg_tablesize = setup_sg_tablesize;
>>>>>
>>>>> -    if (setup_hostid >= 0) {
>>>>> +    if (setup_hostid >= 0)
>>>>>         atari_scsi_template.this_id = setup_hostid & 7;
>>>>> -    } else {
>>>>> +#ifdef CONFIG_NVRAM
>>>>> +    else
>>>>
>>>> Such ifdefs should be avoided in C files.
>>>> It would be better to use
>>>>
>>>> } else if (IS_ENABLED(CONFIG_NVRAM)) {
>>>>
>>>
>>> I don't like #ifdefs either. However, as the maintainer of this file,
>>> I am
>>> okay with this one.
>>>
>>> The old #ifdef CONFIG_NVRAM conditional compilation convention that gets
>>> used here and under drivers/video/fbdev could probably be improved upon
>>> but I consider this to be out-of-scope for this series, which is
>>> complicated enough.
>>>
>>> And as explained in the commit log, CONFIG_NVRAM=y and CONFIG_NVRAM=m
>>> are
>>> treaded differently by drivers. Therefore, IS_ENABLED would be
>>> incorrect.
>>
>> IS_BUILTIN(CONFIG_NVRAM) is probably what Christophe really meant to
>> suggest.
>
> Doesn't #ifdef means either y or m ? So the same as IS_ENABLED() ?

#ifdef CONFIG_NVRAM is used if you want to match CONFIG_NVRAM=y. For 
CONFIG_NVRAM=m, you'd use #ifdef CONFIG_NVRAM_MODULE.

Cheers,

	Michael


>
> Christophe
>
>>
>> Or (really going out on a limb here):
>>
>> IS_BUILTIN(CONFIG_NVRAM) ||
>> ( IS_MODULE(CONFIG_ATARI_SCSI) && IS_ENABLED(CONFIG_NVRAM) )
>>
>> Not that I'd advocate that, for this series.
>>
>> Cheers,
>>
>>     Michael
>
>
