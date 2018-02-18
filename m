Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbeBRXY2 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 18:24:28 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33771 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbeBRXY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 18:24:26 -0500
X-Google-Smtp-Source: AH8x227SpMoSve6dpnfkhcXP0O4FZ5/2ehRbXV9enje6/rQvb3uE2YvCgHiipqQYBiYvcrUnMucKmw==
Date: Sun, 18 Feb 2018 17:24:24 -0600
From: Rob Herring <robh@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv2 4/8] dt-bindings: panel: common: document orientation
 property
Message-ID: <20180218232424.47ejrqdze7nm7g5d@rob-hp-laptop>
References: <20180208183035.8461-1-sebastian.reichel@collabora.co.uk>
 <20180208183035.8461-5-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208183035.8461-5-sebastian.reichel@collabora.co.uk>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 07:30:31PM +0100, Sebastian Reichel wrote:
> Introduce new "orientation" property for describing in which
> orientation a panel has been mounted to the device. This can
> be used by the operating system to automatically rotate the
> display correctly.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>  .../devicetree/bindings/display/panel/panel-common.txt     | 12 ++++++++++++
>  include/dt-bindings/display/common.h                       | 14 ++++++++++++++
>  2 files changed, 26 insertions(+)
>  create mode 100644 include/dt-bindings/display/common.h
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-common.txt b/Documentation/devicetree/bindings/display/panel/panel-common.txt
> index 557fa765adcb..c646b8908458 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-common.txt
> +++ b/Documentation/devicetree/bindings/display/panel/panel-common.txt
> @@ -18,6 +18,18 @@ Descriptive Properties
>    physical area where images are displayed. These properties are expressed in
>    millimeters and rounded to the closest unit.
>  
> +- orientation: The orientation property specifies the panel orientation
> +  in relation to the device's casing. The following values are possible:
> +
> +   * 0 = The top side of the panel matches the top side of the device's
> +         casing.
> +   * 1 = The top side of the panel matches the bottom side of the device's
> +         casing. In other words the panel is mounted upside-down.
> +   * 2 = The left side of the panel matches the top side of the device's
> +         casing.
> +   * 3 = The right side of the panel matches the top side of the device's
> +         casing.


The rotation property in panel.txt already handles this, right?

> +
>  - label: The label property specifies a symbolic name for the panel as a
>    string suitable for use by humans. It typically contains a name inscribed on
>    the system (e.g. as an affixed label) or specified in the system's
