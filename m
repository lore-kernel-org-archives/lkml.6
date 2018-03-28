Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2729766-1522254097-2-14470560856834838341
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522254096; b=jy89rq1CkV8pd8YIE4oI6dKXPBNXOmIvBhlJNj+V6sTR3Lb
    6XsFdMHmUOKUjojoUEyccO7y2qXx6Y7Ci2+M9P5E8cjVSr5w2jngnHE41vMTgZKV
    DR/9t1c7MNnhGydbrOU3GCqmUdPGPkdCYJUW/hrSczFqaazrF50OxYfh2Gf5rMPn
    dOLdMUlfIe95OnmA7QrTfcF4DG9uAeyiYuy9Z1XvbkfidpCMtXV4fC6SmAEc08pb
    TJAkTkyZkFx1emi6Dues5LUZn0AJp2W509HMoAYjWMjOQT+YvRIKbv3JFsSoM4Q4
    GNcbXkmlK2zq3z3lhnIQ5FlpAjSzZvHEZDGIy0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522254096; bh=Jg6tKj1S0PFFI/ANV+XBp02HQT
    GsZvVgSCEDMtVdrP8=; b=SG4x+3pu8y5ATdPrbWSp0TzZY//u7hFilNsNuaXSdL
    Qc4zVq0j7iHjjCo2W4tiLJlPpneXikKQoGYt8o0kZCvg8n3nhZLqatgX6u8eq6CG
    kEZKn1LIunE30UgeJEzMBSQ1g3erOf9nzEsg3+XuSY1Np/GDeR8KcTM7dJ1nET0y
    NwkTEoGX2eTzfSQqs0Of0NWMBiHbhHT/ztIza/CYu2F6yqTzxM0jGqblpH99nvGB
    QHGY8dL6XpdFlMumxrnVp39fpg4ol5bO6yDJrISpoxXJdPTisU9lPRvJkrz999z2
    a0kQrKkoqjllNTwnh8ZorkG2rW0CF45TRZiXbi0WNghg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfGOv/WIKgdpyBIVwrvtxB/v0q1gLdG52qDX349gkm/rxvlQxEh+nSCYXR0zMdJw4P2mITJZSLiRgXByZ1nSHtyAP1pKW+E6qix2VsJ5xTzW++tmqwXb6
    1bgeKbaR7j4Hw4nbut3C5QgHPgG3GcEPBZTMTrr1ygPDn/fW+WNRQwk3b0y+5rMcmHhyEyp6C20wL4XhmLuexUn2mjP6Hf6/gsVf4oKu8c6zLJ5vRiI7pB5N
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=lOsWcqUcs_UA:10
    a=v2DPQv5-lfwA:10 a=IonwzucbsYlezDIYyoAA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752850AbeC1QVX (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 12:21:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51608 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752989AbeC1QVW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 12:21:22 -0400
Date: Wed, 28 Mar 2018 18:21:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/101] 4.14.31-stable review
Message-ID: <20180328162119.GD9211@kroah.com>
References: <20180327162749.993880276@linuxfoundation.org>
 <ccc26122-eeb2-8b56-f8ff-51655af96822@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccc26122-eeb2-8b56-f8ff-51655af96822@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 06:38:53AM -0700, Guenter Roeck wrote:
> On 03/27/2018 09:26 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.31 release.
> > There are 101 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Mar 29 16:27:21 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 145 pass: 145 fail: 0
> Qemu test results:
> 	total: 141 pass: 141 fail: 0

Thanks for testing all of these and letting me know.

greg k-h
