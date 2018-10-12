Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D299C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE3E204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE3E204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbeJMETb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 00:19:31 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44682 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeJMETb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 00:19:31 -0400
Received: by mail-oi1-f193.google.com with SMTP id u74-v6so10843125oia.11;
        Fri, 12 Oct 2018 13:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mzj3L4pyzZqMIxHpDunCaIpeLFfVR+c3zJJ0ilzi3qE=;
        b=GhqnP/QE545bQO/2N99OfsL16iSFpY2IbnDg9ga9gSy7EKvW3DVPpgste7y5WS2JkE
         pDlMnJod8KGp7GfQ3evhCJKFZ0Cbeut2++siE0m1Ze4KzSNDA96tnp1rGREPJ5/Uvjjn
         mEdnodVGrZQ8hsS+PlHvFk9ntXqyl3XVG+AWhobOLAOjXtlbtZI9sS6YMfBzWUnwz6TJ
         jLHENNASN+fbye/O+tzLwQOMeinBjy7LcTaIVuMNN4me2zp65C5GIXE3/LgpNuSXvZqf
         7rlFGpRvSZjrFCOHGYL0+ijA/VZ75I5mffNtIhnW4n9jiGwwim+UG4/s4wCxhL3VK2MN
         wtZQ==
X-Gm-Message-State: ABuFfoj75iie4KwJ6Y8spgveFafNBqwXqBvZWQsRav+LnRSyQ/W8G2AF
        kleuN8y2DG/0cG7hpGcG2oa/Kbe7aQ==
X-Google-Smtp-Source: ACcGV63IfpVboMxPRK743P+12wNsj8IejaJ7msVlIN1VirKds5C3EI9J5RrdNENoUOHWgBDetksEug==
X-Received: by 2002:aca:ba54:: with SMTP id k81-v6mr4315744oif.177.1539377114940;
        Fri, 12 Oct 2018 13:45:14 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a33-v6sm684090otc.79.2018.10.12.13.45.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 13:45:14 -0700 (PDT)
Date:   Fri, 12 Oct 2018 15:45:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jerome Forissier <jerome.forissier@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Maydell <peter.maydell@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        tee-dev@lists.linaro.org
Subject: Re: [PATCH v2] Documentation: dt: Add binding for
 /secure-chosen/stdout-path
Message-ID: <20181012204513.GA29769@bogus>
References: <20181008101642.8040-1-jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008101642.8040-1-jerome.forissier@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 06:16:42PM +0800, Jerome Forissier wrote:
> Some platforms may use a single device tree to describe two address
> spaces, as described in d9f43babb998 ("Documentation: dt: Add bindings
> for Secure-only devices"). For these platforms it makes sense to define
> a secure counterpart of /chosen, namely: /secure-chosen. This new node
> is meant to be used by the secure firmware to pass data to the secure
> OS. Only the stdout-path property is supported for now.
> 
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
> 
> Notes:
>     Sending this again, slightly modified. Previous submission was in March
>     2017 [1]. Since then, OP-TEE has implemented this binding for platforms
>     that use DT [2] (fallback to /chosen/stdout-path to be implemented in
>     [3]). A patch for QEMU has been proposed [4], to which the maintainer
>     responded "Are the DT bindings upstream yet?" ;-)
>     
>     [1] https://patchwork.kernel.org/patch/9602401/
>     [2] https://github.com/OP-TEE/optee_os/commit/4dc31c52544a
>     [3] https://github.com/OP-TEE/optee_os/pull/2569
>     [4] https://patchwork.ozlabs.org/patch/979345/
>     
>     Changes since v1:
>     - Use "should" instead of "may" ("...the Secure OS should use the value
>     of /chosen/stdout-path...").
> 
>  Documentation/devicetree/bindings/arm/secure.txt | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)

Applied.

Rob
