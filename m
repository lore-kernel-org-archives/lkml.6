Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A9BECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347C020846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347C020846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388000AbeGWMND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 08:13:03 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13620 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387859AbeGWMND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 08:13:03 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b55b80b0000>; Mon, 23 Jul 2018 04:12:12 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 23 Jul 2018 04:12:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 23 Jul 2018 04:12:21 -0700
Received: from tbergstrom-lnx.Nvidia.com (172.20.13.39) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1347.2; Mon, 23 Jul 2018 11:12:20 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1002)
        id C258EF805D2; Mon, 23 Jul 2018 14:12:16 +0300 (EEST)
Date:   Mon, 23 Jul 2018 14:12:16 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
CC:     <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <pgaikwad@nvidia.com>,
        <jonathanh@nvidia.co>, <thierry.reding@gmail.com>,
        <linux-kernel@lists.codethink.co.uk>
Subject: Re: [PATCH 2/8] clk: tegra: host1x has fractional divider
Message-ID: <20180723111216.GM1636@tbergstrom-lnx.Nvidia.com>
References: <20180720134532.13148-1-ben.dooks@codethink.co.uk>
 <20180720134532.13148-3-ben.dooks@codethink.co.uk>
 <20180723085010.GK1636@tbergstrom-lnx.Nvidia.com>
 <7df28a76490315402d28ad7de43dc0db@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7df28a76490315402d28ad7de43dc0db@codethink.co.uk>
X-NVConfidentiality: public
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 10:32:58AM +0100, Ben Dooks wrote:
> 
> 
> On 2018-07-23 09:50, Peter De Schrijver wrote:
> >On Fri, Jul 20, 2018 at 02:45:26PM +0100, Ben Dooks wrote:
> >>The host1x clock according to both tegra2 and tegra3 manuals is
> >>an 8bit divider with lsb being fractional. This is running into
> >>an issue where the host1x is being set on a tegra20a system to
> >>266.4MHz but ends up at 222MHz instead.
> >>
> >
> >The fact the hw has a fractional divider, does not mean we're
> >allowed to use
> >it. Due to the non 50% duty cycle of fractional divided clocks,
> >they are not
> >allowed for certain peripherals. Do you have information
> >indicating this is
> >ok for the host1x clock?
> 
> Only that's what was setup for the systems we're using.
> We couldn't match the 2.6 working system without these changes.
> 

On Tegra20 or Tegra30?

Peter.
