Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B767CC070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639722133F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="vPld2NdV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q+lQB655"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 639722133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbeIMAoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:44:20 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45315 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728146AbeIMAoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:44:20 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 9ADEA21751;
        Wed, 12 Sep 2018 15:38:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 12 Sep 2018 15:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=ziH+0NfVWqpawC7evJqEjWlKmMlWPS954GjPF+lFV90=; b=vPld2NdV
        IT5LA1wuC4VB2uAjPtNZ8UUDum5rROrGmr6BMFEukcujaOtq+kzV25CLPmiZcVcP
        CCgqV8FRyHGqJT6jMfCepM6lteQuVM40SR1ZsPhR5B0yuxrH4eZ1LLAjCv8ttr3S
        3zhYQTt8ERIjwQoCK3OHkEi+wsBA7/jGwZttfyGfAx0+TupU+TOElycoH5YER2L5
        U/eheD+NPCa1MKjVY9ykQKA/pntlrDBe2bxOAVsqT+gsRhUivR+vq1lkdVJifVLE
        o5gWB3EqWxVgG93cU7N4L4PD2FNTsBQoVL0oZ8jQd4CuarEIay0kCWePhrs1Twrc
        S23dxrtUbreHOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=ziH+0NfVWqpawC7evJqEjWlKmMlWP
        S954GjPF+lFV90=; b=q+lQB655/j2ozyjkz0ogBq4wYaUaGwlxE7F626N7DwH3r
        gCGz5soTwNrn6r6WBBnb7YiXHN06msM58+35MxGzWHO2n3PWHEWu30hDWzF7AHmr
        9pwbDQ+8jXiTKCvnXP9Q3NkX9/vPgA8FayVvRZNykXMEsF+Is0sMJ/qNAkmR8BkY
        tfEdAfoz5e0zg2MTV7imDvBl9hQuuoxz6XhFqf9VKs75oT4KH/flOuwol1Q+O5MP
        sMDLuwN6AeOT7+1kRVfwpsWq3qCEHDLh+6jD31Ta5CvRWBnP1jBZQVCxnX4qoiYj
        i+NVv9VXgeQhk593W7NrFlfHsNYwkYNx1uaHNy1Ng==
X-ME-Proxy: <xmx:KWuZW3b7t_tjq2q_Pulk4m0PRQPMlxdcAWhgIzUUnfyY7Sf3iFsvAA>
    <xmx:KWuZW-jFVlrrdhg2uWL0sjF1ACIyEdwpiCSut9D5hggf-cMJdGcGig>
    <xmx:KWuZW81n9UIQhtznVgCvpk9HGKgV4a60mzIbOeRjN77I-Rk6jWUbYw>
    <xmx:KWuZWz5gTXA_GnAydkm6ZgMX7RIMIZZO4m5HcR_AnC6E8aMSL0XRlg>
    <xmx:KWuZW3KMkzbEDDRxd41dzP94FZaMaXO1DQcNgKXJDVJIiWAWwfKRkA>
    <xmx:KmuZW8PqTkSkwx_u_FB5UemvmHbVY_nVsh0e2TtZK_XTfuZG738Svw>
X-ME-Sender: <xms:KWuZW320GrpgBp3LNxtmkWqShwpt8Ah0wlEGxmCj6V7VWZUMAgPltg>
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7A511102D7;
        Wed, 12 Sep 2018 15:38:17 -0400 (EDT)
Date:   Wed, 12 Sep 2018 21:38:16 +0200
From:   Greg KH <greg@kroah.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     stable@vger.kernel.org, will.deacon@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com
Subject: Re: [stable PATCH 1/2] arm64: Fix mismatched cache line size
 detection
Message-ID: <20180912193816.GF21563@kroah.com>
References: <1536052210-11625-1-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536052210-11625-1-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 10:10:09AM +0100, Suzuki K Poulose wrote:
> commit 4c4a39dd5fe2d13e2d2fa5fceb8ef95d19fc389a upstream
> 
> If there is a mismatch in the I/D min line size, we must
> always use the system wide safe value both in applications
> and in the kernel, while performing cache operations. However,
> we have been checking more bits than just the min line sizes,
> which triggers false negatives. We may need to trap the user
> accesses in such cases, but not necessarily patch the kernel.
> 
> This patch fixes the check to do the right thing as advertised.
> A new capability will be added to check mismatches in other
> fields and ensure we trap the CTR accesses.
> 
> Fixes: be68a8aaf925 ("arm64: cpufeature: Fix CTR_EL0 field definitions")
> Cc: <stable@vger.kernel.org> # v4.9

Why 4.9?  be68a8aaf925 only showed up in 4.16 and was backported only to
4.14-stable.  Not to 4.9-stable from what I can tell.

thanks,

greg k-h
