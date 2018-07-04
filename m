Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469B6C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0094921719
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZJpNoEoK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EPdyc9x4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0094921719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933051AbeGDJnQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:43:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52814 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753339AbeGDJlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:41:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6CC3960B83; Wed,  4 Jul 2018 09:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530697310;
        bh=zJJWXZGiH4Fb3SRANQugPi3QML2QGPcNZvPiA6k8dPY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZJpNoEoKJ3XQEnI3Obz7yOI7seVPlcg1lhNvAQ7m2fIdRXWlEtI+6B2X3VTi6TFMT
         OJQtrZyjZhsnAFU+2csNo/DPXiTQ17wY7HiHo8os7T7l2Go1uUQKbUkDwx7AQTpmva
         OsvSJLOH+eHoL7tYlvm/yZNxv47OMnYYqq6KeyQc=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id A1D5360B6B;
        Wed,  4 Jul 2018 09:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530697309;
        bh=zJJWXZGiH4Fb3SRANQugPi3QML2QGPcNZvPiA6k8dPY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EPdyc9x4EG+jQOqU95yTvCzSV1QpSl9Jjts8xKYrcOR0IBT2NiL47lpKhyRusqzus
         Wwx8yB9jlU9cXX9CdoBlVJhIEjK+MvCXqfR47F+JKcnC3yqtSM1wr4qzqc+aM4tLhf
         uw99sgrWEoJniVdx8BI/nTVUQt53goBrpn9Mtrko=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 04 Jul 2018 15:11:49 +0530
From:   Vikash Garodia <vgarodia@codeaurora.org>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>, bjorn.andersson@linaro.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>,
        linux-media-owner@vger.kernel.org
Subject: Re: [PATCH v2 2/5] media: venus: add a routine to set venus state
In-Reply-To: <CAAFQd5BvTNhafus4WcoPLiBTN8X3Ls+YA0OgpfnyadDayvVQxA@mail.gmail.com>
References: <1527884768-22392-1-git-send-email-vgarodia@codeaurora.org>
 <1527884768-22392-3-git-send-email-vgarodia@codeaurora.org>
 <20180601212117.GD11565@jcrouse-lnx.qualcomm.com>
 <CAAFQd5DH2i+8ZJ+s2XUnmFHwxXKLF6z_=w0Z-RFs=W9oVvrJgw@mail.gmail.com>
 <ca7567c1df773f1223d919fab28f1460@codeaurora.org>
 <CAAFQd5BvTNhafus4WcoPLiBTN8X3Ls+YA0OgpfnyadDayvVQxA@mail.gmail.com>
Message-ID: <5560573ed426b03ad7676ac14a291e70@codeaurora.org>
X-Sender: vgarodia@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-04 14:30, Tomasz Figa wrote:
> On Wed, Jul 4, 2018 at 4:59 PM Vikash Garodia <vgarodia@codeaurora.org> 
> wrote:
>> On 2018-06-04 18:24, Tomasz Figa wrote:
>> > On Sat, Jun 2, 2018 at 6:21 AM Jordan Crouse <jcrouse@codeaurora.org>
>> > wrote:
>> >> On Sat, Jun 02, 2018 at 01:56:05AM +0530, Vikash Garodia wrote:
>> > Given that this function is supposed to substitute existing calls into
>> > qcom_scm_set_remote_state(), why not just do something like this:
>> >
>> >         if (qcom_scm_is_available())
>> >                 return qcom_scm_set_remote_state(state, 0);
>> >
>> >         switch (state) {
>> >         case TZBSP_VIDEO_SUSPEND:
>> >                 writel_relaxed(1, reg_base + WRAPPER_A9SS_SW_RESET);
>> >                 break;
>> >         case TZBSP_VIDEO_RESUME:
>> >                 venus_reset_hw(core);
>> >                 break;
>> >         }
>> >
>> >         return 0;
>> This will not work as driver will write on the register irrespective 
>> of
>> scm
>> availability.
> 
> I'm sorry, where would it do so? The second line returns from the
> function inf SCM is available, so the rest of the function wouldn't be
> executed.

Ah!! you are right. That would work as well.
I am ok with either way, but would recommend to keep it the existing way
as it makes it little more readable.

> Best regards,
> Tomasz
