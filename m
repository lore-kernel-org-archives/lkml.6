Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C78C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 02:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A521B218FD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 02:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6uhzUWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbeL2Cue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 21:50:34 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41625 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbeL2Cue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 21:50:34 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so11144988pfi.8;
        Fri, 28 Dec 2018 18:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=HH/VVa7JnPpWgQW9gVxne6LPArl8bMHIK3nhE9clvu4=;
        b=a6uhzUWhRQ14S39hh8Feobo5RXFI3b3IG6DOsuFwQmDPi21474vntMlybsnMovt5nK
         oa6KRQTQvNyJ8UzIyFYH585zkhBagdLSJGhZ9iMuX+SWN/PDxQFcNxFY9isD1mvc5nzd
         Rt4Rb/ocgWckcxw9A1wFaH2XVS5azJm2JqxCZQVVn246mJsXUv5qgtGzqPjlpPuZ1C5j
         YFgGYOZgRPTD4Nhh3NayB6CXJ9wIoKRJ6DLVTkj8LPf+xg1XwkcZrrERTokPy6XimQi4
         igkG+snDBOR1sOWY0UB0yPDB3NJzjNBt9ILnewtAbzWBEDt/itZgECGWO6OrbeRXNa5e
         3Otg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=HH/VVa7JnPpWgQW9gVxne6LPArl8bMHIK3nhE9clvu4=;
        b=Gj3FvcygtlLZ0m0oqn16XgZtVSLb5DUkJqdJV+37d4V+CIOh4f4a8zt5UnWBW06LVH
         ZwQvhXUtdToktvEDqeXTVVqA++RW+mBSvrehY2Mq8zZXV9WjdELicUBjGXQxgnBJD7w+
         OSeyVRkte5tL0T+B6SVeEolVq6ttLXN+RBSMNsCE1+5imy3q1qKb8Yzvtb6F4bL6Nv/T
         tTEr65mGC+ESOCKxx41mQddmJpXCydzasgdPxqhvx2rsCGUAYXMRAmxPg6egrNnPjr9M
         GgMd0mVri9Ok15rHZbcgD4MsabSkuStimFTNNVmppTsK586F+WWiyLAJzlEngZQEVNgp
         3Ylg==
X-Gm-Message-State: AJcUukeBKY36+mzcyuWsjRS3paVxnzE9s3ffKZqvZPZoyQ+e39/960bQ
        Ypxk+q5Ytr9pBpeO9I/8+eQ=
X-Google-Smtp-Source: ALg8bN4E1A2uVct1AsGLJkRQZMqSIZqm4C2uX3mwR0Cp0JXV9wrw1hr4OzmWwjdEDT7LwBaUGubS7Q==
X-Received: by 2002:a63:ab08:: with SMTP id p8mr372699pgf.87.1546051833241;
        Fri, 28 Dec 2018 18:50:33 -0800 (PST)
Received: from [192.168.1.101] (122-58-176-92-adsl.sparkbb.co.nz. [122.58.176.92])
        by smtp.gmail.com with ESMTPSA id n21sm59547273pfg.84.2018.12.28.18.50.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 18:50:32 -0800 (PST)
Subject: Re: [PATCH v8 01/25] scsi/atari_scsi: Don't select CONFIG_NVRAM
To:     Finn Thain <fthain@telegraphics.com.au>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <e68fcc3ec0a6cd4e14f763366d4d9445890b9b82.1545784679.git.fthain@telegraphics.com.au>
 <20181228173846.Horde.z_zDEJN0rVd8tkt3HjYzmg2@messagerie.si.c-s.fr>
 <alpine.LNX.2.21.1812291050330.152@nippy.intranet>
 <a170720a-fe17-744d-790b-e258465bd75e@gmail.com>
 <alpine.LNX.2.21.1812291327380.152@nippy.intranet>
Cc:     LEROY Christophe <christophe.leroy@c-s.fr>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-m68k@lists.linux-m68k.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <5e901432-65e2-c87b-31e3-36a394687a9a@gmail.com>
Date:   Sat, 29 Dec 2018 15:50:23 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1812291327380.152@nippy.intranet>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

Am 29.12.2018 um 15:34 schrieb Finn Thain:
> On Sat, 29 Dec 2018, Michael Schmitz wrote:
>
>>
>> IS_BUILTIN(CONFIG_NVRAM) is probably what Christophe really meant to suggest.
>>
>> Or (really going out on a limb here):
>>
>> IS_BUILTIN(CONFIG_NVRAM) ||
>> ( IS_MODULE(CONFIG_ATARI_SCSI) && IS_ENABLED(CONFIG_NVRAM) )
>>
>> Not that I'd advocate that, for this series.
>>
>
> Well, you are a maintainer for atari_scsi.c.
>
> Are you saying that you want IS_BUILTIN(CONFIG_NVRAM) used here instead of
> ifdef?

No, just pointing out that there would be a way to avoid the ifdef 
without messing up driver behaviour. I'm fine with the ifdef - not least 
because it clearly eliminates code that would be unreachable.

(On second thought - I don't want to speculate whether there's weird 
compiler options that could result in the nvram_check_checksum and 
nvram_read_bytes symbols to still be referenced in the final link, even 
though IS_BUILTIN(CONFIG_NVRAM) always evaluates to false. Best leave 
this as-is.)

> OTOH, if you approve of the existing patch, please send your acked-by.

Of course - I'd seen Geert's acked-by on some of the patches and forgot 
to check which still required acks.

Cheers,

	Michael


