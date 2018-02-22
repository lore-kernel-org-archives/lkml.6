Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751368AbeBVSoc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 13:44:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:56415 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750765AbeBVSoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 13:44:30 -0500
Date: Thu, 22 Feb 2018 19:44:28 +0100
From: Jiri Bohac <jbohac@suse.cz>
To: David Howells <dhowells@redhat.com>
Cc: linux-security-module@vger.kernel.org, jforbes@redhat.com,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/30] Enforce module signatures if the kernel is locked
 down
Message-ID: <20180222184428.yby6usf4b5pd6nrw@dwarf.suse.cz>
References: <151024866805.28329.10437019941463042267.stgit@warthog.procyon.org.uk>
 <151024863544.28329.2436580122759221600.stgit@warthog.procyon.org.uk>
 <30284.1519304877@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30284.1519304877@warthog.procyon.org.uk>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 01:07:57PM +0000, David Howells wrote:
> I'm considering folding the attached changes into this patch.
> 
> It adjusts the errors generated:
> 
>  (1) If there's no signature (ENODATA) or we can't check it (ENOPKG, ENOKEY),
>      then:
> 
>      (a) If signatures are enforced then EKEYREJECTED is returned.
> 
>      (b) If IMA will have validated the image, return 0 (okay).
> 
>      (c) If there's no signature or we can't check it, but the kernel is
> 	 locked down then EPERM is returned (this is then consistent with
> 	 other lockdown cases).
> 
>  (2) If the signature is unparseable (EBADMSG, EINVAL), the signature fails
>      the check (EKEYREJECTED) or a system error occurs (eg. ENOMEM), we return
>      the error we got.
> 
> Note that the X.509 code doesn't check for key expiry as the RTC might not be
> valid or might not have been transferred to the kernel's clock yet.

Looks good. 

Reviewed-by: Jiri Bohac <jbohac@suse.cz>

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia
