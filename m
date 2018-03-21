Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2984189-1521601842-2-6002906237272972762
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521601842; b=KLyK7NWWfPuQaUSp10un1vu03S+FOr6NkTIVgB0DbZFVRC5
    8+8H5zhmj2w/hOdT0OXakIakON3ovtEHIKm+vZLkiISjtmNz4azw/f2TTFEktrUM
    1AByfP0/pLzvQwEsZcV2SlOxvnGyKQAK2S/7CpZGFttpDKEUY7pSM7gF7r5P5e1S
    0JPr0fhB99SYUzS2W7BhihQvP3yQaZ7kYrkTN9Blrfkr6C6YWx+KBYDwE7ZUUtIO
    mGQSlF0sCkxfrq8fdRXwvfqcX07NCktuirdv3P0a0rIF2wt8LNo8w0twxRQgZk7K
    52DVbAGp7YLYePH4AqRWJgcbW+DfCoOez130wrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521601842; bh=RBQZtA/kS5VXlbNJz84DnfQt6x
    P2BWC4/pOwwEfr/Rg=; b=dDNAHSfu2Kxg13lPbR61RXaVroYhvsOcjLVNgRHHjq
    8K3eROao3z8igtjzOYFCgXUPnz2U4xDn/MLWlKnsAK1OZEFfNsOfplXh4nwrWYrV
    FStl+ITpqj26qVJZj5kxqLKzu3i0xl1hWHHD+znnlZCpA+BhQ0vU9pyc6gSrnHLz
    ZWOatrcXPudp89M5rX0ea7NskwvNqQtqzH3pNu2wQn3WfEh/2asycxGzxFm7SlXs
    pdZe/GqurUxJbOn9nQ3HUbo6mfzJZMI9NMbxCupPXCmpHRm89dp+JRAsfsEsHXV1
    2El7lJF7QxZNdbgCmpneu6cpbiC68C1r5n5A0v4Q3yow==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751719AbeCUDKj (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 23:10:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:41481 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751551AbeCUDKi (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 20 Mar 2018 23:10:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,338,1517904000";
   d="scan'208";a="29831373"
Date: Wed, 21 Mar 2018 11:00:38 +0800
From: Wu Hao <hao.wu@intel.com>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>
Subject: Re: [PATCH v4 23/24] fpga: dfl: afu: add user afu sub feature support
Message-ID: <20180321030038.GB3489@hao-dev>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
 <1518513893-4719-24-git-send-email-hao.wu@intel.com>
 <CANk1AXQpPXhNoPt1Uj=YvbtO+jun7e2Yzvyp+wuR1ZXx6+-i8Q@mail.gmail.com>
 <20180320071037.GB31239@hao-dev>
 <CANk1AXRqfiWCDEo31-QGoKdUQ6PCjHH69LkuZdjErgGA-qxbiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXRqfiWCDEo31-QGoKdUQ6PCjHH69LkuZdjErgGA-qxbiQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 01:17:14PM -0500, Alan Tull wrote:
> On Tue, Mar 20, 2018 at 2:10 AM, Wu Hao <hao.wu@intel.com> wrote:
> > On Mon, Mar 19, 2018 at 03:10:28PM -0500, Alan Tull wrote:
> >> On Tue, Feb 13, 2018 at 3:24 AM, Wu Hao <hao.wu@intel.com> wrote:
> >>
> >> Hi Hao,
> >>
> >> > From: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> >> >
> >> > User Accelerated Function Unit sub feature exposes the MMIO region of
> >>
> >> Is it 'user accelerated'?  I think it is the Accelerator interface.
> >
> > Hi Alan,
> >
> > This is only used to emphasize this is the interface to accelerator
> > exposed to user. But looks like this causes some confusions for user
> > actually from the description. I agree with you, that I will remove
> > this UAFU from this patchset.
> >
> >>
> >> > the AFU. After valid green bitstream (GBS) is programmed and port is
> >>
> >> Would it make sense to just use "partial bitstream" or "PR bitstream"
> >> and "static bitstream" for this patchset?  I don't think that adding
> >> this terminology makes things clearer.  In any case when someone else
> >> uses this patchset, they may not be using this type of branding in
> >> their terminology.
> >
> > Sure, will update the commit message and also sysfs doc below.
> 
> Yes and dfl.txt and the rest of the patchset as well, please.

Sure, I understand that it may have different PR hardwares under this
framework, each PR hardware may have a different terminology for its own
bitstream. We should use common terminology in the common doc and code
to avoid confusion. Thanks for the reminder. I will fix this.

Thanks
Hao

> 
> Alan
