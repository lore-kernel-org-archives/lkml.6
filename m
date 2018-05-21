Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4118154-1526872439-2-8123745943405803608
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526872438; b=DbFYrVvjnPhf/1ToCJFbKr9HFOuqHTFctDPUdevJ5lLiM6jLJJ
    fL/ndLshEN52UY8UVgf44jjQACt3Zsx7zlcRw+407MAvK1Ggs6u90vmAAcMo5DVD
    kYOOZa9jMPFWaHRo0sYP0mATEgegua63MI2Sl4Rdp5ypQp+WDkaqzDNCsR1aj2hB
    5/iL2r6dUPCTOoZI+OD9HFNUWG30nlCeIPKUATt5PLTScQQVuWxioi0OezO3IlNa
    Q8hSJz/fHXmbSVhoqf+C4cXMy0zRfDIJhKYAowX+RsaZly1gqLElcMGkEAODh0AG
    2ngxjPfmh6XPbDaYVeXpvvOAXdatOgcfw6AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526872438; bh=aMx3ZtQhXBFeZgbrfYYOXrh+9XdUDY
    jFfVIdkep6JjQ=; b=PVGW+LHbfy20zShR1CNYRQzAMOjagL2qjlMA5KcFt7VNL4
    XailPfZJeZf1hcOJaAxr/HExWJDgGZ4gtGtladF9fVg1NPfw+fD0RHp1z5+187jc
    AhIkqMRs1tKxqVmaUrlPSgD6Vu1jXX4xqmIY5ntOIhfpZKcb5ZE7I8Zlra9d1Ohd
    Dvc5jSIZeymxL9d3crwwlajNyFyu+oeZJYEzjl4QTPtTffVJ/4S3TM8SKTbrmeKB
    cyhRHGiYlcbD+DfgU/fNKgx1P47IGSRGVYjqz2aoVvjblebgGfZtfghE17hPwY4A
    +pxBUuodc0XgA4EAmgVbLmG6OkjGypfSw9jpw6SQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLZiqBmTyVUBZoB0pBXTZA7iobIuKbgso4XRgvapmtrPEdP0OSUpZscMrciQMLuzkvdUr8qy4wehWGFvkE4Zq3FM5ptPzcPBp13WUtaVsPTePs8yQpNS
    3rwn3JXy+rER5Pty/KReA3fvkOILcazijTPDrSIqP5uA3FNnuNUbwHd4kekPJEWgiAith4kUdIM3TZWgaArg2LJugFRR/L+tiXd2qQfhimXv4wSeNqtQt5xs
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=8Qt7rL-48hU6YEiaFoQA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751300AbeEUDNz (ORCPT <rfc822;greg@kroah.com>);
        Sun, 20 May 2018 23:13:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:64159 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751117AbeEUDNy (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 20 May 2018 23:13:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,425,1520924400";
   d="scan'208";a="52447052"
Date: Mon, 21 May 2018 11:03:07 +0800
From: Wu Hao <hao.wu@intel.com>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>, song.liu@intel.com
Subject: Re: [PATCH v5 04/28] fpga: mgr: add compat_id support
Message-ID: <20180521030307.GA26500@hao-dev>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
 <1525229431-3087-5-git-send-email-hao.wu@intel.com>
 <CANk1AXRsWsd++wjWH44CCWN+cmscy_WjLJhaGGgxmmNe-u1OLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXRsWsd++wjWH44CCWN+cmscy_WjLJhaGGgxmmNe-u1OLw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 07, 2018 at 04:09:06PM -0500, Alan Tull wrote:
> On Tue, May 1, 2018 at 9:50 PM, Wu Hao <hao.wu@intel.com> wrote:
> 
> Hi Hao,
> 
> Looks good!
> 
> > This patch introduces compat_id support to fpga manager, it adds
> > a fpga_compat_id pointer to fpga manager data structure to allow
> > fpga manager drivers to save the compatibility id. This compat_id
> > could be used for compatibility checking before doing partial
> > reconfiguration to associated fpga regions.
> >
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> Acked-by: Alan Tull <atull@kernel.org>

Hi Alan

Thanks a lot for the acked-by.

Did you get a chance to look into other patches?

Thanks
Hao
