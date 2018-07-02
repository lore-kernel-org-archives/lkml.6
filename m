Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD063C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3CE23EFA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="pSt6IkQp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3CE23EFA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753501AbeGBSNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:13:48 -0400
Received: from vern.gendns.com ([206.190.152.46]:44459 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753194AbeGBSNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ssqodhSvXYROAXc666CT4w7IS1FPO3p8Yl0pAruNXnA=; b=pSt6IkQpZQhTSi7gkQtWZVunnh
        6tDwNnzPY8ZT9KKa708CccXJS/ms6p/CTzKDI7qFbNVo8r6KMzT+At3Eon0SSycgINP83TFfZ36yy
        rVQLLY4x8aBS0Hc08nNbf8qwCvFRVFFAKP22LQc8FiKMa0s98YKQZlNEdeKrhDchVbseH4HF1YNX5
        /QAWQ5Q32S+ipSQX9FVCrir9Jx+0pSSi9qhS3T0w7kBc7S+Nixjg/pmjBxnD9WsPs8RttFIuQaN8J
        484FTBgjG1H/LeQsAQqFwkUhY2rgxI4R0skhlfplWAFsTITz2DlB33mf7J0vuFXnlY35zuR/MmJu9
        PrvVzSbQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:35132 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fa3KY-00DgCc-R3; Mon, 02 Jul 2018 14:13:42 -0400
Subject: Re: [PATCH v7 00/10] Introduce the Counter subsystem
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, robh+dt@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <603b0373-f1e1-5938-fa53-8328c9a5964f@lechnology.com>
Date:   Mon, 2 Jul 2018 13:13:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1529607879.git.vilhelm.gray@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/21/2018 04:06 PM, William Breathitt Gray wrote:
> I decided to strip down these devices to arrive at the core essence of
> what constitutes a "counter device" and therefore design a "generic
> counter" abstraction to better represent these devices and prevent the
> ambiguity we discovered with the existing IIO Counter interface. This
> abstraction became the Generic Counter paradigm, which is explained in
> detail within the Documentation/driver-api/generic-counter.rst file
> introduced by this patchset.

I'm curious if you have given any thought to the time aspect of counters.
I am interested in the rate at which the counters are counting (e.g. how
many counts per second). I realize that you can calculate this in
userspace or in the kernel using the system timer, but it is not very
accurate since Linux is not a realtime OS. So, I would like to get the
rate directly from the hardware. For example, the TI eQEP[1], like the
one found in BeagleBones, has a couple ways of measuring time (see link
for details).

[1]: http://www.ti.com/lit/ug/sprug05a/sprug05a.pdf

