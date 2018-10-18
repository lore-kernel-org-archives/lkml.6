Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE89C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218CA20658
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218CA20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbeJSEuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:50:50 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35287 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbeJSEuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:50:50 -0400
Received: by mail-oi1-f196.google.com with SMTP id 22-v6so25174154oiz.2;
        Thu, 18 Oct 2018 13:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WWTmcb4Q0TX73UB9zWrhPmmr0IcLLfSMRvGijY4JEiU=;
        b=cHevS2Frz37ILb+dVQ4BQ3QaJBfqoXzQdOZsPpSMuSKRiWBdFbzVBvflKwu0vos8Af
         dZ0hhqNh5l7zn3hOM4prVvukK2kCwNSqfDdI9KSdcMEEdb/Pg6JxDiS8fQnSUgcLpeqc
         S/62HNTr7G8bNbMVhSyzsZ7+bMfb8rbRG2k/jLT0TCq8BikcvZBrdlDLqkxTDTY1IaH1
         FOcMnipKyJGPGlZkxuAKgjzjzU03YK6TQe8pix9FsNYg+utSbZYVeuQbe8gjH/KAXswK
         qqI6KxHLVHkJ2QjwI26MQ2yiLIsVpd10zL5mwx0cGUumNzmeliVtND42uI6GPN7QHuF0
         NKuw==
X-Gm-Message-State: ABuFfojvXJzjH2tIXEVOEdiATfeQiCDQlniArqT3qB/Pb1VqcpO1P1Us
        DbLuhu/8OL/+GzZq8UKrVg==
X-Google-Smtp-Source: ACcGV60M8oWPQnWsn/gdyn4t4b3Co+FxxMz179ICXXnzXJcnei5Iaz4W2DLC1HDmM60ncaOl+6Zepg==
X-Received: by 2002:aca:da02:: with SMTP id r2-v6mr18173433oig.345.1539895682551;
        Thu, 18 Oct 2018 13:48:02 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 31sm6771634otw.41.2018.10.18.13.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 13:48:02 -0700 (PDT)
Date:   Thu, 18 Oct 2018 15:48:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hannah@marvell.com, catalin.marinas@arm.com, will.deacon@arm.com,
        corbet@lwn.net, joro@8bytes.org, gregory.clement@bootlin.com,
        mark.rutland@arm.com, jason@lakedaemon.net, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, omrii@marvell.com,
        linux-kernel@vger.kernel.org, nadavh@marvell.com,
        iommu@lists.linux-foundation.org, thomas.petazzoni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, nd@arm.com
Subject: Re: [PATCH 3/4] dt-bindings: iommu/arm, smmu: add compatible string
 for Marvell
Message-ID: <20181018204801.GA2009@bogus>
References: <1539604846-21151-1-git-send-email-hannah@marvell.com>
 <1539604846-21151-4-git-send-email-hannah@marvell.com>
 <3ce1d67a-4e3c-e8d8-f7fc-79649f1def68@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ce1d67a-4e3c-e8d8-f7fc-79649f1def68@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 02:11:52PM +0100, Robin Murphy wrote:
> On 15/10/18 13:00, hannah@marvell.com wrote:
> > From: Hanna Hawa <hannah@marvell.com>
> > 
> > Add specific compatible string for Marvell usage due errata of
> > accessing 64bit registers of ARM SMMU, in AP806.
> > 
> > AP806 SOC use the generic ARM-MMU500, and there's no specific
> > implementation of Marvell, this compatible is used for errata only.
> 
> Given that, I think something more specific like:
> 
> 	"marvell,ap806-smmu", "arm,mmu-500";
> 
> would be most appropriate. Otherwise, if some future Marvell SoC were to
> ever come out with a *different* MMU-500 integration problem, you'd already
> have painted yourself into a corner.
> 
> Alternatively (or additionally), we could perhaps consider a separate
> property like "marvell,32bit-config-access", to mirror the existing handling
> of the secure integration bug.

The former please. We have learned our lesson there (though for some 
reason, that was the *only* SMMU problem in Calxeda Midway ;) ).

Rob
