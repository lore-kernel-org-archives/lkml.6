Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932706AbeEaBqv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 21:46:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42736 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932593AbeEaBqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 21:46:48 -0400
Subject: Re: [PATCH 0/8] xen: dma-buf support for grant device
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc: daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180525153331.31188-1-andr2000@gmail.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <9687b6e5-808e-0c63-34c3-90e6fcbdfb2e@oracle.com>
Date: Wed, 30 May 2018 21:46:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180525153331.31188-1-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8909 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1805310016
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/25/2018 11:33 AM, Oleksandr Andrushchenko wrote:

> 
> Oleksandr Andrushchenko (8):
>    xen/grant-table: Make set/clear page private code shared
>    xen/balloon: Move common memory reservation routines to a module
>    xen/grant-table: Allow allocating buffers suitable for DMA
>    xen/gntdev: Allow mappings for DMA buffers
>    xen/gntdev: Add initial support for dma-buf UAPI
>    xen/gntdev: Implement dma-buf export functionality
>    xen/gntdev: Implement dma-buf import functionality
>    xen/gntdev: Expose gntdev's dma-buf API for in-kernel use
> 
>   drivers/xen/Kconfig           |   23 +
>   drivers/xen/Makefile          |    1 +
>   drivers/xen/balloon.c         |   71 +--
>   drivers/xen/gntdev.c          | 1025 ++++++++++++++++++++++++++++++++-


I think this calls for gntdev_dma.c. I only had a quick look over gntdev 
changes but they very much are concentrated in dma-specific routines.

You essentially only share file_operations entry points with original 
gntdev code, right?

-boris


>   drivers/xen/grant-table.c     |  176 +++++-
>   drivers/xen/mem-reservation.c |  134 +++++
>   include/uapi/xen/gntdev.h     |  106 ++++
>   include/xen/grant_dev.h       |   37 ++
>   include/xen/grant_table.h     |   28 +
>   include/xen/mem_reservation.h |   29 +
>   10 files changed, 1527 insertions(+), 103 deletions(-)
>   create mode 100644 drivers/xen/mem-reservation.c
>   create mode 100644 include/xen/grant_dev.h
>   create mode 100644 include/xen/mem_reservation.h
> 
