Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0344DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE70B20700
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732296AbfAKPpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:45:39 -0500
Received: from mga09.intel.com ([134.134.136.24]:9006 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731201AbfAKPpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:45:39 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jan 2019 07:45:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,466,1539673200"; 
   d="scan'208";a="135041129"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.6])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jan 2019 07:45:37 -0800
Date:   Fri, 11 Jan 2019 23:45:45 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Qu Wenruo <wqu@suse.de>
Cc:     lkp@01.org, Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <DSterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [LKP] [btrfs] 05a37c4860:
 kmsg.BTRFS_error(device_vdd):failed_to_verify_dev_extents_against_chunks
Message-ID: <20190111154545.GN17624@shao2-debian>
References: <20190111140312.GM17624@shao2-debian>
 <819023c9-a7f1-44be-6e8d-5525eb6b0fc9@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <819023c9-a7f1-44be-6e8d-5525eb6b0fc9@suse.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 10:39:45PM +0800, Qu Wenruo wrote:
> 
> 
> On 2019/1/11 下午10:03, kernel test robot wrote:
> > FYI, we noticed the following commit (built with gcc-7):
> > 
> > commit: 05a37c48604c19b50873fd9663f9140c150469d1 ("btrfs: volumes: Make sure no dev extent is beyond device boundary")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > in testcase: xfstests
> > with following parameters:
> > 
> > 	disk: 6HDD
> > 	fs: btrfs
> > 	test: btrfs-group1
> > 
> > test-description: xfstests is a regression test suite for xfs and other files ystems.
> > test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > 
> > 
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> For the LKP tests, would you please not bind all fstests test cases into
> one LKP test case?
> 
> That's pretty hard for us to locate the problem. not to mention there
> will be tons of generic tests, and new tests could easily screw up your
> existing result.
> 
> It will make more sense to generate test cases based on
> fstests/tests/btrfs/group, and save their result for each fstests test case.
> 

Thanks for your suggestion, we'll adapt the test cases.

Best Regards,
Rong Chen
