Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224ecAJ4e03ZRMjLsT3lKO0170V2Vug1n0mO058fOflD7UDQAGG5GXgjjB1II7KGf0w+FWip
ARC-Seal: i=1; a=rsa-sha256; t=1517591098; cv=none;
        d=google.com; s=arc-20160816;
        b=dDaq+WJLyIf+YNg3rEM5AWQNKgdB5IwixlrZ1SF2ohMU6cAz31u0qsUuJggvXgIxLx
         XlJixWeRQrjLxiMguyoj43GJZQtwR2yLpLur+JFBA00e4Co3w6C0dTJvh//lmEXDYHCg
         h+vYJGiGwtoVElYlK5P43B9zrVPywM8JnTTLE73iVSqpN4ddAvwvZdTp48oH+mllkqfy
         n08PjIKHFCYUJBNN6YXM45xTqyO1pFt3t6i2jutXuHSTzObOfftQEggkwe0iXOklCOvj
         zKEFilcHcV7FKAApbQKvfFvasqH+HOzzTwPQphpAFabArok1Lnst+B4yDMe0YJvYGRSr
         tUXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Qr0NCXgketDI7vITS2BpcexsRMyock1VDEw2JqPbRYQ=;
        b=A5Tp6S5BQ8m1BPmF78ytEAMdDSVv/YrH40/XS49RLspxg7fWDafpEPXfyZQo8nNEH1
         ZxCnTpnqWitfrseHm9dutWEh0Ud3qXeyP9mOs1hXQP+b2TMtSCjhyn1RnVQ/bXnYpGDj
         seMnj4CgC7EdKk9IhWkqs+ABs7aG5htKP85OGR/hKL+XHlcJ2hpUV1YQTAnPkFCotlbx
         YgpHkE0K6jCC0hrJErj7igzRUzvnh/uaUyVDr6zKv1eKKcFprZtlCZgPzEtg/6kjFZIV
         jICS5y50GKrXr/kA3eJ75uWqrBDqTpBZaJdjcr5lV1bIeKYyxUsRRQ0a/qyoWR1qJf9I
         N6Fg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Abhishek Goel <huntbag@linux.vnet.ibm.com>,
	Shuah Khan <shuahkh@osg.samsung.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 18/86] cpupowerutils: bench - Fix cpu online check
Date: Fri,  2 Feb 2018 17:57:38 +0100
Message-Id: <20180202140824.480086738@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309604120937333?=
X-GMAIL-MSGID: =?utf-8?q?1591309604120937333?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Abhishek Goel <huntbag@linux.vnet.ibm.com>


[ Upstream commit 53d1cd6b125fb9d69303516a1179ebc3b72f797a ]

cpupower_is_cpu_online was incorrectly checking for 0. This patch fixes
this by checking for 1 when the cpu is online.

Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/power/cpupower/bench/system.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/power/cpupower/bench/system.c
+++ b/tools/power/cpupower/bench/system.c
@@ -61,7 +61,7 @@ int set_cpufreq_governor(char *governor,
 
 	dprintf("set %s as cpufreq governor\n", governor);
 
-	if (cpupower_is_cpu_online(cpu) != 0) {
+	if (cpupower_is_cpu_online(cpu) != 1) {
 		perror("cpufreq_cpu_exists");
 		fprintf(stderr, "error: cpu %u does not exist\n", cpu);
 		return -1;
