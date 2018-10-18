Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63499ECDE3D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B6F21470
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B6F21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbeJRJl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 05:41:26 -0400
Received: from smtprelay0014.hostedemail.com ([216.40.44.14]:38035 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727090AbeJRJl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 05:41:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 84608180A68AA;
        Thu, 18 Oct 2018 01:42:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cloud67_8d984a8f44a2b
X-Filterd-Recvd-Size: 2275
Received: from XPS-9350 (unknown [172.58.22.135])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Thu, 18 Oct 2018 01:42:52 +0000 (UTC)
Message-ID: <864470f074e634e7276bf999e3c3704b58c1e913.camel@perches.com>
Subject: Re: [PATCH v11 1/5] venus: firmware: add routine to reset ARM9
From:   Joe Perches <joe@perches.com>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Vikash Garodia <vgarodia@codeaurora.org>, hverkuil@xs4all.nl,
        mchehab@kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org
Date:   Wed, 17 Oct 2018 18:42:51 -0700
In-Reply-To: <fffd5b1f-73b5-81d5-a95b-a2dc9db1961d@linaro.org>
References: <1539005572-803-1-git-send-email-vgarodia@codeaurora.org>
         <1539005572-803-2-git-send-email-vgarodia@codeaurora.org>
         <fffd5b1f-73b5-81d5-a95b-a2dc9db1961d@linaro.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-17 at 11:49 +0300, Stanimir Varbanov wrote:
> On 10/08/2018 04:32 PM, Vikash Garodia wrote:
> > Add routine to reset the ARM9 and brings it out of reset. Also
> > abstract the Venus CPU state handling with a new function. This
> > is in preparation to add PIL functionality in venus driver.
[]
> > diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
[]
> > @@ -129,6 +130,7 @@ struct venus_core {
> >  	struct device *dev;
> >  	struct device *dev_dec;
> >  	struct device *dev_enc;
> > +	bool use_tz;
> 
> could you make it unsigned? For more info please run checkpatch --strict.
> 
> I know that we have structure members of type bool already - that should
> be fixed with follow-up patches, I guess.

That's probably not necessary.

I personally have no issue with bool struct members that
are only used on a transitory basis and not used by hardware
or shared between multiple cpus with different hardware
alignment requirements.

Nothing in this struct is saved or shared.

Perhaps the checkpatch message should be expanded to
enumerate when bool use in a struct is acceptable.

