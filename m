Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39921C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1206241A4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYHnFXuS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1206241A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753681AbeGCBf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 21:35:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753130AbeGCBfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 21:35:25 -0400
Received: from dragon (unknown [104.237.91.44])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88C7A223C9;
        Tue,  3 Jul 2018 01:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530581724;
        bh=Czuc7MiliXqTI21oi424HsyC7m1S7Jm1seJ5sTvD2YI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aYHnFXuSxdsfMqZ+lHqYiaAxTMCSTmHCmsAx6B0LMEJIUzcCRr6WL2YL9qRpfTVSz
         IIPGRqiVPCy3tH6g0KzawD3Ba40hqX323EWC27CiQHMdWJZ57ZDq3sQNHoiPX9N52h
         1Wr+rRoLXVbrwGqm8gcrgC7ya7pvO0eATSjoJfMA=
Date:   Tue, 3 Jul 2018 09:35:10 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     arm@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        chris.redpath@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/15] arm: dts: ls1021a: Add missing cooling device
 properties for CPUs
Message-ID: <20180703013508.GA28742@dragon>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
 <abb38102bb031a5c0d3ef9adf58b4b04ad38c07c.1527244201.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abb38102bb031a5c0d3ef9adf58b4b04ad38c07c.1527244201.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 04:01:48PM +0530, Viresh Kumar wrote:
> The cooling device properties, like "#cooling-cells" and
> "dynamic-power-coefficient", should either be present for all the CPUs
> of a cluster or none. If these are present only for a subset of CPUs of
> a cluster then things will start falling apart as soon as the CPUs are
> brought online in a different order. For example, this will happen
> because the operating system looks for such properties in the CPU node
> it is trying to bring up, so that it can register a cooling device.
> 
> Add such missing properties.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks.
