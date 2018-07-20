Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA89ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58FA204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58FA204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732042AbeGTOcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:32:20 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51289 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731289AbeGTOcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:32:20 -0400
Received: by mail-it0-f68.google.com with SMTP id h2-v6so14759678itj.1;
        Fri, 20 Jul 2018 06:43:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4s3SBuJrqXt/UTEt4ZmGfVxY52cbKBknVoLuA/7yJ8g=;
        b=nTWm+mZ3mYByVF0tXUHikGJiw23qHT+7SX2bXNBZOMPnySvDaBtoZ7I3eJvPLo24e5
         sbVQH06eki6ZfFwsIH+b1Sc6HFeOVAFRYiFIe+4KF6K2ARLSM5YFKBWJiwH8iCXMYLZI
         YEI55vro9QHsVXqu1FAFrUfA5XTFpG0wtMgBdhqLGpFval7uj2Gvi04RFOcr3Pd2AHiG
         obZFGUEtG8OedXosOdEjqiwZlhENa61ks/jie22WEz8JaG/zf5JZb/+GdE6yTTbL1buh
         40yHxsJja+oaj3XRSpXdWGog7ohe0niNjDqAnOcl0DF0XEW29gJfYIKwPtx19gr8aSpN
         vmdQ==
X-Gm-Message-State: AOUpUlG706tZruiSohh6x8vBKAnq96aotFr4lIpjYKgXdXqKrZT8pyhw
        Hr9Ddr8KXEsipN7kveqMxw==
X-Google-Smtp-Source: AAOMgpc6iIa0T5aXihKASMB+og8TZFWtUnWlpUEaeTVWgDnhYR2U6GlMadm9hJTRfeDlIkXkdITNBQ==
X-Received: by 2002:a24:a701:: with SMTP id a1-v6mr1796982itf.129.1532094237826;
        Fri, 20 Jul 2018 06:43:57 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id v13-v6sm1054252ita.38.2018.07.20.06.43.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 06:43:57 -0700 (PDT)
Date:   Fri, 20 Jul 2018 07:43:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@bootlin.com>
Cc:     dmitry.torokhov@gmail.com, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH v3 1/3] Input: edt-ft5x06 - Add support for regulator
Message-ID: <20180720134355.GA24750@rob-hp-laptop>
References: <20180718182719.29663-1-mylene.josserand@bootlin.com>
 <20180718182719.29663-2-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180718182719.29663-2-mylene.josserand@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 08:27:17PM +0200, Mylène Josserand wrote:
> Add the support of regulator to use it as VCC source.
> 
> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> ---
>  .../bindings/input/touchscreen/edt-ft5x06.txt      |  1 +

Please add acks when posting new versions.

>  drivers/input/touchscreen/edt-ft5x06.c             | 29 ++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
