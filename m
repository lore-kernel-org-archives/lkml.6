Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44092C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FFF24636
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01FFF24636
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754539AbeFVQ77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:59:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9124 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751377AbeFVQ76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:59:58 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AFD7CE64F940B;
        Sat, 23 Jun 2018 00:59:42 +0800 (CST)
Received: from localhost (10.47.144.153) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.382.0; Sat, 23 Jun 2018
 00:59:39 +0800
Date:   Fri, 22 Jun 2018 17:59:25 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
CC:     <gregkh@linuxfoundation.org>, <jic23@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <fabrice.gasnier@st.com>,
        <benjamin.gaignard@st.com>, <robh+dt@kernel.org>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <mark.rutland@arm.com>
Subject: Re: [PATCH v7 05/10] counter: 104-quad-8: Documentation: Add
 Generic Counter sysfs documentation
Message-ID: <20180622175925.00005cbc@huawei.com>
In-Reply-To: <891d9716ce95bd8568296ef53d5b8d266f7efe3e.1529607879.git.vilhelm.gray@gmail.com>
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
        <891d9716ce95bd8568296ef53d5b8d266f7efe3e.1529607879.git.vilhelm.gray@gmail.com>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.144.153]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2018 17:08:08 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> This patch adds standard documentation for the Generic Counter interface
> userspace sysfs attributes of the 104-QUAD-8 driver.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
This stuff is very device specific obviously, but looks fine to me.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  .../ABI/testing/sysfs-bus-counter-104-quad-8  | 36 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 37 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8 b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
> new file mode 100644
> index 000000000000..062637df3c78
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
> @@ -0,0 +1,36 @@
> +What:		/sys/bus/counter/devices/counterX/signalY/index_polarity
> +KernelVersion:	4.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Active level of index input Signal Y; irrelevant in
> +		non-synchronous load mode.
> +
> +What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_available
> +What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_available
> +KernelVersion:	4.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Discrete set of available values for the respective Signal Y
> +		configuration are listed in this file.
> +
> +What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode
> +KernelVersion:	4.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Configure the counter associated with Signal Y for
> +		non-synchronous or synchronous load mode. Synchronous load mode
> +		cannot be selected in non-quadrature (Pulse-Direction) clock
> +		mode.
> +
> +		Non-synchronous:
> +			A logic low level is the active level at this index
> +			input. The index function (as enabled via preset_enable)
> +			is performed directly on the active level of the index
> +			input.
> +
> +		Synchronous:
> +			Intended for interfacing with encoder Index output in
> +			quadrature clock mode. The active level is configured
> +			via index_polarity. The index function (as enabled via
> +			preset_enable) is performed synchronously with the
> +			quadrature clock on the active level of the index input.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4083523699f3..a06fd762f5d9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -270,6 +270,7 @@ ACCES 104-QUAD-8 DRIVER
>  M:	William Breathitt Gray <vilhelm.gray@gmail.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
>  F:	Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
>  F:	drivers/counter/104-quad-8.c
>  


