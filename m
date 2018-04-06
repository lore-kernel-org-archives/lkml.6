Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1200889-1523014704-2-3767215520483449753
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
    1523014703; b=GYwD9bTHa/Vrbjl59yIxt6Nc2iQn6t18lUJi8LQ49a55Zr0lpW
    HpiR2UrifKqScVP1ulE4mJ2lqblRioSGRTADD4F6xb8a1ppxj+7mGftoek3+5Rd6
    y5SJjXRIGBWgYq5M34vldZ7XlDlgXigTmUN2z5Sr7OWAF70ksfpxoz8kmNLK0vWd
    G4ozrkROUTyupCWnfHhi00Mz9oH74lszDMLQBQxGVNo3/ulZGrb7DYTjKjOUjMYL
    qGnDYauyi3z/BKG1YTrpli9M69cvkhjvT6UMy4IePuAFnQwH4ayeX9tdeBCQypq2
    3CmEqSJIpiSU+/aUX2JcKJyMPzAulfACpwwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version:subject:from
    :in-reply-to:date:cc:content-transfer-encoding:message-id
    :references:to:sender:list-id; s=fm2; t=1523014703; bh=GWjck7ogm
    n8GWtn9xs0h9mVtIZWSw3IFEj+Pz1uYZR4=; b=XDujbNbbsKt5YISzGhjKxiYEy
    E02k0FvJZ9ljfMLLchDz5PlLU8xXr5ln/JR6N5P8oEiYnt9Z63PtoD1FmWZCsaIT
    xtw8llD4Ly0/CVxryzeUg3BBsx18oK1q0du8zXIBX5LJdguDb5dIky41nZao81ze
    sHH7QzOPHWX6pJuHn625K0yNtJhL1vZw7bt47WUrDQWQtsnPQQZuoAeuIDHz4CS5
    6q259/yiNj7R/9lBqTAJCs82xaSmZltWjzYKLzoxr11T1cWZoT7BJyMwO8rIoM0k
    SzG7GLMkXz/hxoC++26HE+gB0skpnKeb5WxWJEdr49LhiA7I5D9ZiZSnfcL9A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=darmarit.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=darmarit.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfOk5AbUCXW8iKprst322s80hQw57zMSUyvmuk4AYtAOJjTZWLpG9gHzM8wVYyShiW9FYqIY4chRYWiegIhsWx6qu2xms4iAHexouahpIDKXDYbLL80fi
    nfoSY8LJF68NT57czAl/2LCfKS8iiA/e6kS3bAt7akJC3YdF0ihG5/MvkANK5GBVpVfDbNU8XdB7jd19o5Q8SUZlHojNaIT2uMV2cKrsVWadq6nzodx7dU5N
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=Vt2AcnKqAAAA:8 a=0xewmzA2pznlXagSOgYA:9
    a=CjuIK1q_8ugA:10 a=F6Jk-oJU964A:10 a=x8gzFH9gYPwA:10 a=j_u4NUWTGpUA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=v10HlyRyNeVhbzM4Lqgd:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbeDFLiM convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Fri, 6 Apr 2018 07:38:12 -0400
Received: from smtp2.goneo.de ([85.220.129.33]:35458 "EHLO smtp2.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751809AbeDFLiL (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 6 Apr 2018 07:38:11 -0400
X-Remote-Spam-Flag: NO
X-Remote-Spam-Score: -2.774
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.774 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=0.126, BAYES_00=-1.9] autolearn=ham
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: make xmldocs failed with error after 4.17 merge period
From: Markus Heiser <markus.heiser@darmarit.de>
In-Reply-To: <20180406105139.GA28862@kuha.fi.intel.com>
Date: Fri, 6 Apr 2018 13:38:06 +0200
Cc: Greg KH <gregkh@linuxfoundation.org>,
        Masanari Iida <standby24x7@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-usb@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <B8BFEE5C-F2CF-485D-80D6-8EC31EE2429C@darmarit.de>
References: <CALLJCT0MFg6b+dG50cqe_hv6hxmQDj-ZM066BOtQt_wOiC8ENA@mail.gmail.com>
 <20180406075109.GA21589@kuha.fi.intel.com> <20180406075734.GA16728@kroah.com>
 <20180406081555.GB21589@kuha.fi.intel.com> <20180406083010.GA20174@kroah.com>
 <20180406091126.GC21589@kuha.fi.intel.com>
 <2A917B38-AFF6-44DC-A4A9-796B2BE560E2@darmarit.de>
 <20180406105139.GA28862@kuha.fi.intel.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        johannes@sipsolutions.net
X-Mailer: Apple Mail (2.3273)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> Am 06.04.2018 um 12:51 schrieb Heikki Krogerus <heikki.krogerus@linux.intel.com>:
> 
> Hi Markus,
> 
> On Fri, Apr 06, 2018 at 12:03:55PM +0200, Markus Heiser wrote:
>>>> There are ways to do this, look at how the v4l2 and I think the drm
>>>> subsystems handle ascii art such that "real" drawings end up being
>>>> produced.
>>> 
>>> Thanks. I did not actually find anything else except use of tables and
>>> code-blocks in v4l documentation. Is that what you were referring?
>> 
>> If it is about *figures*: we have a directive named 'kernel-figure',
>> which is a full replacement of the 'figure' directive from Sphinx-Doc.
>> In addition it supports *inline* SVG and DOT markups. Read:
>> 
>> https://www.kernel.org/doc/html/latest/doc-guide/sphinx.html#figures-images
> 
> Thanks for the info.
> 
> I don't want to use for example dot language in kernel documentation.
> I want to be able to clearly see the figure also from the plain text
> file. That's why I prefer ascii art.
> 
> Isn't there a way we could render ascii art as svg diagram?

Sorry, not yet. Johannes started a discussion about this. Its a long
time ago and I do not have any new ideas yet :/ see:

  https://www.mail-archive.com/linux-doc@vger.kernel.org/msg07035.html

-- Markus --

