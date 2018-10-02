Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C9CC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD682064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYZgrAUc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD682064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbeJBXwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 19:52:17 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38535 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeJBXwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 19:52:17 -0400
Received: by mail-pl1-f194.google.com with SMTP id b5-v6so2056965plr.5;
        Tue, 02 Oct 2018 10:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EIPbGsjH+rmJ9Zn47a7tfgVu+weQ1wqkfOQ2S8mBr4I=;
        b=qYZgrAUcbHktnYnGOkdsT05b52u/Y4uaiTevfTIueMt58SU3nnuVG20beFIziNE7OZ
         15y/JFWGY8JfwW50jXXb5KPYu17Zo1wf3ccrunnnYBFnWlsH479NhTukUbyPlc9LtfuB
         1uoNPUGVYD18mzSyxPsdBTWtEyzfH697dJr3RapRt6JFcGCOAbPrl3oVk2ZNgYT3LsuR
         Z+GoSJinoWDnScNGQgljxHqBcd2mprJr3ApjSgh2H2sopSQNQEPakloNHV+yZCFgelqP
         Zg547fj7vfohfvwMQ/6vGl9lXo9cNwCkcHjEEK/yh9fyRuoTbB6i74iwGi0QoqyBqYMS
         JwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EIPbGsjH+rmJ9Zn47a7tfgVu+weQ1wqkfOQ2S8mBr4I=;
        b=cicJc4a9uXqDtDKlR3HCMlOmZdc2lTTLVitjKfyr+TaKrtssP9RWE8tODXNRwvU9D8
         q9t6wyNxzxcdTOHrf6vz2scSfO833Jbxk7DLwieheQQlCr0JIPTfcxhr4ypw7yDRY9cO
         rpY6fEY/xa4aeLeROv/mkx2aJsbLWkplEdBextwKNftuhirpvU5CIBI6SlO3/I8cN481
         iviJqWZhUJpLwFC/nDd8ZZNXPmmrJQZs7ELXXyqF4hCAw4KUjgN1ZLdwIvGY7ZQfosQ6
         dRfg/Rz2mjAjz6JkZYSZoAq23f0GSt7KB4CcKLNUnKoPmbHL5mKgvvNBsz0TCBbBrdG7
         I/Eg==
X-Gm-Message-State: ABuFfogDdXiAgIz22yO2yep7w7ngWMp41W8x55inA2+cwiS5a1uK9t2U
        bjwmjqMwYrSPvgTRLTyk3N0=
X-Google-Smtp-Source: ACcGV60h5Efv+5JOEULseLI0KR0v4Ku2dXv1SvkHuNRDL1rKZJ/4oUnRT4DUFV1gbE6erKl+H/4YjA==
X-Received: by 2002:a17:902:8690:: with SMTP id g16-v6mr17106926plo.302.1538500074222;
        Tue, 02 Oct 2018 10:07:54 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id i2-v6sm23136550pgq.35.2018.10.02.10.07.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 10:07:54 -0700 (PDT)
Date:   Tue, 2 Oct 2018 10:07:48 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        corbet@lwn.net, afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v9 1/2] dt-bindings: hwmon: Add ina3221 documentation
Message-ID: <20181002170748.GA24384@Asurada-Nvidia.nvidia.com>
References: <20181002010523.2019-1-nicoleotsuka@gmail.com>
 <20181002010523.2019-2-nicoleotsuka@gmail.com>
 <20181002170518.GA27236@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002170518.GA27236@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 10:05:18AM -0700, Guenter Roeck wrote:
> Hi Nicolin,
> 
> On Mon, Oct 01, 2018 at 06:05:22PM -0700, Nicolin Chen wrote:
> > Texas Instruments INA3221 is a triple-channel shunt and bus
> > voltage monitor. This patch adds a DT binding doc for it.
> > 
> > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > ---
> 
> This version of the series looks good to me. I'll add both patches to
> hwmon-next, with the understanding that I may pull them if Rob has
> bindings related concerns.

Thanks a lot, especially for the review.

Nicolin
