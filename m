Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A10C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A41620861
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbeL3RuJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 12:50:09 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:1869 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbeL3RuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 12:50:08 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43SSdN6dZBz9tyyM;
        Sun, 30 Dec 2018 18:50:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id IFlTTtuyCB7x; Sun, 30 Dec 2018 18:50:00 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43SSdN61zsz9tyyL;
        Sun, 30 Dec 2018 18:50:00 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id 57EE11CB; Sun, 30 Dec 2018 18:50:02 +0100 (CET)
Received: from 37-165-14-176.coucou-networks.fr
 (37-165-14-176.coucou-networks.fr [37.165.14.176]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Sun, 30 Dec 2018 18:50:02 +0100
Date:   Sun, 30 Dec 2018 18:50:02 +0100
Message-ID: <20181230185002.Horde.AdSknvcs4hP1Kh_T_Cos6w8@messagerie.si.c-s.fr>
From:   LEROY Christophe <christophe.leroy@c-s.fr>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Finn Thain <fthain@telegraphics.com.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: [PATCH v8 01/25] scsi/atari_scsi: Don't select CONFIG_NVRAM
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <e68fcc3ec0a6cd4e14f763366d4d9445890b9b82.1545784679.git.fthain@telegraphics.com.au>
 <20181228173846.Horde.z_zDEJN0rVd8tkt3HjYzmg2@messagerie.si.c-s.fr>
 <alpine.LNX.2.21.1812291050330.152@nippy.intranet>
 <a170720a-fe17-744d-790b-e258465bd75e@gmail.com>
 <alpine.LNX.2.21.1812291327380.152@nippy.intranet>
 <5e901432-65e2-c87b-31e3-36a394687a9a@gmail.com>
 <CAK8P3a1J3sy55nd5QbxR5AjxkLyE-RE=bDNKB9sG27xx=mZ60A@mail.gmail.com>
In-Reply-To: <CAK8P3a1J3sy55nd5QbxR5AjxkLyE-RE=bDNKB9sG27xx=mZ60A@mail.gmail.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> a écrit :

> On Sat, Dec 29, 2018 at 3:51 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
>>
>> Hi Finn,
>>
>> Am 29.12.2018 um 15:34 schrieb Finn Thain:
>> > On Sat, 29 Dec 2018, Michael Schmitz wrote:
>> >
>> >>
>> >> IS_BUILTIN(CONFIG_NVRAM) is probably what Christophe really  
>> meant to suggest.
>> >>
>> >> Or (really going out on a limb here):
>> >>
>> >> IS_BUILTIN(CONFIG_NVRAM) ||
>> >> ( IS_MODULE(CONFIG_ATARI_SCSI) && IS_ENABLED(CONFIG_NVRAM) )
>> >>
>> >> Not that I'd advocate that, for this series.
>> >>
>> >
>> > Well, you are a maintainer for atari_scsi.c.
>> >
>> > Are you saying that you want IS_BUILTIN(CONFIG_NVRAM) used here instead of
>> > ifdef?
>>
>> No, just pointing out that there would be a way to avoid the ifdef
>> without messing up driver behaviour. I'm fine with the ifdef - not least
>> because it clearly eliminates code that would be unreachable.
>>
>> (On second thought - I don't want to speculate whether there's weird
>> compiler options that could result in the nvram_check_checksum and
>> nvram_read_bytes symbols to still be referenced in the final link, even
>> though IS_BUILTIN(CONFIG_NVRAM) always evaluates to false. Best leave
>> this as-is.)
>
> As far as I know, it's totally reliable with the supported compilers  
> (gcc-4.6+).
> In the older compilers (e.g. 4.1), there was a corner case, where it could
> have failed to eliminate a function that was only referenced through  
> a pointer
> from a discarded variable, but a plain IS_ENABLED() check like the one here
> was still ok, and lots of code relies on that.
>
> Other than that, I agree either way is totally fine here, so no objections
> to using the #ifdef.

As far as I know, kernel codying style promotes the use of  
IS_ENABLED() etc. instead of #ifdefs when possible.

Christophe

>
>       Arnd


