Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932535AbeCLUwi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 16:52:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:48157 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932387AbeCLUwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 16:52:37 -0400
Date: Mon, 12 Mar 2018 20:52:35 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 5/6] ipc: Clamp semmni to the real IPCMNI limit
Message-ID: <20180312205235.GB4449@wotan.suse.de>
References: <1520885744-1546-1-git-send-email-longman@redhat.com>
 <1520885744-1546-6-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520885744-1546-6-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 04:15:43PM -0400, Waiman Long wrote:
> +	if (clamped)
> +		pr_warn_once("sysctl: \"sem[3]\" was set out of range [%d, %d], clamped to %d.\n",
> +			     0, IPCMNI, ns->sc_semmni);

Why warn if the kernel already does that? If we can avoid more code on
drivers the better.

  Luis
