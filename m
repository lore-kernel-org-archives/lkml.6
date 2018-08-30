Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5F0C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18AF820837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOuMNKCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18AF820837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbeH3Wus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:50:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbeH3Wus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:50:48 -0400
Received: from jouet.infradead.org (unknown [189.43.51.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73BE820661;
        Thu, 30 Aug 2018 18:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535654836;
        bh=Dc6Q0KswM/5KLm2tQIMFit/g4Zonhpjn+mrEC5om6qk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VOuMNKCDyL6AX9SWcu6MRqV1URNGuTBCuVIuHB25/AUc72lfBsumsjxza2SeqvBGz
         XAlFfnVHr9FXpBPz4Tk3VIJSrk6ZZQCScBsvb0W2Z2SUuOYymgKc3BJzPNVmfwfFqw
         XpYDAnhTP8MOcwr29nr/43WzC1wQ0ZiRiOEH/ODA=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id AC42D141C3F; Thu, 30 Aug 2018 15:47:06 -0300 (-03)
Date:   Thu, 30 Aug 2018 15:47:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Kim Phillips <kim.phillips@arm.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Anton Blanchard <anton@samba.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Taeung Song <treeze.taeung@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        perf group <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v2] perf annotate: fix parsing aarch64 branch
 instructions after objdump update
Message-ID: <20180830184706.GH6097@kernel.org>
References: <20180823191047.9260992844205984b75e6721@arm.com>
 <20180827125049.GD22309@kernel.org>
 <20180827125340.a2f7e291901d17cea05daba4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827125340.a2f7e291901d17cea05daba4@arm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 27, 2018 at 12:53:40PM -0500, Kim Phillips escreveu:
> v2: address acme's comments:
>     - consolidate into a validate_comma()
>     - call from an additional couple of places necessary
>     - don't listen to checkpatch wrt reflowing jump__parse definition
>       line to less than 80 characters, just rm the __maybe_unused
>     - re-tested no diff on x86_64 and power arch, arm64 conditional
>       branches fixed.

Thanks for taking into account my comments, applied.

- Arnaldo
