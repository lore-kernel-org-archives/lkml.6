Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B11C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E742152C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKrGrtrM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E742152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387760AbeHBRfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 13:35:10 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44113 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387660AbeHBRfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 13:35:10 -0400
Received: by mail-pl0-f68.google.com with SMTP id ba4-v6so1193004plb.11;
        Thu, 02 Aug 2018 08:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4xB6CYYP8IvTrhTriTcapb3rpc0KMM1JsYBRCNRBjcg=;
        b=UKrGrtrM2qLGkuszabY1MHJ6hDOZ5z1vz6lXwcDMBWQIyJR3vVgNlLPbGnmDC/Tfbe
         Qqg3knL9/IOsGXnZb2L8tkNCa0KnMbwPRCUNoyn9xo9Zd3MTB0yqV36Vo5ydfpebv0Ma
         DFgQ/qnHOgunst5HWhLhayCGxR9A47N3MgBOsudCKhyaIhx6TBvyjFNnAIEDWMICX7Qp
         1lcpTzg1sk/3Z7AJesLn0tMSL5zEqoIN6iQqssAtMlfqvJVNiFquq+pLD/srvbDlfswZ
         VVb2mZ6JTwqTv3KuCUCGXQPtZDOX+tybbRTJb2dVPvRpkiUvI60895n6XcN01cDU66No
         ahRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4xB6CYYP8IvTrhTriTcapb3rpc0KMM1JsYBRCNRBjcg=;
        b=DEWlzu9DVeAIQH9FLRtKAVN3hZlab8dx/o19jVzI/WIP/KY5NR3ParDMvLxZ8RZN+K
         IehSw9xHOZwWIlg0mWcuskmCzuNen1pxwTGiVOLnAN+BnYuBPDZn06uYd3ClhOtjZH+J
         BMzW2MAFjQ9xZge4VSO18bC1ilQibWEHb1tQ+lQFIGwyJXHCTUhIcJX5OQLASU16A/jY
         93oeyAAO4sLM+7hF1yAaQLS6qkhIqTCEKwHgn3xWhKNVsjayhU/0wJSZyie1z0TrxkGA
         BuoDOfbuxbkZ31MIKUT3nJneqy2XhKJigkNvahQmQpGFv84Nnl3hYduuP7hNcc7A/+jQ
         fJnQ==
X-Gm-Message-State: AOUpUlFMSaxIQeOs/93Gjwsjis2waJFN/d4F4LHLn9So/tDxqayLjD7U
        uLjBa6FxwCSg5p/5fCULeBE=
X-Google-Smtp-Source: AAOMgpc55OEbYy+3bvH2OipBHmv9Fa/jvUS1QxP+fbm+0/1QcNVoxAuO7fgRule8EHL+nvtr75QaSw==
X-Received: by 2002:a17:902:530a:: with SMTP id b10-v6mr2312330pli.101.1533224607269;
        Thu, 02 Aug 2018 08:43:27 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id b18-v6sm8876226pgk.15.2018.08.02.08.43.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 08:43:26 -0700 (PDT)
Date:   Thu, 2 Aug 2018 08:43:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/246] 4.14.60-stable review
Message-ID: <20180802154325.GB5137@roeck-us.net>
References: <20180801165011.700991984@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 06:48:30PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.60 release.
> There are 246 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Aug  3 16:49:18 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 198 pass: 198 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
