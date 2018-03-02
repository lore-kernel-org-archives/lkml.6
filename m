Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2738277-1520031136-2-5978192732442332101
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520031136; b=WBZ2Rxm9wA5G82f10uvTIjaNpQ/Wi8oA7Bd7ffUaQtlbEfu
    rr9RvmgfXIApRn9mWA3SJA/XE+4dmq1TQLHtHXGN50P+0Irg37tQOQk5WfRGavWd
    GFkk7QJg5wzF+o5eQClK1KiGIse6GGtXgZ3xnpuh2dScS1pq8OArq9z5srcTEN0C
    Yhe9aB+VvptMa7S9COvergsOswWTVCi7aLDhxJOaqsu1FvOeKMY3ssDRHAFd49nt
    nh3yY7e/1+wGBchxSRly1RPbiBO+n3XHmqSEHxbozQnqNI64vmkxH7ktv/9JLVEu
    W8zqNkgTY5S76upwCfACunHhEedqSAZpn6c/MvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520031136; bh=l2WBiCb5duYJRA9nKpihqrJOH1
    Qjg6utSrFiu8qAdtc=; b=SPm8N7WKlnWUSNvM+C+wSYHDYced1/pkYKaFTHfwBF
    0ds8zVVBsWJ0wsfOosu0uLBwRHbYrPEU/iO6Ps8RDhxxcHVdLTenQw/Yx5FhEFpA
    LtkKDUUw4vp2OW/JmpsHKRDw0ts1BEsDXLGE5xwvtvNzUem0B8KuAPxuq271DX3v
    WOYhhdd8KTKpaXfCcFHEOXHZESdWSUu5hJvmhA9NW+urMk97Ax9beZtjo8CRm7bp
    v7dgX4ZROKWYtuqDxf19UbWGAKewX/nEXuwmC0e0n2D2JI3v4w9I5GgOk92dA+06
    12omVK2ly3u1Dwj0XGUcBtVBX+7bMvykKkJM/c15Kfkg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933838AbeCBWwN (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 17:52:13 -0500
Received: from verein.lst.de ([213.95.11.211]:38330 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933561AbeCBWwM (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 2 Mar 2018 17:52:12 -0500
Date: Fri, 2 Mar 2018 23:52:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, stable@vger.kernel.org,
        Gerd Rausch <gerd.rausch@oracle.com>,
        Jane Chu <jane.chu@oracle.com>,
        Haozhong Zhang <haozhong.zhang@intel.com>,
        Jan Kara <jack@suse.cz>, linux-xfs@vger.kernel.org, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/12] dax: fix vma_is_fsdax() helper
Message-ID: <20180302225210.GB31240@lst.de>
References: <151996281307.28483.12343847096989509127.stgit@dwillia2-desk3.amr.corp.intel.com> <151996281881.28483.2616406435517031167.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151996281881.28483.2616406435517031167.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
