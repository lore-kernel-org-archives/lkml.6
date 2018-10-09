Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2ACCC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1662082B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF1662082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbeJIWhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:37:50 -0400
Received: from mail.us.es ([193.147.175.20]:41804 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbeJIWhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:37:50 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id AF62E8D0514
        for <linux-kernel@vger.kernel.org>; Tue,  9 Oct 2018 17:20:23 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 854BADA8FA
        for <linux-kernel@vger.kernel.org>; Tue,  9 Oct 2018 17:20:23 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 79DB8DA85E; Tue,  9 Oct 2018 17:20:23 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A0911DA856;
        Tue,  9 Oct 2018 17:20:21 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 09 Oct 2018 17:20:21 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id AD4C94265A5D;
        Tue,  9 Oct 2018 17:20:21 +0200 (CEST)
Date:   Tue, 9 Oct 2018 17:20:21 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Andre Tomt <andre@tomt.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 4.18 000/168] 4.18.13-stable review
Message-ID: <20181009152021.gthtffreggalvy64@salvia>
References: <20181008175620.043587728@linuxfoundation.org>
 <966cae81-c3f6-1d38-5721-97dc317a3fde@tomt.net>
 <20181009092154.GC19241@kroah.com>
 <41c3c40f-2757-9405-4899-02eacb3d05f0@tomt.net>
 <20181009151828.hv6rrxyttjfj3yq7@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181009151828.hv6rrxyttjfj3yq7@salvia>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 05:18:28PM +0200, Pablo Neira Ayuso wrote:
> On Tue, Oct 09, 2018 at 01:33:39PM +0200, Andre Tomt wrote:
> > On 09. okt. 2018 11:21, Greg Kroah-Hartman wrote:
> > > On Tue, Oct 09, 2018 at 05:21:31AM +0200, Andre Tomt wrote:
> > > > On 08. okt. 2018 20:29, Greg Kroah-Hartman wrote:
> > > > > This is the start of the stable review cycle for the 4.18.13 release.
> > > > > There are 168 patches in this series, all will be posted as a response
> > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > let me know.
> > > > 
> > > >    CC [M]  net/ipv4/netfilter/nf_conntrack_proto_icmp.o
> > > > net/ipv4/netfilter/nf_conntrack_proto_icmp.c:373:3: error: ‘const struct
> > > > nf_conntrack_l4proto’ has no member named ‘ctnl_timeout’; did you mean
> > > > ‘get_timeouts’?
> > > >    .ctnl_timeout  = {
> > > >     ^~~~~~~~~~~~
> > > >     get_timeouts
> > > > 
> > > > The problematic patch is:> netfilter-conntrack-timeout-interface-depend-on-config_nf_conntrack_timeout.patch
> > > > 
> > > > The stuff the commit message talks about seems like it was added in
> > > > 4.19-rc1, so this should not go into stable.
> > > > 
> > > > Kernel builds fine with this one patch reverted.
> > > 
> > > So you have CONFIG_NF_CT_NETLINK_TIMEOUT enabled but not
> > > CONFIG_NF_NETLINK_TIMEOUT?  Looks like we just need to modify the .h
> > > file to fix this up properly, right?
> > 
> > Adding Pablo to the thread as I dont know
> > 
> > > This isn't showing up in my build tests as that configuration seems a
> > > bit odd to me.
> > 
> > I think you meant CONFIG_NF_CONNTRACK_TIMEOUT instead of
> > CONFIG_NF_NETLINK_TIMEOUT?
> > 
> > This is the configuration:
> > CONFIG_NF_CONNTRACK_TIMEOUT=y
> > # CONFIG_NF_CT_NETLINK_TIMEOUT is not set
> 
> upstream commit a874752a10da113f513980e28f562d946d3f829d depends on:
> 
> commit 6c1fd7dc489d9bf64196f5b0fa33e059f64460c8
> Author: Pablo Neira Ayuso <pablo@netfilter.org>
> Date:   Tue Aug 7 17:14:15 2018 +0200
> 
>     netfilter: cttimeout: decouple timeout policy from nfnetlink_cttimeout object
> 
> So I would suggest to keep it back / not place it 4.18.x stable.

Hm, actually, a874752a10da113f513980e28f562d946d3f829 depends on:

commit ad83f2a9ce37a264202f48f4fd8889ee9056b703
Author: Pablo Neira Ayuso <pablo@netfilter.org>
Date:   Tue Aug 7 17:14:19 2018 +0200

    netfilter: remove ifdef around cttimeout in struct nf_conntrack_l4proto

Not the one I mentioned above.
