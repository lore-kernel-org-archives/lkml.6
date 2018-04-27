Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-717497-1524858104-2-5651084400372977492
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524858103; b=JgSTchjcQDckRst/PQoB4A6DgcxU2Qg8oVEpYduIE6xKzvGZjU
    OSIQStAXwEJjrzi1GpcmpUKXJ/j5Jegb9SZuPqaoptTWpGo4oKN+woNxGmQXiH/K
    F7yV+HrMwmY2qybTZ7jpQY1gyL5WVl9ZzrhJb9JuTZsKo8edieTlcA8XgWTKaGR7
    mLZ7AZ98eLJGTBQ2i5H365zv86EkhYHvzkcfnw7gfHGB5VtZqFnCs7GgOlcbgjF4
    r4NXvO5mP8kiGo4t/FpWbT7C0md/3173u/38Y6fKuKHiyqY+rvdt7rDAul6hHpHe
    SRwSzzyJD9FJ7d/VHEOyTbCWw18kM+tYRCZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524858103; bh=kCE2nxjdmTUcb+Yai/TBvCsTHUHTWc
    HhWEdCaWKGMyk=; b=AEOdAaAUiiixBcB/QtfQaPNnztzWyvU5lWtgL21QcKOInm
    k8f6RWaKI3Q8F7ycaxH2RktinvyuthsAtMCX/Yx6uoylMMIAJuUC/aOrESzVcDOm
    sHg+HZbVGQCmrH8dv40BLc2mIpyFOJCSzSe8A0DFv+juU3f892iU2N5QnEeIlzgk
    A0oDu29+NOfJb2uW6Kji98FBbfm3EntBLMXGdm/LpI3GJJeWSwZ3htwNOOLrf2Ic
    UQkYPkdnRMNXnI0Lv1w739Dg7312F9ch3KryOJh+cS13pv5Lz10kvz4yjIVJREPj
    nIU5eB89ehKkJvTPUX+Rvi8sLMKoLYYvV/tAVWzw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=thunk.org header.i=@thunk.org header.b=LiCQHbCT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mit.edu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=thunk.org header.i=@thunk.org header.b=LiCQHbCT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mit.edu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDkUTm2hH551v8tE7VI3xMXGTCa6zNdi4YcL58keRy9xIFTv4c7Hj4Qag/f06/euptFzVddcMIBldtLaO4dfsqfI5INFCBgYg98XsBgBUlpl0evLf4oz
    rNoz4B2f2xEqLWFyewpkaV71fN8SUfAH+uaRBgeJtqv+ez+h7BFcAbxf8Z50yOOrl7CQzSNsz5pn5qVnkikuOWHgLoobg7WA/tQ/WDzSr0U+XcNzcB7Th5sS
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=28HZq395EAYA:10 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=AMWwri6qENbl8ABgyeEA:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759038AbeD0Tlk (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 15:41:40 -0400
Received: from imap.thunk.org ([74.207.234.97]:40186 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758167AbeD0Tlj (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 15:41:39 -0400
Date: Fri, 27 Apr 2018 15:41:28 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/24] 3.18.107-stable review
Message-ID: <20180427194128.GK5965@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20180427135631.584839868@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427135631.584839868@linuxfoundation.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 03:57:35PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.107 release.

The kernel.org page currently lists 3.18 as EOL.  I assume we released
an update for Spectre/Meltdown after we declared it end of life, but I
was surprised to see that there was going to be a 3.18.107.

Should we change how 3.18 is listed on kernel.org?  Or should we just
keep peeople wondering whether will be updates after 3.18.107?  :-)

     	     	       	       	    - Ted
