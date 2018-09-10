Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77484C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8A52087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A8A52087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbeIJU4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:56:55 -0400
Received: from mga18.intel.com ([134.134.136.126]:39001 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727777AbeIJU4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:56:55 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 09:02:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,356,1531810800"; 
   d="scan'208";a="79357179"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Sep 2018 09:02:01 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 63581301376; Mon, 10 Sep 2018 09:02:01 -0700 (PDT)
Date:   Mon, 10 Sep 2018 09:02:01 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Chengdong Li <chengdong.li@linux.alibaba.com>
Cc:     ebiederm@xmission.com, peterz@infradead.org,
        kjlx@templeofstupid.com, hbathini@linux.vnet.ibm.com,
        brendan.d.gregg@gmail.com, linux-kernel@vger.kernel.org,
        chengdong.licd@alibaba-inc.com
Subject: Re: Question: How to switch a process namespace by nsfs "device" and
 inode number directly?
Message-ID: <20180910160201.GV27886@tassilo.jf.intel.com>
References: <0eb9ec62-1c1b-5903-2db6-43ca571580b9@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0eb9ec62-1c1b-5903-2db6-43ca571580b9@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 04:50:42PM +0800, Chengdong Li wrote:
> Hi folks,
> 
> I am getting stuck by the lack of approach to switch process namespace by
> nsfs "device" and inode number in user-space,  for example (mnt: 0xf0000000)
> 
> From my best understanding, the normal way to do that is by setns system
> call. But setns only accept fd that refer to a opened namespace, sometimes
> we couldn't get it.
> 
> For example:  After perf record, perf report couldn't work well once the
> process that runs inside a container has exited, as the /proc/pid/ns doesn't
> exist anymore after process exit.

The kernel name space doesn't exist anymore at this point, so there is simply no way
to reconstruct it.

Perhaps would need some higher level side band data for perf, similar as what
is done for JITed code. Somehow the container run time needs to tell perf
where to find the code.

-Andi
