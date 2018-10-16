Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F6CC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A968520869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrlDqRci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A968520869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbeJQEpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 00:45:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbeJQEpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 00:45:45 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC44620869;
        Tue, 16 Oct 2018 20:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539723213;
        bh=MuwDY0syUKSgTirzXFL7Un5gqfE/77swndofx8ag3Jk=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=JrlDqRciFislKqpLwZw1QxsmDN2cggDhFVrNK09IUwEjrkc6hT+FDgrdbWf3tQb7u
         l4UEXf9cYD7typL+6UcZ9QBClTGJESUNXZ+hCCWSmJueOdvdwKg/xKITAbJYOXtURO
         rBpukFXIaaba7UCREoDJoBnr2NU6ZoFnOK0WmXAs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Douglas Anderson <dianders@chromium.org>,
        gregkh@linuxfoundation.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181015204425.84537-1-dianders@chromium.org>
Cc:     msavaliy@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alokc@codeaurora.org, mka@chromium.org, evgreen@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>
References: <20181015204425.84537-1-dianders@chromium.org>
Message-ID: <153972321308.5275.4720449474527347628@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Don't slow all ports just for kgdb
Date:   Tue, 16 Oct 2018 13:53:33 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2018-10-15 13:44:24)
> If you turn on CONFIG_KGDB then you'll get CONFIG_CONSOLE_POLL
> selected.
> =

> If you have CONFIG_CONSOLE_POLL selected then the GENI serial driver
> was setting RX_BYTES_PW to 1 for _all_ UART ports.
> =

> This doesn't seem like such a good idea.  Let's only set RX_BYTES_PW
> to 1 for the console port.
> =

> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

