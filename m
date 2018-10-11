Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305ECC28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF1420841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF1420841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbeJLFqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 01:46:50 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:32806 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbeJLFqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 01:46:49 -0400
Received: by mail-ot1-f66.google.com with SMTP id q50so10558170otd.0;
        Thu, 11 Oct 2018 15:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7LRoTccW3Qd/lI+RNLsIYPnvFamwVX9Crg52AF9Ffao=;
        b=Lu2766c/SMrkYEvyYMFqw0BHi4akUS7of/PWOPhPkUIp0Zuo3QIkJ7hK+5JZ32cMCR
         VStAjoYicog5sFetLIluGzRBRSX0rwdIJ2SlIVyXS32BJc3s/VtnUhEV11qtsWebeo+B
         Rm4da/MVc8kPPEERBWPInIK9zONBPpGD8FaYrUmkIor5eK2PKxuce2Kugh0K5xhTED5h
         hZAugAb00f1sJZY+aoqraGHBSbNftW4orE5R2KBLYLXUvPERG8FquCGryE8tQpEM2GVH
         9rFppzy1/W3Mc2Ks2UxIsug7dmlK4+nwi/YP1a7dZMdjwmfUz+2QrOJMHNSc1aTXQeML
         K4VA==
X-Gm-Message-State: ABuFfoh3omwGVFM/hUYQlPQ2KNxXv6M0vfCUD9k4L2QE/zw5hB4oEnPz
        P09zOomtXRCi9muhJbDGCw==
X-Google-Smtp-Source: ACcGV61DlaXEv78cOo3s9EjBamZs7vKoYCgW3QhBFhfERd2PhY9xxhba1UA4eWal8b0tTdMdmiW4Bg==
X-Received: by 2002:a9d:52a4:: with SMTP id f36mr2340486oth.186.1539296252521;
        Thu, 11 Oct 2018 15:17:32 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d6sm7071160otj.75.2018.10.11.15.17.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 15:17:31 -0700 (PDT)
Date:   Thu, 11 Oct 2018 17:17:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: Re: [PATCH v4 2/5] dt-bindings: spi: add binding file for NXP
 FlexSPI  controller
Message-ID: <20181011221730.GA7293@bogus>
References: <1539255519-1408-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1539255519-1408-3-git-send-email-yogeshnarayan.gaur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539255519-1408-3-git-send-email-yogeshnarayan.gaur@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2018 11:00:38 +0000, Yogesh Narayan Gaur wrote:
> Add binding file for NXP FlexSPI controller
> 
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> ---
> Changes for v4:
> - Incorporated Rob review comments.
> Changes for v3:
> - Removed node property 'big-endian'.
> Changes for v2:
> - Incorporated Rob review comments.
> 
>  .../devicetree/bindings/spi/spi-nxp-fspi.txt       | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
