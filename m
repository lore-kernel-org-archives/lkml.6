Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754488AbeCRMvw (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 08:51:52 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44555 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754108AbeCRMsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 08:48:36 -0400
X-Google-Smtp-Source: AG47ELuqhpuaINM12FgxjZOTqdIEIrQ2jSpl+66sC46uoef5V1QcZ4yBx0iv00zk8LZ+6MJOI/jsdQ==
Date: Sun, 18 Mar 2018 07:48:33 -0500
From: Rob Herring <robh@kernel.org>
To: Andreas Brauchli <a.brauchli@elementarea.net>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: chemical: sgp30: Support Sensirion SGPxx
 sensors
Message-ID: <20180317234938.qf7j45o53nu4ryu2@rob-hp-laptop>
References: <58a6dcdc4097d60e7bcee61ec1d0cbdf8ad3ae49.camel@elementarea.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58a6dcdc4097d60e7bcee61ec1d0cbdf8ad3ae49.camel@elementarea.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 10, 2018 at 11:07:30PM +0100, Andreas Brauchli wrote:
> Support Sensirion SGP30 and SGPC3 multi-pixel I2C gas sensors
> 
> Supported Features:
> 
> * Indoor Air Quality (IAQ) concentrations for
>   - tVOC (in_concentration_voc_input)
>   - CO2eq (in_concentration_co2_input) - SGP30 only
>   IAQ concentrations are periodically read out by a background thread
>   to allow the sensor to maintain its internal baseline.
> * Baseline support for IAQ (in_iaq_baseline, set_iaq_baseline)
> * Gas concentration signals
>   - Ethanol (in_concentration_ethanol_raw)
>   - H2 (in_concentration_h2_raw) - SGP30 only
> * On-chip self test (in_selftest)
> * Sensor interface version (in_feature_set_version)
> * Sensor serial number (in_serial_id)
> * Humidity compensation
>   With the help of an external humidity signal, the gas signals can be
>   humidity-compensated. The sensor performs the compensation on-chip.
> * Power mode switching between low power mode (1/2Hz) and
>   ultra low power mode (1/30Hz) sampling - SGPC3 only
> * Checksummed I2C communication
> 
> For all features, refer to the data sheet or the documentation in
> Documentation/iio/chemical/sgp30.txt for more details.
> 
> The ABI is documented in
> Documentation/ABI/testing/sysfs-bus-iio-chemical-sgp30
> 
> Signed-off-by: Andreas Brauchli <andreas.brauchli@sensirion.com>
> ---
>  .../ABI/testing/sysfs-bus-iio-chemical-sgp30       |   62 ++
>  .../bindings/iio/chemical/sensirion,sgp30.txt      |   15 +

Please split bindings to separate patch.

>  Documentation/iio/chemical/sgp30.txt               |   97 ++
>  drivers/iio/chemical/Kconfig                       |   13 +
>  drivers/iio/chemical/Makefile                      |    1 +
>  drivers/iio/chemical/sgp30.c                       | 1120 ++++++++++++++++++++
>  6 files changed, 1308 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-chemical-sgp30
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sgp30.txt
>  create mode 100644 Documentation/iio/chemical/sgp30.txt
>  create mode 100644 drivers/iio/chemical/sgp30.c
