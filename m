Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1793992-1526547717-2-5869917707174005831
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: yes ("Address greg@kroah.com in From header is in addressbook");
 in-addressbook; shared/fdfaecbe-d8f0-4518-a17e-0d89bf6dc529 ("Greg")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526547716; b=Yk7l+v2kS6r8B2hCsvCiWOd0gyAWSBGOaKkKQ/QxQdtax997XJ
    DKLUmkjHS+3OGFT6dwa52NxZj6lh1zP55gtnaC9CFsVjAh2XaehJ9A2bLKoxq44C
    Cba80TktPi+DSyPv2CxtMcS2vm36txsdyMzKBrcLHoA5E9Yi/KJWWjDY2mrRzK1I
    9Uff2XarYerk0Wlh7qcyF9R3OqxJMJ0JHbM71JHaBy3A6XNNgimvHf5R4Ug5PSQY
    XUSTA4bRBsjTSMPFZAiTkSRLYer12khPpmy+C8cZFEvWgne9gz7xnvU/EAvxF3US
    fnF8qito54nmFE3ehXHUw45xTIBjeAs7EXKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526547716; bh=xHES714DI/tOB122IyZI2/5CWJIXVi
    KDhYtPFxd7G80=; b=l+QWxAL0vtiRvVQAOhVrXcd6j5qnfl/xwhwRHcY8s5Dbho
    UApau7/JI5Q8RulNgBQNI5LflyJneIBh5KVk1g3xwDiN5ymb5yuKEVkHg9wqKa0S
    l5xStVETz/4ILc3fS18W+lLUkOsL3RJLasF0Zq2QiZ0P0+CzeAyfAIrM7AzOPrJ3
    cxbaGXqEM5cFnRkjIHXZrCoqX4BlpA0cyf8s22XkEhFM5ZRP15i1HX9HPwrgRssZ
    5OI3SKLxwIpnubfWSsm5G4XI0qW3WjMdBRfcvVY1AbenR2tJ7KnsH0OUlj70vPF/
    NNavHnyH/dqcoLg6j+frcNPDcM6Y2U9tNMUEtc2g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com
    header.i=@messagingengine.com header.b=IxXlcTX5 x-bits=2048
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com
      header.i=@messagingengine.com header.b=IxXlcTX5 x-bits=2048
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
X-CM-Envelope: MS4wfFMQz6D4vYE2mgAbCDNOjsPqpJ4v+fewLITt21Y4Llv0k7YEDWsYDJNKxR7awaGWV3kntz1nyG6/nQ7y1kssiS+C6oVIhXNStTOlvz112+to0AL3nSLu
    70ajTC6B4/YwlON5B8OlSVS3S544r9aG1AURUIkO1bCog1lBRUnCoIWV5cfg2wRZEwag++cHDQ4vzcdzD6rUBnxKtK0irhLHLue+E7iFWWRoGysSwk0aJBdd
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=5hbFD1BkjCuMjG_J0ygA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751017AbeEQJBg (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 05:01:36 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35565 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750779AbeEQJBd (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 17 May 2018 05:01:33 -0400
X-ME-Proxy: <xmx:7ET9WsTIeW3_WGxCqG6Bq30Konpn6GVCSlDOPdmJvkotafxGjQn7OA>
X-ME-Proxy: <xmx:7ET9WvchA8mUI0SRO6nVOlSYbpVMnEZUBiicrVMgeyoxfcuFVjNVtA>
X-ME-Proxy: <xmx:7ET9WrBy5i02yrKJRZaKk6gkf8WgF2jzN5dnTVrGJcak1upw5uxQAg>
X-ME-Proxy: <xmx:7ET9Wt0u6TfUzmZldpJx1uvQB3m2x1IQ41zeb4p26pf-tsgvzOCiww>
X-ME-Proxy: <xmx:7ET9WrTH-uoNq3rmoetw0Rp4uoyBQ-hb_CNsc0v4bFDQqJWbCEV5hQ>
X-ME-Proxy: <xmx:7ET9WjhPkfqtFuIKGQb7eWAiFhCRJxyXBkLcKFrnIX1vNBMKrdWg4w>
X-ME-Sender: <xms:7ET9WvVzSXXqB7hrlrTI0yGq1LOXfQKkhd3rYOTSnx338m7Z-65R6Q>
Date: Thu, 17 May 2018 11:01:15 +0200
From: Greg KH <greg@kroah.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, mark.rutland@arm.com, dave.martin@arm.com
Subject: Re: [PATCH 2/2] [stable 4.4] arm64: Add work around for Arm
 Cortex-A55 Erratum 1024718
Message-ID: <20180517090115.GE25318@kroah.com>
References: <1526295664-22187-1-git-send-email-suzuki.poulose@arm.com>
 <1526295664-22187-2-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526295664-22187-2-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 12:01:04PM +0100, Suzuki K Poulose wrote:
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
> Cc: stable@vger.kernel.org # v4.4
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Note: The upstream commit is on top of a reworked capability
> infrastructure for arm64 heterogeneous systems, which allows
> delaying the CPU model checks. This backport is based on the
> original version of the patch [0], which checks the affected
> CPU models during the early boot.
> 
> [0] https://lkml.kernel.org/r/20180116102323.3470-1-suzuki.poulose@arm.com

Thanks for these, now queued up.

greg k-h
