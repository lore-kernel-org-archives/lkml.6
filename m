Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751502AbeEVIkN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 04:40:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:37989 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750733AbeEVIkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 04:40:09 -0400
Date: Tue, 22 May 2018 10:40:06 +0200
From: Jan Kara <jack@suse.cz>
To: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Cc: viro@ZenIV.linux.org.uk, jra@google.com, tytso@mit.edu, olaf@sgi.com,
        darrick.wong@oracle.com, kernel@lists.collabora.co.uk,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com, jack@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/15] nls: Wrap uni2char/char2uni callers
Message-ID: <20180522084006.rlxtmmmzv3z5rtny@quack2.suse.cz>
References: <20180521173617.31625-1-krisman@collabora.co.uk>
 <20180521173617.31625-2-krisman@collabora.co.uk>
 <20180522083753.sphuqufm5edg7dja@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522083753.sphuqufm5edg7dja@quack2.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-05-18 10:37:53, Jan Kara wrote:
> On Mon 21-05-18 14:36:03, Gabriel Krisman Bertazi wrote:
> > Generated with the following coccinele script:
> > 
> > <smpl>
> > 
> > @@
> > expression A, B, C, D;
> > @@
> > (
> > - A->uni2char(B, C, D)
> > + nls_uni2char(A, B, C, D)
> > |
> > - A->char2uni(B, C, D)
> > + nls_char2uni(A, B, C, D)
> > )
> > 
> > </smpl>
> > 
> > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
> 
> fs/udf/unicode.c also uses char2uni and uni2char but evades your SMPL
> patch. So you'll need to fix that up manually. Also note that I have some
> changes to that area queued in my tree.

Ah, OK, now I see that you've handled that in patch 3. Sorry for the noise.

> 
> 								Honza
> 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
