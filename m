Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966073AbeE2SJK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:09:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47268 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966047AbeE2SJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:09:05 -0400
Date: Tue, 29 May 2018 14:09:03 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Colin King <colin.king@canonical.com>
Cc: Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] dm writecache: fix missing goto in error handling
 code
Message-ID: <20180529180903.GB32763@redhat.com>
References: <20180527222512.25280-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180527222512.25280-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 27 2018 at  6:25pm -0400,
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently, the -EFBIG error condition when n_bitmaps_bits is
> too large is falling through to the next statement and the
> error assignment to r is potentially being ignored.  The code
> should be exiting to the error path via label 'bad'. Fix
> this by adding the missing goto statement.
> 
> Detected by CoverityScan, CID#1469377 ("Unused value")
> 
> Fixes: bb15b431d650 ("dm: add writecache target")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks, I've picked this up.
