Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6FFC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8152921736
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8152921736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732442AbeHCQxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 12:53:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726115AbeHCQxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 12:53:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4E3BA7DAC3;
        Fri,  3 Aug 2018 14:56:34 +0000 (UTC)
Received: from redhat.com (ovpn-120-99.rdu2.redhat.com [10.10.120.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E75502026D65;
        Fri,  3 Aug 2018 14:56:33 +0000 (UTC)
Date:   Fri, 3 Aug 2018 09:56:32 -0500
From:   Bill O'Donnell <billodo@redhat.com>
To:     Thomas Bianchi <thomas.bianchi8@gmail.com>
Cc:     linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: substitute spaces with tabs
Message-ID: <20180803145632.GB20657@redhat.com>
References: <1533140611-23467-1-git-send-email-thomas.bianchi8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533140611-23467-1-git-send-email-thomas.bianchi8@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 03 Aug 2018 14:56:34 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 03 Aug 2018 14:56:34 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'billodo@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 06:22:25PM +0200, Thomas Bianchi wrote:
> Inside xfs_attr_shortform_list removes spaces at the beginnig of the line
> and replaces with tabs.
> Issue found by checkpatch.
> 
> ERROR: code indent should use tabs where possible
> 
> Signed-off-by: Thomas Bianchi <thomas.bianchi8@gmail.com>
> ---
looks fine.
Reviewed-by: Bill O'Donnell <billodo@redhat.com>

>  fs/xfs/xfs_attr_list.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_attr_list.c b/fs/xfs/xfs_attr_list.c
> index f9ca801..a580340 100644
> --- a/fs/xfs/xfs_attr_list.c
> +++ b/fs/xfs/xfs_attr_list.c
> @@ -87,7 +87,7 @@
>  	 */
>  	if (context->bufsize == 0 ||
>  	    (XFS_ISRESET_CURSOR(cursor) &&
> -             (dp->i_afp->if_bytes + sf->hdr.count * 16) < context->bufsize)) {
> +	     (dp->i_afp->if_bytes + sf->hdr.count * 16) < context->bufsize)) {
>  		for (i = 0, sfe = &sf->list[0]; i < sf->hdr.count; i++) {
>  			context->put_listent(context,
>  					     sfe->flags,
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-xfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
