Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E70C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 00:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7320E20859
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 00:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7320E20859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbeJNHuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 03:50:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48358 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbeJNHuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 03:50:03 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 77C5EC05D3FF;
        Sun, 14 Oct 2018 00:11:06 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-200-28.brq.redhat.com [10.40.200.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E93F95EB18;
        Sun, 14 Oct 2018 00:11:04 +0000 (UTC)
Date:   Sun, 14 Oct 2018 02:11:26 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     tbhardwa@codeaurora.org
Cc:     "'Zhang, Ning A'" <ning.a.zhang@intel.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: question about V4L2_MEMORY_USERPTR on 64bit applications
Message-ID: <20181014001126.GA717@asgard.redhat.com>
References: <1539313441.21249.3.camel@intel.com>
 <1539318782.21249.7.camel@intel.com>
 <000601d461eb$a1f7afc0$e5e70f40$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000601d461eb$a1f7afc0$e5e70f40$@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Sun, 14 Oct 2018 00:11:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 10:52:51AM +0530, tbhardwa@codeaurora.org wrote:
> (in 64 bit userspace long is 32-bit)

Not on Linux.

$ cat /tmp/c.c
int main(void)
{
        return sizeof(long);
}
$ gcc /tmp/c.c
$ ./a.out; echo $?
8
$ file ./a.out
./a.out: ELF 64-bit LSB pie executable, 64-bit PowerPC or cisco 7500, version 1 (SYSV), dynamically linked, interpreter /lib64/ld64.so.2, for GNU/Linux 3.10.0, BuildID[sha1]=dad78822e741b7900dc7568222822d5d63c31a6c, not stripped
