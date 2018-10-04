Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5535FC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DCB20652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21DCB20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeJDV6n convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 17:58:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727375AbeJDV6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 17:58:43 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AC4D7308FB8A;
        Thu,  4 Oct 2018 15:05:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FBC93091322;
        Thu,  4 Oct 2018 15:05:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20180928180048.14259-1-amir73il@gmail.com>
References: <20180928180048.14259-1-amir73il@gmail.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     dhowells@redhat.com, Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Jan Harkes <jaharkes@cs.cmu.edu>, Mark Fasheh <mark@fasheh.com>
Subject: Re: [PATCH] fs: fix access beyond unterminated strings in prints
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32346.1538665500.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Thu, 04 Oct 2018 16:05:00 +0100
Message-ID: <32347.1538665500@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 04 Oct 2018 15:05:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> wrote:

> @@ -47,7 +47,7 @@ static struct dentry *coda_lookup(struct inode *dir, struct dentry *entry, unsig
>  	int type = 0;
>  
>  	if (length > CODA_MAXNAMLEN) {
> -		pr_err("name too long: lookup, %s (%*s)\n",
> +		pr_err("name too long: lookup, %s (%.*s)\n",

Use %pd instead?

David
