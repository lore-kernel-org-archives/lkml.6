Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D338FC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE4E2172F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE4E2172F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbeHMUgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 16:36:35 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:39586 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729025AbeHMUge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 16:36:34 -0400
Received: by mail-io0-f194.google.com with SMTP id l7-v6so11764699iok.6;
        Mon, 13 Aug 2018 10:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x5e9tAl16mCydrCkCvidtIYtGiM1nInW53c1/S7MUX0=;
        b=RIJJmU2wI22t6x1mwcEA2osIjjRt1wtWtrcWOz7eOFQEcIWjvcA6AGdMu2/ZMxewmA
         9I0SsQGFv9sL9lc/zj2LoDAIu5DQSuKfcAp28nsET0hlOYp6H6JUYwt83mHnbefY0riq
         Jum9Q026csr+6vJS3zv/2n16fKIyRZ4yEtFcBuP2OTNrTGzPqUxjAEn0WN6vpVfGMqkm
         5EVs6M4BtGx/+pRHvgHn9oydnu87+eZGfMNwc6xIOcCqW6IYmO8Hlbo/2CLJElFzkhcc
         iD19bHfEbHT2wTbj4S3+cU1JxAwuEKrjuoLgHKb0uf8stu0tK6xJMh3Lxt2T5wG87bbm
         dYLQ==
X-Gm-Message-State: AOUpUlE56k5CLtgwykO3hWtKr9AiL1KfIq1sorT9NDZh5d3UGgZjh5KX
        K32kaYWMJR/vSyJL7OLVWQA8OMQ=
X-Google-Smtp-Source: AA+uWPypnOKL+VhPETs2lijeBNcTjNw1+9GTsiXscK4C8thsMzX/2rqHxx4+zxmaygNo/PLGhqxAbA==
X-Received: by 2002:a6b:5a08:: with SMTP id o8-v6mr15733584iob.5.1534182799984;
        Mon, 13 Aug 2018 10:53:19 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id u68-v6sm6633070ita.36.2018.08.13.10.53.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 10:53:19 -0700 (PDT)
Date:   Mon, 13 Aug 2018 11:53:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Songjun Wu <songjun.wu@linux.intel.com>
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 18/18] dt-bindings: serial: lantiq: Add optional
 properties for CCF
Message-ID: <20180813175317.GA31286@rob-hp-laptop>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-19-songjun.wu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803030237.3366-19-songjun.wu@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 11:02:37AM +0800, Songjun Wu wrote:
> Clocks and clock-names are updated in device tree binding.
> 
> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
> ---
> 
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/serial/lantiq_asc.txt | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
