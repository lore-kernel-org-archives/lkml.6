Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B710ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F85208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F85208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbeGPQRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:17:23 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:44849 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbeGPQRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:17:23 -0400
Received: by mail-yw0-f194.google.com with SMTP id k18-v6so14325489ywm.11;
        Mon, 16 Jul 2018 08:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JsC9fy+DThJjNbdTIQ9/w1KD3qlVlLCGCpOtWpf7byA=;
        b=Otg5pyI9pyFxoetYxloggCFN/65w/xCGMGY04fM5htJaQL7EJH5jawaHi6fQj2n/F4
         ZZg6vMOZ7wBK1Z0dXE1NChQA1g/dpoEx0jMvB531uErOMpeiQhM8n/QTArKvp72YOBBj
         2Ni2PSFSfxRssCq3saXcul5pCz+CK9nsYim8Vv6linb9Ho6fROQjnJSxMg6Hvp10CiCm
         W+BcRJczYyS0YNLOuJokyNA1/z7262DnE16sIS1P9kZrNSDpmOk8Qj7+NCI43zu+VelM
         dwxvv6KGknEuM68xNJnvG2ZKSYZnY6I9EfYawgLJzXoNEaXSrCo2gMXelDa+WNbGoI9n
         mmfg==
X-Gm-Message-State: AOUpUlHJYUmAL6NoZ/2AlhfkFxBJ6cXCq8s3vsRdmYV+Cl9Iv066EBhA
        miaaVp8ejIM0AqD3q2hx6g==
X-Google-Smtp-Source: AAOMgpfBA9RQ02gkKxgCt/Iy7xmuBmKmmiWTcVIWWTyP7bghFhTj3JHmWCTw9lC6o9BYR5vtaiwMuw==
X-Received: by 2002:a81:1690:: with SMTP id 138-v6mr8729518yww.507.1531756161979;
        Mon, 16 Jul 2018 08:49:21 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id s206-v6sm18705991ywc.55.2018.07.16.08.49.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 08:49:21 -0700 (PDT)
Date:   Mon, 16 Jul 2018 09:49:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     hdegoede@redhat.com, linux@armlinux.org.uk, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, tj@kernel.org, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, thierry.reding@gmail.com,
        icenowy@aosc.io
Subject: Re: [PATCH v3 2/9] dt-bindings: ata: ahci-platform: document
 ahci-supply
Message-ID: <20180716154918.GA30653@rob-hp-laptop>
References: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
 <1531479786-4911-3-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531479786-4911-3-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 11:02:59AM +0000, Corentin Labbe wrote:
> This patch document the new optional ahci-supply.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  Documentation/devicetree/bindings/ata/ahci-platform.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
