Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CA0C7C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891B920896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891B920896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965849AbeFOO25 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 10:28:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:18813 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965738AbeFOO2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 10:28:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 07:28:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,227,1526367600"; 
   d="scan'208";a="59508245"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga003.jf.intel.com with ESMTP; 15 Jun 2018 07:28:52 -0700
Received: from fmsmsx102.amr.corp.intel.com (10.18.124.200) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 15 Jun 2018 07:28:51 -0700
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 FMSMSX102.amr.corp.intel.com (10.18.124.200) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 15 Jun 2018 07:28:51 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.223]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.87]) with mapi id 14.03.0319.002;
 Fri, 15 Jun 2018 22:28:49 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>,
        "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>,
        "quan.xu0@gmail.com" <quan.xu0@gmail.com>,
        "nilal@redhat.com" <nilal@redhat.com>,
        "riel@redhat.com" <riel@redhat.com>,
        "peterx@redhat.com" <peterx@redhat.com>
Subject: RE: [PATCH v33 0/4] Virtio-balloon: support free page reporting
Thread-Topic: [PATCH v33 0/4] Virtio-balloon: support free page reporting
Thread-Index: AQHUBGby+/C9AzCksEOKTvSxk6HhoKRgqWWAgACziqA=
Date:   Fri, 15 Jun 2018 14:28:49 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7396A3DC9@shsmsx102.ccr.corp.intel.com>
References: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
 <20180615142610-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180615142610-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTdlYmQ1ZDQtOTUzMS00ODdhLWFkOTEtYmFkODE1NzY3NTY2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNmhFaGk2WnBwOEpwMFNNemZkQUJVSFNVMmxtWndBN1k2dUlZWjZsYTFpdlppUFRoVURtZFprT0tkNDRVS1wvd2YifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, June 15, 2018 7:30 PM, Michael S. Tsirkin wrote:
> On Fri, Jun 15, 2018 at 12:43:09PM +0800, Wei Wang wrote:
> >       - remove the cmd id related interface. Now host can just send a free
> >         page hint command to the guest (via the host_cmd config register)
> >         to start the reporting.
> 
> Here we go again. And what if reporting was already started previously?
> I don't think it's a good idea to tweak the host/guest interface yet again.

This interface is much simpler, and I'm not sure if that would be an issue here now, because
now the guest delivers the whole buffer of hints to host once, instead of hint by hint as before. And the guest notifies host after the buffer is delivered. In any case, the host doorbell handler will be invoked, if host doesn't need the hints at that time, it will just give back the buffer. There will be no stale hints remained in the ring now.

Best,
Wei
