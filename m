Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F17C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 04:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F1E2081C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 04:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0TO/TPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F1E2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbeLIEwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 23:52:46 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43304 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbeLIEwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 23:52:46 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so3651543plb.10;
        Sat, 08 Dec 2018 20:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=46qUYpbbNitWjlB0ZH4fmYZsgzUezmQ9lWgsvWDqpLE=;
        b=J0TO/TPv7gezqLnenEJgcidkKwGmdUYVHpJqbJVGrYkF8ZHH/RNS/is17B3qIBl9ja
         9TFX0x+JMzgJdYJ2Uo0MmfXy93xHMMt/oZmi6r4vbLqrrcg91WkPuItG7IKVP3GwXsNR
         MiDowiNKWOxQk8ye6rZDIlX0Cdg2fEADdQk9bjuo3uLPude38l3TxzDufE7qWxuJvN/B
         21cnpR++TuXpnVcnAUrfGGfd3QJOQUmydAfzU2h9eKjfADpF2WBfaupfwhqy0afW6r8L
         sYdvNevx3VxukHbM2ay/Ftr2ol+RJIWU+mKlREsByDILUVtOoOYhNg6mIJchwJ5q61CE
         Pz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=46qUYpbbNitWjlB0ZH4fmYZsgzUezmQ9lWgsvWDqpLE=;
        b=XaykteYcp4oeRjTFqqtNwCdjAjKNd3RS1lh8gsrDDUP5hcYX1uf7BwLjY59wE5UPeH
         6nB56T0M31VUwJLCLMd8LkDOqcJlIp24nP+tFHYs+eHO1ldwgCAcfutVjUpyPXqK3yNO
         zU6vziz/DQsW6eIOzfhD3wLjx8TKV2OjJuKnUaoZnjcRxkIkGRCFZC+zFjA+S2rt+BKe
         jw9Of+TTWh5vkt1tcCn4jPrq4hTuc25ErdUgBVv9dAsrnU5OGrDRpkdN3/06+EYr7kb9
         S6MkrBudujOnVVRXMzyEyJaCxQNwErnTlSxRLTmf4qHGWh0DmxDBrnaBOGpWvzenzlaG
         Hokg==
X-Gm-Message-State: AA+aEWZFtw+/4koNckVOYMhmkB679AqatgvsL+CQBb+vZbF9EDZ5Ryn0
        q0mQvWjIgEZDl1DewMdad30=
X-Google-Smtp-Source: AFSGD/Wbmf/fsfcSG5CToTJYj2IVPfLTHGmXKhLiCHAHGgVliv5H76YApMljqqtC7hdBo/HsxtmzDA==
X-Received: by 2002:a17:902:3281:: with SMTP id z1mr7842185plb.296.1544331165288;
        Sat, 08 Dec 2018 20:52:45 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 79sm8947886pge.66.2018.12.08.20.52.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Dec 2018 20:52:44 -0800 (PST)
Date:   Sat, 8 Dec 2018 20:52:41 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Philippe Schenker <dev@pschenker.ch>, jic23@kernel.org,
        marcel.ziswiler@toradex.com, stefan@agner.ch,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/4] mfd: stmpe: Move ADC related defines to header of
 mfd
Message-ID: <20181209045241.GF211094@dtor-ws>
References: <20181123142411.8921-1-dev@pschenker.ch>
 <20181128091532.GU4272@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128091532.GU4272@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 09:15:32AM +0000, Lee Jones wrote:
> On Fri, 23 Nov 2018, Philippe Schenker wrote:
> 
> > Move defines that are ADC related to the header of the overlying mfd,
> > so they can be used from multiple sub-devices.
> > 
> > Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> > ---
> > 
> > Changes in v3:
> >  - None
> > 
> > Changes in v2:
> >  - This is a new added commit. Separate commit for moving the defines out of
> >    drivers/input/touchscreen/stmpe-ts.c to overlying mfd-device drivers/mfd/stmpe.c
> >  - Pre-fix defines with STMPE_
> > 
> >  drivers/input/touchscreen/stmpe-ts.c | 34 +++++++++++-----------------
> >  include/linux/mfd/stmpe.h            | 11 +++++++++
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>

The series seem to be heading towards MFD or IIO, so I assume this patch
will be merged through one of these trees.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
