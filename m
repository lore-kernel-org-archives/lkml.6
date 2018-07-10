Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3809C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F592208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAI/BQXe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F592208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934265AbeGJPkZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:40:25 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:44963 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933475AbeGJPkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:40:23 -0400
Received: by mail-oi0-f66.google.com with SMTP id s198-v6so43438666oih.11;
        Tue, 10 Jul 2018 08:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=sDYtqkB5ecz4NxXx+2/UH5lO10c9c2xY8JD5ki42hUY=;
        b=LAI/BQXeMMXO9o71XQ7FUy8YDJnClPYCWoDy7aKBgMiGnWedKlCdEBXJ+F+MotbRDV
         q7MSU+bhNMrE6R+xTj/ZFvBTtHpvnzi5fA+MZiVgrk/yUhzkjVNFMwFPeeku13O8WODW
         NcC9+gagIe7+f2pEjVWdhvkEYpTswjV59QnfnqbSF21cc6e2NeDhPipYu0ntOtuytCIJ
         gPYn6rtYOl4vcjlodU5+WlgT94LiJYfRnMYtlxJljvUtRBuWjF3bTu/vyLXYwGIFKpzi
         68FMMzsIq+L5/wKubzB/tr37CMEQs8Oyxz6+5vP5KHJqXXLb355i3z3fjIdie9PyVpLw
         dsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=sDYtqkB5ecz4NxXx+2/UH5lO10c9c2xY8JD5ki42hUY=;
        b=RA7bJGEBogPuNdO2Nme82pFtQzfDT8FipajrpSGKfxa7IRwApjiUHB31SR4istWiay
         Orrg4nLi7bu1ky1kgp9N6pyc1CO0cVMrLcaC66BzGvEp3x12Lyh6tVDv80EfNhnTbujs
         FLflJvprJYtaj05ZGz48yYvqnsEBW5n7Q57qdEXzOMgmi8F9jl2ygSI14WLI8girrznd
         YfbzxWvTAH9e3f0Bl/LVcmmyTYqt8Z10lzc1VdQgm4d9+zWFyV8lqsM3xNKc5SJFkDeL
         +DTn9NRq9bX0NuNRPlWHt7MPXhnjRuHH9Tfmfa7PXlRH5qnoaRBp8GgrLQSxFyR0mvKv
         J44Q==
X-Gm-Message-State: APt69E1IrCLxXKri/40OK5yYv23Hm17ptHf/qrZaNpPD57LLglq71l5j
        /miFj7qGHYOwbGZaICyT2qpapOD4KdFOPSlkhV4=
X-Google-Smtp-Source: AAOMgpeKp3LTkEP5rOSUuc5A7oHD1xjsITtBIguWD55j+h9ZUklXVUR9jBiSWAbEq9zzhm6Z/m7vdv3oz+BRx9DEZXg=
X-Received: by 2002:aca:6910:: with SMTP id e16-v6mr26918592oic.358.1531237222308;
 Tue, 10 Jul 2018 08:40:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 08:40:21
 -0700 (PDT)
In-Reply-To: <20180710125956.GA25343@kroah.com>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <8816662.k3KXbdkA2e@aspire.rjw.lan> <2927655.Y1qg3UnIrE@aspire.rjw.lan>
 <5284251.Resgjlja2Q@aspire.rjw.lan> <20180710125956.GA25343@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Jul 2018 17:40:21 +0200
X-Google-Sender-Auth: lLGCeqSPYqUm8TCDBxF1Y01p3ZU
Message-ID: <CAJZ5v0iV0ZaCbhoVOrGx08f6Y7Ei2q+qazxEMQRYD4LAq9LUbA@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: Partially revert "driver core: correct
 device's shutdown order"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pingfan Liu <kernelfans@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 2:59 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Jul 10, 2018 at 02:51:33PM +0200, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Commit 52cdbdd49853 (driver core: correct device's shutdown order)
>> introduced a regression by breaking device shutdown on some systems.
>>
>> Namely, the devices_kset_move_last() call in really_probe() added by
>> that commit is a mistake as it may cause parents to follow children
>> in the devices_kset list which then causes shutdown to fail.  For
>> example, if a device has children before really_probe() is called
>> for it (which is not uncommon), that call will cause it to be
>> reordered after the children in the devices_kset list and the
>> ordering of that list will not reflect the correct device shutdown
>> order any more.
>>
>> Also it causes the devices_kset list to be constantly reordered
>> until all drivers have been probed which is totally pointless
>> overhead in the majority of cases and it only covered an issue
>> with system shutdown, while system-wide suspend/resume potentially
>> had the same issue on the affected platforms (which was not covered).
>>
>> Moreover, the shutdown issue originally addressed by the change in
>> really_probe() made by commit 52cdbdd49853 is not present in 4.18-rc
>> any more, since dra7 started to use the sdhci-omap driver which
>> doesn't disable any regulators during shutdown, so the really_probe()
>> part of commit 52cdbdd49853 can be safely reverted.  [The original
>> issue was related to the omap_hsmmc driver used by dra7 previously.]
>>
>> For the above reasons, revert the really_probe() modifications made
>> by commit 52cdbdd49853.
>>
>> The other code changes made by commit 52cdbdd49853 are useful and
>> they need not be reverted.
>>
>> Fixes: 52cdbdd49853 (driver core: correct device's shutdown order)
>> Link: https://lore.kernel.org/lkml/CAFgQCTt7VfqM=UyCnvNFxrSw8Z6cUtAi3HUwR4_xPAc03SgHjQ@mail.gmail.com/
>> Reported-by: Pingfan Liu <kernelfans@gmail.com>
>> Tested-by: Pingfan Liu <kernelfans@gmail.com>
>> Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>
>> -> v2: Added information from Kishon on the fact that it should be safe
>>        to revert the really_probe() modifications added by the
>>        problematic commit.  Also added the Reviewed-by tag from Kishon.
>
> Looks good to me, want me to queue it up in my tree, or are you going to
> send it on to Linus?

Please queue it up.

> And shouldn't this have a stable tag as well?

That is sort of a gray area, because I think it may expose the
shutdown issue on dra7 in -stable, but technically it still fixes a
regression in the driver core.  So your call I suppose. :-)

FWIW, commit 52cdbdd49853 went in during the 4.3 cycle AFAICS.

Cheers,
Rafael
