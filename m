Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932934AbeBVOZO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:25:14 -0500
Received: from www62.your-server.de ([213.133.104.62]:52730 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932564AbeBVOZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:25:12 -0500
Subject: Re: [PATCH v2] selftests/bpf/test_maps: exit child process without
 error in ENOMEM case
To: Li Zhijian <lizhijian@cn.fujitsu.com>, shuah@kernel.org,
        ast@kernel.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Li Zhijian <zhijianx.li@intel.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Philip Li <philip.li@intel.com>
References: <1519266842-29004-1-git-send-email-lizhijian@cn.fujitsu.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <dd9b9ef2-ee8f-ad81-61dc-ce57117f803f@iogearbox.net>
Date: Thu, 22 Feb 2018 15:25:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1519266842-29004-1-git-send-email-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22/2018 03:34 AM, Li Zhijian wrote:
> From: Li Zhijian <zhijianx.li@intel.com>
> 
> test_maps contains a series of stress tests, and previously it will break the
> rest tests when it failed to alloc memory.
> -----------------------
> Failed to create hashmap key=8 value=262144 'Cannot allocate memory'
> Failed to create hashmap key=16 value=262144 'Cannot allocate memory'
> Failed to create hashmap key=8 value=262144 'Cannot allocate memory'
> Failed to create hashmap key=8 value=262144 'Cannot allocate memory'
> test_maps: test_maps.c:955: run_parallel: Assertion `status == 0' failed.
> Aborted
> not ok 1..3 selftests:  test_maps [FAIL]
> -----------------------
> after this patch, the rest tests will be continue when it occurs an ENOMEM failure
> 
> CC: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> CC: Philip Li <philip.li@intel.com>
> Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Li Zhijian <zhijianx.li@intel.com>

Applied to bpf tree, thanks Li!
