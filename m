Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 25E3FC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01C0208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjiaYUoH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D01C0208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933970AbeFLPY0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 11:24:26 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35230 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932803AbeFLPYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 11:24:24 -0400
Received: by mail-io0-f193.google.com with SMTP id u4-v6so28536559iof.2;
        Tue, 12 Jun 2018 08:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=gJg/gHhOBzwR9RLz+lbs7I9UpMjsTOiodcUSUBlt33U=;
        b=MjiaYUoHiQYFTV++MMxozBQGKYebxcrQ/B3CYRCfSKaBusFfCFvxhdOpqANvqY1j1q
         0OmA/ROtkdiU2JBVevw+JWqOQmJObNp108wHLO2ZGyKnhP0arIZIMnzvIKi3N46EYi2n
         h+8b91Hz7nVsSRBhKU5s/OMw8jLbo8abIt7Hm3Wh3mo0j+eeTtrA279qvBWuY+TS+zb7
         nK1NvZWGtG5+FADPjOi+wYmQP5K1z5eHkXfNUetha8r+e2vjqQX8ghBQnry+6Y2qSJRs
         UWws0wYriOFT13/9nprTU4F1mAJrbnfUVHjUiTVKrHjC8/qNXrv5Z/aouA4ISGOPYa1G
         ZLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=gJg/gHhOBzwR9RLz+lbs7I9UpMjsTOiodcUSUBlt33U=;
        b=bbztV25s1NMOikzpS9eRY1CSscM5VKd9Dd9ShGhgr7Nn7+6LI689iUt23QIjOMEDVQ
         RhOLM3ty5XC5Ct90NeUxwMHKR2WbMdqJQGqmlzC0Lv+QMMpHtBuGaKnjU60O32judizS
         jbkFSCGbPyeG3S27s30LL3O/eEXK84QTWdRCYr855w2mPULkk4sQDzVZz46iNGydkh72
         hTMKzyN6htNzGNK8pDuwLc5MN+vI65h3MJoQYtzXCtfakRpYQf+nqPLIVmbE7vSrIWWQ
         28zVW4RR7YN2RpBecooW+xcxH30rSm/AOCb17xdlsBhReWEQDdL1XiSPuvvEkMRUfFez
         m9TA==
X-Gm-Message-State: APt69E3ymc+5wF5cHytjiuYQDDv4fjbbQjhLG/3OkmP6lrR/tzCf7QQq
        OoPatR082HlczIzcENBXbAK3X0rN4OmThXtbOpk=
X-Google-Smtp-Source: ADUXVKIFHUUghhd6LrHwQSJT7028pwu3E61RgyvqGzQiJ817ztv+8JhLNPpQ1ne8QcknlM3UkA1Jqv/VlYRr7Ry9KhA=
X-Received: by 2002:a6b:380b:: with SMTP id f11-v6mr942651ioa.105.1528817063829;
 Tue, 12 Jun 2018 08:24:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:4cb:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 08:24:22 -0700 (PDT)
In-Reply-To: <20180612145516.30897-1-srinivas.kandagatla@linaro.org>
References: <20180612145516.30897-1-srinivas.kandagatla@linaro.org>
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Tue, 12 Jun 2018 16:24:22 +0100
X-Google-Sender-Auth: nEdf92SfFiaC3ry05OfGhFaYZTE
Message-ID: <CAPKp9uaJK8AQPgqYCmVmpS0RsMBPGUAK_xXkHsNDg+2e3MygyQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip/gic-v3: do not access GICR_WAKER if its secured register.
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        "Nayak, Rajendra" <rnayak@codeaurora.org>,
        bjorn.andersson@linaro.org, sboyd@kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 3:55 PM, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
> GICR_WAKER can be a secured register, check this before accessing it
> as its done in power management code.
>
> Without this patch Qualcomm DB820c board crashes.
>

Are you sure this is the one causing the crash ?

As per GIC specification:
"When GICD_CTLR.DS==1, this register is always accessible.
 When GICD_CTLR.DS==0, this is a Secure register. This register is RAZ/WI
 to Non-secure accesses."


--
Regards,
Sudeep
