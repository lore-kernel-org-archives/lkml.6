Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753228AbeDSGMN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 02:12:13 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36148 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbeDSGML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 02:12:11 -0400
X-Google-Smtp-Source: AIpwx4+STjG6yOQ6WzzYupnbOyLT4KFXfUgtskvkOH4eVAYI5bjPTIjRuXO55vObu9LBeJV8+nTJPQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Lina Iyer <ilina@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
From: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180405161834.3850-8-ilina@codeaurora.org>
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, evgreen@chromium.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>
References: <20180405161834.3850-1-ilina@codeaurora.org>
 <20180405161834.3850-8-ilina@codeaurora.org>
Message-ID: <152411832959.46528.17741598693542734318@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 07/10] drivers: qcom: rpmh: cache sleep/wake state requests
Date: Wed, 18 Apr 2018 23:12:09 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3J6CJVa005784

Quoting Lina Iyer (2018-04-05 09:18:31)
> Active state requests are sent immediately to the mailbox controller,

Drive by note, mailbox went away from this code so grep 'mailbox' or
'mbox' on these patches should come up with zero hits.

> while sleep and wake state requests are cached in this driver to avoid
> taxing the mailbox controller repeatedly. The cached values will be sent
> to the controller when the rpmh_flush() is called.
> 
