Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB4EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E4021907
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545338679;
	bh=0wEOmnDJn6z0jLMtcD6LJHUiIpFsOKqJdsQvTak89sU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ukLh3HKKTCmDwbmApVJv9POcXSYIwUrYn8ii+OtO0oH/9IPJHSeMq5rOQJgk0h9dy
	 rmlved6uz2dnATwuA8RDQAbRb6FdvaAATGchAPhHvihs3OWdiRREX4NtQP6kAcEcG3
	 JZNMevHfYKYpNpJfQhHc0sM6HpcmuPamrjVvQUq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387491AbeLTUoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:44:39 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45897 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730057AbeLTUoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:44:38 -0500
Received: by mail-oi1-f194.google.com with SMTP id y1so3001395oie.12;
        Thu, 20 Dec 2018 12:44:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q8i6c4ZL4Z4u35CG2gPdbbPNokVdAtVtmKtXDKnFPJs=;
        b=TAQDJaJrTAIMQjAXodSx8Hdj6W7o3c7+Z1OTS8q4velNFRDMpjxb4XGXzAhvWy4p8S
         CR6d6pPHk3Fi4MHVPiX7EooFiyc6tQOsZz7YhXnNMeeX01HkqgjT4y0Vb3wC/Ud0k4ou
         kCfTzZyvDPqEyuSFeULKxeU+ikczv4IjeWa0ZP+2UEWI2Z90J+/ZcIzigzKanEe21hHH
         q01YeM8hHpHicmIb2lB+9smodmCvf77g8Gy41zf1LO/F+pf9OWav5OrVWksPcgVLQ+wj
         ghkoZWBvnium7ImlKMwaFdxqYFteWSX9pfckHZZ/vgaTqBt09ERr/N4s1oBnfjtPdPVB
         rY+g==
X-Gm-Message-State: AA+aEWbDZkVc84iYv6JIV7hqnAwFGCI50nogcm49ah/HWtr0vWA5sKA+
        uoRbyN4rbY8ExIXFoRrqcw==
X-Google-Smtp-Source: ALg8bN5SWsUxsPipzbSrGvnQvoSjqAoQ5P2RCDdJrnpRoDcjv2vqBnUdsaBFaX1UQITOfm2nW7mUew==
X-Received: by 2002:aca:e283:: with SMTP id z125mr169034oig.23.1545338677992;
        Thu, 20 Dec 2018 12:44:37 -0800 (PST)
Received: from localhost ([2607:fb90:20d2:a5e2:49af:e73e:5a36:3b50])
        by smtp.gmail.com with ESMTPSA id q25sm14032736otg.70.2018.12.20.12.44.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 12:44:37 -0800 (PST)
Date:   Thu, 20 Dec 2018 14:44:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 2/2] dt-bindings: nvmem: imx-ocotp: add compatible string
 for  i.MX7ULP
Message-ID: <20181220204431.GA31062@bogus>
References: <1544777136-9195-1-git-send-email-Anson.Huang@nxp.com>
 <1544777136-9195-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544777136-9195-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2018 08:51:37 +0000, Anson Huang wrote:
> Add new compatible string for i.MX7ULP SOC.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
