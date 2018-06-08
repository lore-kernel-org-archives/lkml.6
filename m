Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 9vzSIup9GlsfIAAAmS7hNA
	; Fri, 08 Jun 2018 13:00:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 590D8608BA; Fri,  8 Jun 2018 13:00:58 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eL6e+1p8"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C01FE607A4;
	Fri,  8 Jun 2018 13:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C01FE607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752642AbeFHNAz (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 09:00:55 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:39620 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751019AbeFHNAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 09:00:53 -0400
Received: by mail-ot0-f196.google.com with SMTP id l15-v6so14540462oth.6;
        Fri, 08 Jun 2018 06:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oyNNZkJZUgA5gLeRu0atbB6TITEVpJnGOWhvIeCTuCc=;
        b=eL6e+1p8zVUj7HBwmUyKVSqgpCyYgvV4krsMEXI3OguTIp34k6Uo1pJHDVDNXY9vHl
         GEvReyzrIxSeI7bnI2nw0Jsw0AxRHHywDcl9V4dgaNlcO9BvlfxkgAKtpY2G9Qn6FQ1u
         +mwLrcOwjRpPI8Cr2ZB4YNGNYICQHgAdE6c67FqPes4NV9Z8vUMFN18M/t9/uk0i4alj
         4qDYoLWSlzYE8/1Ngw58yTiiJbFgWsIDCl3UhQiHhqwPqt1BW9R8Tvt4vzI6k+AdhUd7
         NM70xaN7gLu/693TXHPoDGknvODNQjIUxUutbiRXETn0p6Bpgp8xdZFcbJz1NejCx1Kk
         BBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oyNNZkJZUgA5gLeRu0atbB6TITEVpJnGOWhvIeCTuCc=;
        b=io9aBT4ctw+ZR6CrTrX5IWBAnqMyRv2vANiJpBcfE3HUe5EhjhOekSZW2+voki6DH1
         DoPjq0eCmHZtwrgjAkk0lHLVSOVJFNoRI210l20Y/y4STxAwlTZBPNKOKaI26rhTq2UQ
         QqxjB9doWvvLquaK3Ii8rcFnJhuceDoEKmgiHUpMPTY1jbNi2XW8pp0MoR7g0NGKkJ2i
         0Th5o8GYmx8G4mGSpQ/Cr/INZcjmjfzeAH8H+iX6So7FqFlbZDRLfnN3QmK+P+r3Miw1
         fE5ftsp29qRzwKVqTsPxgHZy7huttmx/jJneJGksF/pCovRWxzJdmHfUUo9mC4gpEpZU
         Ww0w==
X-Gm-Message-State: APt69E227DGMlO0YmULASVNUkaEoCerfD4zSjxfPqkyu5UflLtTb+fjp
        xSl4d9LSqdNH05ksPakDf1lH9soXHTuXlh7sWhEaJw==
X-Google-Smtp-Source: ADUXVKLy2MkzBAtVjfntVLcfVJYtrOvMNEEETIkb0WNnyUrAZ3jZCkgtEtrvfi97RJRsfQkyNNvHJAQ3si5FpMHe3ZQ=
X-Received: by 2002:a9d:62d3:: with SMTP id z19-v6mr3236625otk.159.1528462853207;
 Fri, 08 Jun 2018 06:00:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 06:00:52 -0700 (PDT)
In-Reply-To: <20180608101924.31195-1-pp@emlix.com>
References: <20180608101924.31195-1-pp@emlix.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 8 Jun 2018 10:00:52 -0300
Message-ID: <CAOMZO5C8CA02V+oiag5tGpKBWN+UP28KwQ98jQ9PpQ2_aCq_bA@mail.gmail.com>
Subject: Re: [PATCH] clk: imx6: fix video_27m parent for IMX6QDL_CLK_CKO1_SEL
To: Philipp Puschmann <pp@emlix.com>
Cc: Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

On Fri, Jun 8, 2018 at 7:19 AM, Philipp Puschmann <pp@emlix.com> wrote:
> q/dl datasheets list the 5th selection value for ck01_sel as
> video_27M_clk_root.
>
> By replacing the dummy value we then can set IMX6QDL_CLK_VIDEO_27M
> as parent for IMX6QDL_CLK_CKO1_SEL.
>
> Signed-off-by: Philipp Puschmann <pp@emlix.com>

You could still have added my Reviewed-by tag that I sent previously :-)

Here it goes:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

Also in the future, when posting a new version of a patch, please mark
it as such:

[PATCH v2] clk: imx6: fix video_27m parent for IMX6QDL_CLK_CKO1_SEL

and write below the --- line what are the changes in this new version.

Thanks
