Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411F8C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E9F26434
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mn3gfggA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E9F26434
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965241AbeFZCRm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 22:17:42 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42876 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965199AbeFZCRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 22:17:40 -0400
Received: by mail-pf0-f193.google.com with SMTP id w7-v6so7341514pfn.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 19:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+eQVgtj9EStgM01D1ecbpJtXgSSXRq+/QqNIsapt06A=;
        b=Mn3gfggAaC9nHnDp7LmJvc9rY7NNzpDO4Iiv5Ww087hX0nWmiqsl0WmwciZi5YSGyv
         dXVwyy+xshgrqRmTG9EYqsOELQObbbmesJ/AlNf01XqgkHECcpjVbZACh3DmfWkw3C15
         UE1a39JlhO8ERdwBV86EHSSGP3EoMLmFuFPqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+eQVgtj9EStgM01D1ecbpJtXgSSXRq+/QqNIsapt06A=;
        b=Wm6edjDmZHq+fbfr/aScCOjdaf2PIf+vghxrSCV5rVOCoeRpfa7IZ5vhPaRYasjO4Q
         Hxlm7JpkJ3Z5Qjz+Ge5dpr1rABJ+2mE5/jwZCABjqKNU/+Glf0ZX9XW3ur6EKHKimfzV
         Elv01x7nqrUfZY5B4N2ruJiwv+rluYHsYz1HcjZUhZfaoBkDwyT+jCoC317PLEg2zbVk
         eLpjpygIsFpGdWQ054hPf8pgu9fMQM7rrJcgl18K1jvtAURiPTOz/26y773KLLTV8ZDs
         9+paIkIKaebSUrPErUScBD98aLkiWUh6TDNzQXmjGc/+fTO/oofoAp45E6VwrPPG0KfX
         QMtw==
X-Gm-Message-State: APt69E0AVK7AFD6r+eg1dc0vR2YzRCQxRDeA6HYGCX0cwZKYOK1C37I1
        1HhB1hTIAI9KSReyqnK4WEtZJA==
X-Google-Smtp-Source: ADUXVKLItfXC70LqM2ItSZLRp4tN26yLkoa/10saRx0lJvFKFLaK0A9WbmDvkz5gvSmNWjVPq5i1iA==
X-Received: by 2002:a65:6612:: with SMTP id w18-v6mr12370988pgv.38.1529979460254;
        Mon, 25 Jun 2018 19:17:40 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v15-v6sm554301pfk.12.2018.06.25.19.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 19:17:39 -0700 (PDT)
Date:   Mon, 25 Jun 2018 19:20:04 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     Arnaud Pouliquen <arnaud.pouliquen@st.com>, ohad@wizery.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] remoteproc: rename subdev probe and remove functions
Message-ID: <20180626022004.GG1860@tuxbook-pro>
References: <20180515205345.8090-1-elder@linaro.org>
 <20180515205345.8090-5-elder@linaro.org>
 <dc10f869-48fb-84da-9df2-409d6c3568dc@st.com>
 <726fa7c1-dab8-c1e5-721a-2f60d7f967d8@linaro.org>
 <62d746d5-5cfb-11e4-17ba-e3d8f4eeb659@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62d746d5-5cfb-11e4-17ba-e3d8f4eeb659@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 25 Jun 18:32 PDT 2018, Alex Elder wrote:

> On 05/29/2018 06:53 AM, Alex Elder wrote:
> > On 05/29/2018 04:12 AM, Arnaud Pouliquen wrote:
> >> Hello Alex
> >>
> >>
> >> We have the same needs (prepare unprepare steps) on our platform. We
> >> tested you core patches and they answers to our need.
> > 
> > I'm very glad to hear that.  Would you offer your "Tested-by" on these?
> > 
> > On your comment below, yes, I will re-send v2 and will separate the
> > core from the glink code.
> 
> Arnaud, despite what I said above, I'm about to resend the code but
> will *not* be separating the core code from glink code.  It turns
> out that the glink code (and smd and ssr) are really part of the
> core code at the moment.  So after talking with Bjorn I agreed to
> just send the code without splitting them.
> 

I wasn't trying to say that it's part of the core, but after reading the
patches again I see that my memory failed me on how these where split.

I'm okay merging this patch even though it touches the two separate
files.

Regards,
Bjorn
