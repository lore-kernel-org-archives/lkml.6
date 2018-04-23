Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1593853-1524506603-2-13547543460913747565
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524506602; b=vd8pbuVRyy+ea0cXvdJzfJ3oHlZZW0yUTRKniarSBcUWmJW//z
    9xwYjERn8D3d+ON+hwZd5UTR1G3j/hFmLkV+piEWNCcIlrjDGVStPRrMCCfs6sl4
    wh0embeY4cUVDoFuDA1uBqGpJDR4di5ujrmim7ZDmgBqyE8Sf6ouMnODffzdqMro
    SErMLJAmTK6bCKvUKW0B7ReYA7Pj8expyJrx/jiEgBuFhn0y4j0rBvOCxSoBhhn5
    sIkOC+fFh0UfWo3a0P/kIAmg0mb+SL16h20yqxDwvaaZSaI4nwT/c+67enfI0Ncg
    4IL7FgXBVCqvtGtWZq7RsIU/2JUZQ1WF/uTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524506602; bh=ORS5tsnf5d+6WXc+o0KC1kuG3w6Whi
    yxvGTNOFBmf9s=; b=GzijJVXsxFvG54iQhQGPpSderVxgZYUz8NmExYkcVBbY8S
    t+dhsXiFbFmFJmEDpQA6G0doWa7C9EjKYBWA+ObDbEHJ4iZlnqEH3aa1mubKxnaa
    Z/5Se/6GQ3PcxFKKDK/lmbgdUZeXbBh/uj3HGuRkXUepP7QBWlUOpd8Ysfs/YyNC
    U71soXoP1HL8y/LAN/1ACCfibrpUre7MMk/N7+R2YsambdbV/PfIXb6WftrP4g89
    tFXRp06Q1QRE46/lqpn6we+j/pl8sla+6+66TRjwbPYmZG3zxjdMRdvjuSgMzRNu
    7p0qxehemjlg2f6aV/IikTRSIfVKdGPitriKBGCg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPgIgozRtHPoSqBpH4VZEpiNG5p7NfXauJz8c3qZ768XLThD4bHRVhzClBAe+VTUiUj0nFq83ZYGTY3geYMwKEf39U8YckVYwYRIsrbkvSRYbpF1gKBr
    fxiiqQsfXtKwVmYt9g+VFUNJNmgXc8Ci1E0l3L69VaTLxrEBZ2V68OwoRDTUWm7vLsYLrNIJeI98XpaTyr5cHQwob65z/l45MAM2kPaThG1beGVYaq0+fqC5
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=xRDiy12qv0EA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=8-vRK6DNSD7UNujOA5sA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932257AbeDWSDT (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 14:03:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48774 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932129AbeDWSDT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Apr 2018 14:03:19 -0400
Date: Mon, 23 Apr 2018 20:03:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.16 000/196] 4.16.4-stable review
Message-ID: <20180423180312.GA27081@kroah.com>
References: <20180422135104.278511750@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 22, 2018 at 03:50:20PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.16.4 release.
> There are 196 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue Apr 24 13:50:16 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
> and the diffstat can be found below.

There is a -rc3 out now, to fix some issues reported with -rc1 and -rc2
(I forgot to announce -rc2, sorry.):
 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.4-rc3.gz
