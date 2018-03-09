Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751216AbeCINhI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 08:37:08 -0500
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:57908 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751106AbeCINhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 08:37:06 -0500
Subject: Re: [PATCH v6 02/17] media: doc: add document for rkisp1 meta buffer
 format
To: Jacob Chen <jacob-chen@iotwrt.com>, linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        sakari.ailus@linux.intel.com, hans.verkuil@cisco.com,
        tfiga@chromium.org, zhengsq@rock-chips.com,
        laurent.pinchart@ideasonboard.com, zyc@rock-chips.com,
        eddie.cai.linux@gmail.com, jeffy.chen@rock-chips.com,
        devicetree@vger.kernel.org, heiko@sntech.de,
        Jacob Chen <jacob2.chen@rock-chips.com>,
        Jacob Chen <jacob-chen@rock-chips.com>
References: <20180308094807.9443-1-jacob-chen@iotwrt.com>
 <20180308094807.9443-3-jacob-chen@iotwrt.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <036c8bbe-c17f-b6fa-8432-fd7419adeda9@xs4all.nl>
Date: Fri, 9 Mar 2018 14:37:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180308094807.9443-3-jacob-chen@iotwrt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCFHearEPExDmuFtvs/FGJehmISD/fqH/7KHBE2ci7fA3R72MxUWEN2Sf04XY7BNqLSIHTSavFGQOlIcusPSg5DS9VdOlFprmXuRWaQu/SVv52fALxkS
 GaBbgEYpXhvhfI/buDBACi3XbHi4mAHQ8lJVJTYuh3m1iclvxAyGTbKMUTy5UWneEkdv6hwTADlWxLTmwDrcFr8EcofiUkZKaz7OhqMqPU5ANQEftOUA6F2c
 ILV7PjnQnXYLSA9MyUo1O86hz7bhImbzXr2wEehhONu6hZbxo8x3FSJpBYLdDWFL1tB7ZRGDC8v6GJeRpZ5MbtgdUvCZKyMAqF9YUatgr2EvMnRmIKTY5jFP
 06JBWdQz5lounqwdQlQXQSFfx0kii0E6Job1SDK7yLXgX1omfrwQc0oBs/x7N8QvKTZUCMLqi77+b7/5tPEpQMn/BsotyQ+bcvpurkvcXgYQnOYeeYt2aE5j
 MOL7lUIdbzj4o6M1U3+YcUXZLFdO9cn3k001afakxDqCtDt0zKveGbIB94M6/qtNrXPs0J7T6xxRuKL+g+0ISmtAd9StWbnUl3lE7MN71jKN2Qo8U9vt7bSF
 dQFwg4EnGw5NVYhhfN0QobQt74H+ZGCqNgKz42ofwilXEjUXZE4jmnspvaV/oOmGztMgfCduriPWohiqOwVGYtNgfNg7XbJwdHKHhgK9iQ6c2AzzYs+renFA
 7lsKHeyQVfqNRgio4ghZDwaZQjLv5etJ
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/18 10:47, Jacob Chen wrote:
> From: Jacob Chen <jacob2.chen@rock-chips.com>
> 
> This commit add docuemnt for rkisp1 meta buffer format
> 
> Signed-off-by: Jacob Chen <jacob-chen@rock-chips.com>
> Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
> ---
>  Documentation/media/uapi/v4l/meta-formats.rst        |  2 ++
>  .../media/uapi/v4l/pixfmt-meta-rkisp1-params.rst     | 20 ++++++++++++++++++++
>  .../media/uapi/v4l/pixfmt-meta-rkisp1-stat.rst       | 18 ++++++++++++++++++
>  3 files changed, 40 insertions(+)
>  create mode 100644 Documentation/media/uapi/v4l/pixfmt-meta-rkisp1-params.rst
>  create mode 100644 Documentation/media/uapi/v4l/pixfmt-meta-rkisp1-stat.rst
> 
> diff --git a/Documentation/media/uapi/v4l/meta-formats.rst b/Documentation/media/uapi/v4l/meta-formats.rst
> index 0c4e1ecf5879..44e7edbf1dae 100644
> --- a/Documentation/media/uapi/v4l/meta-formats.rst
> +++ b/Documentation/media/uapi/v4l/meta-formats.rst
> @@ -15,3 +15,5 @@ These formats are used for the :ref:`metadata` interface only.
>      pixfmt-meta-uvc
>      pixfmt-meta-vsp1-hgo
>      pixfmt-meta-vsp1-hgt
> +    pixfmt-meta-rkisp1-params
> +    pixfmt-meta-rkisp1-stat
> diff --git a/Documentation/media/uapi/v4l/pixfmt-meta-rkisp1-params.rst b/Documentation/media/uapi/v4l/pixfmt-meta-rkisp1-params.rst
> new file mode 100644
> index 000000000000..2ff4f4309795
> --- /dev/null
> +++ b/Documentation/media/uapi/v4l/pixfmt-meta-rkisp1-params.rst
> @@ -0,0 +1,20 @@
> +.. -*- coding: utf-8; mode: rst -*-
> +
> +.. _v4l2-meta-fmt-rkisp1-params:
> +
> +*******************************
> +V4L2_META_FMT_RK_ISP1_PARAMS
> +*******************************
> +
> +Rockchip ISP1 Parameters Data
> +
> +Description
> +===========
> +
> +This format describes input parameters for the Rockchip ISP1.
> +
> +It uses c-struct :c:type:`rkisp1_isp_params_cfg`, which is defined in
> +the ``linux/rkisp1-config.h`` header file, see it for details.
> +
> +The parameters consist of multiple modules.
> +The module won't be updated if the correspond bit was not set in module_*_update.

correspond -> corresponding

> diff --git a/Documentation/media/uapi/v4l/pixfmt-meta-rkisp1-stat.rst b/Documentation/media/uapi/v4l/pixfmt-meta-rkisp1-stat.rst
> new file mode 100644
> index 000000000000..dca8befe58f1
> --- /dev/null
> +++ b/Documentation/media/uapi/v4l/pixfmt-meta-rkisp1-stat.rst
> @@ -0,0 +1,18 @@
> +.. -*- coding: utf-8; mode: rst -*-
> +
> +.. _v4l2-meta-fmt-rkisp1-stat:
> +
> +*******************************
> +V4L2_META_FMT_RK_ISP1_STAT_3A
> +*******************************
> +
> +Rockchip ISP1 Statistics Data
> +
> +Description
> +===========
> +
> +This format describes image color statistics information generated by the Rockchip
> +ISP1.
> +
> +It use c-struct :c:type:`rkisp1_stat_buffer`, which is defined in

use -> uses

> +the ``linux/cifisp_stat.h`` header file, see it for details.
> 

Regards,

	Hans
