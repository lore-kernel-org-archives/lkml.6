Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3808880-1520443926-2-18347979323452449411
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520443925; b=QK8G/lZivqudezkYiDb9/WJmx4qHf/BRjdIZe05I5tyZTzH
    ugWz/q6dgmqC+rwM4jJ8Zg+QnavFKiSMdea+jMwk05QJh1RiLd3eajlSMb1O73x+
    dQjyhBPQHmQbgPXb5OIMvFnnvpn6A4WoT02xk/RB+1djdfyGIu4l7CZ0up/mQ82U
    UMnFGu8hT3PPeAE/fCtuZsRjEYBb/kJHeR7CRJajN8N7vQYHDk3VBekWlNOoqaCa
    4FoQv+t7OoyW0T6+Gblagk1eBU4up6tZou/KShmbjrdb+7Ci1WzEloxtHu27dqlA
    qGWzAA4QrG0VryOl6HKhz2HymOMiaBrMO9szoQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520443925; bh=Yebcrs7jpKEtDwR/nopgPiiB0v
    g2b7g8bl876nxFk0M=; b=iP3Yob0c8e8LfEy/ScjN7J4plXe7Pphd///aLeXoed
    WMwe094OlSvRgVnGHrtpC8gt0zQJajGHvVXLc/CvqcALnrgY7vtNQf5yGLDavPI1
    UnycNtXrxDleA/80HeMvmDmH5MB84n4QHUXSjy+ayPnnp8kRkL36VLRVAaKD7Nn+
    Wum1snc9k4LHvyYmZUDRfSXsM87nj6rVs0EsxILt+4fEKRXYofgFNN5nt90yNHZE
    VMVcNOKSPbMoBiwxPU5Z2YIDW4aBDwDgRj4bVXYrDMqIiB6W95STeiTHv/uPvnSo
    xkConK6O1+JINPGDt2dPm1r8k1FQou58SqCXIX0IIFPg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933173AbeCGRcD (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 12:32:03 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:42652 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933412AbeCGRcC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 12:32:02 -0500
Date: Wed, 7 Mar 2018 09:32:02 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>, ak@linux.intel.com,
        karahmed@amazon.de, pbonzini@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Backport IBPB on context switch to non-dumpable
 process
Message-ID: <20180307173202.GK7097@kroah.com>
References: <cover.1520026221.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1520026221.git.tim.c.chen@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 02, 2018 at 01:32:08PM -0800, Tim Chen wrote:
> Greg,
> 
> I will like to propose backporting "x86/speculation: Use Indirect Branch
> Prediction Barrier on context switch" from commit 18bf3c3e in upstream
> to 4.9 and 4.4 stable.  The patch has already been ported to 4.14 and
> 4.15 stable.  The patch needs mm context id that Andy added in commit
> f39681ed. I have lifted the mm context id change from Andy's upstream
> patch and included it here.

Applied to 4.9.y, but I need a separate set of patches for 4.4.y in
order for them to work there.  Can you provide that?

thanks,

greg k-h
