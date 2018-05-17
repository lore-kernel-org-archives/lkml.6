Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751958AbeEQVVs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 17:21:48 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:40045 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbeEQVVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 17:21:46 -0400
X-Google-Smtp-Source: AB8JxZqtrffDWlQPzDZlOp56/oTR8QmKJNo2rVm2g3mbA8p6j5pfOzOvnFtHbNx56c/xtWcpq7STdfh327UtVX0EUDk=
MIME-Version: 1.0
In-Reply-To: <f3aa166ddd11c8f9813602be68aa5b10e5c90979.1526088289.git.collinsd@codeaurora.org>
References: <cover.1526088289.git.collinsd@codeaurora.org> <f3aa166ddd11c8f9813602be68aa5b10e5c90979.1526088289.git.collinsd@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 17 May 2018 14:21:42 -0700
X-Google-Sender-Auth: QcWjHovs_QRHoPoVDRMjHUHhxlE
Message-ID: <CAD=FV=W5vqTJHGiuoznqgJGtvGs2eYs54JvV8-8ukwmsJ5p7bw@mail.gmail.com>
Subject: Re: [PATCH 1/2] regulator: of: add property for allowed modes specification
To: David Collins <collinsd@codeaurora.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 11, 2018 at 6:46 PM, David Collins <collinsd@codeaurora.org> wrote:
> Add a common device tree property for regulator nodes to support
> the specification of allowed operating modes.
>
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/regulator/regulator.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
> index 2babe15b..c627aa0 100644
> --- a/Documentation/devicetree/bindings/regulator/regulator.txt
> +++ b/Documentation/devicetree/bindings/regulator/regulator.txt
> @@ -59,6 +59,11 @@ Optional properties:
>  - regulator-initial-mode: initial operating mode. The set of possible operating
>    modes depends on the capabilities of every hardware so each device binding
>    documentation explains which values the regulator supports.
> +- regulator-allowed-modes: list of operating modes that software is allowed to
> +  configure for the regulator at run-time.  Elements may be specified in any
> +  order.  The set of possible operating modes depends on the capabilities of
> +  every hardware so each device binding document explains which values the
> +  regulator supports.

Looks sane to me.  It might be interesting to be explicit about what
happens if "regulator-allowed-modes" doesn't include the mode that was
listed as "regulator-initial-mode".  Does that mean that there's no
way to get back to "regulator-initial-mode" after it's been changed
once, or is it an error to not include the initial mode in the set of
allowed modes?

I'm not 100% sure if going to such detail is necessary though.  Thus,
feel free to add:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
