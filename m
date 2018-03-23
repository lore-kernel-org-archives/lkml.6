Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1092440-1521803575-2-2650131415882231163
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521803575; b=YgVAfoXAsI83gGNvUt0jfPz0FZa+TSOp/3roX12xOtdjN/b
    JLiH8h/IRqQA40GUWJxyh+6vpCh5tyCN04W77glSWkrYrFw4xfX0yivWS450vhAa
    0zHgg5FLoGk7AxYFHcyXLhy4aR1XJFOxCWn78h34lwgtTHX2ZpMj8tcipf31bWwB
    YUXWjAWcdcrfNHMuxNZ4lX9vOnRzyph1CBpYn2RtQZyVT9R60xQSoRkdMZu1NE5n
    3wlBkWDkUq8kZPXvcPBRMW4iJ+NrARvAv5pw63fHxeSUvTl+6GVMmsRrdFyTwsWx
    GNctj+ke/zSsVSVXP7l2B+rBQlpZO8irgnKa/mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803575; bh=0fRCv24UwNW+R8jEJgz0NDVbkP
    j04BgPQUnCP7jruMM=; b=j4BHj3SGIreuL1tWLf45eZK1vgPZ3mMb+h4AMu7YWR
    eb3RmTu4WBPLqprxMRT09+E6OahJKRNUk5J2Oyq9Wnhzr2oIZac3f7DHr9Mm5Vaz
    QhzgN/EIxDq4c3AOWWz/xv0NYVvoh85JYX0ed3AtEZOC42ktEvDfpHj2eILp5M23
    XYjndJM4prwESRRHpevuRlkwVgIMGFYFgbcT3TY9UpGWTpuatAKXPr8SJl/CGKib
    27e2tU/TqSX5Ch7fLV5AGCfRFyb1JZQD7ruTTmvQuTPbNmoCprB6GjdtCczQ36Bq
    A1pdZqECrjhuMtzmIxc3g5mL8Asm3bDOh0cFzg5BeLMA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932781AbeCWKKo (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:10:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42726 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932734AbeCWKKm (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:10:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        kernel test robot <lkp@intel.com>,
        Xiaolong Ye <xiaolong.ye@intel.com>,
        Chen Gong <gong.chen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 128/177] mm: hwpoison: call shake_page() after try_to_unmap() for mlocked page
Date: Fri, 23 Mar 2018 10:54:16 +0100
Message-Id: <20180323094210.876445498@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>


[ Upstream commit 286c469a988fbaf68e3a97ddf1e6c245c1446968 ]

Memory error handler calls try_to_unmap() for error pages in various
states.  If the error page is a mlocked page, error handling could fail
with "still referenced by 1 users" message.  This is because the page is
linked to and stays in lru cache after the following call chain.

  try_to_unmap_one
    page_remove_rmap
      clear_page_mlock
        putback_lru_page
          lru_cache_add

memory_failure() calls shake_page() to hanlde the similar issue, but
current code doesn't cover because shake_page() is called only before
try_to_unmap().  So this patches adds shake_page().

Fixes: 23a003bfd23ea9ea0b7756b920e51f64b284b468 ("mm/madvise: pass return code of memory_failure() to userspace")
Link: http://lkml.kernel.org/r/20170417055948.GM31394@yexl-desktop
Link: http://lkml.kernel.org/r/1493197841-23986-3-git-send-email-n-horiguchi@ah.jp.nec.com
Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Xiaolong Ye <xiaolong.ye@intel.com>
Cc: Chen Gong <gong.chen@linux.intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memory-failure.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -921,6 +921,7 @@ static int hwpoison_user_mappings(struct
 	int ret;
 	int kill = 1, forcekill;
 	struct page *hpage = *hpagep;
+	bool mlocked = PageMlocked(hpage);
 
 	/*
 	 * Here we are interested only in user-mapped pages, so skip any
@@ -985,6 +986,13 @@ static int hwpoison_user_mappings(struct
 		       pfn, page_mapcount(hpage));
 
 	/*
+	 * try_to_unmap() might put mlocked page in lru cache, so call
+	 * shake_page() again to ensure that it's flushed.
+	 */
+	if (mlocked)
+		shake_page(hpage, 0);
+
+	/*
 	 * Now that the dirty bit has been propagated to the
 	 * struct page and all unmaps done we can decide if
 	 * killing is needed or not.  Only kill when the page
