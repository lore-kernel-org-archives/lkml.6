Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751034AbeBIHWL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 02:22:11 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:36245 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750778AbeBIHWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 02:22:10 -0500
Subject: Re: [V9fs-developer] [RFC] we should solve create-unlink-getattr
 idiom
To: jiangyiwen <jiangyiwen@huawei.com>,
        Eric Van Hensbergen <ericvh@gmail.com>, Greg Kurz <groug@kaod.org>,
        <v9fs-developer@lists.sourceforge.net>, <qemu-devel@nongnu.org>
CC: <aneesh.kumar@linux.vnet.ibm.com>, Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <5A7D4976.6060407@huawei.com>
From: Veaceslav Falico <veaceslav.falico@huawei.com>
Message-ID: <a1ef7be5-d368-fe31-4386-1d40762b5849@huawei.com>
Date: Fri, 9 Feb 2018 08:21:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <5A7D4976.6060407@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.204.62.163]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yiwen, all,

On 2/9/2018 8:10 AM, jiangyiwen wrote:
> Hi Eric and Greg,
> 
> I encountered the similar problem with create-unlink-getattr idiom.
> I use the testcase that create-unlink-setattr idiom, and I see the
> bug is reported at https://bugs.launchpad.net/qemu/+bug/1336794.
> Then I also see you already fix the issue and push the patch to upstream.
> https://github.com/ericvh/linux/commit/eaf70223eac094291169f5a6de580351890162a2
> http://patchwork.ozlabs.org/patch/626194/
> 
> Unfortunately, the two patches are not merged into master, I don't know
> the reason, so I suggest if the patche can be merged into master, and
> it will solve the create-unlink-getattr idiom.

As a follow up - the create-unlink-setattr (mainly ftruncate and anything
else which works on fd instead of path) isn't fixed by these patches, but
I'm currently working on a new patch, obviously on top of those two, to
make the setattr work too.

It's based on the same logic as the above patches though - use FIDs with
open fd's guest side and use open fd's host side if possible with f*
functions, otherwise path with l* functions.

It's bigger than the QEMU getattr patch, as there are no f* functions
available for ftruncate case, for example.

So if those two patches could be merged it'd be a lot easier to then
go forward with the setattr fix.

Thank you!

> 
> Thanks,
> Yiwen
> 
> .
> 
