Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3F9C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781482075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 781482075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbeIFXAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 19:00:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34004 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbeIFXAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 19:00:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id k19-v6so5706681pfi.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 11:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2E170GdDLCBZZ2OYnlivT2k2lXaCdh6T65oK4bwHCso=;
        b=SxQrAwUfesN1T+5yvbdiYgdzi2wB6in7K2d+109tzf9Ja3G+GFJxgFPOzUuqbLub/6
         /sa/fbZv4YXDK7hZoTcAN5i/ajdMjQ/F/NwgGntbZ5GtPBa8VhYabLOMvolcehh0LrvQ
         eGNOAE1UtuzNV3VoM3y3uoZlPR/ZZDC9LBb+76AzKv8PC8omiedjyRKc7t6ywO6p9ckQ
         cSWPpsmV3Dljjsc3x335BxFIMMkyUY3X7YqgMmo7dYl3cIMzAdEvObYvEiPWmWRj4ZkW
         KrCHPInKUUXtEmh2I3PL/nIwUMlbBbG3x0JzFAdDL1GEnQRfJgF4hGTQymQTmedqxok7
         ASPg==
X-Gm-Message-State: APzg51BbTJjDLjRQOVg11pJKIy4HSuyb4g2XzgfAle9dW9Hx48PIg0fg
        7R3MVngQFEphkxQQ6sAkA8sAjg==
X-Google-Smtp-Source: ANB0VdZ7Gpqk0GhVOetbgs4QWF4hepbT9fQvfGcbTvr/t4DLQ4hmipRqtoGveeZdKI9d2yell9YOHQ==
X-Received: by 2002:a63:4606:: with SMTP id t6-v6mr4086266pga.271.1536258240222;
        Thu, 06 Sep 2018 11:24:00 -0700 (PDT)
Received: from localhost ([207.114.172.147])
        by smtp.gmail.com with ESMTPSA id v72-v6sm15489172pfj.22.2018.09.06.11.23.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 11:23:59 -0700 (PDT)
Date:   Thu, 6 Sep 2018 11:23:59 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Alan Tull <atull@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Moritz Fischer <mdf@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: fpga: fix freeze controller compatible in
 region doc
Message-ID: <20180906182359.GB20419@archbook>
References: <20180906180152.3620-1-atull@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906180152.3620-1-atull@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

looks like it's just the examples, right? So not sure someone
would be affected by that, yet?

On Thu, Sep 06, 2018 at 01:01:52PM -0500, Alan Tull wrote:
> Documentation/devicetree/bindings/fpga/fpga-region.txt has an error
> regarding the freeze controller bridge, secifically:
> 
>  compatible = "altr,freeze-bridge";
> 
> The compatibility string should be "altr,freeze-bridge-controller"
> as set forth in altera-freeze-bridge.txt.
> 
> Signed-off-by: Alan Tull <atull@kernel.org>

Acked-by: Moritz Fischer <mdf@kernel.org>

Cheers,

Moritz
