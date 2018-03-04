Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-568472-1520225609-2-3046795774665991951
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DATE_IN_PAST_12_24 1.049,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520225609; b=EnhDS033FI4m4UO41zrEavNWdrDDTIjOw1LfRDkyygF3j4/
    PFRqYz0Io9xBh/fmGYi65143eVlK3YfGUPE6p230+LPwznC+sctvtOUMN5igHCia
    jl3yTDpBDpl4gnSiFGFSpalLHJnoxVJfWmUMP06bqnyJJJOhq7LD3wOSTg1PfgFC
    7Km8ytEGGc+39DK2XzAKwXrtZGr1MW97n0Lf5TKmdPDfACHAPIkxlPYNzvjKU5ho
    9avm05bt70M5VDw1Z/DR2zaHs8povePwYbsTOlWAU+Qx2lMvkUxZwhkpjj2UrZ9i
    wv59MjwhDmCzE8bg1MloIPiUWNd+ysAvDN58RUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520225609; bh=58ajev1xf5a5EwKRQXR9wiyNPm
    3VkYNSsK0mskVoCbc=; b=DBgohs+jWh92QGNWVqHHwNmRayN9rff22WXw1I46EX
    PzzSJJxzuOYKoMYZ5Yr3wUM58kOmcz7kWAnljwGZhkpB5tbuV0TKeO7oy/9ICjgv
    FTJX6RnzJH/O0QDOv8TeyPoNQQi6DWqGInB2SCrZpt4WoUYWX7nQ8HiwRw/QvoMq
    K6WDVx7P0++RUqDRkomVM83ytQp/cEKVUPIXPG98ezMLDqYzWuY0yEjRVqLBYSF+
    8sFs4hHbqRrrPcfQ6R7oIthZi8jbJqgbC8xQ1IxsmjYTkinzky4n/Jhjlgy2EPmT
    ewEiisVi4y/lSXAkTy4X463HZhcQBu7SISom+3Jndj1w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932739AbeCEEx2 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 4 Mar 2018 23:53:28 -0500
Received: from mga12.intel.com ([192.55.52.136]:63429 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932540AbeCEEx1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 4 Mar 2018 23:53:27 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,426,1515484800";
   d="scan'208";a="31391274"
Date: Sun, 4 Mar 2018 21:16:02 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: kbuild-all@01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Olof Johansson <olof@lixom.net>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Hao, Shun" <shun.hao@intel.com>
Subject: Re: [linux-stable-rc:linux-4.9.y 6083/6211] warning: __mcount_loc
 already exists: drivers/net/wireless/intel/iwlwifi/mvm/rx.o
Message-ID: <20180304131602.qogvqh7542ngkgrg@wfg-t540p.sh.intel.com>
References: <201803041449.vUjSizBZ%fengguang.wu@intel.com>
 <CAK8P3a3k5pGWuurWVNmPWZ0AXiDjARux8PU0ve3RjWdC4WtKUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK8P3a3k5pGWuurWVNmPWZ0AXiDjARux8PU0ve3RjWdC4WtKUA@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 04, 2018 at 09:29:17AM +0100, Arnd Bergmann wrote:
>On Sun, Mar 4, 2018 at 7:21 AM, kbuild test robot
><fengguang.wu@intel.com> wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
>> head:   85afb4e51ccfdb10f2969b24439ae2887fe0fcff
>> commit: c0ecbd663fe6961c6ff181a211f090005858656f [6083/6211] scsi: advansys: fix uninitialized data access
>> config: i386-allmodconfig (attached as .config)
>> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
>> reproduce:
>>         git checkout c0ecbd663fe6961c6ff181a211f090005858656f
>>         # save the attached .config to linux build tree
>>         make ARCH=i386
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> warning: __mcount_loc already exists: drivers/net/wireless/intel/iwlwifi/mvm/rx.o
>
>I'm pretty sure this is unrelated to my patch, but it's a recurring

CC Shun for checking if there are problems with the bisect.

>problem that we should get
>to the bottom of. Olof's autobuilder has reported the same thing for
>the 3.18-stable tree
>but not any others (for every single file in the kernel, not sure if
>this warning only
>shows up for all of them, or just one module).

Thanks,
Fengguang
