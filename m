Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751058AbeBPV6x (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 16:58:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51528 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbeBPV6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 16:58:50 -0500
Date: Fri, 16 Feb 2018 13:58:48 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, mhocko@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>, david@redhat.com,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cornelia.huck@de.ibm.com, mgorman@techsingularity.net,
        aarcange@redhat.com, amit.shah@redhat.com,
        Paolo Bonzini <pbonzini@redhat.com>, liliang.opensource@gmail.com,
        yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com,
        riel@redhat.com
Subject: Re: [PATCH v21 1/5] xbitmap: Introduce xbitmap
Message-ID: <20180216215848.GB32655@bombadil.infradead.org>
References: <1515496262-7533-1-git-send-email-wei.w.wang@intel.com>
 <1515496262-7533-2-git-send-email-wei.w.wang@intel.com>
 <CAHp75Ve-1-TOVJUZ4anhwkkeq-RhpSg3EmN3N0r09rj6sFrQZQ@mail.gmail.com>
 <20180216183032.GA7439@bombadil.infradead.org>
 <CAHp75Vd_tt0bV_OqAOwc=_uWrsF2zP9pMSbxPw_AxF_s9zj-pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vd_tt0bV_OqAOwc=_uWrsF2zP9pMSbxPw_AxF_s9zj-pw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 11:45:51PM +0200, Andy Shevchenko wrote:
> Now, the question about test case. Why do you heavily use BUG_ON?
> Isn't resulting statistics enough?

No.  If any of those tests fail, we want to stop dead.  They'll lead to
horrendous bugs throughout the kernel if they're wrong.  I think more of
the in-kernel test suite should stop dead instead of printing a warning.
Would you want to boot a machine which has a known bug in the page cache,
for example?
