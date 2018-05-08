Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZovNwjxvgdz366C6b0Bmx6QpIv+yo/Kx2gBoA8B4DvFG7QTnZXPqV1wglReP6DUbJyT6N9H
ARC-Seal: i=1; a=rsa-sha256; t=1525767220; cv=none;
        d=google.com; s=arc-20160816;
        b=cKTLBb+uwtMcoS9rsJFimE5WfZ8MsGZI6OaanG140p6gvjILnPE1+gCv1YqLU231xb
         sSkdwJm07OFh9LhxmN6DGgv0G8FZ+bcylxgcOOYM96iP3K66M82l+Utsmu0jjyqC3cwR
         plsEAXJKcs3qDaF8aXG0XNC2hCOOmXArWJLWrK1x8qJqFRPdOZLICMG7cSNqkGd3IJYo
         ukTYVoRU/Ez1jmAsytvdnpo9QkDQwDnd2qN+IgXp2BOdgcQGApZxLJmLIdV8kXC7aHcZ
         AjouQBozqhmrkIWgtfT5A8FPxAxppAnjTxxhqYE6x6gT7Qjl5CWQouXewx2Br8YCPQg4
         pKMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=l1as4msNPO1VE0PLp8NDpQIr8lbVrL/XmiKV6SlxRdw=;
        b=jd2GHjYnBHQQahOxMPqCASmHDy9EoZvUZUVD6A9Q5Luu9czFMl69+60RLwNdumpuUu
         aVuskqW1wGVL5OS+zJ+kDXWkKO1L+kmOd/k58DSktPGrvCIW5eVgcmM217QSLyc8k5o3
         MVaBfqmmEv/B+gzyFwHbakt4674Uy9BFHGW+m5eRpoY78iAQRHhj0HuHUQQ2u/lEIuDu
         EHElahq4z4+aqJL7sHZJpKOY8VDWg8G1PDPLvUfctO2ZA5+ATz+5/b90pnu30wOwr8cX
         OSLj+jJD4D3UbNapFbZjVlk9B69vJNoe0D3XjwulXobbyt42WtM+EsVRhjztoRvyr8J1
         gnRA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=2X/rVw4D;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=2X/rVw4D;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Diego Viola <diego.viola@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	len.brown@intel.com,
	rjw@rjwysocki.net,
	rui.zhang@intel.com
Subject: [PATCH 4.16 50/52] clocksource: Initialize cs->wd_list
Date: Tue,  8 May 2018 10:10:48 +0200
Message-Id: <20180508073935.198182778@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882888335587122?=
X-GMAIL-MSGID: =?utf-8?q?1599882888335587122?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit 5b9e886a4af97574ca3ce1147f35545da0e7afc7 upstream.

A number of places relies on list_empty(&cs->wd_list), however the
list_head does not get initialized. Do so upon registration, such that
thereafter it is possible to rely on list_empty() correctly reflecting
the list membership status.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Diego Viola <diego.viola@gmail.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: stable@vger.kernel.org
Cc: len.brown@intel.com
Cc: rjw@rjwysocki.net
Cc: rui.zhang@intel.com
Link: https://lkml.kernel.org/r/20180430100344.472662715@infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/time/clocksource.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -332,6 +332,8 @@ static void clocksource_resume_watchdog(
 
 static void clocksource_enqueue_watchdog(struct clocksource *cs)
 {
+	INIT_LIST_HEAD(&cs->wd_list);
+
 	if (cs->flags & CLOCK_SOURCE_MUST_VERIFY) {
 		/* cs is a clocksource to be watched. */
 		list_add(&cs->wd_list, &watchdog_list);
