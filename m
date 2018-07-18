Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4395ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DF820652
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4DF820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbeGROH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:07:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59086 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeGROH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:07:56 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EF6EE898;
        Wed, 18 Jul 2018 13:29:59 +0000 (UTC)
Date:   Wed, 18 Jul 2018 15:29:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof =?utf-8?Q?Koz=C5=82owski?= <k.kozlowski.k@gmail.com>
Cc:     David Howells <dhowells@redhat.com>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        fenghua.yu@intel.com,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG BISECT] "Support fs_context" causes systemd issues
 (linux-next)
Message-ID: <20180718132957.GA17254@kroah.com>
References: <CAJKOXPftCn+qcJtG6bBjUMa2ZX=_YAoHkoYH69-+jSam4-z86Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJKOXPftCn+qcJtG6bBjUMa2ZX=_YAoHkoYH69-+jSam4-z86Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 01:46:35PM +0200, Krzysztof Kozłowski wrote:
> Hi,
> 
> On recent linux-next, the commit f8076f3b0996 ("kernfs, sysfs, cgroup,
> intel_rdt: Support fs_context") causes weird behavior of two of
> systemd units: systemd-timesyncd.service and systemd-resolved.service
> fail to start.
> 
> Logs:
> 
> Jul 18 09:51:33 odroidu3 systemd[376]: systemd-timesyncd.service:
> Failed to set up mount namespacing: Invalid argument

Looks like the parsing for kernel mount options is broken somehow in the
above patch :(

thanks,

greg k-h
