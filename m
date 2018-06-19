Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51541C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0472320652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gpiccoli-net.20150623.gappssmtp.com header.i=@gpiccoli-net.20150623.gappssmtp.com header.b="e+CRUy/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0472320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gpiccoli.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966814AbeFSPaZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:30:25 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:40571 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966591AbeFSPaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:30:22 -0400
Received: by mail-io0-f193.google.com with SMTP id g22-v6so581878iob.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 08:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gpiccoli-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wFXP/+G/y0CiXxzR5wEgHYdiVhVRrbzlGGv4Iu5z9Qw=;
        b=e+CRUy/EgWc5KLGZhrzUwQNLC2YRD+92oM5Zhqx91Edz5SvwJ5IWEp+h7tU87UU802
         keZVwJJSwGDBZUFJZ0DlsP6D5BMMkZZORAXyYztkwXbQ8IrDIgDhANMr3Ly+0xU0txGr
         VmGG8nCxC/Cxt/bJgcDwsyRxzqg08H3eG5YYvnN7CWldEimvum9qoeuda6U4PmOikjgG
         Greg7eF3yfyFlkKRYTJ5sjZVyKlPIRyy8uVfi1aw0ZLBy+2GPMPDT6WPzgwbllzXQG+Q
         cMDhe4tyfPJET748aIupEQoGMZXDexlO8krFsJ2dJRm0by7yt688UGpA93dvm/fCMHHA
         kxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wFXP/+G/y0CiXxzR5wEgHYdiVhVRrbzlGGv4Iu5z9Qw=;
        b=dldnTtCc9qoC/4cAY6dUvF6Sfa16AkcVpEGmJXiDMnzzUJ6+xU/CyeBkkB9KaweZeD
         l3LQ8eV6UsBVp1rxSYMTN4hRk/00s9fnm9NFQuoDHx2qSQsABnC4fRn+jouIdKpVtmS2
         45VHUuCH7XUNlIj6dz9x7txsj+K39K/LEMvd1ivWBPbcMiZ4gS9aMxwMTDnGqb/z7I7h
         hs+CaPqG//qJzIhJDjUjS75PJ5RXJ/NoLvsMqyJOPHBADgRiEfYwWI+22JR04a2g0kLA
         IplsmuDTgXv9bdqQ23UYqXOSpZLIF2FrbZdbF2R6FJKXzwiHwn/vSuKA7R5WDtfGu4qt
         CB7g==
X-Gm-Message-State: APt69E3SRru7YxvhxUM4cWcUAhkxHu2s9ajrjc0Em8fRDzHW6/e346vv
        7Hl5ngScMJqzO8johvBqTBxVv6i/ZknihYlacKSwXw==
X-Google-Smtp-Source: ADUXVKJjdm+ex/C+Acelkg6duBqpmkA46+X8P+WZ8bae3gcs+m7vKl7XqryiZU4RhhbHnFPiZ53+DUFX7zAbHergscc=
X-Received: by 2002:a6b:f314:: with SMTP id m20-v6mr13790428ioh.253.1529422221730;
 Tue, 19 Jun 2018 08:30:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:9909:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 08:29:41
 -0700 (PDT)
X-Originating-IP: [189.0.91.59]
In-Reply-To: <20180618165706.42679-1-danielwa@cisco.com>
References: <20180618165706.42679-1-danielwa@cisco.com>
From:   Guilherme Piccoli <kernel@gpiccoli.net>
Date:   Tue, 19 Jun 2018 12:29:41 -0300
Message-ID: <CALJn8nPbTy3Ne2a7L71c2YZ06Ccr2j0zs6TdptfRc7O-N9u=Yg@mail.gmail.com>
Subject: Re: [PATCH] arch: powerpc: pci-common: fix wrong return value check
 on phd_id
To:     Daniel Walker <danielwa@cisco.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        xe-kernel@external.cisco.com,
        Gavin Shan <gwshan@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Ian Munsie <imunsie@au1.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Mauro Rodrigues <maurosr@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 1:57 PM, Daniel Walker <danielwa@cisco.com> wrote:
> Cisco has a couple platforms which depend on the domain values getting
> set a certain way. We discovered our machines not detecting the pci
> devices, and traced it back to this commit,
>
> 63a7228 powerpc/pci: Assign fixed PHB number based on device-tree
> properties
>
> It seems that the code is expecting the return value of of_property_read_u64()
> to be the opposite of what it actually is.. It returns zero on success, and a
> negative return value on error. So if you only check when it's non-zero your
> going to set Opal for all platforms but Opal, which I assume is not what was
> expected.

Hi Daniel, thanks for exposing a potential issue and trying to fix.
(And thanks Mauro to point this message, since my email changed).

I disagree with your patch Daniel, I think it's wrong.
Since the logic of my original patch is kind of convoluted, for improve
(even my own) understanding, I tried to over-comment the logic here:
https://pastebin.ubuntu.com/p/4DNvd9b2bY

Please, take a look and see if you agree with the logic now.


Regarding your issue, I'm interested - I think perhaps you have some FW
flaw that might be exposing duplicated "reg" or "ibm,opal-phbid" properties.
Or maybe you somehow rely on the old incremental PHB setting and your
software stack is not working properly with the DT-based PHB values.

Please, elaborate the issue a bit more in order we can try to figure
out. And also, you could try reverting the below two patches and boot
the kernel to be sure it works:

61e8a0d5a02 powerpc/pci: Fix endian bug in fixed PHB numbering
63a72284b15 powerpc/pci: Assign fixed PHB number based on device-tree properties

*Notice* the first is a fix to my patch, and both should be tested together.
Be sure your current kernel has _both or neither_ these patches!

Cheers,


Guilherme
