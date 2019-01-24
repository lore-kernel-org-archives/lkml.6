Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E417AC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 04:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB062184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 04:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="a+3wYfTQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfAXEAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 23:00:42 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39230 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfAXEAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 23:00:42 -0500
Received: by mail-ot1-f68.google.com with SMTP id n8so4073296otl.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 20:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ucXfS2mSR3iIep7t/+LXhj0pgV0/EUWs4edPa/8THE0=;
        b=a+3wYfTQEmwx7ia7aP23/YO77+S5m9nixp9ZpZ//FWpVmEQ1Gn1qWzeyTRtRaidhkn
         5aZdk0o3QjDcwcNLpWkCzKo2PqjOMtRdJ8x5b5iLgBR0h9okavGUA6Y5CE+qazWKSuee
         ALJmfUIA/MKxPjVLdfcbG3R+WWU+ZvegCGKEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ucXfS2mSR3iIep7t/+LXhj0pgV0/EUWs4edPa/8THE0=;
        b=dxsW2bH3ZZ+m42AFpeDVcN/NncibFrfv5LaSrRRSG7zAsFbOC1JQOjvQtfmlNvYn+p
         wxP4MAFKjeBEKM9gDcf5/ByYn+yjGwcrWgjimM44vWU5buiKcjpo8tmRTUkQCDa76m0+
         RgrHODRiN3nrMTq5Eaow/3DMiTtDnVhgyGFV5hjMHd3QqUE4KQIEuBooDhZJMT18zAKW
         r7uIkGx0fkk9eyMYCprRO7ov0Ju/reNO10jRtCCiN9Fi3aGcrAnCZKj/AA/DxAu/TmP8
         cq6DGOazfpbUVSME5bZD75G/CAbcFnOhYMlbPVHTHI4ztwDVjzPlpOsZoJ/KRqwBb1EW
         awPg==
X-Gm-Message-State: AJcUukcmwGLl6QJnVmp8SmLqYWwtQrg7ZNZwAZMpXDomCdkTyFVfaT90
        Op5VcNJcHcYA5wWSlPGrO/+nwg==
X-Google-Smtp-Source: ALg8bN67+11/9I2/T9NjiMLwfN77ulo4XCcpLlkebEGgpME7hLEbIxGl4n7BdK0ZRTzg36S+w5gacw==
X-Received: by 2002:a9d:177:: with SMTP id 110mr3406744otu.26.1548302441097;
        Wed, 23 Jan 2019 20:00:41 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li1103-53.members.linode.com. [45.79.4.53])
        by smtp.gmail.com with ESMTPSA id r11sm10321994oib.45.2019.01.23.20.00.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 20:00:39 -0800 (PST)
Date:   Thu, 24 Jan 2019 12:00:33 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH v6 0/8] perf cs-etm: Add support for sample flags
Message-ID: <20190124040033.GD3268@leoy-ThinkPad-X240s>
References: <20190119014347.27441-1-leo.yan@linaro.org>
 <CANLsYkwj0jU+GAXXCNY7h-8C40oouF8dx_fzUVRTbV=buS4M2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkwj0jU+GAXXCNY7h-8C40oouF8dx_fzUVRTbV=buS4M2g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 05:22:03PM -0700, Mathieu Poirier wrote:
> On Fri, 18 Jan 2019 at 18:44, Leo Yan <leo.yan@linaro.org> wrote:

[...]

> > After applying this patch series, we can verify sample flags with below
> > command:
> >
> >   # perf script -F,-time,+flags,+ip,+sym,+dso,+addr,+symoff -k vmlinux
> 
> Since you are going for another iteration please add a "before" and
> "after" example.

Sure, will add it.

Thanks,
Leo Yan
