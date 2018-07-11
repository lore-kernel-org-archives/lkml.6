Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14132C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B3A208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B3A208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732534AbeGKC7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:59:02 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34021 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732292AbeGKC7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:59:02 -0400
Received: by mail-ed1-f68.google.com with SMTP id d3-v6so18020071edi.1;
        Tue, 10 Jul 2018 19:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5OvBi86AJu2LkddjTXUppSE5DsLrI8/pU3zq6fpls4Y=;
        b=EtKNru9viJzhW+ijkTU/2QE29xL1dkfucr5AOsA5AimnSiMtVE4FeYnn8MF5oyRIzG
         AWmX1jh9DKvApm35S5+H84SgnZpSbzMrw0o9RAJgIx8OwiV+em0nzN5P23AaAlAXwEJG
         jW/0DxD2ddeaYdOSn0B735yrjsbBJYpP2jySK/YN7ZxsxxFDZ8BXyS9hXkReeQpqIQyO
         wKPbirsx+tjJVBHDoVGZGrgXHQdgBQrWWwhmVW0upoB1jxdYtap1nKea7oUIL91AQ4LI
         YP9u8uRnCkmN/XRg4RZJmsr/W2rSVk/CqmDk10aQCUGm2YTmNA+yPX2RXw83AjCnBV3B
         XjuA==
X-Gm-Message-State: APt69E2+1jHARSpUasuCM7iBJHmbQgVFVCp+jnaH7rD+GUNbY5k7uwff
        Ra9ddbVGdRiTjjb3WlyuXE1EAhlp
X-Google-Smtp-Source: AAOMgpddWO61IrQlfeGTMNtSzFsyRNr0t2e4OutJDg06MyGsukToWq2Pab0kgz7AsIfuaEuILoWUHg==
X-Received: by 2002:a50:e20c:: with SMTP id n12-v6mr29031433edl.253.1531277815760;
        Tue, 10 Jul 2018 19:56:55 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id m4-v6sm5457640edr.15.2018.07.10.19.56.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 19:56:55 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id m1-v6so3814165wrg.5;
        Tue, 10 Jul 2018 19:56:55 -0700 (PDT)
X-Received: by 2002:adf:c98d:: with SMTP id f13-v6mr18920585wrh.148.1531277815418;
 Tue, 10 Jul 2018 19:56:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 19:56:34
 -0700 (PDT)
In-Reply-To: <20180710203511.18454-10-jernej.skrabec@siol.net>
References: <20180710203511.18454-1-jernej.skrabec@siol.net> <20180710203511.18454-10-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 11 Jul 2018 10:56:34 +0800
X-Gmail-Original-Message-ID: <CAGb2v671bqg2+kAZg=ibczAhCYDh39g8RX2bfKr+biDY7xCdfg@mail.gmail.com>
Message-ID: <CAGb2v671bqg2+kAZg=ibczAhCYDh39g8RX2bfKr+biDY7xCdfg@mail.gmail.com>
Subject: Re: [PATCH v2 09/18] drm/sun4i: mixer: Order includes alphabetically
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 4:35 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> Includes are not alphabetically ordered.
>
> Reorder them.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
