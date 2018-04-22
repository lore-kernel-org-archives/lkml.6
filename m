Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524406320-2-1820041746506063460
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
    1524406320; b=VvX20RGJQTpcOpXvJsqhfH3Ch84Q5++bQJYrxKi/DgGbr4+Gno
    ONUhy9WpbaVibfUCcobjd4Qureq/NKza89mGiNGRLG+mm/PIFzas0XzsnnGL6eOi
    2Yl1rL3Dfii5Q2BvLnh8+KbHQj+I9iigvhIfS4UUJwGZw9gbOf5z3DEzDzb6Sp7J
    Wd1yBUZ+h706ABSGuMR3oadtRwlMFHjwWuczgqT0pTYCy99aLLaTfOiZT3LGmpir
    93h/Z/quap4al9YwXYdUEBCC+Npe8L0aYHkbBs1Q2e569JNbUpRGXApIy/Kc8ZUR
    8VKtc0hrbMx5vARcm1fQyIBppg0tgFevCHcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406320; bh=BjlxJGmAw87VQtmAMlRPg1/ay261RJ
    onJRC6syactUM=; b=tTl9qI8MW/gtnnTsDHtTbLNgcnoewJJKbF0zWhu+I5D+Jw
    +NTDLcQXMJ/00QZAleLCQg1RQ/WF+DHviB2N3pqj9fF2wjE9UybIqUUJPfnHGUWw
    dM3KW2X0Zv0GHlv+EBTuY/8zUFb2PCQNmaFA1bFzWVOiFfq0iuH7E5YQ4ISzesOe
    tXCdTIhJ701YoFM8YoIUa/CsdGtCLmaDdon/QVQ2LGAUyER61HF3LEmnL1/yJ5SZ
    M+CguUDLGuVMF2BKIoFKpiUwywlJQuSPDNP2hRP7oaliX/30VVjB7+pYl2OjtYk3
    ulica4UWGpt6LRm7Eru/ANh0lC7rayvk5NxQHzmw==
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
X-CM-Envelope: MS4wfLPLuVCsDLzYYxsSGJ4891b97s6uaE/mg4rjnQl4xlSXvp+XfWmZ09gL8KzvaCvQf/piI/GNrfm+SRSrBywYCMWS4sGZgXa3g0IwvMYOBvg7kVmetrPA
    OSWunUTbzpa5rYQZfcTc8YawA9U9HLk4e+za1hZ4dP79iHpOYGd+Ny216iomS+RuD8BHO329+v5YVMRKKxiQbTVztZ6xfxDmNa0zVoZersnMDt35yHWo5MlV
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=KSb9T-wMAAAA:8 a=VwQbUJbxAAAA:8 a=_Dj-zB-qAAAA:8 a=Z4Rwk6OoAAAA:8
    a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8 a=ag1SF4gXAAAA:8 a=bx3TDHY-pcSmQ86d2UkA:9
    a=PkI-XMuybx782a7w:21 a=YKK6mV7oXABNnzM1:21 a=QEXdDO2ut3YA:10
    a=KF4VuIdXkMyp4E_ug72i:22 a=AjGcO6oz07-iQ99wixmX:22 a=c-cOe7UV8MviEfHuAVEQ:22
    a=HkZW87K1Qel5hWWM3VKY:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756590AbeDVOL4 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:11:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54660 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756037AbeDVOLx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:11:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Michael Henders <hendersm@shaw.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 07/95] resource: fix integer overflow at reallocation
Date: Sun, 22 Apr 2018 15:52:36 +0200
Message-Id: <20180422135210.730682234@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
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

From: Takashi Iwai <tiwai@suse.de>

commit 60bb83b81169820c691fbfa33a6a4aef32aa4b0b upstream.

We've got a bug report indicating a kernel panic at booting on an x86-32
system, and it turned out to be the invalid PCI resource assigned after
reallocation.  __find_resource() first aligns the resource start address
and resets the end address with start+size-1 accordingly, then checks
whether it's contained.  Here the end address may overflow the integer,
although resource_contains() still returns true because the function
validates only start and end address.  So this ends up with returning an
invalid resource (start > end).

There was already an attempt to cover such a problem in the commit
47ea91b4052d ("Resource: fix wrong resource window calculation"), but
this case is an overseen one.

This patch adds the validity check of the newly calculated resource for
avoiding the integer overflow problem.

Bugzilla: http://bugzilla.opensuse.org/show_bug.cgi?id=1086739
Link: http://lkml.kernel.org/r/s5hpo37d5l8.wl-tiwai@suse.de
Fixes: 23c570a67448 ("resource: ability to resize an allocated resource")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Reported-by: Michael Henders <hendersm@shaw.ca>
Tested-by: Michael Henders <hendersm@shaw.ca>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/resource.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -633,7 +633,8 @@ static int __find_resource(struct resour
 			alloc.start = constraint->alignf(constraint->alignf_data, &avail,
 					size, constraint->align);
 			alloc.end = alloc.start + size - 1;
-			if (resource_contains(&avail, &alloc)) {
+			if (alloc.start <= alloc.end &&
+			    resource_contains(&avail, &alloc)) {
 				new->start = alloc.start;
 				new->end = alloc.end;
 				return 0;
