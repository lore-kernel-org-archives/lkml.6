Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751474AbeBWGqK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 01:46:10 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43480 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750943AbeBWGqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 01:46:08 -0500
X-Google-Smtp-Source: AH8x2245F+RmtFU9T2tf2V0/4xq1SGrc3eEEVwj+Ph8oHAy83dIhu6CVSsE37iKpNGnZzwB/zXwwpA==
Subject: Re: [PATCH 3/9] drm/xen-front: Read driver configuration from Xen
 store
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <1519200222-20623-1-git-send-email-andr2000@gmail.com>
 <1519200222-20623-4-git-send-email-andr2000@gmail.com>
 <74f01442-2e9e-5de7-3a8d-f5c12d9e8667@oracle.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <864fe8f3-99f7-1f63-4169-fc9e37c46c3f@gmail.com>
Date: Fri, 23 Feb 2018 08:46:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <74f01442-2e9e-5de7-3a8d-f5c12d9e8667@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/23/2018 01:20 AM, Boris Ostrovsky wrote:
> On 02/21/2018 03:03 AM, Oleksandr Andrushchenko wrote:
>> +
>> +static int cfg_connector(struct xen_drm_front_info *front_info,
>> +		struct xen_drm_front_cfg_connector *connector,
>> +		const char *path, int index)
>> +{
>> +	char *connector_path;
>> +
>> +	connector_path = devm_kasprintf(&front_info->xb_dev->dev,
>> +			GFP_KERNEL, "%s/%d", path, index);
>> +	if (!connector_path)
>> +		return -ENOMEM;
>> +
>> +	connector->xenstore_path = connector_path;
>> +	if (xenbus_scanf(XBT_NIL, connector_path, XENDISPL_FIELD_RESOLUTION,
>> +			"%d" XENDISPL_RESOLUTION_SEPARATOR "%d",
>> +			&connector->width, &connector->height) < 0) {
>> +		/* either no entry configured or wrong resolution set */
>> +		connector->width = 0;
>> +		connector->height = 0;
> Do you also need to set connector->xenstore_path to NULL? Or maybe just
> set it after xenbus_scanf() call.
Will move it down the code, after "if", thank you
> -boris
>
>
>
