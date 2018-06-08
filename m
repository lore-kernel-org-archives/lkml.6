Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 3IfNB2UFGlt0fwAAmS7hNA
	; Fri, 08 Jun 2018 04:27:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4802A6074D; Fri,  8 Jun 2018 04:27:14 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fn6rWApI"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C0CB960290;
	Fri,  8 Jun 2018 04:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C0CB960290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751112AbeFHE1M (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 00:27:12 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41148 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbeFHE1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 00:27:10 -0400
Received: by mail-pl0-f66.google.com with SMTP id az12-v6so7481350plb.8;
        Thu, 07 Jun 2018 21:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tNe2s+ngtcIsg7+GbuVKJMa6kU73NDn6hfT8xfgVVWI=;
        b=fn6rWApIZHzbkICIK884y/LQT+edJzrGM2SMsD1GGneDPmGqn4Doo01AnrFHPoeAM7
         vvHKufMhaHIBjqRAr1WehRxseczHelOf36+i+fhjFfVHuBoTdfngparzjPhB23LBHUzf
         XgwLyKFgYW/c4l1uWRMA6wf/hZ74AI7fim1U9NVf6wQYRMgc/IKVhMXrOezWYJZlg+mL
         TisOkEICyQLm+AI+TymH1i6Ag3dPD80Ayr7NKug3exiYonnTyst0Fbjg1FFq5dgQ4384
         drnjDMardABkGmAyX13koM8zXJEx5jKnLSLpQNJhGHRsAF79J9z+QcPusYc+mALdb8nz
         rFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tNe2s+ngtcIsg7+GbuVKJMa6kU73NDn6hfT8xfgVVWI=;
        b=fSSfCgiJOk88Voy0Hhm3rOWfjEmwwEGInuTOmA5tBK5YsqvVKZGkxpgSq7GV72kxxh
         qNZ5hAOGUSpnvrq8U4jUhSOAf+jcANfnSMPb5R0JoVxRdysARRTuN0woOY21979zln2j
         pG6HXgLJ0rUBAfWDQ2hnRYDAn1TUnsSNam1Bv6eXte31JmhugHXEso5If1pp94ujGz01
         0Y2U3J58cSIIat4IMTIgW1pp7iXDX6Y9f4hdMfYCtfqwaT9Po6/EvD90dHvo37FpfHeE
         QLeFoiyGz77YJh+/ZKdzQale0oRQE5f05AVIu5s2K501SE5AwPh2gaLxRhLXynxLoUaE
         pUkA==
X-Gm-Message-State: APt69E0DTv2jWWyzUJSKD5CGGawfQIcfN18nfyckY6FtRB+gl6iedtXb
        cQqQ19UpM5wOHvzk//FcfHQ=
X-Google-Smtp-Source: ADUXVKJeufC4v9OqOu9ZA5URSid52c7Amel5AzXpm6uWtxbDKNsozebYo+Tn5RpbvV4judxioCdRPQ==
X-Received: by 2002:a17:902:a518:: with SMTP id s24-v6mr2222978plq.144.1528432029473;
        Thu, 07 Jun 2018 21:27:09 -0700 (PDT)
Received: from localhost (c-24-4-232-150.hsd1.ca.comcast.net. [24.4.232.150])
        by smtp.gmail.com with ESMTPSA id y7-v6sm95083374pfy.52.2018.06.07.21.27.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 21:27:08 -0700 (PDT)
Date: Thu, 7 Jun 2018 21:27:06 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: netdev@vger.kernel.org, madalin.bucur@nxp.com,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v3, 00/10] Support DPAA PTP clock and timestamping
Message-ID: <20180608042706.7gfg5p6574ntc2lq@localhost>
References: <20180607092050.46128-1-yangbo.lu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607092050.46128-1-yangbo.lu@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 05:20:40PM +0800, Yangbo Lu wrote:
> This patchset is to support DPAA FMAN PTP clock and HW timestamping.
> It had been verified on both ARM platform and PPC platform.
> - The patch #1 to patch #5 are to support DPAA FMAN 1588 timer in
>   ptp_qoriq driver.
> - The patch #6 to patch #10 are to add HW timestamping support in
>   DPAA ethernet driver.

Right now, net-next is closed for new stuff.  You will have to post
the series again after the merge window closes.  You can check the
status here:

    http://vger.kernel.org/~davem/net-next.html

When you do re-post, you can add my:

Acked-by: Richard Cochran <richardcochran@gmail.com>
