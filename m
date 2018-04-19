Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753551AbeDSV0T (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 17:26:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:41547 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753419AbeDSV0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 17:26:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,298,1520924400";
   d="scan'208";a="35594044"
Subject: Re: [do_execve] attempted to set unsupported pgprot
To: Andrew Morton <akpm@linux-foundation.org>,
        Fengguang Wu <fengguang.wu@intel.com>
References: <20180418135933.t3dyszi2phhsvaah@wfg-t540p.sh.intel.com>
 <20180418125916.a8be1fac1ac017f41a10f0fb@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, Serge Hallyn <serge@hallyn.com>,
        James Morris <james.l.morris@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkp@01.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <e8f57e63-2657-6193-55e0-b097363ec97a@linux.intel.com>
Date: Thu, 19 Apr 2018 14:26:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180418125916.a8be1fac1ac017f41a10f0fb@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/18/2018 12:59 PM, Andrew Morton wrote:
> Dave, fb43d6cb91ef57 ("x86/mm: Do not auto-massage page protections")
> looks like a culprit?

This looks like a problem when a 32-bit kernel runs on hardware without
NX support.  I'm digging into it but haven't found a root cause yet.
