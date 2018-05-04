Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-753451-1525472125-2-6232482748836525806
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: yes ("Address greg@kroah.com in From header is in addressbook");
 in-addressbook; shared/fdfaecbe-d8f0-4518-a17e-0d89bf6dc529 ("Greg")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525472125; b=mhGumLKztEUI2M7DNzEIjH1SAQ8VWADjMwzbyWxLs88mwqKAHT
    Hmd8v+1o9baWq64eG5AioMM3MM3S1ubui/R6u4oPEGp+vNaw++2kn/K1krldPA5W
    7aKpvslHd6qkNsmGeoJ09zXmLe7aqcWCVXXzSux5f1fe1NFh9uyXaZO229dAO3MZ
    5xmpYFk4mWiIVYZ7k1Pbf73o2Y4fdzxUd+BfqViA69pgy9QtOdY3Gsvd0J5jeavn
    EQj0vWz/K4ZOCNukTI4jb0r6rX7MlYoUkaSt8H3ihhbUU8Y0by/A8g1Vdfjbe9Qt
    7DYQFI+yhbUTKdiaPt7W3WSpwoxGsX/dIuUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525472125; bh=qLcuvL8uLoCHoYsdfvMyT2QP/E6hQz
    WBdHgLXnqEMMQ=; b=bomHVTFKQgru4cJPqvIuPkMlUmNmO6tO/qOQaEN/EPuIUj
    1NVNB5v4LFyOsQvGH6vO3/yisqddptGDk4k8R+fOoCiawmbJUs0kD5hJEeiL61AV
    1QJFU4S0XOlabSDgsG9PcxAFoBuwOxDMHnc1b3b0Rc57iJpTf/AGZghcOwbV1UXV
    kIAGPt+2dk9fN9QM9otpihoChNHomfB0mvxgT6kherKa/hquWYwlZYbxF8zyY1nu
    I68SYig58iquDnv80ndvF66+erRFnTPeJ3kvYIytM5XqCV664HfBS3Khy05Xm4b9
    2NNVPreOice51cmJ93Sr9x9P6WI31zne4Nn7xcBw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com
    header.i=@messagingengine.com header.b=EZFwAFkC x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com
      header.i=@messagingengine.com header.b=EZFwAFkC x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNEx1HnGpkqL1V/9QE8Uy+ySJn7gSEg6mnHQ0Mb9VJtgEWdksXJ72RDBuNzsXy3gALO3yjDLXaiN2B6LMH2c+OL0i1yLIQJMEVP95HUslFNnRMSA+s/Y
    4EULME6FUrIZ4v73pRNnZ/PjZxlV0JA1ps3v6Ip6ZJGtov45xXoiF5eycBhdxnWyS4ls7CiUTItGXPn9i6/Q5DSNVwq9FO4yHJM68rhI179B2/GB5GTwiNAG
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=iLjPVijIpMABvOM5TakA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751687AbeEDWPW (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 18:15:22 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36159 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751622AbeEDWPU (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 May 2018 18:15:20 -0400
X-ME-Sender: <xms:d9vsWmOIzm3CWY51zueOmgjRCAUVA8b23jzxUaSNABbmZOXjbSj86Q>
Date: Fri, 4 May 2018 15:15:08 -0700
From: Greg KH <greg@kroah.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        mark.rutland@arm.com, will.deacon@arm.com
Subject: Re: [PATCH] [stable] arm64: Add work around for Arm Cortex-A55
 Erratum 1024718
Message-ID: <20180504221508.GD20328@kroah.com>
References: <1525170364-21032-1-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525170364-21032-1-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 01, 2018 at 11:26:04AM +0100, Suzuki K Poulose wrote:
> commit ece1397cbc89c51914fae1aec729539cfd8bd62b upstream
> 
> Some variants of the Arm Cortex-55 cores (r0p0, r0p1, r1p0) suffer
> from an erratum 1024718, which causes incorrect updates when DBM/AP
> bits in a page table entry is modified without a break-before-make
> sequence. The work around is to disable the hardware DBM feature
> on the affected cores. The hardware Access Flag management features
> is not affected.
> 
> The hardware DBM feature is a non-conflicting capability, i.e, the
> kernel could handle cores using the feature and those without having
> the features running at the same time. So this work around is detected
> at early boot time, rather than delaying it until the CPUs are brought
> up into the kernel with MMU turned on. This also avoids other complexities
> with late CPUs turning online, with or without the hardware DBM features.
> 
> Note: The upstream commit is on top of a reworked capability
> infrastructure for arm64 heterogeneous systems, which allows
> handling this later in the boot process. This backport
> is based on the original version of the patch [0]. Folded the 3
> patches into this single commit, removing the unncessary bits.
> 
> [0] https://lkml.kernel.org/r/20180116102323.3470-1-suzuki.poulose@arm.com
> 
> Cc: stable@vger.kernel.org # v4.3 to v4.16

This only would apply to the 4.16.y tree.  Can you provide working
backports to 4.14.y, 4.9.y, and 4.4.y so I can queue them up there as
well?

thanks,

greg k-h
