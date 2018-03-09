Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELvz966KXS6bVzalUVMo3yc6eswkGAf2jru5MPgqTvuL7sHMTJm2D9RZs4FIyy3eaLd2loxp
ARC-Seal: i=1; a=rsa-sha256; t=1520558904; cv=none;
        d=google.com; s=arc-20160816;
        b=GkswRf/SfDmK7XfEvja6SVx6XIY7q9va9c7rpDTWp92tcBD+7zVh+n/htmWs1rZL3b
         QHuusHmT0sZHPkBInxuAvD3SKGeMJusvwJX77XvO36KwlL782ScZ+A81wM53sVdfa63+
         wvH8c3YjDsM8HXqVqBI1Po02KeaFHy9voprCx2xH2fZPOYtZG2PCAIHurqH1AizP1EUo
         nQKPsp2BZXqg7dW0dC7EKPZUlcoemZxZEI5MiAvccoCN7qPru3+1PjPRtBaIKx5xVRzq
         IAxkIH5lYnlEQP+MbK0Ffi3Pvns70xSPyuudc7pAlA/IezcnCc//hwIvTzt0V9e9iV3c
         Y9YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-language
         :content-transfer-encoding:mime-version:user-agent:date:message-id
         :cc:to:subject:from:arc-authentication-results;
        bh=Q0p2guhkDYxwTemoXtDSAamIOSZeghGlNCkCNRsVWVc=;
        b=xbSpEOctYslJcJ71U3K6sxKtgN2Cs/VdjOzRS5dAGbdvcBYATvkIMtJC7yiaiFUDzK
         v8g9e/QY8TvOJQlLsKiJ8YQExMmz8O4LPHzYGcVyizmcLg88jryEHYTbv6nzIi2adsnm
         1QkdlJA1VyhlEbHXpMQVM6YlFJniS5szC8kESaAHqEVSN8YtRoWl+aUag2/0tAA31+J+
         Ja0Ldj2ZMQ56f2aC3KPpH6p8o8NrhuZCx0gufUGAZvhPDcoLvjFyCc2JbcFpBnjxxtsM
         ImSOcSSX0mVDhx63iOD2rfgNwWEzmwsIMraoGaSKksdxAUshzw7z/0O8G93mr8EoAUPn
         URGg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751371AbeCIB2Y (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 8 Mar 2018 20:28:24 -0500
Received: from mga01.intel.com ([192.55.52.88]:57638 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751148AbeCIB2X (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Mar 2018 20:28:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,443,1515484800";
   d="scan'208";a="181179966"
From: Li Zhijian <zhijianx.li@intel.com>
Subject: kernel_selftests.x86.mpx-mini-test_32.fail on skylake platform
To: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>, dave.hansen@linux.intel.com
Cc: "Li, Philip" <philip.li@intel.com>,
        Chen Rong <rongx.a.chen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Li, Zhijian" <lizhijian@cn.fujitsu.com>
Message-ID: <4edaa677-bd38-2428-960b-124615be85a6@intel.com>
Date: Fri, 9 Mar 2018 09:28:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594421573984612479?=
X-GMAIL-MSGID: =?utf-8?q?1594421573984612479?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi all

0Day noticed that kernel_selftests.x86.mpx-mini-test_32.fail at recent upstream kernel
a. v4.11 Good
b. v4.12 and later: Bad

And the 64bit application kernel_selftests.x86.mpx-mini-test_64 is always good.

0Day robot tried to bisect the FBC, but it failed at last. But anyway i want to let you know we had this issue.

below is the testing log at v4.12
-----------------------
2018-03-02 23:12:08 make run_tests -C x86
make: Entering directory '/usr/src/linux-selftests-x86_64-rhel-7.2_mpx-6f7da290413ba713f0cdd9ff1a2a9bb129ef4f6c/tools/testing/selftests/x86'
#BR status == 2, missing bounds table,kernel should have handled!!
XSAVE is supported by HW & OS
XSAVE processor supported state mask: 0x2ff
XSAVE OS supported state mask: 0x2ff
  BNDREGS: size: 64 user: 1 supervisor: 0 aligned: 0
   BNDCSR: size: 64 user: 1 supervisor: 0 aligned: 0
executing unmaptest
mpx dig (  1) complete, SUCCESS (       0 /    0)
selftests:  mpx-mini-test_32 [FAIL]
-----------------------

0Day Environment
OS: Debian 9
kernel: v4.12
model: Skylake
nr_cpu: 104
memory: 64G
brand: Intel(R) Xeon(R) Platinum 8170 CPU @ 2.10GHz

-------------------------
as a comparison, paste the log at v4.11 as following
XSAVE is supported by HW & OS
XSAVE processor supported state mask: 0x2ff
XSAVE OS supported state mask: 0x2ff
  BNDREGS: size: 64 user: 1 supervisor: 0 aligned: 0
   BNDCSR: size: 64 user: 1 supervisor: 0 aligned: 0
executing unmaptest
mpx dig (  1) complete, SUCCESS (       0 /    0)
iteration 1 complete, OK so far
mpx dig (  2) complete, SUCCESS (    8836 / 5554)
mpx dig (  3) complete, SUCCESS (    2761 / 1760)
mpx dig (  4) complete, SUCCESS (    4494 / 2828)
mpx dig (  5) complete, SUCCESS (     531 /  337)
mpx dig (  6) complete, SUCCESS (     145 /   92)
mpx dig (  7) complete, SUCCESS (       0 /    0)
mpx dig (  8) complete, SUCCESS (       0 /    0)
mpx dig (  9) complete, SUCCESS (       0 /    0)
mpx dig ( 10) complete, SUCCESS (       0 /    0)
mpx dig ( 11) complete, SUCCESS (       0 /    0)
mpx dig ( 12) complete, SUCCESS (       0 /    0)
mpx dig ( 13) complete, SUCCESS (       0 /    0)
mpx dig ( 14) complete, SUCCESS (       0 /    0)
mpx dig ( 15) complete, SUCCESS (       0 /    0)
mpx dig ( 16) complete, SUCCESS (       0 /    0)
iteration 1566 complete, OK so far
mpx dig ( 17) complete, SUCCESS (       0 /    0)
mpx dig ( 18) complete, SUCCESS (       0 /    0)
mpx dig ( 19) complete, SUCCESS (       0 /    0)
mpx dig ( 20) complete, SUCCESS (       0 /    0)
mpx dig ( 21) complete, SUCCESS (       0 /    0)
mpx dig ( 22) complete, SUCCESS (       0 /    0)
mpx dig ( 23) complete, SUCCESS (       0 /    0)
mpx dig ( 24) complete, SUCCESS (       0 /    0)
mpx dig ( 25) complete, SUCCESS (       0 /    0)
mpx dig ( 26) complete, SUCCESS (       0 /    0)
mpx dig ( 27) complete, SUCCESS (       0 /    0)
mpx dig ( 28) complete, SUCCESS (       0 /    0)
mpx dig ( 29) complete, SUCCESS (       0 /    0)
mpx dig ( 30) complete, SUCCESS (       0 /    0)
mpx dig ( 31) complete, SUCCESS (       0 /    0)
mpx dig ( 32) complete, SUCCESS (       0 /    0)
mpx dig ( 33) complete, SUCCESS (       0 /    0)
mpx dig ( 34) complete, SUCCESS (       0 /    0)
mpx dig ( 35) complete, SUCCESS (       0 /    0)
mpx dig ( 36) complete, SUCCESS (       0 /    0)
mpx dig ( 37) complete, SUCCESS (       0 /    0)
mpx dig ( 38) complete, SUCCESS (       0 /    0)
mpx dig ( 39) complete, SUCCESS (       0 /    0)
mpx dig ( 40) complete, SUCCESS (       0 /    0)
iteration 3325 complete, OK so far
done with malloc() fun
starting mpx bounds table test
iteration 4574 complete, OK so far
iteration 9157 complete, OK so far
done with mpx bounds table test
./mpx-mini-test_32 completed successfully
selftests: mpx-mini-test_32 [PASS]


Thanks

