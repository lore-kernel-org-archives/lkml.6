Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141EEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE7F22086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmnGoll9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfARKmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:42:03 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44230 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfARKmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:42:03 -0500
Received: by mail-ot1-f68.google.com with SMTP id f18so13939345otl.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 02:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jsnQCsxSsRQfBdYzCu5rotOa8sOVq6I8dxu7eV3e9R8=;
        b=nmnGoll9xUiKbMix7UXhyShQcR+LpPwK/jMMIWiVqMFIZtixXafN/NOmFPlv2oX3t6
         q4S2E3KqvYb3DkxVriuYHmH+h+bnQ4Ygu1OCCdO+svRZKeTBbOX1GEerDmBqrRREqQRL
         mO9Vqc8BvxrrWweTxQc4xOhB8nMN/UKjL33PHXcKibP4oTyk8oF9xck5GlyyYdPGeyjM
         9nynXDedfFeBwWZJCTP7upc6Lj69x6qoy3Gm3RMAv5Fo4cvjCJPl/C6XBXp0eVOOuXlm
         q2FYrlW/bycq/nS7skAhuGrSBaSi4sErgg8+Wk/fGuyjM7QMJdnegdq3Y6y6kn/4MbqO
         EYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jsnQCsxSsRQfBdYzCu5rotOa8sOVq6I8dxu7eV3e9R8=;
        b=Xu12afdZ6q9OhpBJ/DG3MkIZHNw5SkiWhlr2JLxBOy1IV/2o9uagp7mpFS65NTSMyc
         pbzim104F8esPk8rVGYY36Zcnz2u+JZrArBiI7Y10qSy5r3Rvnn8kTuFAF8DJoTkbBZY
         NTCCzlrck2UXOmg00t1rOXZDbrpVq9HD8kZ/D2dJRc726+AF2C41p5airdrmr7JHRpHM
         MEmd4jhbAP5l3Af36D2uvpolssNEs3a9yio/TXa9m5V0Uaua9n+/+3QjI1dbvoF651T4
         +B4tBycjxc+6OEL/Uhe+q3/zwIOlbowu0IutG9KbHYbKcrC4kbUGj1sk3pwWaOPMnZuK
         wbkg==
X-Gm-Message-State: AJcUukdBNYUnq+kmfm3Y62mazwsIgt1eis9IMgglPWTJIjKiFurm1Hnp
        1r+IO769D0Um9VTRA5m1p4mwsPPdBOn0S+VDtx0=
X-Google-Smtp-Source: ALg8bN5hbdwdQu0D9zPCOHGxsDbGo9KED+AhaNS0WN66XHT8lsyjV1D58MRQ1YzhRBAIDY68PzPO4h5Hb/a1Phcd3Wk=
X-Received: by 2002:a9d:aa9:: with SMTP id 38mr12004597otq.255.1547808122331;
 Fri, 18 Jan 2019 02:42:02 -0800 (PST)
MIME-Version: 1.0
References: <20190118090656.14201-1-stefan@agner.ch> <20190118090656.14201-2-stefan@agner.ch>
In-Reply-To: <20190118090656.14201-2-stefan@agner.ch>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 18 Jan 2019 08:41:52 -0200
Message-ID: <CAOMZO5CFM9Ryo14+M7GR3TFFj=7PypL0kwGactge7x05KKmeOA@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 2/5] ASoC: imx-sgtl5000: lower log level
 for potential probe deferral cases
To:     Stefan Agner <stefan@agner.ch>
Cc:     timur@kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 7:07 AM Stefan Agner <stefan@agner.ch> wrote:
>
> Not finding the codec/SSI instance can be due to probe deferral.
> Do not print error messages in those cases.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
