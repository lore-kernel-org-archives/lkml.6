Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751019AbeDNHzu (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 03:55:50 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54648 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbeDNHzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 03:55:49 -0400
Date: Sat, 14 Apr 2018 08:55:45 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Zev Weiss <zev@bewilderbeest.net>
Cc: "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: avoid fdput() after failed fdget() in
 vfs_dedupe_file_range()
Message-ID: <20180414075544.GU30522@ZenIV.linux.org.uk>
References: <20180414061658.3774-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180414061658.3774-1-zev@bewilderbeest.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 14, 2018 at 01:16:58AM -0500, Zev Weiss wrote:
> It's a fairly inconsequential bug, since fdput() won't actually try to
> fput() the file due to fd.flags (and thus FDPUT_FPUT) being zero in
> the failure case, but most other vfs code takes steps to avoid this.

Applied.
