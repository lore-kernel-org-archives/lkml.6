Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFEEC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2859920C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2859920C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbeIYVdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:33:52 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33699 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729420AbeIYVdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:33:51 -0400
Received: by mail-oi1-f196.google.com with SMTP id a203-v6so1830310oib.0;
        Tue, 25 Sep 2018 08:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=laV7YMZcgoly5nTS711whLPQ0y+sjF+AfXlA/I4KVl4=;
        b=H6QpLieDU0zH8eH8ku1ACDaFDaxd6FCm+egT8t3wZvdw5y/kH4fzl9ojHGmmiIICQt
         mgdhWw1cCX/0ulCpB45b9wgFlYF7h4yEAz0PVCPqDmuRHYF8wkx/Nc/oNqH7HXbG7T7h
         tC/n6HAkzkqflMqEGQ841LZPdxynvLxRZrMZvkoLZiHN07jGxDw3L8uEG8C4IWTsA+9+
         OlslEvdPyEkW8zhh+zLNTKVP5kUL5SOhx7WNbShxLUAcWQtxQDyONx2MvePJ7Ieow/cN
         H3TW86PxRkhaB0MvTTgbWLV2qgB/Nv0VqrSuLPqxwi1r1+KsG1rZHsC4eF4wcChPm87F
         W9CA==
X-Gm-Message-State: ABuFfogSSDwy0LAEdM18uEfHc18v5n587HUmTEofimCxGTHdokLgNOP9
        3UhvJOWXa1j/eF3R/272tQ==
X-Google-Smtp-Source: ACcGV63E+nDQuE8zn3NIb7XB00zWQVPneAO1f2VN2y+pjqk3n2iA9V6XME0aPWtWWcMntFFO1V7vxg==
X-Received: by 2002:aca:6a48:: with SMTP id f69-v6mr954837oic.279.1537889151205;
        Tue, 25 Sep 2018 08:25:51 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u141-v6sm847766oif.33.2018.09.25.08.25.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 08:25:50 -0700 (PDT)
Date:   Tue, 25 Sep 2018 10:25:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Janek Kotas <jank@cadence.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: ufs: Add bindings for Cadence UFS
Message-ID: <20180925152549.GA26019@bogus>
References: <9429A347-939A-44C6-BDBE-A892F5BCBD47@global.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9429A347-939A-44C6-BDBE-A892F5BCBD47@global.cadence.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 01:08:22PM +0000, Janek Kotas wrote:
> This patch adds a DT binding documentation for
> Cadence UFS Host Controller.
> 
> Signed-off-by: Jan Kotas <jank@cadence.com>
> ---
>  .../devicetree/bindings/ufs/cdns,ufshc.txt         | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ufs/cdns,ufshc.txt

Reviewed-by: Rob Herring <robh@kernel.org>
