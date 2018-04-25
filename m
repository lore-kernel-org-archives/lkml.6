Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-557887-1524653124-2-10792065237222934469
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
    1524653123; b=ILsxSiMFpUR7ZcPuTDCXDD6Aj1bbkNw2d3s0B1Hgos8HBRbyzH
    6y3qeRiMm3eKK+O2FaTzgAu6zIv3x+W4KUXDGig6sWPX3dfIV7OF3uEIUq52be9x
    qTTjc+KpTPiqPMWt7zmj8umPm+sshfSp6WpwNMRy0drGed1ZvZS6Jfb1qUAfAWQ3
    Cua/UiVpKsxoPdrRFbPyTHepmuhCwPmNoX5IyDojnnplrfvjYNib2VHocvoDq8OB
    cuszMkfyrVTRzMSDpFjd5vng1tloGri0WoUlLwKW1nPn1dzAfXLYbTX5ApZgMSno
    ahtbpbssS8ho3vZT5ShnxD2ulukRp4H8KNnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524653123; bh=fLPs8nRfa/hzjEYEPLYPr/IhUlZBKy
    ncAb+P5J/EtxU=; b=UCglmq+B98IOpZmu8MWAZ9Ht4J1NmOtwp9FhiILE5+mgy6
    qymuUmEKOB27fez8SdHIjMsQSvtiIBQiVaiEyvjgV6HZLXhhA9IxJre7vfVrq12e
    XCrozI5LlAe/W/v71l8XV2ZiX9/vD4HWaTlOxRR4+n+0iA8JMV1UI2QeVSw1zgyD
    ndCYdRSDr/kTOTz66f1/JiugQsMtrZneMkwfKTvW1lhVL8/liba2lumCeLTdeNPc
    SgNuhuW0491BtYdDxy5BOsXBLD1VP5jSsKY6AI7Pa4Dwpzqoq8AQlb4XuapyNWbL
    IRrjSOUKG+6Lj7ic1Qw+qCgXwNp18ZNrll2d4O5A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfLRlrCzEcWEdRd1qvPWlWTG71qgei9FxayN+fcXm3yEn9d4I8K5KSRdW/5dIYAEjxxfU4gVNCaA2Raxjw/yCMmNTHSdrYa+Qo0m+kEGr5CgQbCux6ZjX
    K18EA+rbkBHXWKzFrY9sCXTL9dMHLiCbE5W8RCRNO15ed/oCPBB4C8eDz5VmW65bf3jd8sHiPDC1LnME7S5CxaBMk3Zxi9AbTqCmZZFRWyH4xIDNU2h8BElG
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=meVymXHHAAAA:8 a=VwQbUJbxAAAA:8 a=drOt6m5kAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=UhSkpe21RigDWVNyvmIA:9 a=QEXdDO2ut3YA:10
    a=2JgSa4NbpEOStq-L5dxp:22 a=AjGcO6oz07-iQ99wixmX:22 a=RMMjzBEyIzXRtoq5n5K6:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754272AbeDYKpT (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:45:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53528 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754488AbeDYKpM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:45:12 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 152/183] selftests/ftrace: Add some missing glob checks
Date: Wed, 25 Apr 2018 12:36:12 +0200
Message-Id: <20180425103248.644594158@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
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

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>


[ Upstream commit 97fe22adf33f06519bfdf7dad33bcd562e366c8f ]

Al Viro discovered a bug in the glob ftrace filtering code where "*a*b" is
treated the same as "a*b", and functions that would be selected by "*a*b"
but not "a*b" are not selected with "*a*b".

Add tests for patterns "*a*b" and "a*b*" to the glob selftest.

Link: http://lkml.kernel.org/r/20180127170748.GF13338@ZenIV.linux.org.uk

Cc: Shuah Khan <shuah@kernel.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
@@ -29,6 +29,12 @@ ftrace_filter_check '*schedule*' '^.*sch
 # filter by *, end match
 ftrace_filter_check 'schedule*' '^schedule.*$'
 
+# filter by *mid*end
+ftrace_filter_check '*aw*lock' '.*aw.*lock$'
+
+# filter by start*mid*
+ftrace_filter_check 'mutex*try*' '^mutex.*try.*'
+
 # Advanced full-glob matching feature is recently supported.
 # Skip the tests if we are sure the kernel does not support it.
 if grep -q 'accepts: .* glob-matching-pattern' README ; then
