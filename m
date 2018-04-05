Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752782AbeDECFJ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 22:05:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:19225 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752661AbeDECFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 22:05:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,409,1517904000";
   d="scan'208";a="39496099"
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org"
        <virtualization@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>,
        "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>,
        "quan.xu0@gmail.com" <quan.xu0@gmail.com>,
        "nilal@redhat.com" <nilal@redhat.com>,
        "riel@redhat.com" <riel@redhat.com>,
        "huangzhichao@huawei.com" <huangzhichao@huawei.com>
Subject: RE: [PATCH v30 2/4] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
Thread-Topic: [PATCH v30 2/4] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
Thread-Index: AQHTyyXXTsdlmy3QmUiflW8thGbyQqPu3AAAgAB7EICAAMkagIABH5Eg//+aJwCAAIzSsA==
Date: Thu, 5 Apr 2018 02:05:03 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7394A7F3B@shsmsx102.ccr.corp.intel.com>
References: <1522771805-78927-1-git-send-email-wei.w.wang@intel.com>
 <1522771805-78927-3-git-send-email-wei.w.wang@intel.com>
 <20180403214147-mutt-send-email-mst@kernel.org> <5AC43377.2070607@intel.com>
 <20180404155907-mutt-send-email-mst@kernel.org>
 <286AC319A985734F985F78AFA26841F7394A6E96@shsmsx102.ccr.corp.intel.com>
 <20180405040900-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180405040900-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjkyNWYwMTAtMjczNy00YTdmLTk5NTQtOTVmOGY1ZjJiZTI3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6Ik13NkdCMXVadElUSUJHc1wvb2NBcExPWUdCNTZLelZBMlkwWmd0TUdYMlR3PSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, April 5, 2018 9:12 AM, Michael S. Tsirkin wrote:
> On Thu, Apr 05, 2018 at 12:30:27AM +0000, Wang, Wei W wrote:
> > On Wednesday, April 4, 2018 10:08 PM, Michael S. Tsirkin wrote:
> > > On Wed, Apr 04, 2018 at 10:07:51AM +0800, Wei Wang wrote:
> > > > On 04/04/2018 02:47 AM, Michael S. Tsirkin wrote:
> > > > > On Wed, Apr 04, 2018 at 12:10:03AM +0800, Wei Wang wrote:
> > I'm afraid the driver couldn't be aware if the added hints are stale
> > or not,
> 
> 
> No - I mean that driver has code that compares two values and stops
> reporting. Can one of the values be stale?

The driver compares "vb->cmd_id_use != vb->cmd_id_received" to decide if it needs to stop reporting hints, and cmd_id_received is what the driver reads from host (host notifies the driver to read for the latest value). If host sends a new cmd id, it will notify the guest to read again. I'm not sure how that could be a stale cmd id (or maybe I misunderstood your point here?)

Best,
Wei
