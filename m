Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754881AbeEYDHh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 23:07:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:33209 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751768AbeEYDHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 23:07:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,438,1520924400";
   d="scan'208";a="202317656"
Date: Fri, 25 May 2018 11:07:55 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, wexu@redhat.com,
        jfreimann@redhat.com
Subject: Re: [RFC v5 0/5] virtio: support packed ring
Message-ID: <20180525030754.GA11557@debian>
References: <20180522081648.14768-1-tiwei.bie@intel.com>
 <b19e0888-61dc-c067-0b05-fde3b5eb0902@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b19e0888-61dc-c067-0b05-fde3b5eb0902@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 10:31:26AM +0800, Jason Wang wrote:
> On 2018年05月22日 16:16, Tiwei Bie wrote:
> > Hello everyone,
> > 
> > This RFC implements packed ring support in virtio driver.
> > 
> > Some simple functional tests have been done with Jason's
> > packed ring implementation in vhost (RFC v4):
> > 
> > https://lkml.org/lkml/2018/5/16/501
> > 
> > Both of ping and netperf worked as expected w/ EVENT_IDX
> > disabled. Ping worked as expected w/ EVENT_IDX enabled,
> > but netperf didn't (A hack has been added in the driver
> > to make netperf test pass in this case. The hack can be
> > found by `grep -rw XXX` in the code).
> 
> Looks like this is because a bug in vhost which wrongly track signalled_used
> and may miss an interrupt. After fixing that, both side works like a charm.
> 
> I'm testing vIOMMU and zerocopy, and will post a new version shortly. (Hope
> it would be the last RFC version).

Great to know that. Thanks a lot! :)

Best regards,
Tiwei Bie
