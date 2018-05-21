Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1059582-1526924030-2-3917018059358107637
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526924029; b=jlm8raudeHyB9+aoKWuXlBai5LsEqc/YlanDnnFKW4/iayO0HR
    y9UVU0eBzchFMYQFHMdRXvb+3oDAqfS6/v2ZlZjnWcJHzlVLgW/NRy+qG+k/r2S/
    K0PAZheasty85uwFYzNUIVVyBRC3N+ZZbEbBfMWy/x4WvKvH6VJOzL5WojFyLWnC
    JD2/Q6Syf2rw8gnV7JJnsIoIZ3AZReNCdysw1LMutlWmjGiAXfVAVJ4VUpJhQZ5T
    lsQWNg4pc21PMYrP7hlPsb4ZhhM+JR834Ci+msHdfeBpMC5awG1sDoxgkfb5YHRY
    YqV6BiATAr3uWpw4iRnM01so5WeTAh41DQWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526924029; bh=z7bhXEonJ7W6pLHjLwtBwTtGJgz6rMa79qMIHVtK/C
    M=; b=iDYePDAcB4Xrb3SCz6h2jTGNCeVTlIjR6DPD3VX7l36H3L6Tz35pFSKFDZ
    CWtLxyL4G9S7XDUxvQGdOdcCcvBNJGW9ZZNkLjzLVxRuOO/l1BQAKec+q6pU6lUS
    EQo4pQewqN+C+ILB2uxT/UTvibalB2Qxxjtr3meGOO/d8bUbhV3oJvSafikr2FOa
    4bdIRcIt9G4Yfdmr5XeyruZT8r5bl97H510+NndzO1h0fvHBTZ/DgSTitp2Rzh9z
    yFQn15QJsT0UTW56hTD2Xa9NF6YNCBcLdEKV66f0UPXoc/I9wePey9HBvKUFf+U0
    bOnE7/3HceKTBQUFryCk+ah6PHzQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=RoVmNUj4 x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=RoVmNUj4 x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDaXVQ4APRlDyuZMa1Eh8qcMJohVYGLDDIo+xN9zYDwmDnLWPY2TPlv/Q05QPKXTDJcaQlqKvxls5NQxbMnsXGm0/ZH7n50ygQiNJmzUiGAcpfhlYl8/
    Wh/L1aK+thT9SJwpn83xhne4yGqPd0jyN1rpdP+RF9h0pdjGpqJnDaHi+YzExiH/f8n91/8TSd4cLPF/VTfSF3xoZO+fw45Y9bwwynPHxZZ5P5PZfEdSMjoN
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=yoSQhCf9slXgkWlAxkgA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753097AbeEURds (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 13:33:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752928AbeEURdr (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 21 May 2018 13:33:47 -0400
X-Google-Smtp-Source: AB8JxZoeoeCWY6gLeseNC9LKUlMe8F8CPzGBfKMjO1LDHEJ7rbtIrbPTX3RIKiYBUyUWXtPPpVenflPDvcbpJ7u1koU=
MIME-Version: 1.0
In-Reply-To: <20180521030307.GA26500@hao-dev>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
 <1525229431-3087-5-git-send-email-hao.wu@intel.com> <CANk1AXRsWsd++wjWH44CCWN+cmscy_WjLJhaGGgxmmNe-u1OLw@mail.gmail.com>
 <20180521030307.GA26500@hao-dev>
From: Alan Tull <atull@kernel.org>
Date: Mon, 21 May 2018 12:33:05 -0500
X-Gmail-Original-Message-ID: <CANk1AXTDgVONiaECNOnwj26vCxJSi7ixvD_QcB4VmEo7P_cUMA@mail.gmail.com>
Message-ID: <CANk1AXTDgVONiaECNOnwj26vCxJSi7ixvD_QcB4VmEo7P_cUMA@mail.gmail.com>
Subject: Re: [PATCH v5 04/28] fpga: mgr: add compat_id support
To: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        "Liu, Song" <song.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, May 20, 2018 at 10:03 PM, Wu Hao <hao.wu@intel.com> wrote:
> On Mon, May 07, 2018 at 04:09:06PM -0500, Alan Tull wrote:
>> On Tue, May 1, 2018 at 9:50 PM, Wu Hao <hao.wu@intel.com> wrote:
>>
>> Hi Hao,
>>
>> Looks good!
>>
>> > This patch introduces compat_id support to fpga manager, it adds
>> > a fpga_compat_id pointer to fpga manager data structure to allow
>> > fpga manager drivers to save the compatibility id. This compat_id
>> > could be used for compatibility checking before doing partial
>> > reconfiguration to associated fpga regions.
>> >
>> > Signed-off-by: Wu Hao <hao.wu@intel.com>
>> Acked-by: Alan Tull <atull@kernel.org>
>
> Hi Alan
>
> Thanks a lot for the acked-by.
>
> Did you get a chance to look into other patches?

What I'm looking for mostly is: is it clear that this code was written
to be reused.  What do you think?  Was it?  Is there a way that intent
could be made clear in the code?  This patchset has a history of being
a one-off solution for a single platform, doing things to work around
the FPGA framework instead of doing what the framework was intended to
do.  The FPGA framework was written so that any FPGA could be used
with interface.  Currently in the upstream that means any of the
supported FPGAs can be programmed with the same of-fpga-region code.
It didn't have to get rewritten for each fpga.

This patchset adds 5000 lines and I understand that another 4000 is
coming to add to this.  Has that been written so that the upper layer
can be reused?  Or will the 'reusable' version be another huge
patchset?  Do you see my point?  Up to this point I've been trying to
help figure out what changes could make this reusable.  If you could
get with someone to take responsibility for architecting this patchset
to be clearly reusable, that could speed things up.

If there are improvements to the current FPGA framework that can help
this work, I'm interested and open to suggestions/code in that
direction..

Alan

>
> Thanks
> Hao
