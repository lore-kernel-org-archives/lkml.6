Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933352AbeCNDM2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 23:12:28 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:36387 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933192AbeCNDM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 23:12:26 -0400
Subject: Re: [PATCH v8 11/13] [media] v4l: introduce the fences capability
To: Gustavo Padovan <gustavo@padovan.org>, linux-media@vger.kernel.org
Cc: kernel@collabora.com, Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Shuah Khan <shuahkh@osg.samsung.com>, Pawel Osciak <pawel@osciak.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Brian Starkey <brian.starkey@arm.com>, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>
References: <20180309174920.22373-1-gustavo@padovan.org>
 <20180309174920.22373-12-gustavo@padovan.org>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <69cd0da1-9f71-6ce9-7ca0-955d9d3fae61@xs4all.nl>
Date: Tue, 13 Mar 2018 20:12:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180309174920.22373-12-gustavo@padovan.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBCpVMsX1NWj8Z9951fcgWPWV/YrkzEgs7i0lR9JpR5vdI2cFh1IC3W3Pd0QZzI2T32xW6Q2DkiAGNR9b6q5SHgOAjL6TGdGLA2ewB+3fXvTxml3OiYf
 I685n46f6s6V6o/ATFVQ+qph9MWN2bQVNoy9OUO6rlwAhT+GW96a3dbq1W3fpFktnHgsHxNPs1bdW6pFAR07oxeksFF58Keba80NlApiv45FWBzkEIvlNWLC
 H95kcA0nVaDEe2oH/iyje981WOmtFwNVSOXWLrbSg7enjFV2gkxqz7J82mfQbZV0hWqvC3aJKpP5hJ6TXuMp3YWiCDmGEhtTLvew+BTu5Jc385A+7GOl0L/3
 JLsTJ6yDhv8JnAbl36ClCDPlDU92smc7vBF33wR7+WcKCQEE3oFRIDZmX/CP9ZiDm6fAOLQmITjYFC9DLak5ZzH0vEkvvCzgIL0+W26wEgwxxtvYiSYBFeNq
 7x+PKCNyEvicUu+d
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2018 09:49 AM, Gustavo Padovan wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.com>
> 
> Drivers capable of using fences (vb2 drivers) should report the
> V4L2_CAP_FENCES to userspace, so add this flag to the uapi.
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
> ---
>  Documentation/media/uapi/v4l/vidioc-querycap.rst | 3 +++
>  include/uapi/linux/videodev2.h                   | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/Documentation/media/uapi/v4l/vidioc-querycap.rst b/Documentation/media/uapi/v4l/vidioc-querycap.rst
> index 66fb1b3d6e6e..414016065309 100644
> --- a/Documentation/media/uapi/v4l/vidioc-querycap.rst
> +++ b/Documentation/media/uapi/v4l/vidioc-querycap.rst
> @@ -254,6 +254,9 @@ specification the ioctl returns an ``EINVAL`` error code.
>      * - ``V4L2_CAP_TOUCH``
>        - 0x10000000
>        - This is a touch device.
> +    * - ``V4L2_CAP_FENCES``
> +      - 0x20000000
> +      - The device support explicit synchronization.

support -> supports

>      * - ``V4L2_CAP_DEVICE_CAPS``
>        - 0x80000000
>        - The driver fills the ``device_caps`` field. This capability can
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 2d424aebdd1e..db58204e346e 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -460,6 +460,7 @@ struct v4l2_capability {
>  #define V4L2_CAP_STREAMING              0x04000000  /* streaming I/O ioctls */
>  
>  #define V4L2_CAP_TOUCH                  0x10000000  /* Is a touch device */
> +#define V4L2_CAP_FENCES                 0x20000000  /* Supports explicit synchronization */
>  
>  #define V4L2_CAP_DEVICE_CAPS            0x80000000  /* sets device capabilities field */
>  
> 

Regards,

	Hans
