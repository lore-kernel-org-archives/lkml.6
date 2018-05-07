Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751010AbeEGEkH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 00:40:07 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:33643 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbeEGEkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 00:40:05 -0400
X-Google-Smtp-Source: AB8JxZrDMWgTmwTjoXadD882Cem4AtL3FL7cDGfbnFKZLkW00E6jdy/a12VmsFKohzIElsIFUsIjqQ==
Date: Mon, 7 May 2018 13:40:51 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: James Morse <james.morse@arm.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 02/11] kexec_file: make
 kexec_image_post_load_cleanup_default() global
Message-ID: <20180507044050.GC11326@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, dyoung@redhat.com,
        bhe@redhat.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
 <20180425062629.29404-3-takahiro.akashi@linaro.org>
 <cbf66675-1671-32f9-1410-a76986becf85@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbf66675-1671-32f9-1410-a76986becf85@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 06:46:04PM +0100, James Morse wrote:
> Hi Akashi,
> 
> On 25/04/18 07:26, AKASHI Takahiro wrote:
> > Change this function from static to global so that arm64 can implement
> > its own arch_kimage_file_post_load_cleanup() later using
> > kexec_image_post_load_cleanup_default().
> 
> Do we need to call kexec_image_post_load_cleanup_default()? All it does is call
> the image-type fops->cleanup(), which you don't implement in this series.
> 
> Is this just-in-case someone adds cleanup() later and is surprised only the
> arch-level helper is called?

Yes, we want not to miss two possibilities:
- some common clean-up code is added to kexec_image_post_load_cleanup_default()
- some format(i.e. Image)-specific clean-up code is added to fops->cleanup()

-Takahiro AKASHI

> 
> 
> Thanks,
> 
> James
