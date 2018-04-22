Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2651967-1524406910-8-5261846103764434825
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enfrro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524406910; b=AVmvNYfi6KJtYeQA9yvToK9biMUZdDlN/zy7QrIfMNl4YGWreB
    i3bvDs4SV8IMQe7EZQEtHoxS0TfVz9JvJBfr1fu4RSmvkJzzkO0YqnKFHdAXltgv
    ePxG43wSZc0V2Nc2FU7jZwv+YTGiSKZye2OBHQBxwTtmxOmagSX3D6beQuEBzYyB
    QqsgT39sqqM7tAz4pzvEF1mnYjgZOEpjA7xCsMihpfUKgWh1Deg2ofsXe5t92GB5
    /RMYZENwI/CoOnyvK2/pI0P8Z3OENXMqRYFr2q+O2fcAJzKN9seR5mdCbeGAlWM7
    9xDOXRe75VEHOsGUUdAY6NKmskxxcVSm2ASA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406910; bh=2q/eBLDsTKLT76xBZm3K9VuJj/7wUN
    lTXB9EtiYK5WU=; b=YtiZbCyYzilTjZuxMStfg73NyjQD5u0N/0UsniQP8ThRzv
    0d7/A8PlPoLiN/vDcqmxuomjw0pIdM+zK0Uyq442ZldzhAAschRG4lav6p8ngdhE
    kAuPxUFgw6qGTIE9WpTi16CvMMehjI9kNbx2PH69fU93qNf6mHz748x3u0w81Wfb
    Brp5edcaLkN8ic6DsYkDhkN9uDdTom3dE03qgrLMMclDI4cHVF/v5zaSt0D6hJiX
    8Op/zux2Y96KJsh14Ztg16k2gyyHH+y+7u05xDbNDSozOBfnjbvNGv28bDwYhFst
    tCs0MIvmUYQaLw8DlyqtTibFPlyih8w3yHOzHhIg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfBcOLZqjADmh/jHVYxBKa4cbH2+MS/mXag48AWhx0YsNpQtcAYKV/wRFIzEVgyc0h0jJqq9vTeJCPjZO+H+kOkcug7+MC5U+XL+akmEP/RJOWlouWQ7b
    a1iJfssX/eKR90WAV3VBlJN3qD0/uJKZ6SlRRzmgLUfVsxbE7pvrOurMeJMvXWNn1tIIQZt8mmteBcmWpsgMeHcdZgWawwKYErs0la9y8GNBx02tV/I9HtzL
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=drOt6m5kAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=SGWSbA6nldhbN5OcOtoA:9
    a=glA3qBdtw17n8kDT:21 a=xAZLZ00CKbJvsoW8:21 a=QEXdDO2ut3YA:10
    a=RMMjzBEyIzXRtoq5n5K6:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757444AbeDVOVs (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:21:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33038 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756330AbeDVOVp (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:21:45 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 3.18 47/52] jffs2_kill_sb(): deal with failed allocations
Date: Sun, 22 Apr 2018 15:54:20 +0200
Message-Id: <20180422135317.515847428@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
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

From: Al Viro <viro@zeniv.linux.org.uk>

commit c66b23c2840446a82c389e4cb1a12eb2a71fa2e4 upstream.

jffs2_fill_super() might fail to allocate jffs2_sb_info;
jffs2_kill_sb() must survive that.

Cc: stable@kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/jffs2/super.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -345,7 +345,7 @@ static void jffs2_put_super (struct supe
 static void jffs2_kill_sb(struct super_block *sb)
 {
 	struct jffs2_sb_info *c = JFFS2_SB_INFO(sb);
-	if (!(sb->s_flags & MS_RDONLY))
+	if (c && !(sb->s_flags & MS_RDONLY))
 		jffs2_stop_garbage_collect_thread(c);
 	kill_mtd_super(sb);
 	kfree(c);
