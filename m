Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753987AbeEOPfl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 11:35:41 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:56987 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752522AbeEOPfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 11:35:39 -0400
Subject: Re: [PATCH v2 5/5] media: platform: Add Chrome OS EC CEC driver
To: Neil Armstrong <narmstrong@baylibre.com>, airlied@linux.ie,
        hans.verkuil@cisco.com, lee.jones@linaro.org, olof@lixom.net,
        seanpaul@google.com
Cc: sadolfsson@google.com, felixe@google.com, bleung@google.com,
        darekm@google.com, marcheu@chromium.org, fparent@baylibre.com,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1526395342-15481-1-git-send-email-narmstrong@baylibre.com>
 <1526395342-15481-6-git-send-email-narmstrong@baylibre.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <ec0506cf-2c7a-ebb6-3f40-2dffd30367f2@xs4all.nl>
Date: Tue, 15 May 2018 17:35:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1526395342-15481-6-git-send-email-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFYiF2IqCyEbm2bfiJw/4cCAuyFrU3r7dZlbOPKlnhB8cBYAe9kwftK9UYZCpbcQRZmUVWFg7CNQQBzoFL/FulW/KBdyLSUqQ2xgCgVH6T4Gci3QL/C3
 jhrl6gDES+L8EPqnHkuXanegZXB//W0slth0jxqbhWRT2qwSfQWD/SSlEVPnE3wG/Fw/E3kIxJT03oDYbdkdHawZBzO8+aQln72pgWnf9Oii8Y1BtZNS9+5w
 xNBFOILxttjHJj8k8Z8qSYBuG983RJec+w8ixxLoq0ba/+PVn7HVK8GVlpLNuNdaX6T8OzQ6+WwO7BMWK9CjGIY5kPU4kwmLHuGCD94SbuxjgRTgjjE0XcNi
 zV0nYLo3wOhMK3FsLu4/tLJArjJ47auPTBSNkS3Ka1EjjJlRIbII5mAK0qTqFNiK5wr5nc/+AFACWq2Z507En0TjcvfxbJ75jm12kadZB/e36SThDlZSZE9A
 teukzIrbNOvvZUcJeLBmoMK5HG+Q6FsETJNNjRpUGTWR2B4COXnHcpYfT/gLD9BDWfvcCsLIJyYi6cc1LUnTr8cnHUSs+rODnP6LyBDJtEIcS5g1Q5bAknWL
 /3egDc1Fv4nI01JPpo2UkaIJ2QFjxDnTWHHW/XTL9JPVSwnoET3S6iFfp6lgWOpn0Eiq0Qp6z5UToeRTNpbX3lvqbHWoTM9zSayRnFK6q6wqjJ2xvmfyX5Nr
 45ALByZU5L4=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/15/2018 04:42 PM, Neil Armstrong wrote:
> The Chrome OS Embedded Controller can expose a CEC bus, this patch add the
> driver for such feature of the Embedded Controller.
> 
> This driver is part of the cros-ec MFD and will be add as a sub-device when
> the feature bit is exposed by the EC.
> 
> The controller will only handle a single logical address and handles
> all the messages retries and will only expose Success or Error.
> 
> The controller will be tied to the HDMI CEC notifier by using the platform
> DMI Data and the i915 device name and connector name.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---

<snip>

> +static SIMPLE_DEV_PM_OPS(cros_ec_cec_pm_ops,
> +	cros_ec_cec_suspend, cros_ec_cec_resume);
> +
> +/*
> + * The Firmware only handles single CEC interface tied to a single HDMI

single CEC -> a single CEC

> + * connector we specify along the DRM device name handling the HDMI output

along -> along with

> + */
> +
> +struct cec_dmi_match {
> +	char *sys_vendor;
> +	char *product_name;
> +	char *devname;
> +	char *conn;
> +};
> +

Looks good!

Regards,

	Hans
