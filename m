Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A39ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09EB2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D09EB2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeJYDGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 23:06:48 -0400
Received: from baldur.buserror.net ([165.227.176.147]:35194 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeJYDGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 23:06:48 -0400
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1gFO25-0002H4-Ni; Wed, 24 Oct 2018 13:37:30 -0500
Message-ID: <d4598171243a37516faae71095eb3126d77fa723.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     andy.tang@nxp.com, sboyd@kernel.org, mturquette@baylibre.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Date:   Wed, 24 Oct 2018 13:37:28 -0500
In-Reply-To: <20181024021122.3942-3-andy.tang@nxp.com>
References: <20181024021122.3942-1-andy.tang@nxp.com>
         <20181024021122.3942-2-andy.tang@nxp.com>
         <20181024021122.3942-3-andy.tang@nxp.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: andy.tang@nxp.com, sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH 3/3 v2] clk: qoriq: update clock driver
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-24 at 10:11 +0800, andy.tang@nxp.com wrote:
> From: Yuantian Tang <andy.tang@nxp.com>
> 
> Legacy bindings are deleted. So the legacy support in driver
> can be deleted safely.

NACK (both this and 2/3).  The legacy support is intended to preserve
compatibility, regardless of what the dts files in the current kernel tree do.
 If years later we find it's been broken for a while and nobody complained,
then maybe it'll be time to remove it, but why deliberately throw away
compatibility the instant the users have been removed from reference DTs that
might be copied by board vendors, etc?

Note that even if we didn't care about long-term compatibility at all,
removing the support in the same patchset as the change to the dts files means
that the patches can't go in via separate trees (though if that's still the
intent, you should make it clear who you're asking to take what by putting
them in separate patchsets).

-Scott

