Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3018566-1525793452-2-8952505071744262035
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525793452; b=RRN6eZlx/nyWVTsRyUHZdWtwe5GLsSAY0uApItNtls5rRTomLL
    eJgYuEC0+VLfyyXWKAjdsu+6O5Smut063u62kmEiDB7a2yzl1f9GRi9FcKlb3fZ4
    W8tQjah3QrKo6qznnV+KOXtVT6bs0ZG57fOtIIvXiU5iM9gvXneJ/U/yaX8UwbsM
    HLy/f7DBPxzs6yrFQ1I8CMGCsNAVcrsnhQ34JB6/CFqFkocgf9Ps/rqur2XBYX58
    0zLhSq/me537Ipg3Wyr/mY3xjZKs7hneGDdQczHWYwNUxhYAe5BIVxBn1jBio+KG
    NsIIwE6doLO3j3mI4Gicd5a2g/V8+r8o2WWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525793452;
    bh=ALfuWf++86jlo/He6NeXzttDwv3fjTflF+XvldmLzfA=; b=VDEVXov05DnE
    jOluT3PPkafjHaW7tdhR6W8ZBNXfRLqc3RHzbGmOYJ3ICmDynw6JrM6seonandfh
    R9Q6GF44IoHtrkkzTdHPPZcnZITG/dTGFcrgn+fCXoA6VO+fevLhK0ZKOoyLTuLu
    tJulHRe73bx+GuvCdWHpPuWBDQyrIuB4XWe+HdYtF3I3Xe0ul0kTB/DcQYh21liC
    R+GmPp2LuRCl5ru6iFzlMYk2AQHY40DHynPbS1ckaEUSdiXp8TkRgkz5nu+pQwqv
    9A9fJaYuVfQuCdJrbS1rPvJBUzqhLZNvC/rk+GDp9RWRBAAedyc0PVQZthPvo/6O
    iUwdIml5rw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lwn.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=lwn.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lwn.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=lwn.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIxO/JQvemZX5ZhGN/TUL5/OBbn3FxsbhYqW9EsNko5cEflsyr12BxC6RjcaYyeba4eolkHWiL0GQjZ4F7N03NUbGEWyzVM4V0a/dCKzaJRWwS6BZMhd
    lLIP52yk3yvVnDY+uUWy6feO1682Uwb5mmzfQS/6k+yeM8DPR6TJyhc8aWV5xfXcDwQW49mHBPoiGnyiOCAlsR34vqkfPrURL9SvAC2t28sA29pThvHUApI/
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=iP-xVBlJAAAA:8 a=iCcTNRZ2YDSDLJEII7AA:9 a=CjuIK1q_8ugA:10
    a=lHLH-nfn2y1bM_0xSXwp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932727AbeEHPat (ORCPT <rfc822;linux@kroah.com>);
        Tue, 8 May 2018 11:30:49 -0400
Received: from ms.lwn.net ([45.79.88.28]:35634 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932699AbeEHPat (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 May 2018 11:30:49 -0400
Date: Tue, 8 May 2018 09:30:45 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        paulmck@linux.vnet.ibm.com
Subject: Re: [RFC PATCH v3 0/6] Documentation/features: Provide and apply
 'features-refresh.sh'
Message-ID: <20180508093045.7397f31c@lwn.net>
In-Reply-To: <1525689823-3340-1-git-send-email-andrea.parri@amarulasolutions.com>
References: <1525689823-3340-1-git-send-email-andrea.parri@amarulasolutions.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon,  7 May 2018 12:43:37 +0200
Andrea Parri <andrea.parri@amarulasolutions.com> wrote:

> This series provides the script 'features-refresh.sh', which operates on
> the arch support status files, and it applies this script to refresh the
> status files in place; previous discussions about this series are at [1].

Looks good, I've applied the set, thanks.

jon
