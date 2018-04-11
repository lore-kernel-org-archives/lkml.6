Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3374234-1523481569-2-9412377686957022240
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523481568; b=SBRLMUGZR/M+WgjkWQ3rhHqI4AYGAsijSeoi+ziBqcKMIEdv2c
    RJinKii9CpOqrfy8P9cCp5uhHqfxHHkwiHqBxFBZyf0uHC641KBcOw8/pWtL7QTI
    Xb8nfMMbOJ6AbAm3MQZRxUoGyCXWK8eeC2ms4M0T9vbPL/tRj7Libcc24HajRSpc
    sMn85pI9VA6Ldvmb7t+Ny0GA0iEod+ZL4JeIaVMXu5Up3oP6yWzxBJLV/moojEhS
    jTzXL0VwMvZ4ud+eZ2osRM7jTci4OHc3dEqK6uaZsK2S5GdThN1i1zKNzup4LbV5
    QW39epUA7D10vfWIWm+omDXq1d7/Atjnh9pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481568; bh=wHAfLuQukyyZdhcC6ygfxh09gxrRMb
    hT1c6Qx2ogr38=; b=PKWY/vE+SkOM9CRv1g6TMvnoMLD+ZFay/4eMHeYioj9if2
    NU4p2b94MyIvPtJiRnMpieh/N3L2Bdf1KhTX8dRh7xeJeDXg7SZiaPTaYcqFWzwK
    FLRbqQSdXthDigEjJQdWb0J5TFMhshAtpGEhB8e9khP7NlyA30BTqIyE8X+Ud/Uo
    8VBRDBJJiVLWYgXhnZ7AABpLcvQmtdhw+0d26VsTwrQoPQgVzPhPyhJ256YhEHw3
    uFOk1/9t5WSUsghk7EeSd3ITj0NX3GsvwFhS4C81J9XhIdPuE4Rppyr6xfushpLl
    9kW3btEvx6kN3/if7okyJv2Wa7SXr1p5D7ypP90A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBRL87inQjbOyVLmN7PBKX8Mgt5oOg9xRijy0uQKmp9DYtF9DLD5MVPj/FJDHzC4Gommp1zzoBUKyWrEfzL4kG1wkyoy5bobadjCdpdG828VJY5FWMjh
    YQfD86YA/1L0rOAcrD53d8pUls9R3ILd3l2wWQpS+J0WOOgN9vHzC/Kq9Jh7v8vwh55oryIG0SPbDBaq71IBR7HNk5qNo0t94NrQcXvN7NBJ6+umY6tVW/lZ
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=ULtGjE2pG87AcrYebtMA:9
    a=pT9xsN5DhCHNDBuW:21 a=FGrdD5REwOa6q-Dz:21 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753317AbeDKSjn (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:39:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56138 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754467AbeDKSjj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:39:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eryu Guan <eguan@redhat.com>,
        Theodore Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 044/121] ext4: fix off-by-one on max nr_pages in ext4_find_unwritten_pgoff()
Date: Wed, 11 Apr 2018 20:35:47 +0200
Message-Id: <20180411183459.077393849@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eryu Guan <eguan@redhat.com>


[ Upstream commit 624327f8794704c5066b11a52f9da6a09dce7f9a ]

ext4_find_unwritten_pgoff() is used to search for offset of hole or
data in page range [index, end] (both inclusive), and the max number
of pages to search should be at least one, if end == index.
Otherwise the only page is missed and no hole or data is found,
which is not correct.

When block size is smaller than page size, this can be demonstrated
by preallocating a file with size smaller than page size and writing
data to the last block. E.g. run this xfs_io command on a 1k block
size ext4 on x86_64 host.

  # xfs_io -fc "falloc 0 3k" -c "pwrite 2k 1k" \
  	    -c "seek -d 0" /mnt/ext4/testfile
  wrote 1024/1024 bytes at offset 2048
  1 KiB, 1 ops; 0.0000 sec (42.459 MiB/sec and 43478.2609 ops/sec)
  Whence  Result
  DATA    EOF

Data at offset 2k was missed, and lseek(2) returned ENXIO.

This is unconvered by generic/285 subtest 07 and 08 on ppc64 host,
where pagesize is 64k. Because a recent change to generic/285
reduced the preallocated file size to smaller than 64k.

Signed-off-by: Eryu Guan <eguan@redhat.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -300,7 +300,7 @@ static int ext4_find_unwritten_pgoff(str
 		int i, num;
 		unsigned long nr_pages;
 
-		num = min_t(pgoff_t, end - index, PAGEVEC_SIZE);
+		num = min_t(pgoff_t, end - index, PAGEVEC_SIZE - 1) + 1;
 		nr_pages = pagevec_lookup(&pvec, inode->i_mapping, index,
 					  (pgoff_t)num);
 		if (nr_pages == 0)
