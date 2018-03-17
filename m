Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751911AbeCQKBz (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 06:01:55 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:7232 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751278AbeCQKBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 06:01:54 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="37901402"
To: <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Subject: questions about header.S
Message-ID: <ac02a918-0c7a-2376-569d-c53a87bc1a42@cn.fujitsu.com>
Date: Sat, 17 Mar 2018 18:01:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: EA9624D0EFCD.AA767
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  I find two small questions which confuse me a little.

1.
# Check signature at end of setup
       cmpl    $0x5a5aaa55, setup_sig
       jne     setup_bad

setup_sig is defined in setup.ld, which points to the constant also
defined in setup.ld, so I don't figure out in which case they don't
equal and jump to setup_bad?

In my test, drop these 2 lines seems fine, system can boot without any
obvious error.

2.
# Zero the bss
	movw	$__bss_start, %di
	movw	$_end+3, %cx
	xorl	%eax, %eax
	subw	%di, %cx
	shrw	$2, %cx
	rep; stosl

It is not a big deal, but I think replace "_end" with "__bss_end" make
more sense, and "_end" is already aligned to word length. And, there is
no other code use symbol "__bss_end". So I don't know is there any
reason to use "_end" here?

In my test, replace the 2nd line with:

	movw	$_end, %cx

or:

	movw	$__bss_end+3, %cx

are both fine.

-- 
Sincerely,
Cao jin
