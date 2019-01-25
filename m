Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9D1C41518
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A57218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbfAYPHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 10:07:19 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:44039 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfAYPHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 10:07:19 -0500
Received: from [192.168.178.52] ([109.104.48.130]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MjjOl-1hS8GC3fo3-00lGpf; Fri, 25 Jan 2019 16:07:03 +0100
Subject: Re: [PATCH] mmc: mxs-mmc: Introduce regulator support
To:     Martin Kepplinger <martink@posteo.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robin@protonic.nl
Cc:     ulf.hansson@linaro.org, s.hauer@pengutronix.de,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        shawnguo@kernel.org
References: <20190125113449.10128-1-martink@posteo.de>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <a193bd83-bef6-dc60-b752-a8e355b44082@i2se.com>
Date:   Fri, 25 Jan 2019 16:07:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190125113449.10128-1-martink@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:ucaF43hGRMhO35kCOuGkoiDdlEVkBnYIqrXV2GzRw86W3cPN1OV
 br/+GN6PQNBowxx94uiDprjDe7jviXtl7IROKk/54cW9b18vc7HVdDjXDkDjCPr3Vz5Ry72
 JS5591gt9bXnM+omn7QriQQxpI9yhO+1kRVRS6G0PeE3atxtYzdoiDxqJ20DHk5bivAWYDX
 u2E3zVRzwp1MBfvlp5ahg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UAV8ZLXhoG8=:s7ch59USJwhIce4l+3fbT2
 KY7ZehIaJk9MgoCJZIHqK+/c+6CjxHoDp17XQ5T2OdNynCiH7UbvKc4uzWnmz+uS5NSnzRtVr
 Xi7ctAJXXTcFi/I0XZtpqDFDxWI8LQk3BjcGC1DaQ8KOATINRa9chZDISDWSH8MgWFG/bZLMj
 vyyW4H2I8iitUbvb2PrxdcTIQuk3qu/XJYIiOInIArllp6kB0mUh+t4X0dX6ldstjbW1J7XtD
 d6XTzxdQFM3TRHMgahBKrSbTl1LKEGnQpKgGceNTQe5ZY4kWOWNNDty6JXQajIpaAAnxyHbb0
 YrfvqBICuixaAsID0sCgN2QUMMN4yoLteKdze65I2h6ebmtqA+gm+IlhliTdTyeQVERXJTjw+
 IMf72OAxbw7e/nkm40xvtio+Y9ny4sMM75yZaa9/QADCKX2NWK6CP5lLngUTtygRYI/pe1149
 Kwh8KlNgagfB5j8fsDmk2vRMJhChar/sstCc8bmrVz8K8KLFl5Xh+pMjSOC7JgyxpiDTC4iJ+
 xdCdOwEL+Zr0Uv4mkwBP10VGRn9tf+iJkFS8yc7jl4K80b5bz6HezpsGIXVq6LhsqbH7rEzrq
 vKF4exPZXcXdyLxa641aMbsipJloQjJ/rE8fhYzRAhJoLsneLtMCI/vFAgdVvzMvbN6ny6WRq
 H3uelxFqOX+/uwPEe/egPUyry/CTLw2JJh7tSAVGXmHlf2AHHLkU2zFhNytatIdFdr8Sf4C3R
 kZPTuXgLgpGaPq9LzwSDeVT6ys5uS6f1l6e1Etvj0KOHS7AyhDOvskbBieo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Am 25.01.19 um 12:34 schrieb Martin Kepplinger:
> From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
>
> This adds support for explicitly switching the mmc's power on and off.

could you please explain in the commit log why or for which board this
is necessary?

Thanks
Stefan

