Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-987399-1520880883-2-17971595620961535057
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520880882; b=sr46esxIVhvLsuMSHEpQsxiwUtyUkvBDW/n1+1MXm2JP8qk
    q+mhhPpr0RuK2vfGnfIf9bJzPkpIRCM12aLxXbcEfXfLUo3mvEPfeDhnRxhA27jb
    /N99RMZNfTqroLgiJSSU4c8DIXC5lg4BP0Kyi6CbYfYKkCrMVhhC0TkgO/a65LNy
    oXyQZXpS/4ARf+DMme0fTf/gvj4eO22DWQ08EwCpnS/AzODcDl/N+GLZ4S+vvBUY
    PU/sfDt4vZ6pO/TleYOhBiAU8/Sxde1DTRGrb9vKxWarAUA08pzFmmxOEPjgpMwh
    u9HiTrtpQZwkVPOHUMvHgVQ1qrl5DPiOyeTwoiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520880882; bh=NxQNv6KGlVgVFii9cBFP7/HoruFN0cC2fopfid
    kyCFM=; b=JxZKdldIMO/4JvcfoOUkYHt0OhioHHeMHYh0VgxPDKp0w1PTv7IwAT
    /UXHgF+tJtpTsAPZFOnYevFvoHtFDl8jwpQ0Tkf8mY/1sDOOcIpZhbd+O6mLgE11
    jbPQ9fDb6aRZjJkeOE9eifAWG1i1LmPldJR6/eTWgN5wBFNTeA8nxqXWPClyvbW0
    2HQVJi9/qtsRzYb4o7ezPPyWonOgs6mLy7N3j1POFJE4cArXzNRjp2fdx+fEW5Vx
    oxZHsNz+NKqlZAJWjZ6T1hiuCMTaUowuoS/T2tXSGzZEBfi+95XEYCsUS3XSAX/p
    nXJTHPHti3yA8sZ3THPFljFe7ApW7kMQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751337AbeCLSyk (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 14:54:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:60144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751232AbeCLSyj (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 12 Mar 2018 14:54:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682C021772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
X-Google-Smtp-Source: AG47ELsLslUOlLS1fr5V4ns9daf5ZxLsixscTk8wI1YrXrsG5/5lqg3nVyvfyspw26P6pQfzOI7NnX4LEzxqZ3P9Om4=
MIME-Version: 1.0
In-Reply-To: <20180312042939.GA19068@hao-dev>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
 <1518513893-4719-15-git-send-email-hao.wu@intel.com> <CANk1AXRT6Rd6kjxT9Q_=3T0zNfzLGmdxOzY=pyX0VKMYReh-0Q@mail.gmail.com>
 <alpine.DEB.2.20.1803111251190.11747@mgerlach-VirtualBox> <20180312042939.GA19068@hao-dev>
From: Alan Tull <atull@kernel.org>
Date: Mon, 12 Mar 2018 13:53:57 -0500
X-Gmail-Original-Message-ID: <CANk1AXSwV+gZ-6cYdfNAzLiQx5Hu2po6NUrhFJ_zX-C6GRae5Q@mail.gmail.com>
Message-ID: <CANk1AXSwV+gZ-6cYdfNAzLiQx5Hu2po6NUrhFJ_zX-C6GRae5Q@mail.gmail.com>
Subject: Re: [PATCH v4 14/24] fpga: dfl: fme: add partial reconfiguration sub
 feature support
To: Wu Hao <hao.wu@intel.com>
Cc: Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 11, 2018 at 11:29 PM, Wu Hao <hao.wu@intel.com> wrote:
> On Sun, Mar 11, 2018 at 01:09:31PM -0700, matthew.gerlach@linux.intel.com wrote:
>>

>> Hi Hao,
>>
>> I do think we should consider different hw implementations with this code
>> because it does look like most of it is generic.  Specifically, I think
>> we should consider DFH based fpga images that have been shipped already,
>> and I think we need to consider new hardware implementations as well.
>> Full disclosure, I am particularly interested in porting to a new hw
>> implementation for partial reconfiguration.

Hi Matthew,

The manager may not be the only thing that has to change for a new
implementation, i.e. will your 'port' be able to work with this
patchset?  In the current implementation, the port is part of the dfl
enumeration code (dfl.c and dfl.h) rather than being part of the
bridge for some reason.  We discussed the possibility of putting the
port enable/disable code into the bridge driver [1], but that didn't
seem feasible at least last December.  I still would feel more
confident if port were part of the bridge instead of part of dfl.

Alan

[1] https://lkml.org/lkml/2017/12/21/62
