Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966928AbeBPMhU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 07:37:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:50603 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966628AbeBPMhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 07:37:18 -0500
Date: Fri, 16 Feb 2018 13:37:15 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Xiongfeng Wang <wangxiongfeng2@huawei.com>
cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: uhid: use strlcpy() instead of strncpy()
In-Reply-To: <1515500612-191425-1-git-send-email-wangxiongfeng2@huawei.com>
Message-ID: <nycvar.YFH.7.76.1802161337050.13621@cbobk.fhfr.pm>
References: <1515500612-191425-1-git-send-email-wangxiongfeng2@huawei.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2018, Xiongfeng Wang wrote:

> From: Xiongfeng Wang <xiongfeng.wang@linaro.org>
> 
> gcc-8 reports
> 
> drivers/hid/uhid.c: In function 'uhid_dev_create2':
> ./include/linux/string.h:245:9: warning: '__builtin_strncpy' output may
> be truncated copying 127 bytes from a string of length 127
> [-Wstringop-truncation]
> 
> The compiler require that the input param 'len' of strncpy() should be
> greater than the length of the src string, so that '\0' is copied as
> well. We can just use strlcpy() to avoid this warning.

Applied to for-4.17/upstream.

-- 
Jiri Kosina
SUSE Labs
