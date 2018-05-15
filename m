Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3406733-1526426142-2-14592984059470425507
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526426142; b=QOX/97ZSqGe0qIrqjl/PW4iW+qqobjed4AwBFnhndq4DKL/umv
    EnuE9hVTpR6Qha9ny7KD5tYh/2ACvrjtJFbNJCBPsh15wOUH7D4PnW/DldMpDs6O
    HgunZkHcd9/Es5R2kG780QzaKrMmfGEDnbGR6DzSxhg9VNjv7onmldJXtcjNuSfH
    D/RkghVQw7aZYOFIVkUaX/P76Pq3zgepc+ErsZdv5xxwp71tYgrwPY8Fq+wCEvMf
    txmmS+PCV958wdpqfeFmjBDXJcxnxC28lqkmWIQpdiGc2lGFEV+s5i3DrTzLVK31
    RVF9/8tHQ7O2bxey+oT8uQll6iOW20ryMCnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526426142;
    bh=g7HkmS0cJUvcuCu5zrSnaGnSE8qcgMlk4fSMiCznJ2A=; b=OVSg8onTYAK1
    z0erlvCSwKCnDlfyTNaO7i1gjG5wnYMqGlxlf6xA+vWF3aAKNxjzeZ726Iej6F9H
    D843DrRmfZjfRcjFwFmx7IE26qqPAjIrulDolfMh+mBoPjOzL6Ygps95tcn6/VR3
    5aU+zyt+knao5oHPjHqhunjXok1+tbH0I4GXaMnxunOzxTWcIIpRJKyuBNxNuDKe
    u+a2kZGXOO1W3Mxgb+IcDxgvNnoO+0OOSKqr44hIOMyHYI3ZHI6Wnhyy4X8xu2/2
    a9C8Bj+PWUrPEDkuVfMsVGpSrFbRVL6NuuK5lDCF1Ig8N2w7K620JHMBlRSdDdsX
    /P4X3wp/kw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=codethink.co.uk header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=codethink.co.uk header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIx6NMVKfH7ycBKTRPHQDPQiV+vYy0qZEwTaP1AlASOApIgJGhywZDnlyAsg9Ck93eHCCpxrDq3rSYCJ4ezPqG/+Iruy2z/PF7hexlBsPbVOcTh8q0mx
    jm7jnqAgEBLAy2XlVZ9qJ4Q4BPG25afRSwPIgSmAkhwC6T7bseYknKV2ooK/cWRcLjS3bDl6HK/meogKZH1VPGL9XTGM9dp59lewUmmSxM17H/SHG8NPsYsh
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=7CQSdrXTAAAA:8 a=JLtsQNn4QX4pJjDu-goA:9 a=QEXdDO2ut3YA:10
    a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751099AbeEOXPk (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 19:15:40 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:58983 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbeEOXPk (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 15 May 2018 19:15:40 -0400
Message-ID: <1526426136.9159.85.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 099/190] arm64: futex: Fix undefined behaviour with
 FUTEX_OP_OPARG_SHIFT usage
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Date: Wed, 16 May 2018 00:15:36 +0100
In-Reply-To: <20180411183556.339662900@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
         <20180411183556.339662900@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-04-11 at 20:35 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> > From: Will Deacon <will.deacon@arm.com>
> 
> 
> [ Upstream commit 5f16a046f8e144c294ef98cd29d9458b5f8273e5 ]
> 
> FUTEX_OP_OPARG_SHIFT instructs the futex code to treat the 12-bit oparg
> field as a shift value, potentially leading to a left shift value that
> is negative or with an absolute value that is significantly larger then
> the size of the type. UBSAN chokes with:
[...]
> Whilst I think this catches all of the issues, I'd much prefer to remove
> this stuff, as I think it's unused and the bugs are copy-pasted between
> a bunch of architectures.
[...]

Indeed.  That more complete fix was done upstream by:

commit 30d6e0a4190d37740e9447e4e4815f06992dd8c3
Author: Jiri Slaby <jslaby@suse.cz>
Date:   Thu Aug 24 09:31:05 2017 +0200

    futex: Remove duplicated code and fix undefined behaviour

It's a bit big for stable - though most of the changes are deletions. 
What do you think?

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
