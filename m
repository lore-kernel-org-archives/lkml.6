Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83765C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C53208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uk3T+5Zo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C53208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966042AbeFOQQw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:16:52 -0400
Received: from mail-yb0-f177.google.com ([209.85.213.177]:33058 "EHLO
        mail-yb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964966AbeFOQQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:16:50 -0400
Received: by mail-yb0-f177.google.com with SMTP id x36-v6so3701045ybi.0;
        Fri, 15 Jun 2018 09:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tdG+trXG1kBx0hQ2bKXsm97k/QxWxuelgCi5+5yuNbg=;
        b=uk3T+5Zo01OuIBCBK54GXfb7cf7pfBirnRuq/d5d9/YViODiY0IaiN4KQRR588NDxm
         ykd102eWbaFpaTlVPEUTn87PHNz0wkI4tbWraD0Lz6mcnSGQm1cLf06afTGpjBcGlka9
         HMK746pB6pmokdhuMRFMPHfWFLDquxrf8lBVWeXt3AEdd4s+Qx/EImdwKKiCQl1MH3ja
         Ch/dq+jqgYNksqHYQefgQi8/yShhx6DXy/deRVJUf8rsnD818gyQxbFc1hzd/wkUVVil
         kXcaJL4zIFM5hjbVX1/Nhoy0zDbb40PRYxvcKG3nPRYMoMYPg/Y3AmDE/kUlCBlvbjfT
         3tBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tdG+trXG1kBx0hQ2bKXsm97k/QxWxuelgCi5+5yuNbg=;
        b=DWTyVgbixtXWIOlLTQOgmpkwqyccfvMx6PLAEVEKn7Ni3mSa/JKtNvpz0bobsm4zE1
         6TYF4G6dZZYNyojxxOE2Qz3/V83pQtJQmETQxhcPbZt0sliyHA7s/e3qi2Y1qPd9OcUE
         uvPmMcEIlOngdyHqTB6jHQOx96aPw2mj755Evy8nLZRW5yNvag4Klkq26uSkbkmspMNp
         EOLFqnWK9mKX22XKZD8oPtoioT9h9wcDVUem9o3QgyI0ojF0gC8w/+1kW3NhfIVVWRjD
         CPS06zc7gvqghZ4DhmeHLfP0B4+sj4cqH+zjle61onxZOmP++WbTIuWkzAGBa06WA6le
         qlSg==
X-Gm-Message-State: APt69E2ibSmEHUw6r8q6N8sHnpFi1F+bDa/nLv238yKaAsEECKcccAnV
        L++KXk3Qm55vLv9fjP0gMgY=
X-Google-Smtp-Source: ADUXVKKlmerpXvTmAcGK5Uobjb4HZCWW3yUuhC7mnNZx5KkTNd3Sx0Zrh6YEdHF+fWvlsj9aizim+w==
X-Received: by 2002:a25:a087:: with SMTP id y7-v6mr92113ybh.219.1529079410090;
        Fri, 15 Jun 2018 09:16:50 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:f114])
        by smtp.gmail.com with ESMTPSA id n19-v6sm4857823ywh.55.2018.06.15.09.16.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 09:16:48 -0700 (PDT)
Date:   Fri, 15 Jun 2018 09:16:47 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Ivan Zahariev <famzah@icdsoft.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Cgroups "pids" controller does not update "pids.current" count
 immediately
Message-ID: <20180615161647.GW1351649@devbig577.frc2.facebook.com>
References: <77af3805-e912-2664-f347-e30c0919d0c4@icdsoft.com>
 <20180614150650.GU1351649@devbig577.frc2.facebook.com>
 <7860105c-553a-534b-57fc-222d931cb972@icdsoft.com>
 <20180615154140.GV1351649@devbig577.frc2.facebook.com>
 <1d635d1d-6152-ecfc-d235-147ff1fe7c95@icdsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d635d1d-6152-ecfc-d235-147ff1fe7c95@icdsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Jun 15, 2018 at 07:07:27PM +0300, Ivan Zahariev wrote:
> I understand all concerns and design decisions. However, having
> RLIMIT_NPROC support combined with "cgroups" hierarchy would be very
> handy.
> 
> Does it make sense that you introduce "nproc.current" and
> "nproc.max" metrics which work in the same atomic, real-time way
> like RLIMIT_NPROC? Or make this in a new "nproc" controller?

I'm skeptical for two reasons.

1. That doesn't sound much like a resource control problem but more of
   a policy enforcement problem.

2. and it's difficult to see why such policies would need to be that
   strict.  Where is the requirement coming from?

Thanks.

-- 
tejun
