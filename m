Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-463875-1522182085-2-10786098054282083547
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522182084; b=p0GBDioCR8dckJAwqUW0fhy+T79seieZymFkXClQFKxSfM7
    aQFCoM78vB5WTCUp38S8olqkhvxvN2Mfhw0y+/H0TVnEaMM6lEoXseIWUatb8bpd
    ygVVye58f9Yyb/GTxmh+EnyNscJ6PF+0NWqUByhwNA3gjDIHSJ9YyBMLz9sCKGYo
    M02AMWAtkpPfLFmUnR16PGyBjiGs6Sf+bLHWD+maScpqBowtgkUQwGHEWsc6CrZk
    sYKZk4mYjKUhKmsrGTjcH+/l8WxtH9cfP8g6d9hIl3iJypYVxCUTYNmePQz/mnIW
    fMB9e8u2ZHD3zk1/vsVqgS2mLcDGtSWGdv7FC9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522182084; bh=b0S4DwqGPS8Z7tDMp3a6wAhaQZ
    33mcACCPMpzLjqnmI=; b=HaF5oUPkUjWrM4o2Wy7olOZUHvkOSWgM9UGliD6FIV
    JnbZOwFqkaR1dAkq7XWJDBUZjLLeHrivuLHxxGeRwod981eE8d3Ak/6TwrNhgqfP
    qegVmrvS3NEkVQ7tu1xFH4w77GxopPGJPt0Pwc0GSPF0vxdQcvVtCRkPFKOmG9OT
    6z/SSz2uZr0q3KJs1dF8FZ9LkTslQUa7reijDLGVoi4lg68w74QMa1QxpLa8y83L
    yoI9lS+H7J2rXF+NRPVOycYJoMkM5H/AEYgXNRz5ewk8RWyqfyCdOS3bPgKUdiFw
    RYSGxjFuExOY1DLU9w5qk1QpT+D/JQcwruiZM3TqUuDQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=VyM5dB0e x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gvwtlbs8;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=VyM5dB0e x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gvwtlbs8;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOrq8jnsbVOQBZ/rgfjGZd06hn+w6PCvzwQdD+OutrAO364oPdjvInVXBlwyaj5gI+EKXb5MvrIDtctTp+w66KSZif2zmigItRT9qXse4kLGqQCjRGok
    1rd2D5OVlTIhNc3pt1u0YPODJwT4l3zxULavLiNI9xudvloccXQU8JaTafMsNkS10uymd1LQC/pC1gz89ccOvhswH7IFqIi7dI06z61RRail9Pk24RlitIiy
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=y98JahJlUwsA:10
    a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8 a=MvuuwTCpAAAA:8 a=8-vRK6DNSD7UNujOA5sA:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=dVHiktpip_riXrfdqayU:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751179AbeC0UVX (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 16:21:23 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:54690 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751070AbeC0UVW (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 16:21:22 -0400
X-Google-Smtp-Source: AIpwx49NnAke7TqUjBhgNFmCLEF45gPoBxEDuAdTmeo8N2HkeXm678TsFfAsuEajTrQAIUfKKUIgnw==
Date: Tue, 27 Mar 2018 15:21:20 -0500
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/43] 4.4.125-stable review
Message-ID: <20180327202120.hwibyvaiovg6jage@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180327162716.407986916@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
User-Agent: NeoMutt/20180223
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 06:27:04PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.125 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Mar 29 16:27:00 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.125-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.

...

> Toshi Kani <toshi.kani@hpe.com>
>     mm/vmalloc: add interfaces to free unmapped page table

Fails to build on 4.4/arm64 due to

    f2ef4616ccfd ("mm/vmalloc: add interfaces to free unmapped page table")

See my reply to the patch for specifics,

Thanks,
Dan
