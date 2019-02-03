Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC591C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 19:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C59217D9
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 19:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549220775;
	bh=8qLnA/eLODDURM2k3KxzET1/3JHzna8OSBaWYVasd5Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=gc+ElFPIvuM0iRff787sxaDCWJudEqp+vcQslSaUSfJiR/yDbAS/cLDCPdtL8zOaJ
	 Edt211O0oOVLdQ/NFzJ0CXjcZBq5Mdxp3yCRiCNA9rhFIgeEz3AXWQ8Baos2L8cTYd
	 lxed9+FYtPCcvDmxpW6XkT2e5a44RBtDEOULbzkk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfBCTGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 14:06:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:46442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726737AbfBCTGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 14:06:13 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EFAC217D6;
        Sun,  3 Feb 2019 19:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549220773;
        bh=8qLnA/eLODDURM2k3KxzET1/3JHzna8OSBaWYVasd5Y=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=aLnlfGkGMiPhhq1Krd2yXZzSkofcSlvAOGrX+FuUSxdOTxRMlFZjIm9B2uWEX6uA1
         FH+hEhlxbRFk2JtN67WfuMfpukaDAjMgq+8I//jUmfn86q6CBYfHCQwd4MmTxoZDLW
         31pcPis0nBONh5RYPxYT/E2wFPp0AZGwzYCZq6Pk=
Date:   Sun, 3 Feb 2019 20:05:53 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Ben Hutchings <ben@decadent.org.uk>
cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        WoodhouseDavid <dwmw@amazon.co.uk>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        SchauflerCasey <casey.schaufler@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3.16 045/305] x86/speculation: Apply IBPB more strictly
 to avoid cross-process data leak
In-Reply-To: <lsq.1549201508.524404500@decadent.org.uk>
Message-ID: <nycvar.YFH.7.76.1902032005040.11598@cbobk.fhfr.pm>
References: <lsq.1549201508.524404500@decadent.org.uk>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Feb 2019, Ben Hutchings wrote:

> 3.16.63-rc1 review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Jiri Kosina <jkosina@suse.cz>
> 
> commit dbfe2953f63c640463c630746cd5d9de8b2f63ae upstream.

You really want the whole IBPB+STIBP revamp from upstream, otherwise 
you're going to get noticeable performance penalties on some workloads 
with some microcodes.

-- 
Jiri Kosina
SUSE Labs

