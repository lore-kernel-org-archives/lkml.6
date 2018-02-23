Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752140AbeBWVPq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 16:15:46 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:47059 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751425AbeBWVPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 16:15:44 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Moore <paul@paul-moore.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Martin Kepplinger <martink@posteo.de>,
        Richard Haines <richard_c_haines@btinternet.com>,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: fix typo in selinux_netlbl_sctp_sk_clone declaration
Date: Fri, 23 Feb 2018 22:12:09 +0100
Message-Id: <20180223211235.2402024-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:2zD4Kx64SMHBLbVmy2BNCZW4at+tntvbK0M7f4nbAFN4n4GURAg
 bqwvTl8XOGo+le4H/Iolo40s++0mZYqzI81go/2unUGUuu+7ZIFArZAbhhwUjuNA59z8Mht
 PC5uUkr+9nkEaMFLbpvHb3npFPg58Yc7q/5f+GsFAfQAygWnzG9QmjC3FUD12iK40q7pgpK
 nInKigXpISlhqL4A58lDQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gCxSWBdmDbA=:cRVA5f7alv+ogVo9VeO39h
 4+tLQ9sIX82l9L27Vev19m78PQVAU6DzExnfOAwsUaDQ2mWivAusiZL+8VP+r367ypALpyqrX
 T0ndJp0eoIHHiCbPuN+rQCnCCD2QdYa949khfVBOwsSiUchiY+a2oRHReZpiVtIOwvDX09yE8
 K1q5ErQ5wQJYSiShjfJfR62KU7uXDYc1cfmF9Rez+mRphOQJjmAzolqt1hzy6SDQtmWn5E0JJ
 JFI9D4JG56M6nn899ehjPRXIewepCjhquCQMCsBiQtDSq8a9h7IyOaFsIbIvPGUmmZcmI5X9y
 ulnNjc0FKp7wrnVcU+AICKJOygXVPLu8GhIvWOLcR0caLemAiPMNIFqEZCCA0oLH5KwosmKBP
 d489cGpOiW9nTQlCJ2hGK2/cuuh9wI5JZdG2XQdvyuHAHz7Vjq+yXVp/IjEaBEvbOfchdkbUd
 to5RZ5ID0jWEBaToa0yAp6q3H2i0Otu6GWA514w2xJRTYAFQA3OrbouXb5rZP9dSIlQAA17VZ
 C8P77q48sX+krY6xpoMn7d29oeF/L4KJeoqRz/Ox4ZMAhcdRn2CzEEtify4Elq3zowpZFJBtA
 MUERDZdIRU+zihmFYDuDt7i/FGffoTrIGWJ4dkrBlEiOLRvO2XByvcRaGry/uZHrq/4mhAlsf
 86hlLzBtbALG6zscOREuKOZLsdMGnlrSbZvg8hlhY72LKmZDWE4RaUZLJE9WiR3w+pvKigIUA
 r5O979DpOo4mTZODJhp8ga/2A4RfpCBwiLpjOg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A missing 'struct' keyword caused a build error when CONFIG_NETLABEL
is disabled:

In file included from security/selinux/hooks.c:99:
security/selinux/include/netlabel.h:135:66: error: unknown type name 'sock'
 static inline void selinux_netlbl_sctp_sk_clone(struct sock *sk, sock *newsk)
                                                                  ^~~~
security/selinux/hooks.c: In function 'selinux_sctp_sk_clone':
security/selinux/hooks.c:5188:2: error: implicit declaration of function 'selinux_netlbl_sctp_sk_clone'; did you mean 'selinux_netlbl_inet_csk_clone'? [-Werror=implicit-function-declaration]

Fixes: db97c9f9d312 ("selinux: Add SCTP support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 security/selinux/include/netlabel.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/include/netlabel.h b/security/selinux/include/netlabel.h
index 6ef4953431dc..8671de09c363 100644
--- a/security/selinux/include/netlabel.h
+++ b/security/selinux/include/netlabel.h
@@ -132,7 +132,8 @@ static inline void selinux_netlbl_inet_csk_clone(struct sock *sk, u16 family)
 {
 	return;
 }
-static inline void selinux_netlbl_sctp_sk_clone(struct sock *sk, sock *newsk)
+static inline void selinux_netlbl_sctp_sk_clone(struct sock *sk,
+						struct sock *newsk)
 {
 	return;
 }
-- 
2.9.0
