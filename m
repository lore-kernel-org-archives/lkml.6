Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2941227-1520037656-2-8186316874760413176
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520037656; b=sXR1XhpkmbnLs+5DuWu5UYc4O58uHARV+ZskKXlWNs0qVut
    gTo0sQOWt1DCWLSskfREJDv4XCl2BoA+ZbjDPkj6Jfb4QyM08mxG/RR6scu0cMDK
    wHogN7AgEZ72gbc6UCy0lCpX5XPE2rl8y1lDFqvUDj5I3hZL+hrioeNx7k6IfqvN
    9T3mGb53ejrDtbsERowHaII5D+rde/dTQYWkSi79P48e30GXDGZY2sMAJtQamh63
    BT+1YZTLY7s4uezGfjiNbk1JdgX1jzcjvvnXLDaiJTyfLgQ+Xg01bM7Erp2kr3pZ
    nzuQTmShL0J99qQ/bpUYISl4uw123kXQm8sUIYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520037656; bh=aG0YQvW2Cm6rpGaldhQ/GRXYniQVrqafTo7gMPwKXS8=; b=K
    d9nYDJ5l0mb7v72WIGwkHR9vPPXzNkpEgxSLLeIePEPDCobXw3UVLhYiaR4QKRKR
    +6cid6pC2MW0SlwQp4yzBPZHqD2GC/z85mKSw0qq6S0oLM7RWgugNylCxPyv1xIh
    eDB/zsr5uGMMmCCEvg/l9toeakpxsSR1Y65EX1PQOv/oOanb8NGg5CYPuhbs++Yx
    ObND7TI2CTsbC117IARxOm00UpOXQrLupPMYB0E7pKeBtBS069sPGjRmuAm4qnis
    +6aukFbBzBVafvXeGC9a2SK4gERTey0H8N079BcVUhTTPp+yzfy+bHSM0pBX9HOd
    2OAOOofr53ZHla/yv7A3Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752697AbeCCAkz (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 19:40:55 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44408 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752274AbeCCAky (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 19:40:54 -0500
Date: Fri, 2 Mar 2018 16:40:52 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Daniel Vacek <neelx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Paul Burton <paul.burton@imgtec.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mm/page_alloc: fix memmap_init_zone pageblock
 alignment
Message-Id: <20180302164052.5eea1b896e3a7125d1e1f23a@linux-foundation.org>
In-Reply-To: <0485727b2e82da7efbce5f6ba42524b429d0391a.1520011945.git.neelx@redhat.com>
References: <1519908465-12328-1-git-send-email-neelx@redhat.com>
        <cover.1520011944.git.neelx@redhat.com>
        <0485727b2e82da7efbce5f6ba42524b429d0391a.1520011945.git.neelx@redhat.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat,  3 Mar 2018 01:12:26 +0100 Daniel Vacek <neelx@redhat.com> wrote:

> Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
> where possible") introduced a bug where move_freepages() triggers a
> VM_BUG_ON() on uninitialized page structure due to pageblock alignment.

b92df1de5d28 was merged a year ago.  Can you suggest why this hasn't
been reported before now?

This makes me wonder whether a -stable backport is really needed...
