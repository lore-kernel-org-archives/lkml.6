Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808E2C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 02:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 522D02146F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 02:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbeL2Cdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 21:33:47 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:33594 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbeL2Cdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 21:33:46 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 711D328CFC;
        Fri, 28 Dec 2018 21:33:44 -0500 (EST)
Date:   Sat, 29 Dec 2018 13:34:02 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Michael Schmitz <schmitzmic@gmail.com>
cc:     LEROY Christophe <christophe.leroy@c-s.fr>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-m68k@lists.linux-m68k.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v8 01/25] scsi/atari_scsi: Don't select CONFIG_NVRAM
In-Reply-To: <a170720a-fe17-744d-790b-e258465bd75e@gmail.com>
Message-ID: <alpine.LNX.2.21.1812291327380.152@nippy.intranet>
References: <cover.1545784679.git.fthain@telegraphics.com.au> <e68fcc3ec0a6cd4e14f763366d4d9445890b9b82.1545784679.git.fthain@telegraphics.com.au> <20181228173846.Horde.z_zDEJN0rVd8tkt3HjYzmg2@messagerie.si.c-s.fr> <alpine.LNX.2.21.1812291050330.152@nippy.intranet>
 <a170720a-fe17-744d-790b-e258465bd75e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2018, Michael Schmitz wrote:

> 
> IS_BUILTIN(CONFIG_NVRAM) is probably what Christophe really meant to suggest.
> 
> Or (really going out on a limb here):
> 
> IS_BUILTIN(CONFIG_NVRAM) ||
> ( IS_MODULE(CONFIG_ATARI_SCSI) && IS_ENABLED(CONFIG_NVRAM) )
> 
> Not that I'd advocate that, for this series.
> 

Well, you are a maintainer for atari_scsi.c.

Are you saying that you want IS_BUILTIN(CONFIG_NVRAM) used here instead of 
ifdef?

OTOH, if you approve of the existing patch, please send your acked-by.

-- 

> Cheers,
> 
> 	Michael
> 
> 
> 
> 
