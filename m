Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524406222-2-1993129200959303186
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524406221; b=FKb02ppEyGB4CUAxb942BeRpAWGAzWRq7JLoRYmOGHEccsn45a
    4sjue2lxkBhtZWmc+QE1gBCvQQ//9zzKZc2kb0Db+FClYfxBWUlKfyeqF785dxqh
    AmXX2+7S39qx48407xEGBn/UhcRrL8O89s49D/pBUqFUPBpBlkvo6cgt9XFwquFi
    cMLcAOBjD1ZjP1PLCH/VrhI2ISYHMMwIKTpfpC+2AaBYuJ7JuiLW/rsloTOxMaV0
    W5DnA+i/c1QkIlYsK99J8G6ZtlsP9dbkmSANqTXvEKZpTTeXlJYKdDLEgzLsNGg1
    xiUTeAc+BQotMVmp87pQD0aIB0lnH8MQWwlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406221; bh=XBf4bMbUWratyZ82RkYjt9SS9KeEFV
    LCjFQCdv7YZ34=; b=S3OLJEPB1xFiB4otYQEi5EV2VjQIVyP6Zp7m0bXU6KzE/M
    W3FCWDz6c3jumohrYEjugLupqZxnsWsQE7k7fMNiSVLEHTyPm1FyeG6UkTkx35op
    50A+MChWob9td6dQwpi33J25KwsF3dG/Tv2bHIkRa7ir+w58Kung+MBcJqK5jjKF
    9UO5iWjrp+XaseUFB84UXYvjIbOAzKL8iahNoY6Obe2mIxidvv8LLegrYe2sX4QE
    LAz3JUFzIAiZfBMOLZ6/PflBwOd8z/IxAFZvmWCA3NqcS07xBWMZLEzY6J+apqK0
    maQ6EBkmDKu8EeVZMxJufFD/pSVA3CjyGYuDzY5w==
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
X-CM-Envelope: MS4wfJxvG53lILhdKkegLtAygXAqVHgqfBbU+hn5VYdGWFB+/tMAa0HZPw3/uOO39jp6UiRhkFXTHjt8H8Wp7RvX3Gx5fGokoQhHnWxxm89n+OEwlZo8bXn6
    mEpp93R3Zh3AD54r8yzwnYWwvhBpH3rZ6FZSCY/+UYlzMB/QdEDWvmUqVBNedFH9qg1aEJaah4MNXFyKs3UG690dnhEaY8GnUAwoR+MRYRsFa14ZS7epc8Jy
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=drOt6m5kAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=SGWSbA6nldhbN5OcOtoA:9
    a=NIIDW_Qnw_dbgW3w:21 a=9cxVNZlX9-ipTlGC:21 a=QEXdDO2ut3YA:10
    a=RMMjzBEyIzXRtoq5n5K6:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756005AbeDVOKP (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:10:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53596 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753596AbeDVOKK (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:10:10 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.14 153/164] hypfs_kill_super(): deal with failed allocations
Date: Sun, 22 Apr 2018 15:53:40 +0200
Message-Id: <20180422135141.830166483@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit a24cd490739586a7d2da3549a1844e1d7c4f4fc4 upstream.

hypfs_fill_super() might fail to allocate sbi; hypfs_kill_super()
should not oops on that.

Cc: stable@vger.kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/hypfs/inode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -320,7 +320,7 @@ static void hypfs_kill_super(struct supe
 
 	if (sb->s_root)
 		hypfs_delete_tree(sb->s_root);
-	if (sb_info->update_file)
+	if (sb_info && sb_info->update_file)
 		hypfs_remove(sb_info->update_file);
 	kfree(sb->s_fs_info);
 	sb->s_fs_info = NULL;
