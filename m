Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932601AbeCOSuK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 14:50:10 -0400
Received: from mail-pl0-f52.google.com ([209.85.160.52]:42625 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752217AbeCOSuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 14:50:03 -0400
X-Google-Smtp-Source: AG47ELsLe6A5M9NSsRuPfjzHLg32q8fVC/ktYaWyXCltToNCNAC6VC64PPdsu9iZwSsuwIvdL5ovNA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180315181244.8859-1-bjorn.andersson@linaro.org>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20180315181244.8859-1-bjorn.andersson@linaro.org>
Message-ID: <152113980179.111154.13908491838747798092@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] Revert "rpmsg: smd: Create device for all channels"
Date: Thu, 15 Mar 2018 11:50:01 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2FIoE4E006498

Quoting Bjorn Andersson (2018-03-15 11:12:44)
> In an effort to pick up channels that are in a funky state we
> optimistically tried to open all channels that we found, with the
> addition that we failed if the other side did not handshake the opening.
> 
> But as we're starting the modem a second time all channels are found -
> in a "funky" state - and we try to open them. But the modem firmware
> requires the IPCRTR to be up in order to initialize. So any channels we
> try to open before that will fail and will not be opened again.
> 
> This takes care of the regression, at the cost of reintroducing the
> previous behavior of handling of channels with "funky" states.

Is it a funky chicken and egg problem between IPCRTR and smd?
