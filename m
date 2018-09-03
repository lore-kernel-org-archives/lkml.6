Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420ECC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D463720862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ExP49swB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D463720862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbeIDAHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 20:07:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41896 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbeIDAHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 20:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OoNVG1W8+GVzNGV2nMAA8fnz5LjIW2oJwC2knq2hpyc=; b=ExP49swBhn7zJ+mUAKeUkTH+MS
        Fi18XlFfn1WPsyelqTVX/rn3I5WWSlWR/hm+S4u3c4QXiPh+l6ArFyXq2Vt0k6QUgUxvS81/k/CQq
        evpzWptMjq235AhAbiaj3FJ8UX5pJmUVNAHlFGhbfJ/YLfMz1RCim1dfCHomiZpSjQFtyZQavMNZi
        +JsVsU138FLusJbf4nY4rVOaZ2ePAKACintkgUYlWEsf7hRlwcQqsnSPQPq5+ITY092KxOO59mcY4
        ryJvgULq83p3/nB3y4ImyAJAh/q3K/IVu7tLROFJf3c3GUm4B7Lbir9ElVjHCqaiGiecDsY84lLbj
        YYhbTJIw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fwunD-0001wk-R2; Mon, 03 Sep 2018 19:45:48 +0000
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] srcu: fix kernel-doc missing notation
Message-ID: <b3068192-4690-284f-3062-0a2fb7bb32b7@infradead.org>
Date:   Mon, 3 Sep 2018 12:45:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warnings for missing parameter descriptions:

../include/linux/srcu.h:175: warning: Function parameter or member 'p' not described in 'srcu_dereference_notrace'
../include/linux/srcu.h:175: warning: Function parameter or member 'sp' not described in 'srcu_dereference_notrace'

Fixes: 0b764a6e4e19d ("srcu: Add notrace variant of srcu_dereference")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/srcu.h |    3 +++
 1 file changed, 3 insertions(+)

--- lnx-419-rc2.orig/include/linux/srcu.h
+++ lnx-419-rc2/include/linux/srcu.h
@@ -171,6 +171,9 @@ static inline int srcu_read_lock_held(co
 
 /**
  * srcu_dereference_notrace - no tracing and no lockdep calls from here
+ * @p: the pointer to fetch and protect for later dereferencing
+ * @sp: pointer to the srcu_struct, which is used to check that we
+ *	really are in an SRCU read-side critical section.
  */
 #define srcu_dereference_notrace(p, sp) srcu_dereference_check((p), (sp), 1)
 


