Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753497AbeCQXnm (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 19:43:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37530 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751849AbeCQXnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 19:43:40 -0400
Subject: Re: [PATCH v5 3/8] docs: Add Generic Counter interface documentation
To: William Breathitt Gray <vilhelm.gray@gmail.com>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Cc: benjamin.gaignard@st.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1520614431.git.vilhelm.gray@gmail.com>
 <c30b11b8839099bffb3888e9198751af6e5fe623.1520614431.git.vilhelm.gray@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b40d9333-f5de-c39f-25e9-703c5444aed4@infradead.org>
Date: Sat, 17 Mar 2018 16:43:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c30b11b8839099bffb3888e9198751af6e5fe623.1520614431.git.vilhelm.gray@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2018 10:42 AM, William Breathitt Gray wrote:
> This patch adds high-level documentation about the Generic Counter
> interface.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  Documentation/driver-api/generic-counter.rst | 321 +++++++++++++++++++++++++++
>  Documentation/driver-api/index.rst           |   1 +
>  MAINTAINERS                                  |   1 +
>  3 files changed, 323 insertions(+)
>  create mode 100644 Documentation/driver-api/generic-counter.rst
> 
> diff --git a/Documentation/driver-api/generic-counter.rst b/Documentation/driver-api/generic-counter.rst
> new file mode 100644
> index 000000000000..bce0cbc31963
> --- /dev/null
> +++ b/Documentation/driver-api/generic-counter.rst
> @@ -0,0 +1,321 @@

[snip]

> +There are three core components to a counter:
> +
> +        COUNT
> +        -----
> +        A Count represents the count data for a set of Signals. The
> +        Generic Counter interface provides the following available count
> +        data types:
> +
> +		* COUNT_POSITION_UNSIGNED:
> +			Unsigned integer value representing position.
> +
> +		* COUNT_POSITION_SIGNED:
> +			Signed integer value representing position.
> +
> +        A Count has a count function mode which represents the update
> +        behavior for the count data. The Generic Counter interface
> +        provides the following available count function modes:
> +
> +		* Increase:
> +			Accumulated count is incremented.
> +
> +		* Decrease:
> +			Accumulated count is decremented.
> +
> +		* Pulse-Direction:
> +			Rising edges on quadrature pair signal A updates
> +                        the respective count. The input level of
> +                        quadrature pair signal B determines direction.
> +
> +		* Quadrature x1:
> +			If direction is forward, rising edges on
> +                        quadrature pair signal A updates the respective
> +                        count; if the direction is backward, falling
> +                        edges on quadrature pair signal A updates the
> +                        respective count. Quadrature encoding determines
> +                        the direction.
> +
> +		* Quadrature x2:
> +			Any state transition on quadrature pair signal A
> +                        updates the respective count. Quadrature
> +                        encoding determines the direction.
> +
> +		* Quadrature x4:
> +			Any state transition on either quadrature pair
> +                        signals updates	the respective count. Quadrature

                               change <TAB> ^^^ to <SPACE>

> +                        encoding determines the direction.
> +
> +        A Count has a set of one or more associated Signals.
> +
> +        SIGNAL
> +        ------
> +        A Signal represents a counter input data; this is the input data
> +        that is analyzed by the counter to determine the count data;
> +        e.g. a quadrature signal output line of a rotary encoder. Not
> +        all counter devices provide user access to the Signal data.
> +
> +        The Generic Counter interface provides the following available
> +        signal data types for when the Signal data is available for user
> +        access:
> +
> +	        * SIGNAL_LEVEL_LOW:
> +                        Signal line is in a low state.
> +
> +                * SIGNAL_LEVEL_HIGH:
> +                        Signal line is in a high state.
> +
> +        A Signal may be associated to one or more Counts.

                                      with (?)

Hm, there are around 8 or so instances of "associated to" here -- and at least
one of "associated with" (to my surprise :).  But it's no big deal.


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

thanks,
-- 
~Randy
