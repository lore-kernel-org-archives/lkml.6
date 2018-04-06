Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751439AbeDFAa7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 20:30:59 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:38359 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbeDFAa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 20:30:58 -0400
X-Google-Smtp-Source: AIpwx48G7IpI2znXruNIk817rgnbY73kXxGTvSUmN3lUkabIlJuCx2b5VBIR9kIksW8fJObmMQtDhA==
To: airlied@linux.ie, alexander.deucher@amd.com, christian.koenig@amd.com,
        Felix.Kuehling@amd.com, labbott@redhat.com, akpm@linux-foundation.org,
        michel.daenzer@amd.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
From: Jean-Marc Valin <jmvalin@mozilla.com>
Subject: AMD graphics performance regression in 4.15 and later
Message-ID: <c743b220-0395-eef3-4405-a21cdbe8eee1@mozilla.com>
Date: Thu, 5 Apr 2018 20:30:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed a serious graphics performance regression between 4.14 and
4.15. It is most noticeable with Firefox (tried FF57 through FF60) and
causes scrolling to be really choppy/sluggish. I've confirmed that the
problem is also there on 4.16, while 4.13 works fine.

After a bisection, I've narrowed the regression down to this commit:

commit 648bc3574716400acc06f99915815f80d9563783
Author: Christian König <christian.koenig@amd.com>
Date:   Thu Jul 6 09:59:43 2017 +0200

    drm/ttm: add transparent huge page support for DMA allocations v2


Some details about my system:
Distro: Fedora 27 (up-to-date)
Video: MSI Radeon RX 560 AERO
CPU: Dual-socket Xeon E5-2640 v4 (20 cores total)
RAM: 128 GB ECC


As a comparison, when running Firefox with 4.15 on a Lenovo W540 laptop
(with Intel graphics only) the responsiveness is much better then what
I'm getting on the Xeon machine above with the Radeon card, so this
really seems to be an AMD-only issue.

Any way to fix the issue?

Thanks,

	Jean-Marc
