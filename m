Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753331AbeDISqx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 14:46:53 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:46604 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbeDISqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 14:46:51 -0400
X-Google-Smtp-Source: AIpwx4/+/+U1DRrhKNeSmwNLkHiQ1CEI3IlGwzAMKEst9BVNquIDoYhtvLlF5NYs0SwMJCu9pzWtMQ==
Date: Mon, 9 Apr 2018 13:46:48 -0500
From: Rob Herring <robh@kernel.org>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: jic23@kernel.org, ludovic.desroches@microchip.com,
        alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        nicolas.ferre@microchip.com, dmitry.torokhov@gmail.com
Subject: Re: [PATCH v2 03/10] dt-bindings: input: touchscreen: touch_adc:
 create bindings
Message-ID: <20180409184648.jbeajblbhxssqki6@rob-hp-laptop>
References: <1522153963-1121-1-git-send-email-eugen.hristev@microchip.com>
 <1522153963-1121-4-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522153963-1121-4-git-send-email-eugen.hristev@microchip.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 03:32:36PM +0300, Eugen Hristev wrote:
> Added bindings for generic resistive touchscreen ADC.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
> Changes in v2:
>  - modified bindings to have a generic resistive touchscreen adc driver
> instead of specific architecture one.
> 
>  .../bindings/input/touchscreen/touch_adc.txt       | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/touch_adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/touch_adc.txt b/Documentation/devicetree/bindings/input/touchscreen/touch_adc.txt
> new file mode 100644
> index 0000000..27abcdc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/touch_adc.txt
> @@ -0,0 +1,33 @@
> +Generic resistive touchscreen ADC
> +
> +Required properties:
> +
> + - compatible: must be "generic-resistive-adc-touch"

Drop "generic-" and rename the file after the compatible string.

> +The device must be connected to an IIO device that provides channels for

s/IIO/ADC/

> +position measurement and optional pressure.
> +Refer to ../iio/iio-bindings.txt for details
> + - iio-channels: must have at least two channels connected to an IIO device.
> +These should correspond to the channels exposed by the IIO device and should
> +have the right index as the IIO device registers them. These channels
> +represent the relative position on the "x" and "y" axes.
> + - iio-channel-names: must have all the channels' names. Mandatory channels
> +are "x" and "y".
> +
> +Optional properties:
> + - iio-channels: The third channel named "pressure" is optional and can be
> +used if the IIO device also measures pressure besides position.
> +If this channel is missing, pressure will be ignored and the touchscreen
> +will only report position.
> + - iio-channel-names: optional channel named "pressure".
> + - generic-resistive-adc-touch,pressure-threshold: a pressure threshold for
> +the touchscreen, if we are using the "pressure" channel as well.
> +Represented by an integer value.

Define a common touchscreen property for this. We already have several 
definitions.

It seems to me that "contact-threshold" would have been the same thing, 
but it is deprecated in favor of "touchscreen-fuzz-pressure" which 
doesn't really sound like the same thing.

Rob
