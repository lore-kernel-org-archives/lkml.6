Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbeBTOSi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 09:18:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:35234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750733AbeBTOSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 09:18:36 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0CB02178E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AH8x226TE5N4tog0u8XtzzNqZ/hGcYZkKi7ItNIaFb4Y7Y5Ynrb8EQQYl6TPrFazD8aT7Gbi2z5WPOlzeXUZMX/KvEo=
MIME-Version: 1.0
In-Reply-To: <20180219225918.2311-1-mdf@kernel.org>
References: <20180219225918.2311-1-mdf@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 20 Feb 2018 08:18:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLVLhK0_CrdT33OzTfVRR5JUNqnJSkxJNAYpnd+v_hivQ@mail.gmail.com>
Message-ID: <CAL_JsqLVLhK0_CrdT33OzTfVRR5JUNqnJSkxJNAYpnd+v_hivQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: power: reset: gpio-poweroff: Add
 'timeout_ms' property
To: Moritz Fischer <mdf@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 4:59 PM, Moritz Fischer <mdf@kernel.org> wrote:
> Add 'timeout_ms' property to support boards where the 3s timeout that the
> current driver defaults to is too short.
>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>
> Changes from v1:
> - Addressed Rob's feedback (timeout -> timeout_ms)
> - Added to old example rather than creating separate one
>
> ---
>  Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt b/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
> index e62d53d844cc..3f557b344dc4 100644
> --- a/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
> +++ b/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
> @@ -27,10 +27,13 @@ Optional properties:
>    it to an output when the power-off handler is called. If this optional
>    property is not specified, the GPIO is initialized as an output in its
>    inactive state.
> +- timeout_ms: Time to wait before asserting a WARN_ON(1). If nothing is
> +              specified, 3000 ms is used.

timeout-ms
