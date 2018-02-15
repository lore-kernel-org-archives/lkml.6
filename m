Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164516AbeBOXRV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 18:17:21 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:40648 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163785AbeBOXRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 18:17:19 -0500
X-Google-Smtp-Source: AH8x224RsgrP07c7Q5qhZGtpfvLdBeQbU5NWeoZxUenrpMGio2DPXWB5/BnqasDEtLkwfcEyWE4lPg==
Date: Thu, 15 Feb 2018 17:17:14 -0600
From: Dennis Zhou <dennisszhou@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>,
        Daniel Borkmann <daniel@iogearbox.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] percpu: allow select gfp to be passed to underlying
 allocators
Message-ID: <20180215231714.GB79973@localhost>
References: <cover.1518668149.git.dennisszhou@gmail.com>
 <a166972c727e3a1235a7ad17b9df94ca407a1548.1518668149.git.dennisszhou@gmail.com>
 <20180215214148.GV695913@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215214148.GV695913@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 15, 2018 at 01:41:48PM -0800, Tejun Heo wrote:
> On Thu, Feb 15, 2018 at 10:08:16AM -0600, Dennis Zhou wrote:
> > +/* the whitelisted flags that can be passed to the backing allocators */
> > +#define gfp_percpu_mask(gfp) (((gfp) & (__GFP_NORETRY | __GFP_NOWARN)) | \
> > +			      GFP_KERNEL)
> 
> Isn't there just one place where gfp comes in from outside?  If so,
> this looks like a bit of overkill.  Can't we just filter there?
> 

I agree, but it's also nice having a single place where flags can be
added or removed. The primary motivator was for the "| GFP_KERNEL", but
as suggested in the other patch this is getting removed. I guess I still
lean towards having it as it's explicit and helps gate both the balance
path and the user allocation path.

Thanks,
Dennis
