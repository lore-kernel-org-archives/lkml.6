Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1442817-1518442501-2-1387855136070741524
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518442501; b=sQK5Dvulk/Trzfqwtk3V5Qz444id+7p4DrZ84CLu11bXvDD
    vd2gPFpATh+0bbgWEZUviFODtjz2V1N1UpJ9/v49YHWrEenAVu0mjcINC7uX+MAB
    HqkJ4O5R4N1VqfsKniZVXkwR8/SX7knKmgCDbCGrdOTl5lyAA/qwP+qS8AbZ1rHr
    /gHFFqJznHEpHVG54cAVFE8sIHVtApPPFY8L302MM4ALJg6FNfSrZJYTN5q3jUkj
    TgdP+kqQPc6cAeKFnXK8g7g4y7DNT1ACNDJldFgjlHlZeadXorjxDnawf74wv/5K
    41nCr8sTubqADTHRq2pmKkt8Nctm7GZ8nErc5xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518442501; bh=/vfRlOz4fb8uOvgndxjurcjEaz
    H8TdA0uac/QVZGghs=; b=itszrqP4wJQgKx0yxn8BB09+AtNXF1yxiKJoLh1XFB
    lUc9TEY9av9/WzqyJAJ6qYoLMl93CHqg2mqG/fsjQ7x4qH/O3I922Ib9sZnn0nRj
    ipnAOeQwoAOuvfefSWmUGkMaDokYgktU1fmhexMRWfD9hohlA9njx1+OKJox9AhL
    0h3KmS2tLUBHhXXObcsKUGFkXVEvVbQteS1TLbKOrCfITtJtDzjVpSE++T1LT+Cb
    qWe6eiJgzZ66flkF4g8+ymT3vQn/FqbuVsrFrYJfz7Ru8yqYuitK72MkrcgDfTus
    FdDLnZsr6oMKbQVovf1dtXkbpjx26uv17RGpxhLog2dw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=PBPHQg9B x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=PBPHQg9B x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935518AbeBLNer (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Feb 2018 08:34:47 -0500
Received: from merlin.infradead.org ([205.233.59.134]:46034 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933917AbeBLNep (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Feb 2018 08:34:45 -0500
Date: Mon, 12 Feb 2018 14:34:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Lv Zheng <lv.zheng@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Timur Tabi <timur@codeaurora.org>, graeme.gregory@linaro.org,
        mark.salter@redhat.com
Subject: Re: [PATCH] acpi, spcr: Make SPCR available to x86
Message-ID: <20180212133429.GC25314@hirez.programming.kicks-ass.net>
References: <20180118150951.28964-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180118150951.28964-1-prarit@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Jan 18, 2018 at 10:09:51AM -0500, Prarit Bhargava wrote:
>  config ACPI_SPCR_TABLE
> +	bool "ACPI Serial Port Console Redirection Support"
> +	default y if X86
> +	help
> +	  Enable support for Serial Port Console Redirection (SPCR) Table.
> +	  This table provides information about the configuration of the
> +	  earlycon console.

I just got asked this by oldconfig, which left me rather puzzled, WTF
does this do?
