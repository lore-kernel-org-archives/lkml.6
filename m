Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbeCNQID (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:08:03 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:34537 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751413AbeCNQIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:08:01 -0400
Subject: Re: [PATCH v8 12/13] [media] v4l: Add V4L2_CAP_FENCES to drivers
To: Gustavo Padovan <gustavo@padovan.org>, linux-media@vger.kernel.org
Cc: kernel@collabora.com, Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Shuah Khan <shuahkh@osg.samsung.com>, Pawel Osciak <pawel@osciak.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Brian Starkey <brian.starkey@arm.com>, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>
References: <20180309174920.22373-1-gustavo@padovan.org>
 <20180309174920.22373-13-gustavo@padovan.org>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <77c125e0-8f3f-07fd-ac80-0d8491597c18@xs4all.nl>
Date: Wed, 14 Mar 2018 09:07:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180309174920.22373-13-gustavo@padovan.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLhvd51ddvpISedIyq/SuHdI69Dh5odtG7zWeFEMuoOl6/TkgFPeH8XnAl0peX8h8CnN2rkivXFypq8kxJ3S3Cs3muoQL6b9sqrIONtRukVs0GHvaTQa
 vfI02Qd6exjg7R/7GgHofPbFHpdoU35sCTJs8ncLFdmhOOJUCx/wiZuAWOLAZUj+eVwlbdGlv04DoC/P+S/XdRR4P02I+9TjJr5foMgjO67qV0hJq+Kk3nOi
 VVXtQ+RibFyqWT26fiWhfakICagmOT5RXH9gRCPWTVz2rZL2cVKjf9oA8Q3nNLS2j8va7NUGGZIqTEY+Ctdb7/3vsFm0G6m08UDFwgTJVURvAwiXen5EZbUt
 HJzac6XW721UvOMOnvbCDyLlHEI0lA77hNRGVjtGcY/OANH+haLHayCkVchfc5Y0Uc42iyiCGcf1hlwKYdsls/Qt/RH3Aw04/+tcv4M+JIUO136P/w4d6yPk
 Ue0eANZ6elPqb8jP
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2018 09:49 AM, Gustavo Padovan wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.com>
> 
> Drivers that use videobuf2 are capable of using fences and
> should report that to userspace.
> 
> The coding style is following what each drivers was already
> doing.

I think this can be simplified for most drivers: you can set this
flag in the v4l_querycap function if vdev->queue is not NULL or if
m2m_ctx is set in struct v4l2_fh.

I believe all non-m2m drivers that use vb2 set vdev->queue. But not
all m2m drivers will set m2m_ctx, so that will need to be checked.

In other words, this way you only need to modify m2m drivers that
do not set m2m_ctx.

Regards,

	Hans
