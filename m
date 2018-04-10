Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3243332-1523345977-2-11916134510644836392
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523345977; b=GyihzUalpxyvrV3dm6srwVadX9jY2VK5QNFN+2sYBoajfp4B3o
    5ULEBYZNai2Gx2SoTQoPba3KRuYE5wrjbW33GK+/SWB0ajUAZcvJ0jvN0MT3KRUa
    I/amFSXb5DhPdW2IlFG8jcPhwtRZPyNE0LY65mDMcEAOSB/nbOTGVqz4UKlMYkXs
    XOgDjey+oDtGl1hwk6KIacSDE4GUAa/OITdUvDQf+pRbGVFCAtL5kvHnwJx6Fwin
    yOq3c17pKksSZrYj9M5iNPUt4I4PRi39tcYdci0NqRLVTPRMaeHMu5mq7Gg2NQaN
    9BB9/85Gujh/s/lLIOM6fTInJDE/YELZwiNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523345977; bh=HxHxHF5H5qvbYOTMsPgCAvbN8FD2gb
    bKoEnkoEFYCUs=; b=qr8gGUMQpEVkOdzxbP50qxPU+jLCwwGTQARYK6pTDD7Il6
    Ac7XZMfHaorJpz1rA6WerkMcFw//sLLbr991dRpQGPGYbxdy9wQDhR9rW/+OgzHk
    oJtuAWJs58NbY4IpQIk2uieQujhzEQJPHEG9Znu5ILE+pj+8SJ99ZX9lZm9WPKSN
    U4Hs9J4z0iCr5d1Cj6Nt6SZv/YgJzCcFjBytYaSp9xm3yPEjMcCLozGncWIiJLup
    bKbMb61E0aghTF7iT+POGxfKttkihuTx2QnDjHrKsCehvkLGUb8qPm4t3nALHMES
    c3C+NNtCUPEe09HXVuqBZX5NArbAsrcq7QVqfykA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMhOc0QjOGgfELu+NBDtkH8IJDUEI3BMIW+fq0TvWIG03v9pJ7AvhhjdW4ePE43uJjZjKJ9j8uCmGsjQU+g+DG3bgGSrEZCwYfhe56585jsgxfZTSPsZ
    aiXR4isCuEVRiqbI3ILDMyh8LRs4UQMSsjpwJ6A9ezPJgPfw84Y/M3pyvOFHHJRPLI1b6OwYq3pE2guzbWJIOfTbsZT6oxIAHzCvEkr8VsAEXGnA9sczlNx+
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=dRc11X9pSsvMjkvCLakA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752330AbeDJHjK (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 03:39:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:19284 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751963AbeDJHjK (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 10 Apr 2018 03:39:10 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,431,1517904000";
   d="scan'208";a="45638267"
Date: Tue, 10 Apr 2018 10:39:06 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Tobias Regnery <tobias.regnery@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: fix tracepoint related build error
Message-ID: <20180410073906.GC10141@kuha.fi.intel.com>
References: <20180409075517.15362-1-tobias.regnery@gmail.com>
 <20180409100153.GA10141@kuha.fi.intel.com>
 <20180409114053.GA9417@builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409114053.GA9417@builder>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Tobias,

On Mon, Apr 09, 2018 at 01:40:53PM +0200, Tobias Regnery wrote:
> You are right, building a defconfig, enable the UCSI driver and disable
> CONFIG_FTRACE indeed builds without problems. So it must be some other
> combination of config options. Attached is the randconfig which triggers
> the problem with linux-next from today.
> 
> Regardless of the root cause, building trace.c conditionally on
> CONFIG_TRACING works and the build failure goes away. Grepping through
> the tree this seems to be the right option to depend on, as other users
> of tracepoints are doing the same.

Fair enough. I'll send a fix for that.


Thanks,

-- 
heikki
