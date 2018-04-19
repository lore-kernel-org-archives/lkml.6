Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2940596-1524139771-2-9154450288332458976
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524139771; b=kY1VM97iaeAJ+LgAIcNyYDiIC1ZBSnJcqDO/ZUPj0LIrLlSZ+O
    +/rPe+nqI4ZXZnLCvyynaR4dP9ZwcJ3KhKRTEHheqSIHAyjNEVdqXZoDuhzWtX/J
    sGwizUmo03qvYQul0TfMnufrlV3Lz8vjcVtpg47PbfI8hX3tnqgWe4TNyaq96Cmx
    lEFpQqYnlWlCAyMhZASmzZgmXvGKcWZRcTL8WFq1yJl38I5bx8Pa67zlYYqJzHHY
    iHo/71ekpJdu8b6kAlmrsNAWM+K9A/c5qEr1l0RuQnUKrRvtU+6TZ4xPyIQ4in+C
    AHEJZhn/WjNSkT3v9w1aGiHZY7Oo63sadsDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524139771;
    bh=Ti8ILAXgVAziiqBZXXQhktin1yI5qqRNxIpF+8/6Xag=; b=sY4TfoIPISkL
    2/CZ4bLrQfRvBfNOLb5Oe6XLzye+CRbidfT5oxWtEL/6BPjkT1xam3AtoMP5zwQe
    4PabZc3TvSpuZE7HNFBQTl5j82ounOWTQag+iJ4WMzvAkm8RvZnZcrBRf8a5iCQZ
    /Q4ZFDMWYR4UnFMa0lrI0NTc/co7K+too5UO/dLqAJ3tNhbnn2cCNgkK1EL9B5xq
    m7eHiE7uC/giVdwhOgjAV52nDd2I5rkSE7TZYeWcKQ7tgVxMi+bTQtavVkkwAHfs
    swyXwRfSxznAf5e2pmsWM8s9PG6x3rsRwaFYBFGBLSs2MdredeVuPc6jBlclf0WN
    knQIHKeMeA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK5uyhp01bCfKt6hVqTSmHC9aOWB3wc8aROcdFAvEkHhvSc7n8CMa9MNnMYwxSBfApC/97M/a1HwAbs04zKTUhLpX3IEchuC7bHrh5Yj9rVcBd4ynBMA
    MnbVpDDi6cl62HxAz9rG1WasL5z7/ruo6I/FYzyW3dFFslfmC0lAjnACrc9t4/AdCP2kM9uIL68UNP6+fGrHJ+UakqitqbZMqCzBN67MU37RU9Oup6UKLXQw
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=J7Nbbob27coA:10
    a=Kd1tUaAdevIA:10 a=VXix8RcixOca5hTBMfAA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752496AbeDSMJ2 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 08:09:28 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:48233 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbeDSMJ1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 19 Apr 2018 08:09:27 -0400
Message-ID: <1524139760.2587.17.camel@codethink.co.uk>
Subject: Re: [PATCH 4.9 00/66] 4.9.95-stable review
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuahkh@osg.samsung.com>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>
Date: Thu, 19 Apr 2018 13:09:20 +0100
In-Reply-To: <CA+G9fYvwDU481Ui6cAC2ORi+A7rikx=ZGrLew5bAepkMY3wqrw@mail.gmail.com>
References: <20180417155645.868055442@linuxfoundation.org>
         <20180418174244.ke5n4uhbj5geijco@xps> <20180419075608.GA4230@kroah.com>
         <CA+G9fYvwDU481Ui6cAC2ORi+A7rikx=ZGrLew5bAepkMY3wqrw@mail.gmail.com>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-04-19 at 16:42 +0530, Naresh Kamboju wrote:
> > 
> > Can you try 'git bisect'?  I'll hold off on releasing 4.9.y until this
> > gets figured out.
> 
> After reverting this patch, network started works on arm32 x15 device.
> d7ba3c00047d ("net: phy: micrel: Restore led_mode and clk_sel on resume")

Does that also fix the hang during 'ip l'?  (If the hang only occurred
on the same systems that oops'd in the micrel driver, it could well be
because the task that oops'd was holding the rtnetlink lock.)

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
