Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADD7C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB92214FA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwbHvqgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB92214FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbeJIX0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:26:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbeJIX0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:26:17 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5D7C20C0A;
        Tue,  9 Oct 2018 16:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539101318;
        bh=8u5tgihylxFcH5NWwdU6szc9qryCAenTCSaRWtpwlNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fwbHvqgzqEpQuocLhNuEWmrfy0gLfueOYWykip/QfgMctLweHMjNB8TDM6RvzM4bn
         b26XdnUoqOwHwH6TO7RmgN7rjUlVTX26sGoJetQ3mSgNX+MYX3liUOq1uswdHA/3Og
         EaywFaQ3hZw0y6DmA93k8G7txiHKpQBdvhpxSsnE=
Date:   Tue, 9 Oct 2018 18:08:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Andre Tomt <andre@tomt.net>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 4.18 000/168] 4.18.13-stable review
Message-ID: <20181009160836.GB8426@kroah.com>
References: <20181008175620.043587728@linuxfoundation.org>
 <966cae81-c3f6-1d38-5721-97dc317a3fde@tomt.net>
 <20181009092154.GC19241@kroah.com>
 <41c3c40f-2757-9405-4899-02eacb3d05f0@tomt.net>
 <20181009151828.hv6rrxyttjfj3yq7@salvia>
 <20181009152021.gthtffreggalvy64@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181009152021.gthtffreggalvy64@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 05:20:21PM +0200, Pablo Neira Ayuso wrote:
> On Tue, Oct 09, 2018 at 05:18:28PM +0200, Pablo Neira Ayuso wrote:
> > On Tue, Oct 09, 2018 at 01:33:39PM +0200, Andre Tomt wrote:
> > > On 09. okt. 2018 11:21, Greg Kroah-Hartman wrote:
> > > > On Tue, Oct 09, 2018 at 05:21:31AM +0200, Andre Tomt wrote:
> > > > > On 08. okt. 2018 20:29, Greg Kroah-Hartman wrote:
> > > > > > This is the start of the stable review cycle for the 4.18.13 release.
> > > > > > There are 168 patches in this series, all will be posted as a response
> > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > let me know.
> > > > > 
> > > > >    CC [M]  net/ipv4/netfilter/nf_conntrack_proto_icmp.o
> > > > > net/ipv4/netfilter/nf_conntrack_proto_icmp.c:373:3: error: ‘const struct
> > > > > nf_conntrack_l4proto’ has no member named ‘ctnl_timeout’; did you mean
> > > > > ‘get_timeouts’?
> > > > >    .ctnl_timeout  = {
> > > > >     ^~~~~~~~~~~~
> > > > >     get_timeouts
> > > > > 
> > > > > The problematic patch is:> netfilter-conntrack-timeout-interface-depend-on-config_nf_conntrack_timeout.patch
> > > > > 
> > > > > The stuff the commit message talks about seems like it was added in
> > > > > 4.19-rc1, so this should not go into stable.
> > > > > 
> > > > > Kernel builds fine with this one patch reverted.
> > > > 
> > > > So you have CONFIG_NF_CT_NETLINK_TIMEOUT enabled but not
> > > > CONFIG_NF_NETLINK_TIMEOUT?  Looks like we just need to modify the .h
> > > > file to fix this up properly, right?
> > > 
> > > Adding Pablo to the thread as I dont know
> > > 
> > > > This isn't showing up in my build tests as that configuration seems a
> > > > bit odd to me.
> > > 
> > > I think you meant CONFIG_NF_CONNTRACK_TIMEOUT instead of
> > > CONFIG_NF_NETLINK_TIMEOUT?
> > > 
> > > This is the configuration:
> > > CONFIG_NF_CONNTRACK_TIMEOUT=y
> > > # CONFIG_NF_CT_NETLINK_TIMEOUT is not set
> > 
> > upstream commit a874752a10da113f513980e28f562d946d3f829d depends on:
> > 
> > commit 6c1fd7dc489d9bf64196f5b0fa33e059f64460c8
> > Author: Pablo Neira Ayuso <pablo@netfilter.org>
> > Date:   Tue Aug 7 17:14:15 2018 +0200
> > 
> >     netfilter: cttimeout: decouple timeout policy from nfnetlink_cttimeout object
> > 
> > So I would suggest to keep it back / not place it 4.18.x stable.
> 
> Hm, actually, a874752a10da113f513980e28f562d946d3f829 depends on:
> 
> commit ad83f2a9ce37a264202f48f4fd8889ee9056b703
> Author: Pablo Neira Ayuso <pablo@netfilter.org>
> Date:   Tue Aug 7 17:14:19 2018 +0200
> 
>     netfilter: remove ifdef around cttimeout in struct nf_conntrack_l4proto
> 
> Not the one I mentioned above.

Thanks for the info, I've now dropped this from both 4.14.y and 4.18.y.

greg k-h
