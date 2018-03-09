Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751170AbeCIHH7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 02:07:59 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:1261 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750880AbeCIHH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 02:07:58 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="37660501"
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: irqdesc: Why the "__ref" is needed in __irq_alloc_descs() ?
To: Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, <re.emese@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>
CC: <linux-kernel@vger.kernel.org>
Message-ID: <9246951e-9cf5-6a3f-5cf4-2d3aaff03026@cn.fujitsu.com>
Date: Fri, 9 Mar 2018 15:07:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 4E4334D0EFF4.AA5DF
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maintainers,

I have a question about "__ref" in Linux kernel.

When I looked into the __irq_alloc_descs(), I found it tagged a
"__ref" mark, but I didn't find that it referenced code or data
from init section.

So, I confuse why the "__ref"  is needed in __irq_alloc_descs()?
any other reasons?

And after I tested, seems "__ref" just puts the code into a different
section that is not checked by modpost. It does not affect the
performance whether it is tagged or not. Is it right?

Thanks,
	dou.
