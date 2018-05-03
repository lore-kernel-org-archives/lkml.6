Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2941320-1525371485-2-13443023998996446819
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: yes ("Address greg@kroah.com in From header is in addressbook");
 in-addressbook; shared/fdfaecbe-d8f0-4518-a17e-0d89bf6dc529 ("Greg")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525371485; b=YDhJ/mVl471/S0rInKKsVh0yKWzrX35oaxfao4bO+PlUumnxJJ
    Qkr+dh30ntvxX8jcimuD89dguYmJJbqaqXR4CYNP2FJUW4qmoJYPExABFNa1MKM1
    2RPTErog+NWI2FfOwBN5azDHSNpLIj3lmWtNtPbPBnTfoZZymRmYhb6zdbeWB40t
    iA0f6rWr/r/5kxkUMyUnoID+FmNTYZQsMT76m7zgx7FRljYAceYO04OXopyrBBzI
    AY+yTnpRsHSYL+e9kOVNacGXlx8yuca8k2QPXXHeyCVhFhkFKkRlKRDA2ICTRFIA
    zkphCQssJDo6PsyYBIYwPfZrhPm3Pb0t5feA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525371485; bh=wlDX94wnQTPDfd9jJUBzf2VEIhYd3u
    VnYgRV504KdzA=; b=eyc3JSGiNqNeVKPcaSZaORPUfKmYsPhRktZwMUZnz+YdwM
    1lNejJeK+fMJWysbHgnr5OWbaTY6Dy12TqMVUqY0ZWL8A6iiuoWs3c4kp8OosNCe
    XZeCKtX3BXgzYh1dtYaZe8VHpcQOJjGdNxX/MblJHSFIsB6cfrPBX3yxDCGVthsd
    JI/C8iQwdVhrLkG/JlNl9XJt0wKEqFcAoDajkuCDU7MwnQPrtczPBG1GoT29XJA/
    IBn8m80ZS4YHZ6koAWouZR+WMFiaEiO4SjokK9pWdAyAOCk5xNwRYqETkGfKD5sH
    6VgMwKiIL8ryiase7v2Coz6qoGAkQc7n0y+UhOWw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com
    header.i=@messagingengine.com header.b=eEMxDY+y x-bits=2048
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com
      header.i=@messagingengine.com header.b=eEMxDY+y x-bits=2048
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
X-CM-Envelope: MS4wfCwqyCWhsmSX6ApVQkI2zJvtr9oo5dcNLO5C6Srfnemiylb9QOXEq2+USKBWfGrqoTnVksf+gVYrPLD3+KrEbCIUKJ16s7yz3iSuBTVNWGUSbAxkWRu7
    wMr6OtSTlt8Lrt6rqcnRyTXus0IJUPXH5FRPSp/NE0s00DhQaGT1yVl0ParZJ15Q6/m0QPmXuN5dpncujPx/bJjfN1GoJqrq4QSkTfpqdQTD0cdLjO951QQ8
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=b-MTS-ulqcfWhTLMwDcA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbeECSSD (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 14:18:03 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60007 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751019AbeECSSC (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 3 May 2018 14:18:02 -0400
X-ME-Sender: <xms:WVLrWjPM4uk53L5mFwrWjVb9YTZKQV2R74080zzeqIgEJI0hqc5AbA>
Date: Thu, 3 May 2018 11:17:50 -0700
From: Greg KH <greg@kroah.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: stable@vger.kernel.org,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:TPM DEVICE DRIVER"
        <tpmdd-devel@lists.sourceforge.net>
Subject: Re: [PATCH 0/2] fixes for v4.4
Message-ID: <20180503181750.GC29321@kroah.com>
References: <20180503124334.8468-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503124334.8468-1-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 03:43:32PM +0300, Jarkko Sakkinen wrote:
> Decided to add Enric's commit because it is also a bug fix instead
> of modifying Chris commit.

Now applied, thanks.

greg k-h
