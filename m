Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227OFgwvxknX6/XclwSkFKe6J5eg0tgpv0dtRvbZC24rm7YmK/PNA95O84eP1AsronIyfC+r
ARC-Seal: i=1; a=rsa-sha256; t=1517591406; cv=none;
        d=google.com; s=arc-20160816;
        b=Mlqx9z1ITpqUYphj1heKZQt2P6MFWKmW015DlQoX04C7ikfcomnnhJDUmZNWOuTP6x
         YuG72QU0hijebrptfzoiorH4pTA4s/EHGOVzX/jRw7IcXscH1CC+C70hipp8d8OcKapo
         3Juhv2mbnccg+rOJvubBJFt8DHyjFlqBZUSaI+Ui0NZ3NYbp79vNS4tg0mw20mnXxrqw
         fmHFFWG6dv9KaIJqghfva8c3VTLIYWpyBnnvxUz2jh00sBZz/TOLZj/2+QdqDbPxBkFk
         6Z1kjJf30Qqy8GZwmObz+43oy4pQBZZaesSQyDQcm8N1/kilBFbReb11wwyNsqWiOIB9
         eu7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TFmGVzYxU/dqq0CEK+WbOV6D4pnBmgpvAxT/g2H3uN0=;
        b=avcc1OVCNUpsLbfkqc4bY7c+ZM4AkQh3MqE++FjXTHjghqutPC9rMTZgLt5gQ5pSaz
         ElesDXz0k3VE4Wa3s2YtuqOA7A/NtGioPR34lfutLxxDVn07MgnUNMouj+m6dH3eslFR
         Qwl6PhsFKCOZ4uWI6OhRFAet2x/PCxSWKi12FIQxissWGiaN8Bs5Q/C6a1VPHcVll+PV
         OVdj1BN9Tf3cpFDmLGG5QAFfvtV6hdAWhF9OuN2CrSPJvZd1VPyOziopmxhgMiPArl3z
         TsyDpf/KStAWCC4pwmGW47JWeOrZPFYp62rSjvCXhFHg8O9QQGpfLowbpk7gJMMjU0wE
         PztQ==
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
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 034/156] cpupowerutils: bench - Fix cpu online check
Date: Fri,  2 Feb 2018 17:56:55 +0100
Message-Id: <20180202140841.859086842@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309604120937333?=
X-GMAIL-MSGID: =?utf-8?q?1591309926640062738?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Abhishek Goel <huntbag@linux.vnet.ibm.com>


[ Upstream commit 53d1cd6b125fb9d69303516a1179ebc3b72f797a ]

cpupower_is_cpu_online was incorrectly checking for 0. This patch fixes
this by checking for 1 when the cpu is online.

Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
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
