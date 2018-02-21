Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227pd4YS8MqB5ukWHAdMoGuhQKzyRDBSaZ/jebn/xJ44jG8u/dLL5ENsxUSRSzJdezL11hg2
ARC-Seal: i=1; a=rsa-sha256; t=1519218506; cv=none;
        d=google.com; s=arc-20160816;
        b=cvWLMP1ggUtSPdrhesE+VE/qeo9f2JLG49q2bK82Us/mG9HbrRbqTvyxAfhjvv7NE+
         +X0l8uEGvq6nc96sDTy5JuDpEXd+UnFM+CNSjFQz/tNqEqvG3FhqZmSnS6XgeWoiE4NK
         pncLXcgMb7B4F0a8LyaMOQl7fvq/xHwV1ExbHsiUNC98YFz/AWohhJ2MYct0n1GyxNHG
         UURUWEStFDeDck4THHhuTGextPyAUpK8ktPywhNMmejrp5cIs9zA3HlaOdaFzO6cuisR
         oyeH6s+vaIbR5bL21laChF/2DCpt2KFRCh+LjNA+EIEAc+8KvDfENRVtaedy14SDiFEc
         yJiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YE8RsRqJ1A1rPlq27eqCT9C8RLBU4+CluCMfTPjZydM=;
        b=btodMWBiCw9LXIi+FbweIBfjs5h7QfpN7bOX6bcRTtzWPV78HlQPxBUHy/mDaT2dsa
         PZs2icbxkf64qdVCcT2Ss39f5vUwpjmSTLAKKPLMg+Xt/vooOZx2bRYYg7wkHRllUI6B
         DpvJJ/pHcS246MjM1dIj8NKi0MDPwylV/mWwSoi9meXAuNnHvIIEr1gvnpGVdqy+62pz
         NAkZslPJPVSIwW8T9OQrfwC20FVbrlG8JOL/tvXeeLqcsaNcyJCjFg2mpfDsHWWdSemJ
         4/AiwIGew8xRlxf7SocjiywNkMZHt6dduG54ndOqLBWZtkKvH0LTvdFtKGvGxlZva+c8
         2BqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.15 056/163] PM: cpuidle: Fix cpuidle_poll_state_init() prototype
Date: Wed, 21 Feb 2018 13:48:05 +0100
Message-Id: <20180221124533.550598179@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015545701185591?=
X-GMAIL-MSGID: =?utf-8?q?1593016064579449476?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit d7212cfb05ba802bea4dd6c90d61cfe6366ea224 upstream.

Commit f85942207516 (x86: PM: Make APM idle driver initialize polling
state) made apm_init() call cpuidle_poll_state_init(), but that only
is defined for CONFIG_CPU_IDLE set, so make the empty stub of it
available for CONFIG_CPU_IDLE unset too to fix the resulting build
issue.

Fixes: f85942207516 (x86: PM: Make APM idle driver initialize polling state)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/cpuidle.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -225,7 +225,7 @@ static inline void cpuidle_coupled_paral
 }
 #endif
 
-#ifdef CONFIG_ARCH_HAS_CPU_RELAX
+#if defined(CONFIG_CPU_IDLE) && defined(CONFIG_ARCH_HAS_CPU_RELAX)
 void cpuidle_poll_state_init(struct cpuidle_driver *drv);
 #else
 static inline void cpuidle_poll_state_init(struct cpuidle_driver *drv) {}
