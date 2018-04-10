Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752073AbeDJUyc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 16:54:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43062 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbeDJUyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 16:54:31 -0400
Date: Tue, 10 Apr 2018 13:54:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org, pbonzini@redhat.com,
        liliang.opensource@gmail.com, yang.zhang.wz@gmail.com,
        quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com,
        huangzhichao@huawei.com
Subject: Re: [PATCH v29 1/4] mm: support reporting free page blocks
Message-Id: <20180410135429.d1aeeb91d7f2754ffe7fb80e@linux-foundation.org>
In-Reply-To: <20180410211719-mutt-send-email-mst@kernel.org>
References: <1522031994-7246-1-git-send-email-wei.w.wang@intel.com>
        <1522031994-7246-2-git-send-email-wei.w.wang@intel.com>
        <20180326142254.c4129c3a54ade686ee2a5e21@linux-foundation.org>
        <20180410211719-mutt-send-email-mst@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2018 21:19:31 +0300 "Michael S. Tsirkin" <mst@redhat.com> wrote:

> 
> Andrew, were your questions answered? If yes could I bother you for an ack on this?
> 

Still not very happy that readers are told that "this function may
sleep" when it clearly doesn't do so.  If we wish to be able to change
it to sleep in the future then that should be mentioned.  And even put a
might_sleep() in there, to catch people who didn't read the comments...

Otherwise it looks OK.
