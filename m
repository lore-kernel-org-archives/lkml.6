Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244F5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B0B20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0xzsqTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfAQMEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:04:49 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33194 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfAQMEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 07:04:48 -0500
Received: by mail-oi1-f196.google.com with SMTP id c206so5980114oib.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 04:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jq+6Np/fMlcGZKPmTPBsY+GDhmY+Gp8cPsJZFO8SCDY=;
        b=e0xzsqTtUc3IuNXRLBb3yRrHWClhB5WxU9+OqsOaj8j5WHrglmbIndO+cF0s5Z7w90
         ir+tYR7r+Wft9LypTxXqNnXkt49V0STBgFW34SbsryHQzXAFczLwmnik0p5YZvwQHZQr
         H787RDAxeEAK1i/Yv05Um5QD+GoCQkD3oO6s4FNPQpaIOd0fhoy0xd4WvX+lSprUEUYU
         VvnCVCSZR7yACqlI1VFzZFxij+iNly/5VYft1xCfvirn0XU4xnLIU/aVa2/tY1k6Jib/
         5S655SEhU2rB2wgXyWFHGkY+ihVVoWkPMuV7kso2A6mVN0sNGNdcncDKS2uForYr87F3
         D18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jq+6Np/fMlcGZKPmTPBsY+GDhmY+Gp8cPsJZFO8SCDY=;
        b=V0Vaf2z/JlVr6JVwaA38sZ71srm7NS07lJ3akxafPyiTsKFOo7oM20dBBNWHOqTMfg
         i1OHxxLLSfL9OpvtF+hS5A/3TPx/oawYHQ9sxubSBx7+DC9lipU8g60Edurbi2cYhACI
         +unUjpV+aLYxD6BnDTFk7GY8fQGWwHvWD0tPbfXCW4zRjf3Q//wMYkXBXLVe0RSJJrzN
         dZ1sdUM6y+QlK+5es1pzn8RUaFCM9Tet2ilHOBPhkjzmKxcgzSYOOUtTY3RRRk35AZRV
         Xhx+gOhVyD2uPUhrYBPXsIK7MEf/WjDM0krowMW4qIjAVnsG1f9yAIQKbC8KJHRuig7K
         kDKQ==
X-Gm-Message-State: AJcUuke+brX83ACxqXxdWfWpGdyGskWWPH5otItMJwrde51ecozOaiL9
        Jezixx5VMjVxT7r7ozU+Pty0pNoA6nFtTA8PCqE=
X-Google-Smtp-Source: ALg8bN7JuNohoNt3pfykowZRRTZVO8X1gbadfKDJBAh2A/KqmSiYDQFOEKAoPRrv+h/cPEcx9uRa/pgy73BOqVmTI8Q=
X-Received: by 2002:aca:3092:: with SMTP id w140mr5790872oiw.237.1547726687871;
 Thu, 17 Jan 2019 04:04:47 -0800 (PST)
MIME-Version: 1.0
References: <20190117090640.12972-1-stefan@agner.ch> <20190117090640.12972-4-stefan@agner.ch>
In-Reply-To: <20190117090640.12972-4-stefan@agner.ch>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 17 Jan 2019 10:04:38 -0200
Message-ID: <CAOMZO5AWvp0ALPF=Aq3rBWKe0qYNqU7cjZKDNVpFCoUsWXaOPQ@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 4/5] ASoC: imx-sgtl5000: put of nodes if
 finding codec fails
To:     Stefan Agner <stefan@agner.ch>
Cc:     timur@kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Thu, Jan 17, 2019 at 7:07 AM Stefan Agner <stefan@agner.ch> wrote:
>
> Make sure to properly put the of node in case finding the codec
> fails.
>
> Fixes: 81e8e4926167 ("ASoC: fsl: add sgtl5000 clock support for imx-sgtl5000")
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Looks good.

I would suggest making this patch the first one of the series, since
it is a bug fix and could potentially be applied to stable.

Thanks
