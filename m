Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339499-1523480087-2-6717018396695187484
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
    1523480086; b=fnGNtVKJMRYEfIeLTxOwp4OjyzlyK2N4LSHnfcLRO/DU8UAM1E
    jCqjLifgaJQfUiu5V+Slj0eTf4aj7SwzBQVl9017f9Sx7YeVsPUXWpmwUOFnhNAl
    R+aYPB5kpJwrDjwMKjh5XBjfyIRFWLeGzHdLcfgLUN/TRoKIbxk7VfaPLxI9fVJ8
    jyzcRKvY0YqjpUno2wCVnvhoX3af29t21eCCzrWSrcihKkJrmCO0s6bNMjDTFD8a
    OpseI9RhA0NpwlbNXVUnL98VldnH9/kJ5IwmNRZcMv+ZUpTyOIRymPNfzLBY/wEo
    fojf7xTnyJEaDIxT+7kBSDuGYY9H4HQpJ9ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523480086; bh=ExXYLhIIT+yDY50XQIqLT1A/9pxG3B
    Ul3xlqZ2kow+8=; b=WmFVyHg7hiMwj8Wi2sqfWRx0xebW554CExbMpKhNQ6afO8
    TL/sqiWiRXPn9+B/aRIeCnj1NCYzpNEZuDixDS666fz55POmFw1eX5+YR1P2r3Ko
    nN8T3lba00tetRWDO80vL0oL4tqeC2fD4Ol88k1Ht1ZtgBR7gEYvFhp7fl5yQ6hI
    LlQpEvp/lpAGCSHd7haDD/UP2XqIaxYBloz8X/DEbdf5UjfOoCR+I2LhDmn+jj9o
    C6OITvxwwK+2RGP+z/JB693uHA+gfFG4mzW42o+Xuiw2ibRQynJR2BBTCTvfANMy
    D/yUrXKQOvImlLtTYpsjtLWpDtMesjxX199kdGrQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfFcuYdbPMyj2gKzWG9ylLOXixTTyYQ3kdkdxXspA+GE6ts33tbwymp8NbZihM630aNJm0muGLG3IyvVu+NyfbPgVwHQxk+LidGTNkLNLZANmLTdnC11o
    FzZKO9yszoYUlwMjXF7ZVC2zAU6WGHPRKwhzwuE3wQKBmpeS9vcWK7Z1qGGRR9V/rA7Se+Mu8jqS9LqdOQRuh1iUpbdNDZYMKb3GWNsQWOdPmdcSq7tiyR7t
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=DfNHnWVPAAAA:8 a=yPCof4ZbAAAA:8 a=iox4zFpeAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=as_2-ZBmz6qe2MDftmcA:9 a=QEXdDO2ut3YA:10
    a=rjTVMONInIDnV1a_A2c_:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755887AbeDKUya (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:54:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58466 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932287AbeDKSpE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:45:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Liu Bo <bo.li.liu@oracle.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 039/190] btrfs: fix incorrect error return ret being passed to mapping_set_error
Date: Wed, 11 Apr 2018 20:34:45 +0200
Message-Id: <20180411183552.435466214@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>


[ Upstream commit bff5baf8aa37a97293725a16c03f49872249c07e ]

The setting of return code ret should be based on the error code
passed into function end_extent_writepage and not on ret. Thanks
to Liu Bo for spotting this mistake in the original fix I submitted.

Detected by CoverityScan, CID#1414312 ("Logically dead code")

Fixes: 5dca6eea91653e ("Btrfs: mark mapping with error flag to report errors to userspace")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Liu Bo <bo.li.liu@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/extent_io.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2534,7 +2534,7 @@ int end_extent_writepage(struct page *pa
 	if (!uptodate) {
 		ClearPageUptodate(page);
 		SetPageError(page);
-		ret = ret < 0 ? ret : -EIO;
+		ret = err < 0 ? err : -EIO;
 		mapping_set_error(page->mapping, ret);
 	}
 	return 0;
