Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E89C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4EE2409A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4EE2409A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753326AbeGCVDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 17:03:44 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:39715 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752923AbeGCVDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 17:03:42 -0400
Received: by mail-yb0-f194.google.com with SMTP id k127-v6so1269542ybk.6;
        Tue, 03 Jul 2018 14:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=myRy4Ik2KvUw6GV8pOj52zwTnBDjqGZJhhXdyOK+KXo=;
        b=Es6B3tuIE9aGBfDDFmcsdF6FflEq/5DDiOmXrHyBJbxtWz9WiR/qePeGlvekT2EsOa
         D20PlOzfmJL1nhZ7fwlVn0JqGBsFk6NY6FPKpzHQg4WWXREKOw0rVouWefHMSjSmltOt
         EwIYW+hUKZ3FHz37enLZ+Rt+D+nzY71FVGYE+qOR0pW4mzn9ckVKbMpawX0Pj1+zn/vl
         lDAS2EcvbtYhuOympoQJvjgDpdmvGnlrwC+lpISp4aqaoRCcL4+ljZX87elB9uxqi3MV
         N6zsuyn/n6w6ZDEymPIUgA2f/JF1+ARCgtZoE15IlFQd7o+P+N9XpsjroXEiCeOxSw30
         Uubg==
X-Gm-Message-State: APt69E0GM0yY/LJKbEvPm64C10Rt17ihdj7MhXyxaxvJiXMTSNWb3NvF
        3728HKb3bHdEqy5+ChiLKQ==
X-Google-Smtp-Source: AAOMgpd2qTCGSgAfTRjU+S5UA81sHmF7dVqWE7fUTYDOJkIim0YOnkgot/bkdzKN9cSnSzLYwaeV1g==
X-Received: by 2002:a25:accb:: with SMTP id x11-v6mr16052651ybd.494.1530651821738;
        Tue, 03 Jul 2018 14:03:41 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id j11-v6sm771734ywk.44.2018.07.03.14.03.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 14:03:41 -0700 (PDT)
Date:   Tue, 3 Jul 2018 15:03:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     thierry.reding@gmail.com, mark.rutland@arm.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/panel: simple: Add support for DataImage
 SCF0700C48GGU18
Message-ID: <20180703210340.GA31754@rob-hp-laptop>
References: <1529930490-11874-1-git-send-email-michal.vokac@ysoft.com>
 <1529930490-11874-2-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1529930490-11874-2-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 02:41:30PM +0200, Michal Vokáč wrote:
> This adds support for the DataImage SCF0700C48GGU18 7.0" WVGA (800x480)
> TFT LCD panel. The panel has 24-bit parallel interface and can be
> supported by the simple panel driver.
> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> ---
>  .../display/panel/dataimage,scf0700c48ggu18.txt    |  8 ++++++
>  drivers/gpu/drm/panel/panel-simple.c               | 29 ++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/dataimage,scf0700c48ggu18.txt

Reviewed-by: Rob Herring <robh@kernel.org>

