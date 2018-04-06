Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-976820-1523009433-2-10663425382486831355
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523009433; b=Q0qWT61ifW4GnULixvCEjYd/MhSgytb3UfKxsLnV7od/euOtZw
    jg59jcWbV90zz8Fl2c+hJ5d7yRDN7z1ggGxxh63fgnz5PjGIAfrKyQSCWVWQ55kg
    xEQRKsYb4x45kpxE8u/6QYQCZUq4nCvm+Vh6S1P7RfbxVyf1Ea5vnyqWae+AcwMt
    mJ21fXt8tes0hTLPvl6+8dcvacogFVrojs7B9xbPT9WorRFSthxo3DVH+NJyl51N
    7qrx76kt6fizHAUtSNq3xRemq+ClIA3hT+mX0q+5ovYQu0peBQfviJvex5mktKmS
    ZE2ZInpC55ZsrQFc8mcoEDKrBYmpRmbV4dxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version:subject:from
    :in-reply-to:date:cc:content-transfer-encoding:message-id
    :references:to:sender:list-id; s=fm2; t=1523009433; bh=nQdNe+43T
    +juWmr1j9mv9hJmIf8/M6HAdzjGqUXaA90=; b=evzcb7XVOFu3JZvaw4sN32l3t
    7w/ripwzPF04H/uLk4urCQJKDAY3jqLwVJcNIZM5HdY7MPUTZJaZiWOvQBL2obyM
    JTtg6B33TrSRaAmzL4k2u2HFrUwvq8gLNAnRDSyOxOO3hki6XgbBmgWxRXmomDcS
    DbEJvgEhUzVWs17IT0IzX0mb1NvyvpOaTs2aY92wDoHqDJD6IBussOEffaC/u8pJ
    KUydH0Vks0/yNM8rOMfbYYgVKA11pYNL4Ua8btxIY/OoHjSFD7ZXiGOy1t/oJ7EZ
    tI79vEHHPzcbJ0Hdb+AfUiPMaYmYScmGMOK8gJPEo7a/5lfvbE8p254cm9GVg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=darmarit.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=darmarit.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=darmarit.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=darmarit.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBtbm5U2owzwRC69l4QJU0Z0aOU/tSLOj8XuZ8AoIoGBUr6PHhbBSTaxRNgKrV9uVVG6TkJbO9WjHcm8uFfYrh6dqvyQuruLTlkKMG76U5VS17z/u/9F
    xN4mjou542ZfNCY90rmisAHlh4S9CdJTOIjLfmodhqBV+v2GTYzFwo8fQR1sac8X5QuwV2aA3WzVd91dtHRG8k0KSIrO4b4Z+fM/VpuxA9iwe0urFG0v9Mje
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=FP58Ms26AAAA:8 a=Vt2AcnKqAAAA:8 a=VwQbUJbxAAAA:8
    a=gSsvIMlwwZ8h-cq-LDsA:9 a=CjuIK1q_8ugA:10 a=csfUxdiNFq4A:10 a=F6Jk-oJU964A:10
    a=x8gzFH9gYPwA:10 a=j_u4NUWTGpUA:10 a=v10HlyRyNeVhbzM4Lqgd:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbeDFKKU convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Fri, 6 Apr 2018 06:10:20 -0400
Received: from smtp3-1.goneo.de ([85.220.129.38]:59836 "EHLO smtp3-1.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751802AbeDFKKS (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 6 Apr 2018 06:10:18 -0400
X-Remote-Spam-Flag: NO
X-Remote-Spam-Score: -2.793
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.793 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=0.107, BAYES_00=-1.9] autolearn=ham
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: make xmldocs failed with error after 4.17 merge period
From: Markus Heiser <markus.heiser@darmarit.de>
In-Reply-To: <20180406091126.GC21589@kuha.fi.intel.com>
Date: Fri, 6 Apr 2018 12:03:55 +0200
Cc: Greg KH <gregkh@linuxfoundation.org>,
        Masanari Iida <standby24x7@gmail.com>,
        linux-kernel@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-usb@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <2A917B38-AFF6-44DC-A4A9-796B2BE560E2@darmarit.de>
References: <CALLJCT0MFg6b+dG50cqe_hv6hxmQDj-ZM066BOtQt_wOiC8ENA@mail.gmail.com>
 <20180406075109.GA21589@kuha.fi.intel.com> <20180406075734.GA16728@kroah.com>
 <20180406081555.GB21589@kuha.fi.intel.com> <20180406083010.GA20174@kroah.com>
 <20180406091126.GC21589@kuha.fi.intel.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> Am 06.04.2018 um 11:11 schrieb Heikki Krogerus <heikki.krogerus@linux.intel.com>:
[...]

>>>>>> An ascii graphic in typec.rst cause the error.
>>>>> 
>>>>> Thanks for the report. I'm going to propose that we fix this by
>>>>> marking the ascii art as comment:
>>>>> 
>>>>> diff --git a/Documentation/driver-api/usb/typec.rst b/Documentation/driver-api/usb/typec.rst
>>>>> index feb31946490b..972c11bf4141 100644
>>>>> --- a/Documentation/driver-api/usb/typec.rst
>>>>> +++ b/Documentation/driver-api/usb/typec.rst
>>>>> @@ -212,7 +212,7 @@ port drivers can use USB Role Class API with those.
>>>>> 
>>>>> Illustration of the muxes behind a connector that supports an alternate mode:
>>>>> 
>>>>> -                     ------------------------
>>>>> +..                   ------------------------
>>>>>                     |       Connector      |
>>>>>                     ------------------------
>>>>>                            |         |
>>>>> 
>>>>> I hope that works.
>>>> 
>>>> Try it and see!  :)
>>> 
>>> It will fix this issue. I was just wondering if use of ascii art is
>>> acceptable in general with the .rst files? But then again, why
>>> wouldn't it be.

[...]

> I was propsed to use something called "Literal Block" with ascii art.
> http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html#literal-blocks

about *ASCII-art*: see fix from Jani ...

 https://www.mail-archive.com/linux-doc@vger.kernel.org/msg19302.html

where the '::' is a short-markup for a literal-block.


>> There are ways to do this, look at how the v4l2 and I think the drm
>> subsystems handle ascii art such that "real" drawings end up being
>> produced.
> 
> Thanks. I did not actually find anything else except use of tables and
> code-blocks in v4l documentation. Is that what you were referring?

If it is about *figures*: we have a directive named 'kernel-figure',
which is a full replacement of the 'figure' directive from Sphinx-Doc.
In addition it supports *inline* SVG and DOT markups. Read:

 https://www.kernel.org/doc/html/latest/doc-guide/sphinx.html#figures-images

-- Markus --

