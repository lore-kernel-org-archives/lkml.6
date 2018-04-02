Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754113AbeDBCqs (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 22:46:48 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:51107 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754072AbeDBCqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 22:46:46 -0400
X-Google-Smtp-Source: AIpwx48HSBAv2MNO4kJn9lDR4zV4XZZG8DUoVshFDIIQE2mINyQNmSq1k83nLC9lBUJz4EeuecNgvA==
Subject: Re: [Qemu-devel] [RFC] About 9pfs support "O_DIRECT + aio"?
To: jiangyiwen <jiangyiwen@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>, Latchesar Ionkov <lucho@ionkov.net>,
        Greg Kurz <groug@kaod.org>, aneesh.kumar@linux.vnet.ibm.com
Cc: v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org
References: <5ABDFB24.1080207@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <41088460-11f1-1ec7-2bfa-1ebdf675dc17@redhat.com>
Date: Mon, 2 Apr 2018 04:45:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5ABDFB24.1080207@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2018 10:53, jiangyiwen wrote:
> Currently, I found virtio-9p in VirtFS don't support "O_DIRECT + aio"
> mode, both v9fs and qemu. So when user use "O_DIRECT + aio" mode and
> increase iodepths, they can't get higher IOPS.
> 
> I want to know why v9fs don't implement this mode? And I will try to
> implement this mode from now on.

Can you explain?  I think 9p has support for direct I/O in Linux.  See
v9fs_direct_IO in fs/9p/vfs_addr.c.

Paolo
