Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEB0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5420F20874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733291AbeLQUuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 15:50:10 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50240 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbeLQUuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 15:50:09 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E0389AF7;
        Mon, 17 Dec 2018 20:50:08 +0000 (UTC)
Date:   Mon, 17 Dec 2018 12:50:01 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        linux-sctp@vger.kernel.org
Subject: Re: [PATCH 6/7] sctp: Convert to genradix
Message-Id: <20181217125001.8e89ac2565417d55ef7a624e@linux-foundation.org>
In-Reply-To: <20181217131929.11727-7-kent.overstreet@gmail.com>
References: <20181217131929.11727-1-kent.overstreet@gmail.com>
        <20181217131929.11727-7-kent.overstreet@gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 08:19:28 -0500 Kent Overstreet <kent.overstreet@gmail.com> wrote:

> @@ -535,9 +470,6 @@ int sctp_send_add_streams(struct sctp_association *asoc,
>  		goto out;
>  	}
>  
> -	stream->incnt = incnt;
> -	stream->outcnt = outcnt;
> -
>  	asoc->strreset_outstanding = !!out + !!in;
>  

I'm seeing a reject here for some reason.  Using todays's linux-next,
but there are no changes against net/sctp/stream.c in -next.  The
assignment to stream->incnt has disappeared.  I did this:

@@ -535,8 +470,6 @@ int sctp_send_add_streams(struct sctp_as
 		goto out;
 	}
 
-	stream->outcnt = outcnt;
-
 	asoc->strreset_outstanding = !!out + !!in;
 
 out:


We're at 4.20-rc7 and this series is rather large.  I'll merge them all
to see what happens, but I don't think it's 4.21-rc1 material?
