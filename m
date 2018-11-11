Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B9CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE95D20871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="cAv9ybLw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE95D20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbeKLFKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:10:10 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38274 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725725AbeKLFKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:10:09 -0500
Received: by mail-oi1-f194.google.com with SMTP id v83-v6so5498989oia.5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 11:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3rRMoyHTQKQ6FulqB4CpUi7FQ/aPUDkmNpVsQxd3Uyc=;
        b=cAv9ybLw1115nCrneA/GN1e8yDuYWKm0ZGsO8eiNS35b6tA2Q/suLOMPND/g9OOOzt
         SogV2vIVQ+w+IKXG2nHg7Ej2GwZNDt+11Andv8yXC+PtQkTQYTO1sWfMRUHdiVdv96uO
         jU/2PHKcIxPbmmthZMrVdqGMWSyMe0aKmkw3RmjsvU8T4Ky1GpErhuU1XxlZlfPEoAMi
         kv7e/wVKAYe8YiheE9U0XGnVrwgUOJ/LixMRJnk32vcb85qas6PMEahImTdua+pIl6io
         i4d/DH/ka6YidXA+ar1IFBa+PBERKt0mBJ9+IfgCqT1ilRFMTs1WDIIJJdT7pW+3doPi
         CfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3rRMoyHTQKQ6FulqB4CpUi7FQ/aPUDkmNpVsQxd3Uyc=;
        b=sjNVnUGSWeUri2EAX43OHhv/sLwYYjQOpbLuQrP/1DF6tnj4s4DaLtVMf42ODTXIgw
         wqTVFUFr3sA+defuXeektsmlZLBCCPswsoLjQ0ehGvSLCAxGOJYpaADibGr2oTw4Ljry
         U7Iqnc/T6n3CEkx1T9ux475VOD4PJvEcqq31n0ytBLrcXTqPydGPt3W1NVzMXfo+HUl7
         9h9P27Tt0czG3IT0wOhjrZaRmQmfuOhwAPfqlgERocvx1E2PEgTA/wMpqje6f1YMq4zH
         hU7gDNhac5e7d/5xVVwqiHIalbuJ4fKFG1Z4+F6fa3s9R++ZNxuvclkIEqb7j2NoDIe5
         kgVQ==
X-Gm-Message-State: AGRZ1gKublZ99+Y9/VRveT5t/DZpgE8qVOZu+NvV6NoksNX2wjJ4Ohka
        87SybWIHeZ7xCa0qjww2UF1gyLJkQnL3mqyiO2Eqhg==
X-Google-Smtp-Source: AJdET5f7URhl/SBrIJmv6JjODOrKvirVPyQ043y4vZlm/xDvdhA1dl1iCqkFa/a3gAEo/BaJSJCJO3j+xPqG27gWy0k=
X-Received: by 2002:aca:e691:: with SMTP id d139-v6mr9049451oih.232.1541964046479;
 Sun, 11 Nov 2018 11:20:46 -0800 (PST)
MIME-Version: 1.0
References: <154180093865.70506.6858789591063128903.stgit@djiang5-desk3.ch.intel.com>
 <154180163666.70506.8805433934495072699.stgit@djiang5-desk3.ch.intel.com> <1541957268.3734.53.camel@linux.ibm.com>
In-Reply-To: <1541957268.3734.53.camel@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 11 Nov 2018 11:20:34 -0800
Message-ID: <CAPcyv4jMPDap8L6jTo9NGnrJGCjUY_BvSBuPge8NL4QS2Ku0CQ@mail.gmail.com>
Subject: Re: [PATCH 02/11] libnvdimm/security: change clear text nvdimm keys
 to encrypted keys
To:     zohar@linux.ibm.com
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        keyrings@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ add keyrings and lkml ]

On Sun, Nov 11, 2018 at 9:28 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Fri, 2018-11-09 at 15:13 -0700, Dave Jiang wrote:
> > In order to make nvdimm more secure, encrypted keys will be used instead of
> > clear text keys. A master key will be created to seal encrypted nvdimm
> > keys. The master key can be a trusted key generated from TPM 2.0 or a less
> > secure user key.
>
> Trusted keys also work for TPM 1.2.  Are you intentionally limiting
> the master key to TPM 2.0?

TPM 1.2 is supported from a software perspective, however the
intersection of hardware platforms deploying security enabled NVDIMMs
and TPM 1.2 might be a null set.

> Traditionally there is a single master key for the system, which would
> be sealed to a set of boot time PCR values.  After decrypting all of
> the encrypted keys, the master key would be removed from the keyring
> and a PCR extended.  Extending a PCR would prevent the master key from
> being unsealed again and used to decrypt encrypted keys, without
> rebooting the system.  Normally this would be done before pivoting
> root.
>
> If you're not referring to the system master key and are intentionally
> limiting usage to TPM 2.0, more details on the master key security
> requirements should be included.

Oh, interesting point. I think we had been assuming a local +
unsealed-at-runtime nvdimm master key rather than a system-wide master
key. Yes, we need to rethink this in terms of supporting a sealed
system-key. This would seem to limit security actions, outside of
unlock, to always requiring a reboot. I.e. the nominal case is that we
boot up and unlock the DIMMs, but any subsequent security operation
like erase, or change-passphrase would require rebooting into an
environment where the system-master key is unsealed. I do think
re-provisioning keys and erasing DIMM contents are sufficiently
exceptional events that a reboot requirement is tolerable.

Is there already existing tooling around this to be able to schedule
master-key related actions to be deferred to an initrd environment?

> Using trusted keys that are encrypted/decrypted using a user key
> should really be limited to testing environments.

Makes sense.

> >
> > In the process of this conversion, the kernel cached key will be removed
> > in order to simplify the verification process. The hardware will be used to
> > verify the decrypted user payload directly.
>
> Making this sort of change implies there is no concern in breaking
> existing userspace.  Either the code hasn't yet been upstreamed or
> there are not any users. If the code hasn't been upstreamed, it would
> make more sense to squash the git history:
>
> - making code review easier
> - making the git history bisect safe

Yes, the old scheme is not upstream. I'll do the squash once we've
finalized the key-management details.

Thanks for the help Mimi.
