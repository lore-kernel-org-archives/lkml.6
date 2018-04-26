Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753487AbeDZGdU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 02:33:20 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50282 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751984AbeDZGdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 02:33:17 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180426063315euoutp0164029ec65d95aff524b81fbf30ea2998~o6MJZIxe90167301673euoutp01F
X-AuditID: cbfec7f4-713ff700000043e4-e0-5ae172a94103
Subject: Re: [PATCH] drm/bridge/synopsys: dsi: use adjusted_mode in mode_set
To: Philippe Cornu <philippe.cornu@st.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Brian Norris <briannorris@chromium.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Bhumika Goyal <bhumirks@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>,
        Heiko Stubner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc: Yannick Fertre <yannick.fertre@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Mickael Reulier <mickael.reulier@st.com>
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <e85bee37-11da-5fe0-38fe-3b2536b10c22@samsung.com>
Date: Thu, 26 Apr 2018 08:33:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180125155504.8611-1-philippe.cornu@st.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUhUURTHuW+bpzT2GjUPFkUTQUV7YZdcso0eFNGXwoyWMR8arrzJVqpx
        zBzXSsFsJrXFaIEol9ywsmkZNR0Sbahcy4mssLA0FB2nefOM/PY7//M/9yxcllSlMf7s4fgj
        ghiviVUznlTlq1Hr0rvix/AVfS0zcba1kcCl9tcI6w0DNNabmxj8q/sCg8sGf9K4ffgng52f
        vtO4MPc0Tr9UosBlfTYat9Veddl6nSR+Ub8BFznu07jpmZnAvef6adz8tp7CaempTKg3b9K1
        UnxbTjbB1xi7FLzJcIXmO211DF/1p5fmezItBF9ecpZ3GJ9SfJWtiOQ/jzwm+d9lc3ZOC/cM
        ihRiDx8VxOUhBz2jx+vSycTPquO3rROMDjmnZyAPFrg1UDiaTEms4u4gaB70z0CeLh5CkOWo
        puTgN4I+ayedgVh3RacpRtZvI0h7m0fIwQCCyucvCekpb2471BfmISnhw+kpsNmvklJAcskE
        FBWUI8nFcIvAUf6ekVjJhUCm5YVbp7gFoJv4qpDYlwsD/ZdRheyZAY1X7O5hPbh10FFqcDPJ
        zYWqAamBxH7wwV7sHgm4OhZSupMZedPN4LTnT7I3fLNUKGSeDc6aYkLmU/C+X0/JxQYEPWNp
        kwWB8NzS6j4A6Zr6Qe1yWQ6GJ+UPJ+/iBe8GZsgzeEFu5WVSlpVgOK+S3fOgp+URKbMf3Hoz
        zFxE841TNjNO2cY4ZRvj/77XEHUP+QlJ2rgoQbsqXji2TKuJ0ybFRy07lBBXhlzf8/WEZaga
        1Y5HmBHHIvU05UhRb7iK1hzVnogzI2BJtY8yLNslKSM1J04KYsIBMSlW0JrRLJZS+yn3LzwT
        ruKiNEeEGEFIFMR/WYL18NehAmtrwP67EVvte4yb2162l5pKLuY1dKQ2BVSEdTvaB0OXBlV3
        xOxK2JYfmKnS7e561FVo2tK9PlFsqHrm0RyZ+rTTtvrHx+tDIfrgG5f3Llgr4uiork9ZPteJ
        4U0zKwJuBn7dOJRz8NK+VQ1NvmO7WhbtKFiypLj/3iwqz2wyp0w31aspbbRm5WJS1Gr+AtnR
        bSOaAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsVy+t/xu7orih5GGdw5pWDRe+4kk8XGJ6cZ
        LZo63rJaNB06xWbx6V4/m8Wmj+9ZLa58fc9m8f/Ra1aLuZNqLTonLmG32PT4GqvF5V1zgMoe
        /Ge2OHLA0WLe37WsFqcOHmKyeNDygtXizNUDLBbtna1sDsIesxsusnhc7utl8tg56y67x+yO
        mawed67tYfPY/u0Bq8f97uNMHpuX1Hv8nbWfxWP7tXnMHk9/7GX2+LxJLoAnSs+mKL+0JFUh
        I7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/jz55O5oKnQhXLz/1j
        a2D8z9/FyMEhIWAicWd2dhcjF4eQwFJGiXs9x5m6GDmB4uISu+e/ZYawhSX+XOtigyh6zSjR
        3zkdLCEs4CNxYO5kRpCEiEALi8TepzfBqpgFWpkkek5cY4Fo6WWUaL66lgWkhU1AU+LvZpAq
        Tg5eATuJ7uNHGEFsFgFViYZ/L9lBbFGBCIl75z9B1QhKnJz5BKyXU8BK4vbGDjCbWUBd4s+8
        S8wQtrzE9rdzoGxxiVtP5jNNYBSahaR9FpKWWUhaZiFpWcDIsopRJLW0ODc9t9hQrzgxt7g0
        L10vOT93EyMwYWw79nPzDsZLG4MPMQpwMCrx8P6Y9yBKiDWxrLgy9xCjBAezkghvRC9QiDcl
        sbIqtSg/vqg0J7X4EKMp0HMTmaVEk/OBySyvJN7Q1NDcwtLQ3Njc2MxCSZz3vEFllJBAemJJ
        anZqakFqEUwfEwenVANjbIRe87tbguo3r67vUfC4v+LhTe8M3neiRl9kuJ9fKzR4cfZPvZ7a
        SvZjz4JMZyXWPk9m+Xh9hcb7ksvvwyZ9jO3gW/XNYMcs4V31ZzTWL1RZwz8poOHAvweS83Sf
        PTl5eYpVEPsXrTq7Y34px9O9SmZMa5rW+m7GrNtrrSNXhstV7KyTue1uq8RSnJFoqMVcVJwI
        AE1DkQMuAwAA
X-CMS-MailID: 20180426063312eucas1p1f4327da55844cae833bff47458b6deb4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180426063312eucas1p1f4327da55844cae833bff47458b6deb4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180125155556epcas2p107973eb77ab08c436dbddcb66fcb7c89
X-RootMTR: 20180125155556epcas2p107973eb77ab08c436dbddcb66fcb7c89
References: <CGME20180125155556epcas2p107973eb77ab08c436dbddcb66fcb7c89@epcas2p1.samsung.com>
        <20180125155504.8611-1-philippe.cornu@st.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.01.2018 16:55, Philippe Cornu wrote:
> The "adjusted_mode" clock value (ie the real pixel clock) is more
> accurate than "mode" clock value (ie the panel/bridge requested
> clock value). It offers a better preciseness for timing
> computations and allows to reduce the extra dsi bandwidth in
> burst mode (from ~20% to ~10-12%, hw platform dependant).
>
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
> Note: This patch replaces "drm/bridge/synopsys: dsi: add optional pixel clock"

Queued to drm-misc-next.

--
Regards
Andrzej

>
>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> index ed8af32f8e52..b926b62e9e33 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> @@ -707,20 +707,20 @@ static void dw_mipi_dsi_bridge_mode_set(struct drm_bridge *bridge,
>  
>  	clk_prepare_enable(dsi->pclk);
>  
> -	ret = phy_ops->get_lane_mbps(priv_data, mode, dsi->mode_flags,
> +	ret = phy_ops->get_lane_mbps(priv_data, adjusted_mode, dsi->mode_flags,
>  				     dsi->lanes, dsi->format, &dsi->lane_mbps);
>  	if (ret)
>  		DRM_DEBUG_DRIVER("Phy get_lane_mbps() failed\n");
>  
>  	pm_runtime_get_sync(dsi->dev);
>  	dw_mipi_dsi_init(dsi);
> -	dw_mipi_dsi_dpi_config(dsi, mode);
> +	dw_mipi_dsi_dpi_config(dsi, adjusted_mode);
>  	dw_mipi_dsi_packet_handler_config(dsi);
>  	dw_mipi_dsi_video_mode_config(dsi);
> -	dw_mipi_dsi_video_packet_config(dsi, mode);
> +	dw_mipi_dsi_video_packet_config(dsi, adjusted_mode);
>  	dw_mipi_dsi_command_mode_config(dsi);
> -	dw_mipi_dsi_line_timer_config(dsi, mode);
> -	dw_mipi_dsi_vertical_timing_config(dsi, mode);
> +	dw_mipi_dsi_line_timer_config(dsi, adjusted_mode);
> +	dw_mipi_dsi_vertical_timing_config(dsi, adjusted_mode);
>  
>  	dw_mipi_dsi_dphy_init(dsi);
>  	dw_mipi_dsi_dphy_timing_config(dsi);
> @@ -734,7 +734,7 @@ static void dw_mipi_dsi_bridge_mode_set(struct drm_bridge *bridge,
>  
>  	dw_mipi_dsi_dphy_enable(dsi);
>  
> -	dw_mipi_dsi_wait_for_two_frames(mode);
> +	dw_mipi_dsi_wait_for_two_frames(adjusted_mode);
>  
>  	/* Switch to cmd mode for panel-bridge pre_enable & panel prepare */
>  	dw_mipi_dsi_set_mode(dsi, 0);
